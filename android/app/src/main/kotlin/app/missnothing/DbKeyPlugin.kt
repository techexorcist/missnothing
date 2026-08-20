package app.missnothing

import android.os.Build
import android.security.keystore.KeyGenParameterSpec
import android.security.keystore.KeyProperties
import androidx.biometric.BiometricManager
import androidx.biometric.BiometricManager.Authenticators.BIOMETRIC_STRONG
import androidx.biometric.BiometricManager.Authenticators.DEVICE_CREDENTIAL
import androidx.biometric.BiometricPrompt
import androidx.core.content.ContextCompat
import androidx.fragment.app.FragmentActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import java.io.File
import java.security.KeyStore
import java.security.SecureRandom
import javax.crypto.Cipher
import javax.crypto.KeyGenerator
import javax.crypto.SecretKey
import javax.crypto.spec.GCMParameterSpec

/// SQLCipher passphrase lives in Android Keystore, wrapped under a key that
/// requires biometric or device PIN. The plaintext passphrase is never written
/// to disk.
class DbKeyPlugin(
    private val activity: FragmentActivity,
) : MethodChannel.MethodCallHandler {
    companion object {
        const val CHANNEL = "app.missnothing/db_key"
        private const val ALIAS = "missnothing_sqlcipher_v1"
        private const val ANDROID_KEYSTORE = "AndroidKeyStore"
        private const val TRANSFORMATION = "AES/GCM/NoPadding"
        private const val IV_LEN = 12
        private const val KEY_LEN = 32
        private const val AUTH = BIOMETRIC_STRONG or DEVICE_CREDENTIAL

        fun register(
            activity: FragmentActivity,
            engine: FlutterEngine,
        ) {
            MethodChannel(engine.dartExecutor.binaryMessenger, CHANNEL)
                .setMethodCallHandler(DbKeyPlugin(activity))
        }
    }

    private val blobFile: File
        get() = File(activity.filesDir, "sqlcipher_key.enc")

    override fun onMethodCall(
        call: MethodCall,
        result: MethodChannel.Result,
    ) {
        if (call.method != "unlock") {
            result.notImplemented()
            return
        }
        val can = BiometricManager.from(activity).canAuthenticate(AUTH)
        if (can != BiometricManager.BIOMETRIC_SUCCESS) {
            result.error(
                "no_lock",
                "Set a screen lock (PIN, pattern, password, or biometric) " +
                    "so MissNothing can keep the database key in the Keystore.",
                mapOf("canAuthenticate" to can),
            )
            return
        }
        try {
            ensureKey()
            if (!blobFile.exists()) {
                encryptNewKey(result)
            } else {
                decryptExisting(result)
            }
        } catch (e: Exception) {
            result.error("keystore", e.message, null)
        }
    }

    private fun ensureKey() {
        val ks = KeyStore.getInstance(ANDROID_KEYSTORE).apply { load(null) }
        if (ks.containsAlias(ALIAS)) return
        val gen =
            KeyGenerator.getInstance(
                KeyProperties.KEY_ALGORITHM_AES,
                ANDROID_KEYSTORE,
            )
        val builder =
            KeyGenParameterSpec.Builder(
                ALIAS,
                KeyProperties.PURPOSE_ENCRYPT or KeyProperties.PURPOSE_DECRYPT,
            ).setBlockModes(KeyProperties.BLOCK_MODE_GCM)
                .setEncryptionPaddings(KeyProperties.ENCRYPTION_PADDING_NONE)
                .setKeySize(256)
                .setUserAuthenticationRequired(true)
        if (Build.VERSION.SDK_INT >= 30) {
            builder.setUserAuthenticationParameters(0, AUTH)
        } else {
            @Suppress("DEPRECATION")
            builder.setUserAuthenticationValidityDurationSeconds(-1)
        }
        gen.init(builder.build())
        gen.generateKey()
    }

    private fun secretKey(): SecretKey {
        val ks = KeyStore.getInstance(ANDROID_KEYSTORE).apply { load(null) }
        return (ks.getEntry(ALIAS, null) as KeyStore.SecretKeyEntry).secretKey
    }

    private fun encryptNewKey(result: MethodChannel.Result) {
        val raw = ByteArray(KEY_LEN)
        SecureRandom().nextBytes(raw)
        val cipher = Cipher.getInstance(TRANSFORMATION)
        cipher.init(Cipher.ENCRYPT_MODE, secretKey())
        authenticate(cipher, result) { c ->
            val packed = c.iv + c.doFinal(raw)
            blobFile.writeBytes(packed)
            raw.toHex()
        }
    }

    private fun decryptExisting(result: MethodChannel.Result) {
        val blob = blobFile.readBytes()
        if (blob.size <= IV_LEN) {
            result.error("corrupt", "Encrypted key blob is too short.", null)
            return
        }
        val iv = blob.copyOfRange(0, IV_LEN)
        val ct = blob.copyOfRange(IV_LEN, blob.size)
        val cipher = Cipher.getInstance(TRANSFORMATION)
        cipher.init(
            Cipher.DECRYPT_MODE,
            secretKey(),
            GCMParameterSpec(128, iv),
        )
        authenticate(cipher, result) { c ->
            c.doFinal(ct).toHex()
        }
    }

    private fun authenticate(
        cipher: Cipher,
        result: MethodChannel.Result,
        after: (Cipher) -> String,
    ) {
        val executor = ContextCompat.getMainExecutor(activity)
        var replied = false

        fun replyError(
            code: String,
            message: String,
        ) {
            if (replied) return
            replied = true
            result.error(code, message, null)
        }

        fun replyOk(value: String) {
            if (replied) return
            replied = true
            result.success(value)
        }

        val prompt =
            BiometricPrompt(
                activity,
                executor,
                object : BiometricPrompt.AuthenticationCallback() {
                    override fun onAuthenticationSucceeded(
                        authResult: BiometricPrompt.AuthenticationResult,
                    ) {
                        val c = authResult.cryptoObject?.cipher
                        if (c == null) {
                            replyError("crypto", "Keystore did not return a cipher.")
                            return
                        }
                        try {
                            replyOk(after(c))
                        } catch (e: Exception) {
                            replyError("crypto", e.message ?: "cipher failed")
                        }
                    }

                    override fun onAuthenticationError(
                        errorCode: Int,
                        errString: CharSequence,
                    ) {
                        replyError("auth", errString.toString())
                    }
                },
            )
        val info =
            BiometricPrompt.PromptInfo.Builder()
                .setTitle("Unlock MissNothing")
                .setSubtitle("The alarm database key stays in this device’s Keystore.")
                .setAllowedAuthenticators(AUTH)
                .build()
        prompt.authenticate(info, BiometricPrompt.CryptoObject(cipher))
    }

    private fun ByteArray.toHex(): String = joinToString("") { b -> "%02x".format(b) }
}
