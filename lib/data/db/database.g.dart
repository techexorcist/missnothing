// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $MetaEntriesTable extends MetaEntries
    with TableInfo<$MetaEntriesTable, MetaEntry> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MetaEntriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _keyMeta = const VerificationMeta('key');
  @override
  late final GeneratedColumn<String> key = GeneratedColumn<String>(
    'k',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _valueMeta = const VerificationMeta('value');
  @override
  late final GeneratedColumn<String> value = GeneratedColumn<String>(
    'v',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [key, value];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'meta';
  @override
  VerificationContext validateIntegrity(
    Insertable<MetaEntry> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('k')) {
      context.handle(_keyMeta, key.isAcceptableOrUnknown(data['k']!, _keyMeta));
    } else if (isInserting) {
      context.missing(_keyMeta);
    }
    if (data.containsKey('v')) {
      context.handle(
        _valueMeta,
        value.isAcceptableOrUnknown(data['v']!, _valueMeta),
      );
    } else if (isInserting) {
      context.missing(_valueMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {key};
  @override
  MetaEntry map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MetaEntry(
      key: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}k'],
      )!,
      value: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}v'],
      )!,
    );
  }

  @override
  $MetaEntriesTable createAlias(String alias) {
    return $MetaEntriesTable(attachedDatabase, alias);
  }
}

class MetaEntry extends DataClass implements Insertable<MetaEntry> {
  final String key;
  final String value;
  const MetaEntry({required this.key, required this.value});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['k'] = Variable<String>(key);
    map['v'] = Variable<String>(value);
    return map;
  }

  MetaEntriesCompanion toCompanion(bool nullToAbsent) {
    return MetaEntriesCompanion(key: Value(key), value: Value(value));
  }

  factory MetaEntry.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MetaEntry(
      key: serializer.fromJson<String>(json['key']),
      value: serializer.fromJson<String>(json['value']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'key': serializer.toJson<String>(key),
      'value': serializer.toJson<String>(value),
    };
  }

  MetaEntry copyWith({String? key, String? value}) =>
      MetaEntry(key: key ?? this.key, value: value ?? this.value);
  MetaEntry copyWithCompanion(MetaEntriesCompanion data) {
    return MetaEntry(
      key: data.key.present ? data.key.value : this.key,
      value: data.value.present ? data.value.value : this.value,
    );
  }

  @override
  String toString() {
    return (StringBuffer('MetaEntry(')
          ..write('key: $key, ')
          ..write('value: $value')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(key, value);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MetaEntry &&
          other.key == this.key &&
          other.value == this.value);
}

class MetaEntriesCompanion extends UpdateCompanion<MetaEntry> {
  final Value<String> key;
  final Value<String> value;
  final Value<int> rowid;
  const MetaEntriesCompanion({
    this.key = const Value.absent(),
    this.value = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  MetaEntriesCompanion.insert({
    required String key,
    required String value,
    this.rowid = const Value.absent(),
  }) : key = Value(key),
       value = Value(value);
  static Insertable<MetaEntry> custom({
    Expression<String>? key,
    Expression<String>? value,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (key != null) 'k': key,
      if (value != null) 'v': value,
      if (rowid != null) 'rowid': rowid,
    });
  }

  MetaEntriesCompanion copyWith({
    Value<String>? key,
    Value<String>? value,
    Value<int>? rowid,
  }) {
    return MetaEntriesCompanion(
      key: key ?? this.key,
      value: value ?? this.value,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (key.present) {
      map['k'] = Variable<String>(key.value);
    }
    if (value.present) {
      map['v'] = Variable<String>(value.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MetaEntriesCompanion(')
          ..write('key: $key, ')
          ..write('value: $value, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $GmailMessagesTable extends GmailMessages
    with TableInfo<$GmailMessagesTable, GmailMessage> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $GmailMessagesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _messageIdMeta = const VerificationMeta(
    'messageId',
  );
  @override
  late final GeneratedColumn<String> messageId = GeneratedColumn<String>(
    'message_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _threadIdMeta = const VerificationMeta(
    'threadId',
  );
  @override
  late final GeneratedColumn<String> threadId = GeneratedColumn<String>(
    'thread_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _internalDateMsMeta = const VerificationMeta(
    'internalDateMs',
  );
  @override
  late final GeneratedColumn<int> internalDateMs = GeneratedColumn<int>(
    'internal_date_ms',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _fromRawMeta = const VerificationMeta(
    'fromRaw',
  );
  @override
  late final GeneratedColumn<String> fromRaw = GeneratedColumn<String>(
    'from_raw',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _subjectRawMeta = const VerificationMeta(
    'subjectRaw',
  );
  @override
  late final GeneratedColumn<String> subjectRaw = GeneratedColumn<String>(
    'subject_raw',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _parseStatusMeta = const VerificationMeta(
    'parseStatus',
  );
  @override
  late final GeneratedColumn<String> parseStatus = GeneratedColumn<String>(
    'parse_status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _firstSeenAtMeta = const VerificationMeta(
    'firstSeenAt',
  );
  @override
  late final GeneratedColumn<String> firstSeenAt = GeneratedColumn<String>(
    'first_seen_at',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _lastSeenAtMeta = const VerificationMeta(
    'lastSeenAt',
  );
  @override
  late final GeneratedColumn<String> lastSeenAt = GeneratedColumn<String>(
    'last_seen_at',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    messageId,
    threadId,
    internalDateMs,
    fromRaw,
    subjectRaw,
    parseStatus,
    firstSeenAt,
    lastSeenAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'gmail_messages';
  @override
  VerificationContext validateIntegrity(
    Insertable<GmailMessage> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('message_id')) {
      context.handle(
        _messageIdMeta,
        messageId.isAcceptableOrUnknown(data['message_id']!, _messageIdMeta),
      );
    } else if (isInserting) {
      context.missing(_messageIdMeta);
    }
    if (data.containsKey('thread_id')) {
      context.handle(
        _threadIdMeta,
        threadId.isAcceptableOrUnknown(data['thread_id']!, _threadIdMeta),
      );
    }
    if (data.containsKey('internal_date_ms')) {
      context.handle(
        _internalDateMsMeta,
        internalDateMs.isAcceptableOrUnknown(
          data['internal_date_ms']!,
          _internalDateMsMeta,
        ),
      );
    }
    if (data.containsKey('from_raw')) {
      context.handle(
        _fromRawMeta,
        fromRaw.isAcceptableOrUnknown(data['from_raw']!, _fromRawMeta),
      );
    }
    if (data.containsKey('subject_raw')) {
      context.handle(
        _subjectRawMeta,
        subjectRaw.isAcceptableOrUnknown(data['subject_raw']!, _subjectRawMeta),
      );
    }
    if (data.containsKey('parse_status')) {
      context.handle(
        _parseStatusMeta,
        parseStatus.isAcceptableOrUnknown(
          data['parse_status']!,
          _parseStatusMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_parseStatusMeta);
    }
    if (data.containsKey('first_seen_at')) {
      context.handle(
        _firstSeenAtMeta,
        firstSeenAt.isAcceptableOrUnknown(
          data['first_seen_at']!,
          _firstSeenAtMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_firstSeenAtMeta);
    }
    if (data.containsKey('last_seen_at')) {
      context.handle(
        _lastSeenAtMeta,
        lastSeenAt.isAcceptableOrUnknown(
          data['last_seen_at']!,
          _lastSeenAtMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_lastSeenAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {messageId};
  @override
  GmailMessage map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return GmailMessage(
      messageId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}message_id'],
      )!,
      threadId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}thread_id'],
      ),
      internalDateMs: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}internal_date_ms'],
      ),
      fromRaw: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}from_raw'],
      ),
      subjectRaw: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}subject_raw'],
      ),
      parseStatus: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}parse_status'],
      )!,
      firstSeenAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}first_seen_at'],
      )!,
      lastSeenAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}last_seen_at'],
      )!,
    );
  }

  @override
  $GmailMessagesTable createAlias(String alias) {
    return $GmailMessagesTable(attachedDatabase, alias);
  }
}

class GmailMessage extends DataClass implements Insertable<GmailMessage> {
  final String messageId;
  final String? threadId;
  final int? internalDateMs;
  final String? fromRaw;
  final String? subjectRaw;
  final String parseStatus;
  final String firstSeenAt;
  final String lastSeenAt;
  const GmailMessage({
    required this.messageId,
    this.threadId,
    this.internalDateMs,
    this.fromRaw,
    this.subjectRaw,
    required this.parseStatus,
    required this.firstSeenAt,
    required this.lastSeenAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['message_id'] = Variable<String>(messageId);
    if (!nullToAbsent || threadId != null) {
      map['thread_id'] = Variable<String>(threadId);
    }
    if (!nullToAbsent || internalDateMs != null) {
      map['internal_date_ms'] = Variable<int>(internalDateMs);
    }
    if (!nullToAbsent || fromRaw != null) {
      map['from_raw'] = Variable<String>(fromRaw);
    }
    if (!nullToAbsent || subjectRaw != null) {
      map['subject_raw'] = Variable<String>(subjectRaw);
    }
    map['parse_status'] = Variable<String>(parseStatus);
    map['first_seen_at'] = Variable<String>(firstSeenAt);
    map['last_seen_at'] = Variable<String>(lastSeenAt);
    return map;
  }

  GmailMessagesCompanion toCompanion(bool nullToAbsent) {
    return GmailMessagesCompanion(
      messageId: Value(messageId),
      threadId: threadId == null && nullToAbsent
          ? const Value.absent()
          : Value(threadId),
      internalDateMs: internalDateMs == null && nullToAbsent
          ? const Value.absent()
          : Value(internalDateMs),
      fromRaw: fromRaw == null && nullToAbsent
          ? const Value.absent()
          : Value(fromRaw),
      subjectRaw: subjectRaw == null && nullToAbsent
          ? const Value.absent()
          : Value(subjectRaw),
      parseStatus: Value(parseStatus),
      firstSeenAt: Value(firstSeenAt),
      lastSeenAt: Value(lastSeenAt),
    );
  }

  factory GmailMessage.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return GmailMessage(
      messageId: serializer.fromJson<String>(json['messageId']),
      threadId: serializer.fromJson<String?>(json['threadId']),
      internalDateMs: serializer.fromJson<int?>(json['internalDateMs']),
      fromRaw: serializer.fromJson<String?>(json['fromRaw']),
      subjectRaw: serializer.fromJson<String?>(json['subjectRaw']),
      parseStatus: serializer.fromJson<String>(json['parseStatus']),
      firstSeenAt: serializer.fromJson<String>(json['firstSeenAt']),
      lastSeenAt: serializer.fromJson<String>(json['lastSeenAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'messageId': serializer.toJson<String>(messageId),
      'threadId': serializer.toJson<String?>(threadId),
      'internalDateMs': serializer.toJson<int?>(internalDateMs),
      'fromRaw': serializer.toJson<String?>(fromRaw),
      'subjectRaw': serializer.toJson<String?>(subjectRaw),
      'parseStatus': serializer.toJson<String>(parseStatus),
      'firstSeenAt': serializer.toJson<String>(firstSeenAt),
      'lastSeenAt': serializer.toJson<String>(lastSeenAt),
    };
  }

  GmailMessage copyWith({
    String? messageId,
    Value<String?> threadId = const Value.absent(),
    Value<int?> internalDateMs = const Value.absent(),
    Value<String?> fromRaw = const Value.absent(),
    Value<String?> subjectRaw = const Value.absent(),
    String? parseStatus,
    String? firstSeenAt,
    String? lastSeenAt,
  }) => GmailMessage(
    messageId: messageId ?? this.messageId,
    threadId: threadId.present ? threadId.value : this.threadId,
    internalDateMs: internalDateMs.present
        ? internalDateMs.value
        : this.internalDateMs,
    fromRaw: fromRaw.present ? fromRaw.value : this.fromRaw,
    subjectRaw: subjectRaw.present ? subjectRaw.value : this.subjectRaw,
    parseStatus: parseStatus ?? this.parseStatus,
    firstSeenAt: firstSeenAt ?? this.firstSeenAt,
    lastSeenAt: lastSeenAt ?? this.lastSeenAt,
  );
  GmailMessage copyWithCompanion(GmailMessagesCompanion data) {
    return GmailMessage(
      messageId: data.messageId.present ? data.messageId.value : this.messageId,
      threadId: data.threadId.present ? data.threadId.value : this.threadId,
      internalDateMs: data.internalDateMs.present
          ? data.internalDateMs.value
          : this.internalDateMs,
      fromRaw: data.fromRaw.present ? data.fromRaw.value : this.fromRaw,
      subjectRaw: data.subjectRaw.present
          ? data.subjectRaw.value
          : this.subjectRaw,
      parseStatus: data.parseStatus.present
          ? data.parseStatus.value
          : this.parseStatus,
      firstSeenAt: data.firstSeenAt.present
          ? data.firstSeenAt.value
          : this.firstSeenAt,
      lastSeenAt: data.lastSeenAt.present
          ? data.lastSeenAt.value
          : this.lastSeenAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('GmailMessage(')
          ..write('messageId: $messageId, ')
          ..write('threadId: $threadId, ')
          ..write('internalDateMs: $internalDateMs, ')
          ..write('fromRaw: $fromRaw, ')
          ..write('subjectRaw: $subjectRaw, ')
          ..write('parseStatus: $parseStatus, ')
          ..write('firstSeenAt: $firstSeenAt, ')
          ..write('lastSeenAt: $lastSeenAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    messageId,
    threadId,
    internalDateMs,
    fromRaw,
    subjectRaw,
    parseStatus,
    firstSeenAt,
    lastSeenAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is GmailMessage &&
          other.messageId == this.messageId &&
          other.threadId == this.threadId &&
          other.internalDateMs == this.internalDateMs &&
          other.fromRaw == this.fromRaw &&
          other.subjectRaw == this.subjectRaw &&
          other.parseStatus == this.parseStatus &&
          other.firstSeenAt == this.firstSeenAt &&
          other.lastSeenAt == this.lastSeenAt);
}

class GmailMessagesCompanion extends UpdateCompanion<GmailMessage> {
  final Value<String> messageId;
  final Value<String?> threadId;
  final Value<int?> internalDateMs;
  final Value<String?> fromRaw;
  final Value<String?> subjectRaw;
  final Value<String> parseStatus;
  final Value<String> firstSeenAt;
  final Value<String> lastSeenAt;
  final Value<int> rowid;
  const GmailMessagesCompanion({
    this.messageId = const Value.absent(),
    this.threadId = const Value.absent(),
    this.internalDateMs = const Value.absent(),
    this.fromRaw = const Value.absent(),
    this.subjectRaw = const Value.absent(),
    this.parseStatus = const Value.absent(),
    this.firstSeenAt = const Value.absent(),
    this.lastSeenAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  GmailMessagesCompanion.insert({
    required String messageId,
    this.threadId = const Value.absent(),
    this.internalDateMs = const Value.absent(),
    this.fromRaw = const Value.absent(),
    this.subjectRaw = const Value.absent(),
    required String parseStatus,
    required String firstSeenAt,
    required String lastSeenAt,
    this.rowid = const Value.absent(),
  }) : messageId = Value(messageId),
       parseStatus = Value(parseStatus),
       firstSeenAt = Value(firstSeenAt),
       lastSeenAt = Value(lastSeenAt);
  static Insertable<GmailMessage> custom({
    Expression<String>? messageId,
    Expression<String>? threadId,
    Expression<int>? internalDateMs,
    Expression<String>? fromRaw,
    Expression<String>? subjectRaw,
    Expression<String>? parseStatus,
    Expression<String>? firstSeenAt,
    Expression<String>? lastSeenAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (messageId != null) 'message_id': messageId,
      if (threadId != null) 'thread_id': threadId,
      if (internalDateMs != null) 'internal_date_ms': internalDateMs,
      if (fromRaw != null) 'from_raw': fromRaw,
      if (subjectRaw != null) 'subject_raw': subjectRaw,
      if (parseStatus != null) 'parse_status': parseStatus,
      if (firstSeenAt != null) 'first_seen_at': firstSeenAt,
      if (lastSeenAt != null) 'last_seen_at': lastSeenAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  GmailMessagesCompanion copyWith({
    Value<String>? messageId,
    Value<String?>? threadId,
    Value<int?>? internalDateMs,
    Value<String?>? fromRaw,
    Value<String?>? subjectRaw,
    Value<String>? parseStatus,
    Value<String>? firstSeenAt,
    Value<String>? lastSeenAt,
    Value<int>? rowid,
  }) {
    return GmailMessagesCompanion(
      messageId: messageId ?? this.messageId,
      threadId: threadId ?? this.threadId,
      internalDateMs: internalDateMs ?? this.internalDateMs,
      fromRaw: fromRaw ?? this.fromRaw,
      subjectRaw: subjectRaw ?? this.subjectRaw,
      parseStatus: parseStatus ?? this.parseStatus,
      firstSeenAt: firstSeenAt ?? this.firstSeenAt,
      lastSeenAt: lastSeenAt ?? this.lastSeenAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (messageId.present) {
      map['message_id'] = Variable<String>(messageId.value);
    }
    if (threadId.present) {
      map['thread_id'] = Variable<String>(threadId.value);
    }
    if (internalDateMs.present) {
      map['internal_date_ms'] = Variable<int>(internalDateMs.value);
    }
    if (fromRaw.present) {
      map['from_raw'] = Variable<String>(fromRaw.value);
    }
    if (subjectRaw.present) {
      map['subject_raw'] = Variable<String>(subjectRaw.value);
    }
    if (parseStatus.present) {
      map['parse_status'] = Variable<String>(parseStatus.value);
    }
    if (firstSeenAt.present) {
      map['first_seen_at'] = Variable<String>(firstSeenAt.value);
    }
    if (lastSeenAt.present) {
      map['last_seen_at'] = Variable<String>(lastSeenAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('GmailMessagesCompanion(')
          ..write('messageId: $messageId, ')
          ..write('threadId: $threadId, ')
          ..write('internalDateMs: $internalDateMs, ')
          ..write('fromRaw: $fromRaw, ')
          ..write('subjectRaw: $subjectRaw, ')
          ..write('parseStatus: $parseStatus, ')
          ..write('firstSeenAt: $firstSeenAt, ')
          ..write('lastSeenAt: $lastSeenAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $AppAccountsTable extends AppAccounts
    with TableInfo<$AppAccountsTable, AppAccount> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AppAccountsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _emailMeta = const VerificationMeta('email');
  @override
  late final GeneratedColumn<String> email = GeneratedColumn<String>(
    'email',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _displayNameMeta = const VerificationMeta(
    'displayName',
  );
  @override
  late final GeneratedColumn<String> displayName = GeneratedColumn<String>(
    'display_name',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _backendAccountIdMeta = const VerificationMeta(
    'backendAccountId',
  );
  @override
  late final GeneratedColumn<String> backendAccountId = GeneratedColumn<String>(
    'backend_account_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('connected'),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    email,
    displayName,
    backendAccountId,
    status,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'app_accounts';
  @override
  VerificationContext validateIntegrity(
    Insertable<AppAccount> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('email')) {
      context.handle(
        _emailMeta,
        email.isAcceptableOrUnknown(data['email']!, _emailMeta),
      );
    } else if (isInserting) {
      context.missing(_emailMeta);
    }
    if (data.containsKey('display_name')) {
      context.handle(
        _displayNameMeta,
        displayName.isAcceptableOrUnknown(
          data['display_name']!,
          _displayNameMeta,
        ),
      );
    }
    if (data.containsKey('backend_account_id')) {
      context.handle(
        _backendAccountIdMeta,
        backendAccountId.isAcceptableOrUnknown(
          data['backend_account_id']!,
          _backendAccountIdMeta,
        ),
      );
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  AppAccount map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AppAccount(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      email: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}email'],
      )!,
      displayName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}display_name'],
      ),
      backendAccountId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}backend_account_id'],
      ),
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $AppAccountsTable createAlias(String alias) {
    return $AppAccountsTable(attachedDatabase, alias);
  }
}

class AppAccount extends DataClass implements Insertable<AppAccount> {
  final String id;
  final String email;
  final String? displayName;
  final String? backendAccountId;
  final String status;
  final DateTime createdAt;
  final DateTime updatedAt;
  const AppAccount({
    required this.id,
    required this.email,
    this.displayName,
    this.backendAccountId,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['email'] = Variable<String>(email);
    if (!nullToAbsent || displayName != null) {
      map['display_name'] = Variable<String>(displayName);
    }
    if (!nullToAbsent || backendAccountId != null) {
      map['backend_account_id'] = Variable<String>(backendAccountId);
    }
    map['status'] = Variable<String>(status);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  AppAccountsCompanion toCompanion(bool nullToAbsent) {
    return AppAccountsCompanion(
      id: Value(id),
      email: Value(email),
      displayName: displayName == null && nullToAbsent
          ? const Value.absent()
          : Value(displayName),
      backendAccountId: backendAccountId == null && nullToAbsent
          ? const Value.absent()
          : Value(backendAccountId),
      status: Value(status),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory AppAccount.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AppAccount(
      id: serializer.fromJson<String>(json['id']),
      email: serializer.fromJson<String>(json['email']),
      displayName: serializer.fromJson<String?>(json['displayName']),
      backendAccountId: serializer.fromJson<String?>(json['backendAccountId']),
      status: serializer.fromJson<String>(json['status']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'email': serializer.toJson<String>(email),
      'displayName': serializer.toJson<String?>(displayName),
      'backendAccountId': serializer.toJson<String?>(backendAccountId),
      'status': serializer.toJson<String>(status),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  AppAccount copyWith({
    String? id,
    String? email,
    Value<String?> displayName = const Value.absent(),
    Value<String?> backendAccountId = const Value.absent(),
    String? status,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => AppAccount(
    id: id ?? this.id,
    email: email ?? this.email,
    displayName: displayName.present ? displayName.value : this.displayName,
    backendAccountId: backendAccountId.present
        ? backendAccountId.value
        : this.backendAccountId,
    status: status ?? this.status,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  AppAccount copyWithCompanion(AppAccountsCompanion data) {
    return AppAccount(
      id: data.id.present ? data.id.value : this.id,
      email: data.email.present ? data.email.value : this.email,
      displayName: data.displayName.present
          ? data.displayName.value
          : this.displayName,
      backendAccountId: data.backendAccountId.present
          ? data.backendAccountId.value
          : this.backendAccountId,
      status: data.status.present ? data.status.value : this.status,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AppAccount(')
          ..write('id: $id, ')
          ..write('email: $email, ')
          ..write('displayName: $displayName, ')
          ..write('backendAccountId: $backendAccountId, ')
          ..write('status: $status, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    email,
    displayName,
    backendAccountId,
    status,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AppAccount &&
          other.id == this.id &&
          other.email == this.email &&
          other.displayName == this.displayName &&
          other.backendAccountId == this.backendAccountId &&
          other.status == this.status &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class AppAccountsCompanion extends UpdateCompanion<AppAccount> {
  final Value<String> id;
  final Value<String> email;
  final Value<String?> displayName;
  final Value<String?> backendAccountId;
  final Value<String> status;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const AppAccountsCompanion({
    this.id = const Value.absent(),
    this.email = const Value.absent(),
    this.displayName = const Value.absent(),
    this.backendAccountId = const Value.absent(),
    this.status = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  AppAccountsCompanion.insert({
    required String id,
    required String email,
    this.displayName = const Value.absent(),
    this.backendAccountId = const Value.absent(),
    this.status = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       email = Value(email),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<AppAccount> custom({
    Expression<String>? id,
    Expression<String>? email,
    Expression<String>? displayName,
    Expression<String>? backendAccountId,
    Expression<String>? status,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (email != null) 'email': email,
      if (displayName != null) 'display_name': displayName,
      if (backendAccountId != null) 'backend_account_id': backendAccountId,
      if (status != null) 'status': status,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  AppAccountsCompanion copyWith({
    Value<String>? id,
    Value<String>? email,
    Value<String?>? displayName,
    Value<String?>? backendAccountId,
    Value<String>? status,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return AppAccountsCompanion(
      id: id ?? this.id,
      email: email ?? this.email,
      displayName: displayName ?? this.displayName,
      backendAccountId: backendAccountId ?? this.backendAccountId,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (email.present) {
      map['email'] = Variable<String>(email.value);
    }
    if (displayName.present) {
      map['display_name'] = Variable<String>(displayName.value);
    }
    if (backendAccountId.present) {
      map['backend_account_id'] = Variable<String>(backendAccountId.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AppAccountsCompanion(')
          ..write('id: $id, ')
          ..write('email: $email, ')
          ..write('displayName: $displayName, ')
          ..write('backendAccountId: $backendAccountId, ')
          ..write('status: $status, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SourcesTable extends Sources with TableInfo<$SourcesTable, Source> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SourcesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _accountIdMeta = const VerificationMeta(
    'accountId',
  );
  @override
  late final GeneratedColumn<String> accountId = GeneratedColumn<String>(
    'account_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES app_accounts (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _labelMeta = const VerificationMeta('label');
  @override
  late final GeneratedColumn<String> label = GeneratedColumn<String>(
    'label',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _rulePackMeta = const VerificationMeta(
    'rulePack',
  );
  @override
  late final GeneratedColumn<String> rulePack = GeneratedColumn<String>(
    'rule_pack',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('school_in'),
  );
  static const VerificationMeta _enabledMeta = const VerificationMeta(
    'enabled',
  );
  @override
  late final GeneratedColumn<bool> enabled = GeneratedColumn<bool>(
    'enabled',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("enabled" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    accountId,
    label,
    rulePack,
    enabled,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'sources';
  @override
  VerificationContext validateIntegrity(
    Insertable<Source> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('account_id')) {
      context.handle(
        _accountIdMeta,
        accountId.isAcceptableOrUnknown(data['account_id']!, _accountIdMeta),
      );
    } else if (isInserting) {
      context.missing(_accountIdMeta);
    }
    if (data.containsKey('label')) {
      context.handle(
        _labelMeta,
        label.isAcceptableOrUnknown(data['label']!, _labelMeta),
      );
    } else if (isInserting) {
      context.missing(_labelMeta);
    }
    if (data.containsKey('rule_pack')) {
      context.handle(
        _rulePackMeta,
        rulePack.isAcceptableOrUnknown(data['rule_pack']!, _rulePackMeta),
      );
    }
    if (data.containsKey('enabled')) {
      context.handle(
        _enabledMeta,
        enabled.isAcceptableOrUnknown(data['enabled']!, _enabledMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Source map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Source(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      accountId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}account_id'],
      )!,
      label: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}label'],
      )!,
      rulePack: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}rule_pack'],
      )!,
      enabled: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}enabled'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $SourcesTable createAlias(String alias) {
    return $SourcesTable(attachedDatabase, alias);
  }
}

class Source extends DataClass implements Insertable<Source> {
  final String id;
  final String accountId;
  final String label;
  final String rulePack;
  final bool enabled;
  final DateTime createdAt;
  final DateTime updatedAt;
  const Source({
    required this.id,
    required this.accountId,
    required this.label,
    required this.rulePack,
    required this.enabled,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['account_id'] = Variable<String>(accountId);
    map['label'] = Variable<String>(label);
    map['rule_pack'] = Variable<String>(rulePack);
    map['enabled'] = Variable<bool>(enabled);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  SourcesCompanion toCompanion(bool nullToAbsent) {
    return SourcesCompanion(
      id: Value(id),
      accountId: Value(accountId),
      label: Value(label),
      rulePack: Value(rulePack),
      enabled: Value(enabled),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory Source.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Source(
      id: serializer.fromJson<String>(json['id']),
      accountId: serializer.fromJson<String>(json['accountId']),
      label: serializer.fromJson<String>(json['label']),
      rulePack: serializer.fromJson<String>(json['rulePack']),
      enabled: serializer.fromJson<bool>(json['enabled']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'accountId': serializer.toJson<String>(accountId),
      'label': serializer.toJson<String>(label),
      'rulePack': serializer.toJson<String>(rulePack),
      'enabled': serializer.toJson<bool>(enabled),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  Source copyWith({
    String? id,
    String? accountId,
    String? label,
    String? rulePack,
    bool? enabled,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => Source(
    id: id ?? this.id,
    accountId: accountId ?? this.accountId,
    label: label ?? this.label,
    rulePack: rulePack ?? this.rulePack,
    enabled: enabled ?? this.enabled,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  Source copyWithCompanion(SourcesCompanion data) {
    return Source(
      id: data.id.present ? data.id.value : this.id,
      accountId: data.accountId.present ? data.accountId.value : this.accountId,
      label: data.label.present ? data.label.value : this.label,
      rulePack: data.rulePack.present ? data.rulePack.value : this.rulePack,
      enabled: data.enabled.present ? data.enabled.value : this.enabled,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Source(')
          ..write('id: $id, ')
          ..write('accountId: $accountId, ')
          ..write('label: $label, ')
          ..write('rulePack: $rulePack, ')
          ..write('enabled: $enabled, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    accountId,
    label,
    rulePack,
    enabled,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Source &&
          other.id == this.id &&
          other.accountId == this.accountId &&
          other.label == this.label &&
          other.rulePack == this.rulePack &&
          other.enabled == this.enabled &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class SourcesCompanion extends UpdateCompanion<Source> {
  final Value<String> id;
  final Value<String> accountId;
  final Value<String> label;
  final Value<String> rulePack;
  final Value<bool> enabled;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const SourcesCompanion({
    this.id = const Value.absent(),
    this.accountId = const Value.absent(),
    this.label = const Value.absent(),
    this.rulePack = const Value.absent(),
    this.enabled = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SourcesCompanion.insert({
    required String id,
    required String accountId,
    required String label,
    this.rulePack = const Value.absent(),
    this.enabled = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       accountId = Value(accountId),
       label = Value(label),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<Source> custom({
    Expression<String>? id,
    Expression<String>? accountId,
    Expression<String>? label,
    Expression<String>? rulePack,
    Expression<bool>? enabled,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (accountId != null) 'account_id': accountId,
      if (label != null) 'label': label,
      if (rulePack != null) 'rule_pack': rulePack,
      if (enabled != null) 'enabled': enabled,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SourcesCompanion copyWith({
    Value<String>? id,
    Value<String>? accountId,
    Value<String>? label,
    Value<String>? rulePack,
    Value<bool>? enabled,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return SourcesCompanion(
      id: id ?? this.id,
      accountId: accountId ?? this.accountId,
      label: label ?? this.label,
      rulePack: rulePack ?? this.rulePack,
      enabled: enabled ?? this.enabled,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (accountId.present) {
      map['account_id'] = Variable<String>(accountId.value);
    }
    if (label.present) {
      map['label'] = Variable<String>(label.value);
    }
    if (rulePack.present) {
      map['rule_pack'] = Variable<String>(rulePack.value);
    }
    if (enabled.present) {
      map['enabled'] = Variable<bool>(enabled.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SourcesCompanion(')
          ..write('id: $id, ')
          ..write('accountId: $accountId, ')
          ..write('label: $label, ')
          ..write('rulePack: $rulePack, ')
          ..write('enabled: $enabled, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SourceAllowlistEntriesTable extends SourceAllowlistEntries
    with TableInfo<$SourceAllowlistEntriesTable, SourceAllowlistEntry> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SourceAllowlistEntriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sourceIdMeta = const VerificationMeta(
    'sourceId',
  );
  @override
  late final GeneratedColumn<String> sourceId = GeneratedColumn<String>(
    'source_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES sources (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _kindMeta = const VerificationMeta('kind');
  @override
  late final GeneratedColumn<String> kind = GeneratedColumn<String>(
    'kind',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _valueMeta = const VerificationMeta('value');
  @override
  late final GeneratedColumn<String> value = GeneratedColumn<String>(
    'value',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, sourceId, kind, value, createdAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'source_allowlist_entries';
  @override
  VerificationContext validateIntegrity(
    Insertable<SourceAllowlistEntry> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('source_id')) {
      context.handle(
        _sourceIdMeta,
        sourceId.isAcceptableOrUnknown(data['source_id']!, _sourceIdMeta),
      );
    } else if (isInserting) {
      context.missing(_sourceIdMeta);
    }
    if (data.containsKey('kind')) {
      context.handle(
        _kindMeta,
        kind.isAcceptableOrUnknown(data['kind']!, _kindMeta),
      );
    } else if (isInserting) {
      context.missing(_kindMeta);
    }
    if (data.containsKey('value')) {
      context.handle(
        _valueMeta,
        value.isAcceptableOrUnknown(data['value']!, _valueMeta),
      );
    } else if (isInserting) {
      context.missing(_valueMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SourceAllowlistEntry map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SourceAllowlistEntry(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      sourceId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}source_id'],
      )!,
      kind: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}kind'],
      )!,
      value: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}value'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $SourceAllowlistEntriesTable createAlias(String alias) {
    return $SourceAllowlistEntriesTable(attachedDatabase, alias);
  }
}

class SourceAllowlistEntry extends DataClass
    implements Insertable<SourceAllowlistEntry> {
  final String id;
  final String sourceId;
  final String kind;
  final String value;
  final DateTime createdAt;
  const SourceAllowlistEntry({
    required this.id,
    required this.sourceId,
    required this.kind,
    required this.value,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['source_id'] = Variable<String>(sourceId);
    map['kind'] = Variable<String>(kind);
    map['value'] = Variable<String>(value);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  SourceAllowlistEntriesCompanion toCompanion(bool nullToAbsent) {
    return SourceAllowlistEntriesCompanion(
      id: Value(id),
      sourceId: Value(sourceId),
      kind: Value(kind),
      value: Value(value),
      createdAt: Value(createdAt),
    );
  }

  factory SourceAllowlistEntry.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SourceAllowlistEntry(
      id: serializer.fromJson<String>(json['id']),
      sourceId: serializer.fromJson<String>(json['sourceId']),
      kind: serializer.fromJson<String>(json['kind']),
      value: serializer.fromJson<String>(json['value']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'sourceId': serializer.toJson<String>(sourceId),
      'kind': serializer.toJson<String>(kind),
      'value': serializer.toJson<String>(value),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  SourceAllowlistEntry copyWith({
    String? id,
    String? sourceId,
    String? kind,
    String? value,
    DateTime? createdAt,
  }) => SourceAllowlistEntry(
    id: id ?? this.id,
    sourceId: sourceId ?? this.sourceId,
    kind: kind ?? this.kind,
    value: value ?? this.value,
    createdAt: createdAt ?? this.createdAt,
  );
  SourceAllowlistEntry copyWithCompanion(SourceAllowlistEntriesCompanion data) {
    return SourceAllowlistEntry(
      id: data.id.present ? data.id.value : this.id,
      sourceId: data.sourceId.present ? data.sourceId.value : this.sourceId,
      kind: data.kind.present ? data.kind.value : this.kind,
      value: data.value.present ? data.value.value : this.value,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SourceAllowlistEntry(')
          ..write('id: $id, ')
          ..write('sourceId: $sourceId, ')
          ..write('kind: $kind, ')
          ..write('value: $value, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, sourceId, kind, value, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SourceAllowlistEntry &&
          other.id == this.id &&
          other.sourceId == this.sourceId &&
          other.kind == this.kind &&
          other.value == this.value &&
          other.createdAt == this.createdAt);
}

class SourceAllowlistEntriesCompanion
    extends UpdateCompanion<SourceAllowlistEntry> {
  final Value<String> id;
  final Value<String> sourceId;
  final Value<String> kind;
  final Value<String> value;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const SourceAllowlistEntriesCompanion({
    this.id = const Value.absent(),
    this.sourceId = const Value.absent(),
    this.kind = const Value.absent(),
    this.value = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SourceAllowlistEntriesCompanion.insert({
    required String id,
    required String sourceId,
    required String kind,
    required String value,
    required DateTime createdAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       sourceId = Value(sourceId),
       kind = Value(kind),
       value = Value(value),
       createdAt = Value(createdAt);
  static Insertable<SourceAllowlistEntry> custom({
    Expression<String>? id,
    Expression<String>? sourceId,
    Expression<String>? kind,
    Expression<String>? value,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (sourceId != null) 'source_id': sourceId,
      if (kind != null) 'kind': kind,
      if (value != null) 'value': value,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SourceAllowlistEntriesCompanion copyWith({
    Value<String>? id,
    Value<String>? sourceId,
    Value<String>? kind,
    Value<String>? value,
    Value<DateTime>? createdAt,
    Value<int>? rowid,
  }) {
    return SourceAllowlistEntriesCompanion(
      id: id ?? this.id,
      sourceId: sourceId ?? this.sourceId,
      kind: kind ?? this.kind,
      value: value ?? this.value,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (sourceId.present) {
      map['source_id'] = Variable<String>(sourceId.value);
    }
    if (kind.present) {
      map['kind'] = Variable<String>(kind.value);
    }
    if (value.present) {
      map['value'] = Variable<String>(value.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SourceAllowlistEntriesCompanion(')
          ..write('id: $id, ')
          ..write('sourceId: $sourceId, ')
          ..write('kind: $kind, ')
          ..write('value: $value, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $GmailMessageAccountsTable extends GmailMessageAccounts
    with TableInfo<$GmailMessageAccountsTable, GmailMessageAccount> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $GmailMessageAccountsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _messageIdMeta = const VerificationMeta(
    'messageId',
  );
  @override
  late final GeneratedColumn<String> messageId = GeneratedColumn<String>(
    'message_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES gmail_messages (message_id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _accountIdMeta = const VerificationMeta(
    'accountId',
  );
  @override
  late final GeneratedColumn<String> accountId = GeneratedColumn<String>(
    'account_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES app_accounts (id) ON DELETE CASCADE',
    ),
  );
  @override
  List<GeneratedColumn> get $columns => [messageId, accountId];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'gmail_message_accounts';
  @override
  VerificationContext validateIntegrity(
    Insertable<GmailMessageAccount> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('message_id')) {
      context.handle(
        _messageIdMeta,
        messageId.isAcceptableOrUnknown(data['message_id']!, _messageIdMeta),
      );
    } else if (isInserting) {
      context.missing(_messageIdMeta);
    }
    if (data.containsKey('account_id')) {
      context.handle(
        _accountIdMeta,
        accountId.isAcceptableOrUnknown(data['account_id']!, _accountIdMeta),
      );
    } else if (isInserting) {
      context.missing(_accountIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {messageId, accountId};
  @override
  GmailMessageAccount map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return GmailMessageAccount(
      messageId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}message_id'],
      )!,
      accountId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}account_id'],
      )!,
    );
  }

  @override
  $GmailMessageAccountsTable createAlias(String alias) {
    return $GmailMessageAccountsTable(attachedDatabase, alias);
  }
}

class GmailMessageAccount extends DataClass
    implements Insertable<GmailMessageAccount> {
  final String messageId;
  final String accountId;
  const GmailMessageAccount({required this.messageId, required this.accountId});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['message_id'] = Variable<String>(messageId);
    map['account_id'] = Variable<String>(accountId);
    return map;
  }

  GmailMessageAccountsCompanion toCompanion(bool nullToAbsent) {
    return GmailMessageAccountsCompanion(
      messageId: Value(messageId),
      accountId: Value(accountId),
    );
  }

  factory GmailMessageAccount.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return GmailMessageAccount(
      messageId: serializer.fromJson<String>(json['messageId']),
      accountId: serializer.fromJson<String>(json['accountId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'messageId': serializer.toJson<String>(messageId),
      'accountId': serializer.toJson<String>(accountId),
    };
  }

  GmailMessageAccount copyWith({String? messageId, String? accountId}) =>
      GmailMessageAccount(
        messageId: messageId ?? this.messageId,
        accountId: accountId ?? this.accountId,
      );
  GmailMessageAccount copyWithCompanion(GmailMessageAccountsCompanion data) {
    return GmailMessageAccount(
      messageId: data.messageId.present ? data.messageId.value : this.messageId,
      accountId: data.accountId.present ? data.accountId.value : this.accountId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('GmailMessageAccount(')
          ..write('messageId: $messageId, ')
          ..write('accountId: $accountId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(messageId, accountId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is GmailMessageAccount &&
          other.messageId == this.messageId &&
          other.accountId == this.accountId);
}

class GmailMessageAccountsCompanion
    extends UpdateCompanion<GmailMessageAccount> {
  final Value<String> messageId;
  final Value<String> accountId;
  final Value<int> rowid;
  const GmailMessageAccountsCompanion({
    this.messageId = const Value.absent(),
    this.accountId = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  GmailMessageAccountsCompanion.insert({
    required String messageId,
    required String accountId,
    this.rowid = const Value.absent(),
  }) : messageId = Value(messageId),
       accountId = Value(accountId);
  static Insertable<GmailMessageAccount> custom({
    Expression<String>? messageId,
    Expression<String>? accountId,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (messageId != null) 'message_id': messageId,
      if (accountId != null) 'account_id': accountId,
      if (rowid != null) 'rowid': rowid,
    });
  }

  GmailMessageAccountsCompanion copyWith({
    Value<String>? messageId,
    Value<String>? accountId,
    Value<int>? rowid,
  }) {
    return GmailMessageAccountsCompanion(
      messageId: messageId ?? this.messageId,
      accountId: accountId ?? this.accountId,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (messageId.present) {
      map['message_id'] = Variable<String>(messageId.value);
    }
    if (accountId.present) {
      map['account_id'] = Variable<String>(accountId.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('GmailMessageAccountsCompanion(')
          ..write('messageId: $messageId, ')
          ..write('accountId: $accountId, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $GmailMessageBodiesTable extends GmailMessageBodies
    with TableInfo<$GmailMessageBodiesTable, GmailMessageBody> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $GmailMessageBodiesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _messageIdMeta = const VerificationMeta(
    'messageId',
  );
  @override
  late final GeneratedColumn<String> messageId = GeneratedColumn<String>(
    'message_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES gmail_messages (message_id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _normalizedBodyMeta = const VerificationMeta(
    'normalizedBody',
  );
  @override
  late final GeneratedColumn<String> normalizedBody = GeneratedColumn<String>(
    'normalized_body',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _fetchedAtMeta = const VerificationMeta(
    'fetchedAt',
  );
  @override
  late final GeneratedColumn<DateTime> fetchedAt = GeneratedColumn<DateTime>(
    'fetched_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _expiresAtMeta = const VerificationMeta(
    'expiresAt',
  );
  @override
  late final GeneratedColumn<DateTime> expiresAt = GeneratedColumn<DateTime>(
    'expires_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _parserVersionMeta = const VerificationMeta(
    'parserVersion',
  );
  @override
  late final GeneratedColumn<String> parserVersion = GeneratedColumn<String>(
    'parser_version',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    messageId,
    normalizedBody,
    fetchedAt,
    expiresAt,
    parserVersion,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'gmail_message_bodies';
  @override
  VerificationContext validateIntegrity(
    Insertable<GmailMessageBody> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('message_id')) {
      context.handle(
        _messageIdMeta,
        messageId.isAcceptableOrUnknown(data['message_id']!, _messageIdMeta),
      );
    } else if (isInserting) {
      context.missing(_messageIdMeta);
    }
    if (data.containsKey('normalized_body')) {
      context.handle(
        _normalizedBodyMeta,
        normalizedBody.isAcceptableOrUnknown(
          data['normalized_body']!,
          _normalizedBodyMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_normalizedBodyMeta);
    }
    if (data.containsKey('fetched_at')) {
      context.handle(
        _fetchedAtMeta,
        fetchedAt.isAcceptableOrUnknown(data['fetched_at']!, _fetchedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_fetchedAtMeta);
    }
    if (data.containsKey('expires_at')) {
      context.handle(
        _expiresAtMeta,
        expiresAt.isAcceptableOrUnknown(data['expires_at']!, _expiresAtMeta),
      );
    } else if (isInserting) {
      context.missing(_expiresAtMeta);
    }
    if (data.containsKey('parser_version')) {
      context.handle(
        _parserVersionMeta,
        parserVersion.isAcceptableOrUnknown(
          data['parser_version']!,
          _parserVersionMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {messageId};
  @override
  GmailMessageBody map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return GmailMessageBody(
      messageId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}message_id'],
      )!,
      normalizedBody: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}normalized_body'],
      )!,
      fetchedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}fetched_at'],
      )!,
      expiresAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}expires_at'],
      )!,
      parserVersion: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}parser_version'],
      ),
    );
  }

  @override
  $GmailMessageBodiesTable createAlias(String alias) {
    return $GmailMessageBodiesTable(attachedDatabase, alias);
  }
}

class GmailMessageBody extends DataClass
    implements Insertable<GmailMessageBody> {
  final String messageId;
  final String normalizedBody;
  final DateTime fetchedAt;
  final DateTime expiresAt;
  final String? parserVersion;
  const GmailMessageBody({
    required this.messageId,
    required this.normalizedBody,
    required this.fetchedAt,
    required this.expiresAt,
    this.parserVersion,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['message_id'] = Variable<String>(messageId);
    map['normalized_body'] = Variable<String>(normalizedBody);
    map['fetched_at'] = Variable<DateTime>(fetchedAt);
    map['expires_at'] = Variable<DateTime>(expiresAt);
    if (!nullToAbsent || parserVersion != null) {
      map['parser_version'] = Variable<String>(parserVersion);
    }
    return map;
  }

  GmailMessageBodiesCompanion toCompanion(bool nullToAbsent) {
    return GmailMessageBodiesCompanion(
      messageId: Value(messageId),
      normalizedBody: Value(normalizedBody),
      fetchedAt: Value(fetchedAt),
      expiresAt: Value(expiresAt),
      parserVersion: parserVersion == null && nullToAbsent
          ? const Value.absent()
          : Value(parserVersion),
    );
  }

  factory GmailMessageBody.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return GmailMessageBody(
      messageId: serializer.fromJson<String>(json['messageId']),
      normalizedBody: serializer.fromJson<String>(json['normalizedBody']),
      fetchedAt: serializer.fromJson<DateTime>(json['fetchedAt']),
      expiresAt: serializer.fromJson<DateTime>(json['expiresAt']),
      parserVersion: serializer.fromJson<String?>(json['parserVersion']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'messageId': serializer.toJson<String>(messageId),
      'normalizedBody': serializer.toJson<String>(normalizedBody),
      'fetchedAt': serializer.toJson<DateTime>(fetchedAt),
      'expiresAt': serializer.toJson<DateTime>(expiresAt),
      'parserVersion': serializer.toJson<String?>(parserVersion),
    };
  }

  GmailMessageBody copyWith({
    String? messageId,
    String? normalizedBody,
    DateTime? fetchedAt,
    DateTime? expiresAt,
    Value<String?> parserVersion = const Value.absent(),
  }) => GmailMessageBody(
    messageId: messageId ?? this.messageId,
    normalizedBody: normalizedBody ?? this.normalizedBody,
    fetchedAt: fetchedAt ?? this.fetchedAt,
    expiresAt: expiresAt ?? this.expiresAt,
    parserVersion: parserVersion.present
        ? parserVersion.value
        : this.parserVersion,
  );
  GmailMessageBody copyWithCompanion(GmailMessageBodiesCompanion data) {
    return GmailMessageBody(
      messageId: data.messageId.present ? data.messageId.value : this.messageId,
      normalizedBody: data.normalizedBody.present
          ? data.normalizedBody.value
          : this.normalizedBody,
      fetchedAt: data.fetchedAt.present ? data.fetchedAt.value : this.fetchedAt,
      expiresAt: data.expiresAt.present ? data.expiresAt.value : this.expiresAt,
      parserVersion: data.parserVersion.present
          ? data.parserVersion.value
          : this.parserVersion,
    );
  }

  @override
  String toString() {
    return (StringBuffer('GmailMessageBody(')
          ..write('messageId: $messageId, ')
          ..write('normalizedBody: $normalizedBody, ')
          ..write('fetchedAt: $fetchedAt, ')
          ..write('expiresAt: $expiresAt, ')
          ..write('parserVersion: $parserVersion')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    messageId,
    normalizedBody,
    fetchedAt,
    expiresAt,
    parserVersion,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is GmailMessageBody &&
          other.messageId == this.messageId &&
          other.normalizedBody == this.normalizedBody &&
          other.fetchedAt == this.fetchedAt &&
          other.expiresAt == this.expiresAt &&
          other.parserVersion == this.parserVersion);
}

class GmailMessageBodiesCompanion extends UpdateCompanion<GmailMessageBody> {
  final Value<String> messageId;
  final Value<String> normalizedBody;
  final Value<DateTime> fetchedAt;
  final Value<DateTime> expiresAt;
  final Value<String?> parserVersion;
  final Value<int> rowid;
  const GmailMessageBodiesCompanion({
    this.messageId = const Value.absent(),
    this.normalizedBody = const Value.absent(),
    this.fetchedAt = const Value.absent(),
    this.expiresAt = const Value.absent(),
    this.parserVersion = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  GmailMessageBodiesCompanion.insert({
    required String messageId,
    required String normalizedBody,
    required DateTime fetchedAt,
    required DateTime expiresAt,
    this.parserVersion = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : messageId = Value(messageId),
       normalizedBody = Value(normalizedBody),
       fetchedAt = Value(fetchedAt),
       expiresAt = Value(expiresAt);
  static Insertable<GmailMessageBody> custom({
    Expression<String>? messageId,
    Expression<String>? normalizedBody,
    Expression<DateTime>? fetchedAt,
    Expression<DateTime>? expiresAt,
    Expression<String>? parserVersion,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (messageId != null) 'message_id': messageId,
      if (normalizedBody != null) 'normalized_body': normalizedBody,
      if (fetchedAt != null) 'fetched_at': fetchedAt,
      if (expiresAt != null) 'expires_at': expiresAt,
      if (parserVersion != null) 'parser_version': parserVersion,
      if (rowid != null) 'rowid': rowid,
    });
  }

  GmailMessageBodiesCompanion copyWith({
    Value<String>? messageId,
    Value<String>? normalizedBody,
    Value<DateTime>? fetchedAt,
    Value<DateTime>? expiresAt,
    Value<String?>? parserVersion,
    Value<int>? rowid,
  }) {
    return GmailMessageBodiesCompanion(
      messageId: messageId ?? this.messageId,
      normalizedBody: normalizedBody ?? this.normalizedBody,
      fetchedAt: fetchedAt ?? this.fetchedAt,
      expiresAt: expiresAt ?? this.expiresAt,
      parserVersion: parserVersion ?? this.parserVersion,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (messageId.present) {
      map['message_id'] = Variable<String>(messageId.value);
    }
    if (normalizedBody.present) {
      map['normalized_body'] = Variable<String>(normalizedBody.value);
    }
    if (fetchedAt.present) {
      map['fetched_at'] = Variable<DateTime>(fetchedAt.value);
    }
    if (expiresAt.present) {
      map['expires_at'] = Variable<DateTime>(expiresAt.value);
    }
    if (parserVersion.present) {
      map['parser_version'] = Variable<String>(parserVersion.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('GmailMessageBodiesCompanion(')
          ..write('messageId: $messageId, ')
          ..write('normalizedBody: $normalizedBody, ')
          ..write('fetchedAt: $fetchedAt, ')
          ..write('expiresAt: $expiresAt, ')
          ..write('parserVersion: $parserVersion, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $AttachmentsTable extends Attachments
    with TableInfo<$AttachmentsTable, Attachment> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AttachmentsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _messageIdMeta = const VerificationMeta(
    'messageId',
  );
  @override
  late final GeneratedColumn<String> messageId = GeneratedColumn<String>(
    'message_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES gmail_messages (message_id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _gmailAttachmentIdMeta = const VerificationMeta(
    'gmailAttachmentId',
  );
  @override
  late final GeneratedColumn<String> gmailAttachmentId =
      GeneratedColumn<String>(
        'gmail_attachment_id',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _fileNameMeta = const VerificationMeta(
    'fileName',
  );
  @override
  late final GeneratedColumn<String> fileName = GeneratedColumn<String>(
    'file_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _mimeTypeMeta = const VerificationMeta(
    'mimeType',
  );
  @override
  late final GeneratedColumn<String> mimeType = GeneratedColumn<String>(
    'mime_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sizeBytesMeta = const VerificationMeta(
    'sizeBytes',
  );
  @override
  late final GeneratedColumn<int> sizeBytes = GeneratedColumn<int>(
    'size_bytes',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _localPathMeta = const VerificationMeta(
    'localPath',
  );
  @override
  late final GeneratedColumn<String> localPath = GeneratedColumn<String>(
    'local_path',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _sha256Meta = const VerificationMeta('sha256');
  @override
  late final GeneratedColumn<String> sha256 = GeneratedColumn<String>(
    'sha256',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _extractedTextMeta = const VerificationMeta(
    'extractedText',
  );
  @override
  late final GeneratedColumn<String> extractedText = GeneratedColumn<String>(
    'extracted_text',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('listed'),
  );
  static const VerificationMeta _expiresAtMeta = const VerificationMeta(
    'expiresAt',
  );
  @override
  late final GeneratedColumn<DateTime> expiresAt = GeneratedColumn<DateTime>(
    'expires_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    messageId,
    gmailAttachmentId,
    fileName,
    mimeType,
    sizeBytes,
    localPath,
    sha256,
    extractedText,
    status,
    expiresAt,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'attachments';
  @override
  VerificationContext validateIntegrity(
    Insertable<Attachment> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('message_id')) {
      context.handle(
        _messageIdMeta,
        messageId.isAcceptableOrUnknown(data['message_id']!, _messageIdMeta),
      );
    } else if (isInserting) {
      context.missing(_messageIdMeta);
    }
    if (data.containsKey('gmail_attachment_id')) {
      context.handle(
        _gmailAttachmentIdMeta,
        gmailAttachmentId.isAcceptableOrUnknown(
          data['gmail_attachment_id']!,
          _gmailAttachmentIdMeta,
        ),
      );
    }
    if (data.containsKey('file_name')) {
      context.handle(
        _fileNameMeta,
        fileName.isAcceptableOrUnknown(data['file_name']!, _fileNameMeta),
      );
    } else if (isInserting) {
      context.missing(_fileNameMeta);
    }
    if (data.containsKey('mime_type')) {
      context.handle(
        _mimeTypeMeta,
        mimeType.isAcceptableOrUnknown(data['mime_type']!, _mimeTypeMeta),
      );
    } else if (isInserting) {
      context.missing(_mimeTypeMeta);
    }
    if (data.containsKey('size_bytes')) {
      context.handle(
        _sizeBytesMeta,
        sizeBytes.isAcceptableOrUnknown(data['size_bytes']!, _sizeBytesMeta),
      );
    }
    if (data.containsKey('local_path')) {
      context.handle(
        _localPathMeta,
        localPath.isAcceptableOrUnknown(data['local_path']!, _localPathMeta),
      );
    }
    if (data.containsKey('sha256')) {
      context.handle(
        _sha256Meta,
        sha256.isAcceptableOrUnknown(data['sha256']!, _sha256Meta),
      );
    }
    if (data.containsKey('extracted_text')) {
      context.handle(
        _extractedTextMeta,
        extractedText.isAcceptableOrUnknown(
          data['extracted_text']!,
          _extractedTextMeta,
        ),
      );
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    }
    if (data.containsKey('expires_at')) {
      context.handle(
        _expiresAtMeta,
        expiresAt.isAcceptableOrUnknown(data['expires_at']!, _expiresAtMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Attachment map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Attachment(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      messageId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}message_id'],
      )!,
      gmailAttachmentId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}gmail_attachment_id'],
      ),
      fileName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}file_name'],
      )!,
      mimeType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}mime_type'],
      )!,
      sizeBytes: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}size_bytes'],
      ),
      localPath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}local_path'],
      ),
      sha256: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sha256'],
      ),
      extractedText: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}extracted_text'],
      ),
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      expiresAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}expires_at'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $AttachmentsTable createAlias(String alias) {
    return $AttachmentsTable(attachedDatabase, alias);
  }
}

class Attachment extends DataClass implements Insertable<Attachment> {
  final String id;
  final String messageId;
  final String? gmailAttachmentId;
  final String fileName;
  final String mimeType;
  final int? sizeBytes;
  final String? localPath;
  final String? sha256;
  final String? extractedText;
  final String status;
  final DateTime? expiresAt;
  final DateTime createdAt;
  final DateTime updatedAt;
  const Attachment({
    required this.id,
    required this.messageId,
    this.gmailAttachmentId,
    required this.fileName,
    required this.mimeType,
    this.sizeBytes,
    this.localPath,
    this.sha256,
    this.extractedText,
    required this.status,
    this.expiresAt,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['message_id'] = Variable<String>(messageId);
    if (!nullToAbsent || gmailAttachmentId != null) {
      map['gmail_attachment_id'] = Variable<String>(gmailAttachmentId);
    }
    map['file_name'] = Variable<String>(fileName);
    map['mime_type'] = Variable<String>(mimeType);
    if (!nullToAbsent || sizeBytes != null) {
      map['size_bytes'] = Variable<int>(sizeBytes);
    }
    if (!nullToAbsent || localPath != null) {
      map['local_path'] = Variable<String>(localPath);
    }
    if (!nullToAbsent || sha256 != null) {
      map['sha256'] = Variable<String>(sha256);
    }
    if (!nullToAbsent || extractedText != null) {
      map['extracted_text'] = Variable<String>(extractedText);
    }
    map['status'] = Variable<String>(status);
    if (!nullToAbsent || expiresAt != null) {
      map['expires_at'] = Variable<DateTime>(expiresAt);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  AttachmentsCompanion toCompanion(bool nullToAbsent) {
    return AttachmentsCompanion(
      id: Value(id),
      messageId: Value(messageId),
      gmailAttachmentId: gmailAttachmentId == null && nullToAbsent
          ? const Value.absent()
          : Value(gmailAttachmentId),
      fileName: Value(fileName),
      mimeType: Value(mimeType),
      sizeBytes: sizeBytes == null && nullToAbsent
          ? const Value.absent()
          : Value(sizeBytes),
      localPath: localPath == null && nullToAbsent
          ? const Value.absent()
          : Value(localPath),
      sha256: sha256 == null && nullToAbsent
          ? const Value.absent()
          : Value(sha256),
      extractedText: extractedText == null && nullToAbsent
          ? const Value.absent()
          : Value(extractedText),
      status: Value(status),
      expiresAt: expiresAt == null && nullToAbsent
          ? const Value.absent()
          : Value(expiresAt),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory Attachment.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Attachment(
      id: serializer.fromJson<String>(json['id']),
      messageId: serializer.fromJson<String>(json['messageId']),
      gmailAttachmentId: serializer.fromJson<String?>(
        json['gmailAttachmentId'],
      ),
      fileName: serializer.fromJson<String>(json['fileName']),
      mimeType: serializer.fromJson<String>(json['mimeType']),
      sizeBytes: serializer.fromJson<int?>(json['sizeBytes']),
      localPath: serializer.fromJson<String?>(json['localPath']),
      sha256: serializer.fromJson<String?>(json['sha256']),
      extractedText: serializer.fromJson<String?>(json['extractedText']),
      status: serializer.fromJson<String>(json['status']),
      expiresAt: serializer.fromJson<DateTime?>(json['expiresAt']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'messageId': serializer.toJson<String>(messageId),
      'gmailAttachmentId': serializer.toJson<String?>(gmailAttachmentId),
      'fileName': serializer.toJson<String>(fileName),
      'mimeType': serializer.toJson<String>(mimeType),
      'sizeBytes': serializer.toJson<int?>(sizeBytes),
      'localPath': serializer.toJson<String?>(localPath),
      'sha256': serializer.toJson<String?>(sha256),
      'extractedText': serializer.toJson<String?>(extractedText),
      'status': serializer.toJson<String>(status),
      'expiresAt': serializer.toJson<DateTime?>(expiresAt),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  Attachment copyWith({
    String? id,
    String? messageId,
    Value<String?> gmailAttachmentId = const Value.absent(),
    String? fileName,
    String? mimeType,
    Value<int?> sizeBytes = const Value.absent(),
    Value<String?> localPath = const Value.absent(),
    Value<String?> sha256 = const Value.absent(),
    Value<String?> extractedText = const Value.absent(),
    String? status,
    Value<DateTime?> expiresAt = const Value.absent(),
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => Attachment(
    id: id ?? this.id,
    messageId: messageId ?? this.messageId,
    gmailAttachmentId: gmailAttachmentId.present
        ? gmailAttachmentId.value
        : this.gmailAttachmentId,
    fileName: fileName ?? this.fileName,
    mimeType: mimeType ?? this.mimeType,
    sizeBytes: sizeBytes.present ? sizeBytes.value : this.sizeBytes,
    localPath: localPath.present ? localPath.value : this.localPath,
    sha256: sha256.present ? sha256.value : this.sha256,
    extractedText: extractedText.present
        ? extractedText.value
        : this.extractedText,
    status: status ?? this.status,
    expiresAt: expiresAt.present ? expiresAt.value : this.expiresAt,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  Attachment copyWithCompanion(AttachmentsCompanion data) {
    return Attachment(
      id: data.id.present ? data.id.value : this.id,
      messageId: data.messageId.present ? data.messageId.value : this.messageId,
      gmailAttachmentId: data.gmailAttachmentId.present
          ? data.gmailAttachmentId.value
          : this.gmailAttachmentId,
      fileName: data.fileName.present ? data.fileName.value : this.fileName,
      mimeType: data.mimeType.present ? data.mimeType.value : this.mimeType,
      sizeBytes: data.sizeBytes.present ? data.sizeBytes.value : this.sizeBytes,
      localPath: data.localPath.present ? data.localPath.value : this.localPath,
      sha256: data.sha256.present ? data.sha256.value : this.sha256,
      extractedText: data.extractedText.present
          ? data.extractedText.value
          : this.extractedText,
      status: data.status.present ? data.status.value : this.status,
      expiresAt: data.expiresAt.present ? data.expiresAt.value : this.expiresAt,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Attachment(')
          ..write('id: $id, ')
          ..write('messageId: $messageId, ')
          ..write('gmailAttachmentId: $gmailAttachmentId, ')
          ..write('fileName: $fileName, ')
          ..write('mimeType: $mimeType, ')
          ..write('sizeBytes: $sizeBytes, ')
          ..write('localPath: $localPath, ')
          ..write('sha256: $sha256, ')
          ..write('extractedText: $extractedText, ')
          ..write('status: $status, ')
          ..write('expiresAt: $expiresAt, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    messageId,
    gmailAttachmentId,
    fileName,
    mimeType,
    sizeBytes,
    localPath,
    sha256,
    extractedText,
    status,
    expiresAt,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Attachment &&
          other.id == this.id &&
          other.messageId == this.messageId &&
          other.gmailAttachmentId == this.gmailAttachmentId &&
          other.fileName == this.fileName &&
          other.mimeType == this.mimeType &&
          other.sizeBytes == this.sizeBytes &&
          other.localPath == this.localPath &&
          other.sha256 == this.sha256 &&
          other.extractedText == this.extractedText &&
          other.status == this.status &&
          other.expiresAt == this.expiresAt &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class AttachmentsCompanion extends UpdateCompanion<Attachment> {
  final Value<String> id;
  final Value<String> messageId;
  final Value<String?> gmailAttachmentId;
  final Value<String> fileName;
  final Value<String> mimeType;
  final Value<int?> sizeBytes;
  final Value<String?> localPath;
  final Value<String?> sha256;
  final Value<String?> extractedText;
  final Value<String> status;
  final Value<DateTime?> expiresAt;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const AttachmentsCompanion({
    this.id = const Value.absent(),
    this.messageId = const Value.absent(),
    this.gmailAttachmentId = const Value.absent(),
    this.fileName = const Value.absent(),
    this.mimeType = const Value.absent(),
    this.sizeBytes = const Value.absent(),
    this.localPath = const Value.absent(),
    this.sha256 = const Value.absent(),
    this.extractedText = const Value.absent(),
    this.status = const Value.absent(),
    this.expiresAt = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  AttachmentsCompanion.insert({
    required String id,
    required String messageId,
    this.gmailAttachmentId = const Value.absent(),
    required String fileName,
    required String mimeType,
    this.sizeBytes = const Value.absent(),
    this.localPath = const Value.absent(),
    this.sha256 = const Value.absent(),
    this.extractedText = const Value.absent(),
    this.status = const Value.absent(),
    this.expiresAt = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       messageId = Value(messageId),
       fileName = Value(fileName),
       mimeType = Value(mimeType),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<Attachment> custom({
    Expression<String>? id,
    Expression<String>? messageId,
    Expression<String>? gmailAttachmentId,
    Expression<String>? fileName,
    Expression<String>? mimeType,
    Expression<int>? sizeBytes,
    Expression<String>? localPath,
    Expression<String>? sha256,
    Expression<String>? extractedText,
    Expression<String>? status,
    Expression<DateTime>? expiresAt,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (messageId != null) 'message_id': messageId,
      if (gmailAttachmentId != null) 'gmail_attachment_id': gmailAttachmentId,
      if (fileName != null) 'file_name': fileName,
      if (mimeType != null) 'mime_type': mimeType,
      if (sizeBytes != null) 'size_bytes': sizeBytes,
      if (localPath != null) 'local_path': localPath,
      if (sha256 != null) 'sha256': sha256,
      if (extractedText != null) 'extracted_text': extractedText,
      if (status != null) 'status': status,
      if (expiresAt != null) 'expires_at': expiresAt,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  AttachmentsCompanion copyWith({
    Value<String>? id,
    Value<String>? messageId,
    Value<String?>? gmailAttachmentId,
    Value<String>? fileName,
    Value<String>? mimeType,
    Value<int?>? sizeBytes,
    Value<String?>? localPath,
    Value<String?>? sha256,
    Value<String?>? extractedText,
    Value<String>? status,
    Value<DateTime?>? expiresAt,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return AttachmentsCompanion(
      id: id ?? this.id,
      messageId: messageId ?? this.messageId,
      gmailAttachmentId: gmailAttachmentId ?? this.gmailAttachmentId,
      fileName: fileName ?? this.fileName,
      mimeType: mimeType ?? this.mimeType,
      sizeBytes: sizeBytes ?? this.sizeBytes,
      localPath: localPath ?? this.localPath,
      sha256: sha256 ?? this.sha256,
      extractedText: extractedText ?? this.extractedText,
      status: status ?? this.status,
      expiresAt: expiresAt ?? this.expiresAt,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (messageId.present) {
      map['message_id'] = Variable<String>(messageId.value);
    }
    if (gmailAttachmentId.present) {
      map['gmail_attachment_id'] = Variable<String>(gmailAttachmentId.value);
    }
    if (fileName.present) {
      map['file_name'] = Variable<String>(fileName.value);
    }
    if (mimeType.present) {
      map['mime_type'] = Variable<String>(mimeType.value);
    }
    if (sizeBytes.present) {
      map['size_bytes'] = Variable<int>(sizeBytes.value);
    }
    if (localPath.present) {
      map['local_path'] = Variable<String>(localPath.value);
    }
    if (sha256.present) {
      map['sha256'] = Variable<String>(sha256.value);
    }
    if (extractedText.present) {
      map['extracted_text'] = Variable<String>(extractedText.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (expiresAt.present) {
      map['expires_at'] = Variable<DateTime>(expiresAt.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AttachmentsCompanion(')
          ..write('id: $id, ')
          ..write('messageId: $messageId, ')
          ..write('gmailAttachmentId: $gmailAttachmentId, ')
          ..write('fileName: $fileName, ')
          ..write('mimeType: $mimeType, ')
          ..write('sizeBytes: $sizeBytes, ')
          ..write('localPath: $localPath, ')
          ..write('sha256: $sha256, ')
          ..write('extractedText: $extractedText, ')
          ..write('status: $status, ')
          ..write('expiresAt: $expiresAt, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ProposalsTable extends Proposals
    with TableInfo<$ProposalsTable, Proposal> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ProposalsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _messageIdMeta = const VerificationMeta(
    'messageId',
  );
  @override
  late final GeneratedColumn<String> messageId = GeneratedColumn<String>(
    'message_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES gmail_messages (message_id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _sourceIdMeta = const VerificationMeta(
    'sourceId',
  );
  @override
  late final GeneratedColumn<String> sourceId = GeneratedColumn<String>(
    'source_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES sources (id) ON DELETE SET NULL',
    ),
  );
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
    'type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('unreviewed'),
  );
  static const VerificationMeta _proposedDateMeta = const VerificationMeta(
    'proposedDate',
  );
  @override
  late final GeneratedColumn<DateTime> proposedDate = GeneratedColumn<DateTime>(
    'proposed_date',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _allDayMeta = const VerificationMeta('allDay');
  @override
  late final GeneratedColumn<bool> allDay = GeneratedColumn<bool>(
    'all_day',
    aliasedName,
    true,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("all_day" IN (0, 1))',
    ),
  );
  static const VerificationMeta _locationMeta = const VerificationMeta(
    'location',
  );
  @override
  late final GeneratedColumn<String> location = GeneratedColumn<String>(
    'location',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _urgencyMeta = const VerificationMeta(
    'urgency',
  );
  @override
  late final GeneratedColumn<String> urgency = GeneratedColumn<String>(
    'urgency',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('none'),
  );
  static const VerificationMeta _whenHintMeta = const VerificationMeta(
    'whenHint',
  );
  @override
  late final GeneratedColumn<String> whenHint = GeneratedColumn<String>(
    'when_hint',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _subjectMeta = const VerificationMeta(
    'subject',
  );
  @override
  late final GeneratedColumn<String> subject = GeneratedColumn<String>(
    'subject',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _fromRawMeta = const VerificationMeta(
    'fromRaw',
  );
  @override
  late final GeneratedColumn<String> fromRaw = GeneratedColumn<String>(
    'from_raw',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _evidenceMeta = const VerificationMeta(
    'evidence',
  );
  @override
  late final GeneratedColumn<String> evidence = GeneratedColumn<String>(
    'evidence',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _parserVersionMeta = const VerificationMeta(
    'parserVersion',
  );
  @override
  late final GeneratedColumn<String> parserVersion = GeneratedColumn<String>(
    'parser_version',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _modelVersionMeta = const VerificationMeta(
    'modelVersion',
  );
  @override
  late final GeneratedColumn<String> modelVersion = GeneratedColumn<String>(
    'model_version',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    messageId,
    sourceId,
    type,
    status,
    proposedDate,
    allDay,
    location,
    urgency,
    whenHint,
    subject,
    fromRaw,
    evidence,
    parserVersion,
    modelVersion,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'proposals';
  @override
  VerificationContext validateIntegrity(
    Insertable<Proposal> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('message_id')) {
      context.handle(
        _messageIdMeta,
        messageId.isAcceptableOrUnknown(data['message_id']!, _messageIdMeta),
      );
    } else if (isInserting) {
      context.missing(_messageIdMeta);
    }
    if (data.containsKey('source_id')) {
      context.handle(
        _sourceIdMeta,
        sourceId.isAcceptableOrUnknown(data['source_id']!, _sourceIdMeta),
      );
    }
    if (data.containsKey('type')) {
      context.handle(
        _typeMeta,
        type.isAcceptableOrUnknown(data['type']!, _typeMeta),
      );
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    }
    if (data.containsKey('proposed_date')) {
      context.handle(
        _proposedDateMeta,
        proposedDate.isAcceptableOrUnknown(
          data['proposed_date']!,
          _proposedDateMeta,
        ),
      );
    }
    if (data.containsKey('all_day')) {
      context.handle(
        _allDayMeta,
        allDay.isAcceptableOrUnknown(data['all_day']!, _allDayMeta),
      );
    }
    if (data.containsKey('location')) {
      context.handle(
        _locationMeta,
        location.isAcceptableOrUnknown(data['location']!, _locationMeta),
      );
    }
    if (data.containsKey('urgency')) {
      context.handle(
        _urgencyMeta,
        urgency.isAcceptableOrUnknown(data['urgency']!, _urgencyMeta),
      );
    }
    if (data.containsKey('when_hint')) {
      context.handle(
        _whenHintMeta,
        whenHint.isAcceptableOrUnknown(data['when_hint']!, _whenHintMeta),
      );
    }
    if (data.containsKey('subject')) {
      context.handle(
        _subjectMeta,
        subject.isAcceptableOrUnknown(data['subject']!, _subjectMeta),
      );
    } else if (isInserting) {
      context.missing(_subjectMeta);
    }
    if (data.containsKey('from_raw')) {
      context.handle(
        _fromRawMeta,
        fromRaw.isAcceptableOrUnknown(data['from_raw']!, _fromRawMeta),
      );
    } else if (isInserting) {
      context.missing(_fromRawMeta);
    }
    if (data.containsKey('evidence')) {
      context.handle(
        _evidenceMeta,
        evidence.isAcceptableOrUnknown(data['evidence']!, _evidenceMeta),
      );
    } else if (isInserting) {
      context.missing(_evidenceMeta);
    }
    if (data.containsKey('parser_version')) {
      context.handle(
        _parserVersionMeta,
        parserVersion.isAcceptableOrUnknown(
          data['parser_version']!,
          _parserVersionMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_parserVersionMeta);
    }
    if (data.containsKey('model_version')) {
      context.handle(
        _modelVersionMeta,
        modelVersion.isAcceptableOrUnknown(
          data['model_version']!,
          _modelVersionMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Proposal map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Proposal(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      messageId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}message_id'],
      )!,
      sourceId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}source_id'],
      ),
      type: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}type'],
      )!,
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      proposedDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}proposed_date'],
      ),
      allDay: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}all_day'],
      ),
      location: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}location'],
      ),
      urgency: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}urgency'],
      )!,
      whenHint: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}when_hint'],
      ),
      subject: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}subject'],
      )!,
      fromRaw: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}from_raw'],
      )!,
      evidence: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}evidence'],
      )!,
      parserVersion: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}parser_version'],
      )!,
      modelVersion: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}model_version'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $ProposalsTable createAlias(String alias) {
    return $ProposalsTable(attachedDatabase, alias);
  }
}

class Proposal extends DataClass implements Insertable<Proposal> {
  final String id;
  final String messageId;
  final String? sourceId;
  final String type;
  final String status;
  final DateTime? proposedDate;
  final bool? allDay;
  final String? location;
  final String urgency;
  final String? whenHint;
  final String subject;
  final String fromRaw;
  final String evidence;
  final String parserVersion;
  final String? modelVersion;
  final DateTime createdAt;
  final DateTime updatedAt;
  const Proposal({
    required this.id,
    required this.messageId,
    this.sourceId,
    required this.type,
    required this.status,
    this.proposedDate,
    this.allDay,
    this.location,
    required this.urgency,
    this.whenHint,
    required this.subject,
    required this.fromRaw,
    required this.evidence,
    required this.parserVersion,
    this.modelVersion,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['message_id'] = Variable<String>(messageId);
    if (!nullToAbsent || sourceId != null) {
      map['source_id'] = Variable<String>(sourceId);
    }
    map['type'] = Variable<String>(type);
    map['status'] = Variable<String>(status);
    if (!nullToAbsent || proposedDate != null) {
      map['proposed_date'] = Variable<DateTime>(proposedDate);
    }
    if (!nullToAbsent || allDay != null) {
      map['all_day'] = Variable<bool>(allDay);
    }
    if (!nullToAbsent || location != null) {
      map['location'] = Variable<String>(location);
    }
    map['urgency'] = Variable<String>(urgency);
    if (!nullToAbsent || whenHint != null) {
      map['when_hint'] = Variable<String>(whenHint);
    }
    map['subject'] = Variable<String>(subject);
    map['from_raw'] = Variable<String>(fromRaw);
    map['evidence'] = Variable<String>(evidence);
    map['parser_version'] = Variable<String>(parserVersion);
    if (!nullToAbsent || modelVersion != null) {
      map['model_version'] = Variable<String>(modelVersion);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  ProposalsCompanion toCompanion(bool nullToAbsent) {
    return ProposalsCompanion(
      id: Value(id),
      messageId: Value(messageId),
      sourceId: sourceId == null && nullToAbsent
          ? const Value.absent()
          : Value(sourceId),
      type: Value(type),
      status: Value(status),
      proposedDate: proposedDate == null && nullToAbsent
          ? const Value.absent()
          : Value(proposedDate),
      allDay: allDay == null && nullToAbsent
          ? const Value.absent()
          : Value(allDay),
      location: location == null && nullToAbsent
          ? const Value.absent()
          : Value(location),
      urgency: Value(urgency),
      whenHint: whenHint == null && nullToAbsent
          ? const Value.absent()
          : Value(whenHint),
      subject: Value(subject),
      fromRaw: Value(fromRaw),
      evidence: Value(evidence),
      parserVersion: Value(parserVersion),
      modelVersion: modelVersion == null && nullToAbsent
          ? const Value.absent()
          : Value(modelVersion),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory Proposal.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Proposal(
      id: serializer.fromJson<String>(json['id']),
      messageId: serializer.fromJson<String>(json['messageId']),
      sourceId: serializer.fromJson<String?>(json['sourceId']),
      type: serializer.fromJson<String>(json['type']),
      status: serializer.fromJson<String>(json['status']),
      proposedDate: serializer.fromJson<DateTime?>(json['proposedDate']),
      allDay: serializer.fromJson<bool?>(json['allDay']),
      location: serializer.fromJson<String?>(json['location']),
      urgency: serializer.fromJson<String>(json['urgency']),
      whenHint: serializer.fromJson<String?>(json['whenHint']),
      subject: serializer.fromJson<String>(json['subject']),
      fromRaw: serializer.fromJson<String>(json['fromRaw']),
      evidence: serializer.fromJson<String>(json['evidence']),
      parserVersion: serializer.fromJson<String>(json['parserVersion']),
      modelVersion: serializer.fromJson<String?>(json['modelVersion']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'messageId': serializer.toJson<String>(messageId),
      'sourceId': serializer.toJson<String?>(sourceId),
      'type': serializer.toJson<String>(type),
      'status': serializer.toJson<String>(status),
      'proposedDate': serializer.toJson<DateTime?>(proposedDate),
      'allDay': serializer.toJson<bool?>(allDay),
      'location': serializer.toJson<String?>(location),
      'urgency': serializer.toJson<String>(urgency),
      'whenHint': serializer.toJson<String?>(whenHint),
      'subject': serializer.toJson<String>(subject),
      'fromRaw': serializer.toJson<String>(fromRaw),
      'evidence': serializer.toJson<String>(evidence),
      'parserVersion': serializer.toJson<String>(parserVersion),
      'modelVersion': serializer.toJson<String?>(modelVersion),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  Proposal copyWith({
    String? id,
    String? messageId,
    Value<String?> sourceId = const Value.absent(),
    String? type,
    String? status,
    Value<DateTime?> proposedDate = const Value.absent(),
    Value<bool?> allDay = const Value.absent(),
    Value<String?> location = const Value.absent(),
    String? urgency,
    Value<String?> whenHint = const Value.absent(),
    String? subject,
    String? fromRaw,
    String? evidence,
    String? parserVersion,
    Value<String?> modelVersion = const Value.absent(),
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => Proposal(
    id: id ?? this.id,
    messageId: messageId ?? this.messageId,
    sourceId: sourceId.present ? sourceId.value : this.sourceId,
    type: type ?? this.type,
    status: status ?? this.status,
    proposedDate: proposedDate.present ? proposedDate.value : this.proposedDate,
    allDay: allDay.present ? allDay.value : this.allDay,
    location: location.present ? location.value : this.location,
    urgency: urgency ?? this.urgency,
    whenHint: whenHint.present ? whenHint.value : this.whenHint,
    subject: subject ?? this.subject,
    fromRaw: fromRaw ?? this.fromRaw,
    evidence: evidence ?? this.evidence,
    parserVersion: parserVersion ?? this.parserVersion,
    modelVersion: modelVersion.present ? modelVersion.value : this.modelVersion,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  Proposal copyWithCompanion(ProposalsCompanion data) {
    return Proposal(
      id: data.id.present ? data.id.value : this.id,
      messageId: data.messageId.present ? data.messageId.value : this.messageId,
      sourceId: data.sourceId.present ? data.sourceId.value : this.sourceId,
      type: data.type.present ? data.type.value : this.type,
      status: data.status.present ? data.status.value : this.status,
      proposedDate: data.proposedDate.present
          ? data.proposedDate.value
          : this.proposedDate,
      allDay: data.allDay.present ? data.allDay.value : this.allDay,
      location: data.location.present ? data.location.value : this.location,
      urgency: data.urgency.present ? data.urgency.value : this.urgency,
      whenHint: data.whenHint.present ? data.whenHint.value : this.whenHint,
      subject: data.subject.present ? data.subject.value : this.subject,
      fromRaw: data.fromRaw.present ? data.fromRaw.value : this.fromRaw,
      evidence: data.evidence.present ? data.evidence.value : this.evidence,
      parserVersion: data.parserVersion.present
          ? data.parserVersion.value
          : this.parserVersion,
      modelVersion: data.modelVersion.present
          ? data.modelVersion.value
          : this.modelVersion,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Proposal(')
          ..write('id: $id, ')
          ..write('messageId: $messageId, ')
          ..write('sourceId: $sourceId, ')
          ..write('type: $type, ')
          ..write('status: $status, ')
          ..write('proposedDate: $proposedDate, ')
          ..write('allDay: $allDay, ')
          ..write('location: $location, ')
          ..write('urgency: $urgency, ')
          ..write('whenHint: $whenHint, ')
          ..write('subject: $subject, ')
          ..write('fromRaw: $fromRaw, ')
          ..write('evidence: $evidence, ')
          ..write('parserVersion: $parserVersion, ')
          ..write('modelVersion: $modelVersion, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    messageId,
    sourceId,
    type,
    status,
    proposedDate,
    allDay,
    location,
    urgency,
    whenHint,
    subject,
    fromRaw,
    evidence,
    parserVersion,
    modelVersion,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Proposal &&
          other.id == this.id &&
          other.messageId == this.messageId &&
          other.sourceId == this.sourceId &&
          other.type == this.type &&
          other.status == this.status &&
          other.proposedDate == this.proposedDate &&
          other.allDay == this.allDay &&
          other.location == this.location &&
          other.urgency == this.urgency &&
          other.whenHint == this.whenHint &&
          other.subject == this.subject &&
          other.fromRaw == this.fromRaw &&
          other.evidence == this.evidence &&
          other.parserVersion == this.parserVersion &&
          other.modelVersion == this.modelVersion &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class ProposalsCompanion extends UpdateCompanion<Proposal> {
  final Value<String> id;
  final Value<String> messageId;
  final Value<String?> sourceId;
  final Value<String> type;
  final Value<String> status;
  final Value<DateTime?> proposedDate;
  final Value<bool?> allDay;
  final Value<String?> location;
  final Value<String> urgency;
  final Value<String?> whenHint;
  final Value<String> subject;
  final Value<String> fromRaw;
  final Value<String> evidence;
  final Value<String> parserVersion;
  final Value<String?> modelVersion;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const ProposalsCompanion({
    this.id = const Value.absent(),
    this.messageId = const Value.absent(),
    this.sourceId = const Value.absent(),
    this.type = const Value.absent(),
    this.status = const Value.absent(),
    this.proposedDate = const Value.absent(),
    this.allDay = const Value.absent(),
    this.location = const Value.absent(),
    this.urgency = const Value.absent(),
    this.whenHint = const Value.absent(),
    this.subject = const Value.absent(),
    this.fromRaw = const Value.absent(),
    this.evidence = const Value.absent(),
    this.parserVersion = const Value.absent(),
    this.modelVersion = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ProposalsCompanion.insert({
    required String id,
    required String messageId,
    this.sourceId = const Value.absent(),
    required String type,
    this.status = const Value.absent(),
    this.proposedDate = const Value.absent(),
    this.allDay = const Value.absent(),
    this.location = const Value.absent(),
    this.urgency = const Value.absent(),
    this.whenHint = const Value.absent(),
    required String subject,
    required String fromRaw,
    required String evidence,
    required String parserVersion,
    this.modelVersion = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       messageId = Value(messageId),
       type = Value(type),
       subject = Value(subject),
       fromRaw = Value(fromRaw),
       evidence = Value(evidence),
       parserVersion = Value(parserVersion),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<Proposal> custom({
    Expression<String>? id,
    Expression<String>? messageId,
    Expression<String>? sourceId,
    Expression<String>? type,
    Expression<String>? status,
    Expression<DateTime>? proposedDate,
    Expression<bool>? allDay,
    Expression<String>? location,
    Expression<String>? urgency,
    Expression<String>? whenHint,
    Expression<String>? subject,
    Expression<String>? fromRaw,
    Expression<String>? evidence,
    Expression<String>? parserVersion,
    Expression<String>? modelVersion,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (messageId != null) 'message_id': messageId,
      if (sourceId != null) 'source_id': sourceId,
      if (type != null) 'type': type,
      if (status != null) 'status': status,
      if (proposedDate != null) 'proposed_date': proposedDate,
      if (allDay != null) 'all_day': allDay,
      if (location != null) 'location': location,
      if (urgency != null) 'urgency': urgency,
      if (whenHint != null) 'when_hint': whenHint,
      if (subject != null) 'subject': subject,
      if (fromRaw != null) 'from_raw': fromRaw,
      if (evidence != null) 'evidence': evidence,
      if (parserVersion != null) 'parser_version': parserVersion,
      if (modelVersion != null) 'model_version': modelVersion,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ProposalsCompanion copyWith({
    Value<String>? id,
    Value<String>? messageId,
    Value<String?>? sourceId,
    Value<String>? type,
    Value<String>? status,
    Value<DateTime?>? proposedDate,
    Value<bool?>? allDay,
    Value<String?>? location,
    Value<String>? urgency,
    Value<String?>? whenHint,
    Value<String>? subject,
    Value<String>? fromRaw,
    Value<String>? evidence,
    Value<String>? parserVersion,
    Value<String?>? modelVersion,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return ProposalsCompanion(
      id: id ?? this.id,
      messageId: messageId ?? this.messageId,
      sourceId: sourceId ?? this.sourceId,
      type: type ?? this.type,
      status: status ?? this.status,
      proposedDate: proposedDate ?? this.proposedDate,
      allDay: allDay ?? this.allDay,
      location: location ?? this.location,
      urgency: urgency ?? this.urgency,
      whenHint: whenHint ?? this.whenHint,
      subject: subject ?? this.subject,
      fromRaw: fromRaw ?? this.fromRaw,
      evidence: evidence ?? this.evidence,
      parserVersion: parserVersion ?? this.parserVersion,
      modelVersion: modelVersion ?? this.modelVersion,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (messageId.present) {
      map['message_id'] = Variable<String>(messageId.value);
    }
    if (sourceId.present) {
      map['source_id'] = Variable<String>(sourceId.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (proposedDate.present) {
      map['proposed_date'] = Variable<DateTime>(proposedDate.value);
    }
    if (allDay.present) {
      map['all_day'] = Variable<bool>(allDay.value);
    }
    if (location.present) {
      map['location'] = Variable<String>(location.value);
    }
    if (urgency.present) {
      map['urgency'] = Variable<String>(urgency.value);
    }
    if (whenHint.present) {
      map['when_hint'] = Variable<String>(whenHint.value);
    }
    if (subject.present) {
      map['subject'] = Variable<String>(subject.value);
    }
    if (fromRaw.present) {
      map['from_raw'] = Variable<String>(fromRaw.value);
    }
    if (evidence.present) {
      map['evidence'] = Variable<String>(evidence.value);
    }
    if (parserVersion.present) {
      map['parser_version'] = Variable<String>(parserVersion.value);
    }
    if (modelVersion.present) {
      map['model_version'] = Variable<String>(modelVersion.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ProposalsCompanion(')
          ..write('id: $id, ')
          ..write('messageId: $messageId, ')
          ..write('sourceId: $sourceId, ')
          ..write('type: $type, ')
          ..write('status: $status, ')
          ..write('proposedDate: $proposedDate, ')
          ..write('allDay: $allDay, ')
          ..write('location: $location, ')
          ..write('urgency: $urgency, ')
          ..write('whenHint: $whenHint, ')
          ..write('subject: $subject, ')
          ..write('fromRaw: $fromRaw, ')
          ..write('evidence: $evidence, ')
          ..write('parserVersion: $parserVersion, ')
          ..write('modelVersion: $modelVersion, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ProposalItemsTable extends ProposalItems
    with TableInfo<$ProposalItemsTable, ProposalItem> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ProposalItemsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _proposalIdMeta = const VerificationMeta(
    'proposalId',
  );
  @override
  late final GeneratedColumn<String> proposalId = GeneratedColumn<String>(
    'proposal_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES proposals (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _positionMeta = const VerificationMeta(
    'position',
  );
  @override
  late final GeneratedColumn<int> position = GeneratedColumn<int>(
    'position',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _kindMeta = const VerificationMeta('kind');
  @override
  late final GeneratedColumn<String> kind = GeneratedColumn<String>(
    'kind',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _textRawMeta = const VerificationMeta(
    'textRaw',
  );
  @override
  late final GeneratedColumn<String> textRaw = GeneratedColumn<String>(
    'text_raw',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _locationMeta = const VerificationMeta(
    'location',
  );
  @override
  late final GeneratedColumn<String> location = GeneratedColumn<String>(
    'location',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _completedMeta = const VerificationMeta(
    'completed',
  );
  @override
  late final GeneratedColumn<bool> completed = GeneratedColumn<bool>(
    'completed',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("completed" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    proposalId,
    position,
    kind,
    textRaw,
    location,
    completed,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'proposal_items';
  @override
  VerificationContext validateIntegrity(
    Insertable<ProposalItem> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('proposal_id')) {
      context.handle(
        _proposalIdMeta,
        proposalId.isAcceptableOrUnknown(data['proposal_id']!, _proposalIdMeta),
      );
    } else if (isInserting) {
      context.missing(_proposalIdMeta);
    }
    if (data.containsKey('position')) {
      context.handle(
        _positionMeta,
        position.isAcceptableOrUnknown(data['position']!, _positionMeta),
      );
    } else if (isInserting) {
      context.missing(_positionMeta);
    }
    if (data.containsKey('kind')) {
      context.handle(
        _kindMeta,
        kind.isAcceptableOrUnknown(data['kind']!, _kindMeta),
      );
    } else if (isInserting) {
      context.missing(_kindMeta);
    }
    if (data.containsKey('text_raw')) {
      context.handle(
        _textRawMeta,
        textRaw.isAcceptableOrUnknown(data['text_raw']!, _textRawMeta),
      );
    } else if (isInserting) {
      context.missing(_textRawMeta);
    }
    if (data.containsKey('location')) {
      context.handle(
        _locationMeta,
        location.isAcceptableOrUnknown(data['location']!, _locationMeta),
      );
    }
    if (data.containsKey('completed')) {
      context.handle(
        _completedMeta,
        completed.isAcceptableOrUnknown(data['completed']!, _completedMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ProposalItem map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ProposalItem(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      proposalId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}proposal_id'],
      )!,
      position: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}position'],
      )!,
      kind: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}kind'],
      )!,
      textRaw: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}text_raw'],
      )!,
      location: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}location'],
      ),
      completed: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}completed'],
      )!,
    );
  }

  @override
  $ProposalItemsTable createAlias(String alias) {
    return $ProposalItemsTable(attachedDatabase, alias);
  }
}

class ProposalItem extends DataClass implements Insertable<ProposalItem> {
  final String id;
  final String proposalId;
  final int position;
  final String kind;
  final String textRaw;
  final String? location;
  final bool completed;
  const ProposalItem({
    required this.id,
    required this.proposalId,
    required this.position,
    required this.kind,
    required this.textRaw,
    this.location,
    required this.completed,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['proposal_id'] = Variable<String>(proposalId);
    map['position'] = Variable<int>(position);
    map['kind'] = Variable<String>(kind);
    map['text_raw'] = Variable<String>(textRaw);
    if (!nullToAbsent || location != null) {
      map['location'] = Variable<String>(location);
    }
    map['completed'] = Variable<bool>(completed);
    return map;
  }

  ProposalItemsCompanion toCompanion(bool nullToAbsent) {
    return ProposalItemsCompanion(
      id: Value(id),
      proposalId: Value(proposalId),
      position: Value(position),
      kind: Value(kind),
      textRaw: Value(textRaw),
      location: location == null && nullToAbsent
          ? const Value.absent()
          : Value(location),
      completed: Value(completed),
    );
  }

  factory ProposalItem.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ProposalItem(
      id: serializer.fromJson<String>(json['id']),
      proposalId: serializer.fromJson<String>(json['proposalId']),
      position: serializer.fromJson<int>(json['position']),
      kind: serializer.fromJson<String>(json['kind']),
      textRaw: serializer.fromJson<String>(json['textRaw']),
      location: serializer.fromJson<String?>(json['location']),
      completed: serializer.fromJson<bool>(json['completed']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'proposalId': serializer.toJson<String>(proposalId),
      'position': serializer.toJson<int>(position),
      'kind': serializer.toJson<String>(kind),
      'textRaw': serializer.toJson<String>(textRaw),
      'location': serializer.toJson<String?>(location),
      'completed': serializer.toJson<bool>(completed),
    };
  }

  ProposalItem copyWith({
    String? id,
    String? proposalId,
    int? position,
    String? kind,
    String? textRaw,
    Value<String?> location = const Value.absent(),
    bool? completed,
  }) => ProposalItem(
    id: id ?? this.id,
    proposalId: proposalId ?? this.proposalId,
    position: position ?? this.position,
    kind: kind ?? this.kind,
    textRaw: textRaw ?? this.textRaw,
    location: location.present ? location.value : this.location,
    completed: completed ?? this.completed,
  );
  ProposalItem copyWithCompanion(ProposalItemsCompanion data) {
    return ProposalItem(
      id: data.id.present ? data.id.value : this.id,
      proposalId: data.proposalId.present
          ? data.proposalId.value
          : this.proposalId,
      position: data.position.present ? data.position.value : this.position,
      kind: data.kind.present ? data.kind.value : this.kind,
      textRaw: data.textRaw.present ? data.textRaw.value : this.textRaw,
      location: data.location.present ? data.location.value : this.location,
      completed: data.completed.present ? data.completed.value : this.completed,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ProposalItem(')
          ..write('id: $id, ')
          ..write('proposalId: $proposalId, ')
          ..write('position: $position, ')
          ..write('kind: $kind, ')
          ..write('textRaw: $textRaw, ')
          ..write('location: $location, ')
          ..write('completed: $completed')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, proposalId, position, kind, textRaw, location, completed);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ProposalItem &&
          other.id == this.id &&
          other.proposalId == this.proposalId &&
          other.position == this.position &&
          other.kind == this.kind &&
          other.textRaw == this.textRaw &&
          other.location == this.location &&
          other.completed == this.completed);
}

class ProposalItemsCompanion extends UpdateCompanion<ProposalItem> {
  final Value<String> id;
  final Value<String> proposalId;
  final Value<int> position;
  final Value<String> kind;
  final Value<String> textRaw;
  final Value<String?> location;
  final Value<bool> completed;
  final Value<int> rowid;
  const ProposalItemsCompanion({
    this.id = const Value.absent(),
    this.proposalId = const Value.absent(),
    this.position = const Value.absent(),
    this.kind = const Value.absent(),
    this.textRaw = const Value.absent(),
    this.location = const Value.absent(),
    this.completed = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ProposalItemsCompanion.insert({
    required String id,
    required String proposalId,
    required int position,
    required String kind,
    required String textRaw,
    this.location = const Value.absent(),
    this.completed = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       proposalId = Value(proposalId),
       position = Value(position),
       kind = Value(kind),
       textRaw = Value(textRaw);
  static Insertable<ProposalItem> custom({
    Expression<String>? id,
    Expression<String>? proposalId,
    Expression<int>? position,
    Expression<String>? kind,
    Expression<String>? textRaw,
    Expression<String>? location,
    Expression<bool>? completed,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (proposalId != null) 'proposal_id': proposalId,
      if (position != null) 'position': position,
      if (kind != null) 'kind': kind,
      if (textRaw != null) 'text_raw': textRaw,
      if (location != null) 'location': location,
      if (completed != null) 'completed': completed,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ProposalItemsCompanion copyWith({
    Value<String>? id,
    Value<String>? proposalId,
    Value<int>? position,
    Value<String>? kind,
    Value<String>? textRaw,
    Value<String?>? location,
    Value<bool>? completed,
    Value<int>? rowid,
  }) {
    return ProposalItemsCompanion(
      id: id ?? this.id,
      proposalId: proposalId ?? this.proposalId,
      position: position ?? this.position,
      kind: kind ?? this.kind,
      textRaw: textRaw ?? this.textRaw,
      location: location ?? this.location,
      completed: completed ?? this.completed,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (proposalId.present) {
      map['proposal_id'] = Variable<String>(proposalId.value);
    }
    if (position.present) {
      map['position'] = Variable<int>(position.value);
    }
    if (kind.present) {
      map['kind'] = Variable<String>(kind.value);
    }
    if (textRaw.present) {
      map['text_raw'] = Variable<String>(textRaw.value);
    }
    if (location.present) {
      map['location'] = Variable<String>(location.value);
    }
    if (completed.present) {
      map['completed'] = Variable<bool>(completed.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ProposalItemsCompanion(')
          ..write('id: $id, ')
          ..write('proposalId: $proposalId, ')
          ..write('position: $position, ')
          ..write('kind: $kind, ')
          ..write('textRaw: $textRaw, ')
          ..write('location: $location, ')
          ..write('completed: $completed, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $EventsTable extends Events with TableInfo<$EventsTable, Event> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $EventsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _proposalIdMeta = const VerificationMeta(
    'proposalId',
  );
  @override
  late final GeneratedColumn<String> proposalId = GeneratedColumn<String>(
    'proposal_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES proposals (id) ON DELETE SET NULL',
    ),
  );
  static const VerificationMeta _sourceMessageIdMeta = const VerificationMeta(
    'sourceMessageId',
  );
  @override
  late final GeneratedColumn<String> sourceMessageId = GeneratedColumn<String>(
    'source_message_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES gmail_messages (message_id) ON DELETE SET NULL',
    ),
  );
  static const VerificationMeta _accountIdMeta = const VerificationMeta(
    'accountId',
  );
  @override
  late final GeneratedColumn<String> accountId = GeneratedColumn<String>(
    'account_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES app_accounts (id) ON DELETE SET NULL',
    ),
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _startsAtMeta = const VerificationMeta(
    'startsAt',
  );
  @override
  late final GeneratedColumn<DateTime> startsAt = GeneratedColumn<DateTime>(
    'starts_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _allDayMeta = const VerificationMeta('allDay');
  @override
  late final GeneratedColumn<bool> allDay = GeneratedColumn<bool>(
    'all_day',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("all_day" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _locationMeta = const VerificationMeta(
    'location',
  );
  @override
  late final GeneratedColumn<String> location = GeneratedColumn<String>(
    'location',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('active'),
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _exportedCalendarIdMeta =
      const VerificationMeta('exportedCalendarId');
  @override
  late final GeneratedColumn<String> exportedCalendarId =
      GeneratedColumn<String>(
        'exported_calendar_id',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _exportedEventIdMeta = const VerificationMeta(
    'exportedEventId',
  );
  @override
  late final GeneratedColumn<String> exportedEventId = GeneratedColumn<String>(
    'exported_event_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    proposalId,
    sourceMessageId,
    accountId,
    title,
    startsAt,
    allDay,
    location,
    status,
    notes,
    exportedCalendarId,
    exportedEventId,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'events';
  @override
  VerificationContext validateIntegrity(
    Insertable<Event> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('proposal_id')) {
      context.handle(
        _proposalIdMeta,
        proposalId.isAcceptableOrUnknown(data['proposal_id']!, _proposalIdMeta),
      );
    }
    if (data.containsKey('source_message_id')) {
      context.handle(
        _sourceMessageIdMeta,
        sourceMessageId.isAcceptableOrUnknown(
          data['source_message_id']!,
          _sourceMessageIdMeta,
        ),
      );
    }
    if (data.containsKey('account_id')) {
      context.handle(
        _accountIdMeta,
        accountId.isAcceptableOrUnknown(data['account_id']!, _accountIdMeta),
      );
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('starts_at')) {
      context.handle(
        _startsAtMeta,
        startsAt.isAcceptableOrUnknown(data['starts_at']!, _startsAtMeta),
      );
    }
    if (data.containsKey('all_day')) {
      context.handle(
        _allDayMeta,
        allDay.isAcceptableOrUnknown(data['all_day']!, _allDayMeta),
      );
    }
    if (data.containsKey('location')) {
      context.handle(
        _locationMeta,
        location.isAcceptableOrUnknown(data['location']!, _locationMeta),
      );
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    if (data.containsKey('exported_calendar_id')) {
      context.handle(
        _exportedCalendarIdMeta,
        exportedCalendarId.isAcceptableOrUnknown(
          data['exported_calendar_id']!,
          _exportedCalendarIdMeta,
        ),
      );
    }
    if (data.containsKey('exported_event_id')) {
      context.handle(
        _exportedEventIdMeta,
        exportedEventId.isAcceptableOrUnknown(
          data['exported_event_id']!,
          _exportedEventIdMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Event map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Event(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      proposalId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}proposal_id'],
      ),
      sourceMessageId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}source_message_id'],
      ),
      accountId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}account_id'],
      ),
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      startsAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}starts_at'],
      ),
      allDay: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}all_day'],
      )!,
      location: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}location'],
      ),
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
      exportedCalendarId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}exported_calendar_id'],
      ),
      exportedEventId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}exported_event_id'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $EventsTable createAlias(String alias) {
    return $EventsTable(attachedDatabase, alias);
  }
}

class Event extends DataClass implements Insertable<Event> {
  final String id;
  final String? proposalId;
  final String? sourceMessageId;
  final String? accountId;
  final String title;
  final DateTime? startsAt;
  final bool allDay;
  final String? location;
  final String status;
  final String? notes;
  final String? exportedCalendarId;
  final String? exportedEventId;
  final DateTime createdAt;
  final DateTime updatedAt;
  const Event({
    required this.id,
    this.proposalId,
    this.sourceMessageId,
    this.accountId,
    required this.title,
    this.startsAt,
    required this.allDay,
    this.location,
    required this.status,
    this.notes,
    this.exportedCalendarId,
    this.exportedEventId,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    if (!nullToAbsent || proposalId != null) {
      map['proposal_id'] = Variable<String>(proposalId);
    }
    if (!nullToAbsent || sourceMessageId != null) {
      map['source_message_id'] = Variable<String>(sourceMessageId);
    }
    if (!nullToAbsent || accountId != null) {
      map['account_id'] = Variable<String>(accountId);
    }
    map['title'] = Variable<String>(title);
    if (!nullToAbsent || startsAt != null) {
      map['starts_at'] = Variable<DateTime>(startsAt);
    }
    map['all_day'] = Variable<bool>(allDay);
    if (!nullToAbsent || location != null) {
      map['location'] = Variable<String>(location);
    }
    map['status'] = Variable<String>(status);
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    if (!nullToAbsent || exportedCalendarId != null) {
      map['exported_calendar_id'] = Variable<String>(exportedCalendarId);
    }
    if (!nullToAbsent || exportedEventId != null) {
      map['exported_event_id'] = Variable<String>(exportedEventId);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  EventsCompanion toCompanion(bool nullToAbsent) {
    return EventsCompanion(
      id: Value(id),
      proposalId: proposalId == null && nullToAbsent
          ? const Value.absent()
          : Value(proposalId),
      sourceMessageId: sourceMessageId == null && nullToAbsent
          ? const Value.absent()
          : Value(sourceMessageId),
      accountId: accountId == null && nullToAbsent
          ? const Value.absent()
          : Value(accountId),
      title: Value(title),
      startsAt: startsAt == null && nullToAbsent
          ? const Value.absent()
          : Value(startsAt),
      allDay: Value(allDay),
      location: location == null && nullToAbsent
          ? const Value.absent()
          : Value(location),
      status: Value(status),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
      exportedCalendarId: exportedCalendarId == null && nullToAbsent
          ? const Value.absent()
          : Value(exportedCalendarId),
      exportedEventId: exportedEventId == null && nullToAbsent
          ? const Value.absent()
          : Value(exportedEventId),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory Event.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Event(
      id: serializer.fromJson<String>(json['id']),
      proposalId: serializer.fromJson<String?>(json['proposalId']),
      sourceMessageId: serializer.fromJson<String?>(json['sourceMessageId']),
      accountId: serializer.fromJson<String?>(json['accountId']),
      title: serializer.fromJson<String>(json['title']),
      startsAt: serializer.fromJson<DateTime?>(json['startsAt']),
      allDay: serializer.fromJson<bool>(json['allDay']),
      location: serializer.fromJson<String?>(json['location']),
      status: serializer.fromJson<String>(json['status']),
      notes: serializer.fromJson<String?>(json['notes']),
      exportedCalendarId: serializer.fromJson<String?>(
        json['exportedCalendarId'],
      ),
      exportedEventId: serializer.fromJson<String?>(json['exportedEventId']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'proposalId': serializer.toJson<String?>(proposalId),
      'sourceMessageId': serializer.toJson<String?>(sourceMessageId),
      'accountId': serializer.toJson<String?>(accountId),
      'title': serializer.toJson<String>(title),
      'startsAt': serializer.toJson<DateTime?>(startsAt),
      'allDay': serializer.toJson<bool>(allDay),
      'location': serializer.toJson<String?>(location),
      'status': serializer.toJson<String>(status),
      'notes': serializer.toJson<String?>(notes),
      'exportedCalendarId': serializer.toJson<String?>(exportedCalendarId),
      'exportedEventId': serializer.toJson<String?>(exportedEventId),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  Event copyWith({
    String? id,
    Value<String?> proposalId = const Value.absent(),
    Value<String?> sourceMessageId = const Value.absent(),
    Value<String?> accountId = const Value.absent(),
    String? title,
    Value<DateTime?> startsAt = const Value.absent(),
    bool? allDay,
    Value<String?> location = const Value.absent(),
    String? status,
    Value<String?> notes = const Value.absent(),
    Value<String?> exportedCalendarId = const Value.absent(),
    Value<String?> exportedEventId = const Value.absent(),
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => Event(
    id: id ?? this.id,
    proposalId: proposalId.present ? proposalId.value : this.proposalId,
    sourceMessageId: sourceMessageId.present
        ? sourceMessageId.value
        : this.sourceMessageId,
    accountId: accountId.present ? accountId.value : this.accountId,
    title: title ?? this.title,
    startsAt: startsAt.present ? startsAt.value : this.startsAt,
    allDay: allDay ?? this.allDay,
    location: location.present ? location.value : this.location,
    status: status ?? this.status,
    notes: notes.present ? notes.value : this.notes,
    exportedCalendarId: exportedCalendarId.present
        ? exportedCalendarId.value
        : this.exportedCalendarId,
    exportedEventId: exportedEventId.present
        ? exportedEventId.value
        : this.exportedEventId,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  Event copyWithCompanion(EventsCompanion data) {
    return Event(
      id: data.id.present ? data.id.value : this.id,
      proposalId: data.proposalId.present
          ? data.proposalId.value
          : this.proposalId,
      sourceMessageId: data.sourceMessageId.present
          ? data.sourceMessageId.value
          : this.sourceMessageId,
      accountId: data.accountId.present ? data.accountId.value : this.accountId,
      title: data.title.present ? data.title.value : this.title,
      startsAt: data.startsAt.present ? data.startsAt.value : this.startsAt,
      allDay: data.allDay.present ? data.allDay.value : this.allDay,
      location: data.location.present ? data.location.value : this.location,
      status: data.status.present ? data.status.value : this.status,
      notes: data.notes.present ? data.notes.value : this.notes,
      exportedCalendarId: data.exportedCalendarId.present
          ? data.exportedCalendarId.value
          : this.exportedCalendarId,
      exportedEventId: data.exportedEventId.present
          ? data.exportedEventId.value
          : this.exportedEventId,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Event(')
          ..write('id: $id, ')
          ..write('proposalId: $proposalId, ')
          ..write('sourceMessageId: $sourceMessageId, ')
          ..write('accountId: $accountId, ')
          ..write('title: $title, ')
          ..write('startsAt: $startsAt, ')
          ..write('allDay: $allDay, ')
          ..write('location: $location, ')
          ..write('status: $status, ')
          ..write('notes: $notes, ')
          ..write('exportedCalendarId: $exportedCalendarId, ')
          ..write('exportedEventId: $exportedEventId, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    proposalId,
    sourceMessageId,
    accountId,
    title,
    startsAt,
    allDay,
    location,
    status,
    notes,
    exportedCalendarId,
    exportedEventId,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Event &&
          other.id == this.id &&
          other.proposalId == this.proposalId &&
          other.sourceMessageId == this.sourceMessageId &&
          other.accountId == this.accountId &&
          other.title == this.title &&
          other.startsAt == this.startsAt &&
          other.allDay == this.allDay &&
          other.location == this.location &&
          other.status == this.status &&
          other.notes == this.notes &&
          other.exportedCalendarId == this.exportedCalendarId &&
          other.exportedEventId == this.exportedEventId &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class EventsCompanion extends UpdateCompanion<Event> {
  final Value<String> id;
  final Value<String?> proposalId;
  final Value<String?> sourceMessageId;
  final Value<String?> accountId;
  final Value<String> title;
  final Value<DateTime?> startsAt;
  final Value<bool> allDay;
  final Value<String?> location;
  final Value<String> status;
  final Value<String?> notes;
  final Value<String?> exportedCalendarId;
  final Value<String?> exportedEventId;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const EventsCompanion({
    this.id = const Value.absent(),
    this.proposalId = const Value.absent(),
    this.sourceMessageId = const Value.absent(),
    this.accountId = const Value.absent(),
    this.title = const Value.absent(),
    this.startsAt = const Value.absent(),
    this.allDay = const Value.absent(),
    this.location = const Value.absent(),
    this.status = const Value.absent(),
    this.notes = const Value.absent(),
    this.exportedCalendarId = const Value.absent(),
    this.exportedEventId = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  EventsCompanion.insert({
    required String id,
    this.proposalId = const Value.absent(),
    this.sourceMessageId = const Value.absent(),
    this.accountId = const Value.absent(),
    required String title,
    this.startsAt = const Value.absent(),
    this.allDay = const Value.absent(),
    this.location = const Value.absent(),
    this.status = const Value.absent(),
    this.notes = const Value.absent(),
    this.exportedCalendarId = const Value.absent(),
    this.exportedEventId = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       title = Value(title),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<Event> custom({
    Expression<String>? id,
    Expression<String>? proposalId,
    Expression<String>? sourceMessageId,
    Expression<String>? accountId,
    Expression<String>? title,
    Expression<DateTime>? startsAt,
    Expression<bool>? allDay,
    Expression<String>? location,
    Expression<String>? status,
    Expression<String>? notes,
    Expression<String>? exportedCalendarId,
    Expression<String>? exportedEventId,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (proposalId != null) 'proposal_id': proposalId,
      if (sourceMessageId != null) 'source_message_id': sourceMessageId,
      if (accountId != null) 'account_id': accountId,
      if (title != null) 'title': title,
      if (startsAt != null) 'starts_at': startsAt,
      if (allDay != null) 'all_day': allDay,
      if (location != null) 'location': location,
      if (status != null) 'status': status,
      if (notes != null) 'notes': notes,
      if (exportedCalendarId != null)
        'exported_calendar_id': exportedCalendarId,
      if (exportedEventId != null) 'exported_event_id': exportedEventId,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  EventsCompanion copyWith({
    Value<String>? id,
    Value<String?>? proposalId,
    Value<String?>? sourceMessageId,
    Value<String?>? accountId,
    Value<String>? title,
    Value<DateTime?>? startsAt,
    Value<bool>? allDay,
    Value<String?>? location,
    Value<String>? status,
    Value<String?>? notes,
    Value<String?>? exportedCalendarId,
    Value<String?>? exportedEventId,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return EventsCompanion(
      id: id ?? this.id,
      proposalId: proposalId ?? this.proposalId,
      sourceMessageId: sourceMessageId ?? this.sourceMessageId,
      accountId: accountId ?? this.accountId,
      title: title ?? this.title,
      startsAt: startsAt ?? this.startsAt,
      allDay: allDay ?? this.allDay,
      location: location ?? this.location,
      status: status ?? this.status,
      notes: notes ?? this.notes,
      exportedCalendarId: exportedCalendarId ?? this.exportedCalendarId,
      exportedEventId: exportedEventId ?? this.exportedEventId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (proposalId.present) {
      map['proposal_id'] = Variable<String>(proposalId.value);
    }
    if (sourceMessageId.present) {
      map['source_message_id'] = Variable<String>(sourceMessageId.value);
    }
    if (accountId.present) {
      map['account_id'] = Variable<String>(accountId.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (startsAt.present) {
      map['starts_at'] = Variable<DateTime>(startsAt.value);
    }
    if (allDay.present) {
      map['all_day'] = Variable<bool>(allDay.value);
    }
    if (location.present) {
      map['location'] = Variable<String>(location.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (exportedCalendarId.present) {
      map['exported_calendar_id'] = Variable<String>(exportedCalendarId.value);
    }
    if (exportedEventId.present) {
      map['exported_event_id'] = Variable<String>(exportedEventId.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('EventsCompanion(')
          ..write('id: $id, ')
          ..write('proposalId: $proposalId, ')
          ..write('sourceMessageId: $sourceMessageId, ')
          ..write('accountId: $accountId, ')
          ..write('title: $title, ')
          ..write('startsAt: $startsAt, ')
          ..write('allDay: $allDay, ')
          ..write('location: $location, ')
          ..write('status: $status, ')
          ..write('notes: $notes, ')
          ..write('exportedCalendarId: $exportedCalendarId, ')
          ..write('exportedEventId: $exportedEventId, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $EventItemsTable extends EventItems
    with TableInfo<$EventItemsTable, EventItem> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $EventItemsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _eventIdMeta = const VerificationMeta(
    'eventId',
  );
  @override
  late final GeneratedColumn<String> eventId = GeneratedColumn<String>(
    'event_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES events (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _positionMeta = const VerificationMeta(
    'position',
  );
  @override
  late final GeneratedColumn<int> position = GeneratedColumn<int>(
    'position',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _kindMeta = const VerificationMeta('kind');
  @override
  late final GeneratedColumn<String> kind = GeneratedColumn<String>(
    'kind',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _contentMeta = const VerificationMeta(
    'content',
  );
  @override
  late final GeneratedColumn<String> content = GeneratedColumn<String>(
    'text',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _locationMeta = const VerificationMeta(
    'location',
  );
  @override
  late final GeneratedColumn<String> location = GeneratedColumn<String>(
    'location',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _completedMeta = const VerificationMeta(
    'completed',
  );
  @override
  late final GeneratedColumn<bool> completed = GeneratedColumn<bool>(
    'completed',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("completed" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    eventId,
    position,
    kind,
    content,
    location,
    completed,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'event_items';
  @override
  VerificationContext validateIntegrity(
    Insertable<EventItem> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('event_id')) {
      context.handle(
        _eventIdMeta,
        eventId.isAcceptableOrUnknown(data['event_id']!, _eventIdMeta),
      );
    } else if (isInserting) {
      context.missing(_eventIdMeta);
    }
    if (data.containsKey('position')) {
      context.handle(
        _positionMeta,
        position.isAcceptableOrUnknown(data['position']!, _positionMeta),
      );
    } else if (isInserting) {
      context.missing(_positionMeta);
    }
    if (data.containsKey('kind')) {
      context.handle(
        _kindMeta,
        kind.isAcceptableOrUnknown(data['kind']!, _kindMeta),
      );
    } else if (isInserting) {
      context.missing(_kindMeta);
    }
    if (data.containsKey('text')) {
      context.handle(
        _contentMeta,
        content.isAcceptableOrUnknown(data['text']!, _contentMeta),
      );
    } else if (isInserting) {
      context.missing(_contentMeta);
    }
    if (data.containsKey('location')) {
      context.handle(
        _locationMeta,
        location.isAcceptableOrUnknown(data['location']!, _locationMeta),
      );
    }
    if (data.containsKey('completed')) {
      context.handle(
        _completedMeta,
        completed.isAcceptableOrUnknown(data['completed']!, _completedMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  EventItem map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return EventItem(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      eventId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}event_id'],
      )!,
      position: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}position'],
      )!,
      kind: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}kind'],
      )!,
      content: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}text'],
      )!,
      location: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}location'],
      ),
      completed: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}completed'],
      )!,
    );
  }

  @override
  $EventItemsTable createAlias(String alias) {
    return $EventItemsTable(attachedDatabase, alias);
  }
}

class EventItem extends DataClass implements Insertable<EventItem> {
  final String id;
  final String eventId;
  final int position;
  final String kind;
  final String content;
  final String? location;
  final bool completed;
  const EventItem({
    required this.id,
    required this.eventId,
    required this.position,
    required this.kind,
    required this.content,
    this.location,
    required this.completed,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['event_id'] = Variable<String>(eventId);
    map['position'] = Variable<int>(position);
    map['kind'] = Variable<String>(kind);
    map['text'] = Variable<String>(content);
    if (!nullToAbsent || location != null) {
      map['location'] = Variable<String>(location);
    }
    map['completed'] = Variable<bool>(completed);
    return map;
  }

  EventItemsCompanion toCompanion(bool nullToAbsent) {
    return EventItemsCompanion(
      id: Value(id),
      eventId: Value(eventId),
      position: Value(position),
      kind: Value(kind),
      content: Value(content),
      location: location == null && nullToAbsent
          ? const Value.absent()
          : Value(location),
      completed: Value(completed),
    );
  }

  factory EventItem.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return EventItem(
      id: serializer.fromJson<String>(json['id']),
      eventId: serializer.fromJson<String>(json['eventId']),
      position: serializer.fromJson<int>(json['position']),
      kind: serializer.fromJson<String>(json['kind']),
      content: serializer.fromJson<String>(json['content']),
      location: serializer.fromJson<String?>(json['location']),
      completed: serializer.fromJson<bool>(json['completed']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'eventId': serializer.toJson<String>(eventId),
      'position': serializer.toJson<int>(position),
      'kind': serializer.toJson<String>(kind),
      'content': serializer.toJson<String>(content),
      'location': serializer.toJson<String?>(location),
      'completed': serializer.toJson<bool>(completed),
    };
  }

  EventItem copyWith({
    String? id,
    String? eventId,
    int? position,
    String? kind,
    String? content,
    Value<String?> location = const Value.absent(),
    bool? completed,
  }) => EventItem(
    id: id ?? this.id,
    eventId: eventId ?? this.eventId,
    position: position ?? this.position,
    kind: kind ?? this.kind,
    content: content ?? this.content,
    location: location.present ? location.value : this.location,
    completed: completed ?? this.completed,
  );
  EventItem copyWithCompanion(EventItemsCompanion data) {
    return EventItem(
      id: data.id.present ? data.id.value : this.id,
      eventId: data.eventId.present ? data.eventId.value : this.eventId,
      position: data.position.present ? data.position.value : this.position,
      kind: data.kind.present ? data.kind.value : this.kind,
      content: data.content.present ? data.content.value : this.content,
      location: data.location.present ? data.location.value : this.location,
      completed: data.completed.present ? data.completed.value : this.completed,
    );
  }

  @override
  String toString() {
    return (StringBuffer('EventItem(')
          ..write('id: $id, ')
          ..write('eventId: $eventId, ')
          ..write('position: $position, ')
          ..write('kind: $kind, ')
          ..write('content: $content, ')
          ..write('location: $location, ')
          ..write('completed: $completed')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, eventId, position, kind, content, location, completed);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is EventItem &&
          other.id == this.id &&
          other.eventId == this.eventId &&
          other.position == this.position &&
          other.kind == this.kind &&
          other.content == this.content &&
          other.location == this.location &&
          other.completed == this.completed);
}

class EventItemsCompanion extends UpdateCompanion<EventItem> {
  final Value<String> id;
  final Value<String> eventId;
  final Value<int> position;
  final Value<String> kind;
  final Value<String> content;
  final Value<String?> location;
  final Value<bool> completed;
  final Value<int> rowid;
  const EventItemsCompanion({
    this.id = const Value.absent(),
    this.eventId = const Value.absent(),
    this.position = const Value.absent(),
    this.kind = const Value.absent(),
    this.content = const Value.absent(),
    this.location = const Value.absent(),
    this.completed = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  EventItemsCompanion.insert({
    required String id,
    required String eventId,
    required int position,
    required String kind,
    required String content,
    this.location = const Value.absent(),
    this.completed = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       eventId = Value(eventId),
       position = Value(position),
       kind = Value(kind),
       content = Value(content);
  static Insertable<EventItem> custom({
    Expression<String>? id,
    Expression<String>? eventId,
    Expression<int>? position,
    Expression<String>? kind,
    Expression<String>? content,
    Expression<String>? location,
    Expression<bool>? completed,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (eventId != null) 'event_id': eventId,
      if (position != null) 'position': position,
      if (kind != null) 'kind': kind,
      if (content != null) 'text': content,
      if (location != null) 'location': location,
      if (completed != null) 'completed': completed,
      if (rowid != null) 'rowid': rowid,
    });
  }

  EventItemsCompanion copyWith({
    Value<String>? id,
    Value<String>? eventId,
    Value<int>? position,
    Value<String>? kind,
    Value<String>? content,
    Value<String?>? location,
    Value<bool>? completed,
    Value<int>? rowid,
  }) {
    return EventItemsCompanion(
      id: id ?? this.id,
      eventId: eventId ?? this.eventId,
      position: position ?? this.position,
      kind: kind ?? this.kind,
      content: content ?? this.content,
      location: location ?? this.location,
      completed: completed ?? this.completed,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (eventId.present) {
      map['event_id'] = Variable<String>(eventId.value);
    }
    if (position.present) {
      map['position'] = Variable<int>(position.value);
    }
    if (kind.present) {
      map['kind'] = Variable<String>(kind.value);
    }
    if (content.present) {
      map['text'] = Variable<String>(content.value);
    }
    if (location.present) {
      map['location'] = Variable<String>(location.value);
    }
    if (completed.present) {
      map['completed'] = Variable<bool>(completed.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('EventItemsCompanion(')
          ..write('id: $id, ')
          ..write('eventId: $eventId, ')
          ..write('position: $position, ')
          ..write('kind: $kind, ')
          ..write('content: $content, ')
          ..write('location: $location, ')
          ..write('completed: $completed, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $AlarmSchedulesTable extends AlarmSchedules
    with TableInfo<$AlarmSchedulesTable, AlarmSchedule> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AlarmSchedulesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _eventIdMeta = const VerificationMeta(
    'eventId',
  );
  @override
  late final GeneratedColumn<String> eventId = GeneratedColumn<String>(
    'event_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES events (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _kindMeta = const VerificationMeta('kind');
  @override
  late final GeneratedColumn<String> kind = GeneratedColumn<String>(
    'kind',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _fireAtMeta = const VerificationMeta('fireAt');
  @override
  late final GeneratedColumn<DateTime> fireAt = GeneratedColumn<DateTime>(
    'fire_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('scheduled'),
  );
  static const VerificationMeta _snoozeParentIdMeta = const VerificationMeta(
    'snoozeParentId',
  );
  @override
  late final GeneratedColumn<String> snoozeParentId = GeneratedColumn<String>(
    'snooze_parent_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _notificationIdMeta = const VerificationMeta(
    'notificationId',
  );
  @override
  late final GeneratedColumn<int> notificationId = GeneratedColumn<int>(
    'notification_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    eventId,
    kind,
    fireAt,
    status,
    snoozeParentId,
    notificationId,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'alarm_schedules';
  @override
  VerificationContext validateIntegrity(
    Insertable<AlarmSchedule> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('event_id')) {
      context.handle(
        _eventIdMeta,
        eventId.isAcceptableOrUnknown(data['event_id']!, _eventIdMeta),
      );
    }
    if (data.containsKey('kind')) {
      context.handle(
        _kindMeta,
        kind.isAcceptableOrUnknown(data['kind']!, _kindMeta),
      );
    } else if (isInserting) {
      context.missing(_kindMeta);
    }
    if (data.containsKey('fire_at')) {
      context.handle(
        _fireAtMeta,
        fireAt.isAcceptableOrUnknown(data['fire_at']!, _fireAtMeta),
      );
    } else if (isInserting) {
      context.missing(_fireAtMeta);
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    }
    if (data.containsKey('snooze_parent_id')) {
      context.handle(
        _snoozeParentIdMeta,
        snoozeParentId.isAcceptableOrUnknown(
          data['snooze_parent_id']!,
          _snoozeParentIdMeta,
        ),
      );
    }
    if (data.containsKey('notification_id')) {
      context.handle(
        _notificationIdMeta,
        notificationId.isAcceptableOrUnknown(
          data['notification_id']!,
          _notificationIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_notificationIdMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  AlarmSchedule map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AlarmSchedule(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      eventId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}event_id'],
      ),
      kind: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}kind'],
      )!,
      fireAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}fire_at'],
      )!,
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      snoozeParentId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}snooze_parent_id'],
      ),
      notificationId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}notification_id'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $AlarmSchedulesTable createAlias(String alias) {
    return $AlarmSchedulesTable(attachedDatabase, alias);
  }
}

class AlarmSchedule extends DataClass implements Insertable<AlarmSchedule> {
  final String id;
  final String? eventId;
  final String kind;
  final DateTime fireAt;
  final String status;
  final String? snoozeParentId;
  final int notificationId;
  final DateTime createdAt;
  final DateTime updatedAt;
  const AlarmSchedule({
    required this.id,
    this.eventId,
    required this.kind,
    required this.fireAt,
    required this.status,
    this.snoozeParentId,
    required this.notificationId,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    if (!nullToAbsent || eventId != null) {
      map['event_id'] = Variable<String>(eventId);
    }
    map['kind'] = Variable<String>(kind);
    map['fire_at'] = Variable<DateTime>(fireAt);
    map['status'] = Variable<String>(status);
    if (!nullToAbsent || snoozeParentId != null) {
      map['snooze_parent_id'] = Variable<String>(snoozeParentId);
    }
    map['notification_id'] = Variable<int>(notificationId);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  AlarmSchedulesCompanion toCompanion(bool nullToAbsent) {
    return AlarmSchedulesCompanion(
      id: Value(id),
      eventId: eventId == null && nullToAbsent
          ? const Value.absent()
          : Value(eventId),
      kind: Value(kind),
      fireAt: Value(fireAt),
      status: Value(status),
      snoozeParentId: snoozeParentId == null && nullToAbsent
          ? const Value.absent()
          : Value(snoozeParentId),
      notificationId: Value(notificationId),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory AlarmSchedule.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AlarmSchedule(
      id: serializer.fromJson<String>(json['id']),
      eventId: serializer.fromJson<String?>(json['eventId']),
      kind: serializer.fromJson<String>(json['kind']),
      fireAt: serializer.fromJson<DateTime>(json['fireAt']),
      status: serializer.fromJson<String>(json['status']),
      snoozeParentId: serializer.fromJson<String?>(json['snoozeParentId']),
      notificationId: serializer.fromJson<int>(json['notificationId']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'eventId': serializer.toJson<String?>(eventId),
      'kind': serializer.toJson<String>(kind),
      'fireAt': serializer.toJson<DateTime>(fireAt),
      'status': serializer.toJson<String>(status),
      'snoozeParentId': serializer.toJson<String?>(snoozeParentId),
      'notificationId': serializer.toJson<int>(notificationId),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  AlarmSchedule copyWith({
    String? id,
    Value<String?> eventId = const Value.absent(),
    String? kind,
    DateTime? fireAt,
    String? status,
    Value<String?> snoozeParentId = const Value.absent(),
    int? notificationId,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => AlarmSchedule(
    id: id ?? this.id,
    eventId: eventId.present ? eventId.value : this.eventId,
    kind: kind ?? this.kind,
    fireAt: fireAt ?? this.fireAt,
    status: status ?? this.status,
    snoozeParentId: snoozeParentId.present
        ? snoozeParentId.value
        : this.snoozeParentId,
    notificationId: notificationId ?? this.notificationId,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  AlarmSchedule copyWithCompanion(AlarmSchedulesCompanion data) {
    return AlarmSchedule(
      id: data.id.present ? data.id.value : this.id,
      eventId: data.eventId.present ? data.eventId.value : this.eventId,
      kind: data.kind.present ? data.kind.value : this.kind,
      fireAt: data.fireAt.present ? data.fireAt.value : this.fireAt,
      status: data.status.present ? data.status.value : this.status,
      snoozeParentId: data.snoozeParentId.present
          ? data.snoozeParentId.value
          : this.snoozeParentId,
      notificationId: data.notificationId.present
          ? data.notificationId.value
          : this.notificationId,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AlarmSchedule(')
          ..write('id: $id, ')
          ..write('eventId: $eventId, ')
          ..write('kind: $kind, ')
          ..write('fireAt: $fireAt, ')
          ..write('status: $status, ')
          ..write('snoozeParentId: $snoozeParentId, ')
          ..write('notificationId: $notificationId, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    eventId,
    kind,
    fireAt,
    status,
    snoozeParentId,
    notificationId,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AlarmSchedule &&
          other.id == this.id &&
          other.eventId == this.eventId &&
          other.kind == this.kind &&
          other.fireAt == this.fireAt &&
          other.status == this.status &&
          other.snoozeParentId == this.snoozeParentId &&
          other.notificationId == this.notificationId &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class AlarmSchedulesCompanion extends UpdateCompanion<AlarmSchedule> {
  final Value<String> id;
  final Value<String?> eventId;
  final Value<String> kind;
  final Value<DateTime> fireAt;
  final Value<String> status;
  final Value<String?> snoozeParentId;
  final Value<int> notificationId;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const AlarmSchedulesCompanion({
    this.id = const Value.absent(),
    this.eventId = const Value.absent(),
    this.kind = const Value.absent(),
    this.fireAt = const Value.absent(),
    this.status = const Value.absent(),
    this.snoozeParentId = const Value.absent(),
    this.notificationId = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  AlarmSchedulesCompanion.insert({
    required String id,
    this.eventId = const Value.absent(),
    required String kind,
    required DateTime fireAt,
    this.status = const Value.absent(),
    this.snoozeParentId = const Value.absent(),
    required int notificationId,
    required DateTime createdAt,
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       kind = Value(kind),
       fireAt = Value(fireAt),
       notificationId = Value(notificationId),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<AlarmSchedule> custom({
    Expression<String>? id,
    Expression<String>? eventId,
    Expression<String>? kind,
    Expression<DateTime>? fireAt,
    Expression<String>? status,
    Expression<String>? snoozeParentId,
    Expression<int>? notificationId,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (eventId != null) 'event_id': eventId,
      if (kind != null) 'kind': kind,
      if (fireAt != null) 'fire_at': fireAt,
      if (status != null) 'status': status,
      if (snoozeParentId != null) 'snooze_parent_id': snoozeParentId,
      if (notificationId != null) 'notification_id': notificationId,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  AlarmSchedulesCompanion copyWith({
    Value<String>? id,
    Value<String?>? eventId,
    Value<String>? kind,
    Value<DateTime>? fireAt,
    Value<String>? status,
    Value<String?>? snoozeParentId,
    Value<int>? notificationId,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return AlarmSchedulesCompanion(
      id: id ?? this.id,
      eventId: eventId ?? this.eventId,
      kind: kind ?? this.kind,
      fireAt: fireAt ?? this.fireAt,
      status: status ?? this.status,
      snoozeParentId: snoozeParentId ?? this.snoozeParentId,
      notificationId: notificationId ?? this.notificationId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (eventId.present) {
      map['event_id'] = Variable<String>(eventId.value);
    }
    if (kind.present) {
      map['kind'] = Variable<String>(kind.value);
    }
    if (fireAt.present) {
      map['fire_at'] = Variable<DateTime>(fireAt.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (snoozeParentId.present) {
      map['snooze_parent_id'] = Variable<String>(snoozeParentId.value);
    }
    if (notificationId.present) {
      map['notification_id'] = Variable<int>(notificationId.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AlarmSchedulesCompanion(')
          ..write('id: $id, ')
          ..write('eventId: $eventId, ')
          ..write('kind: $kind, ')
          ..write('fireAt: $fireAt, ')
          ..write('status: $status, ')
          ..write('snoozeParentId: $snoozeParentId, ')
          ..write('notificationId: $notificationId, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SyncCursorsTable extends SyncCursors
    with TableInfo<$SyncCursorsTable, SyncCursor> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SyncCursorsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _accountIdMeta = const VerificationMeta(
    'accountId',
  );
  @override
  late final GeneratedColumn<String> accountId = GeneratedColumn<String>(
    'account_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES app_accounts (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _historyIdMeta = const VerificationMeta(
    'historyId',
  );
  @override
  late final GeneratedColumn<String> historyId = GeneratedColumn<String>(
    'history_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _watchExpiresAtMeta = const VerificationMeta(
    'watchExpiresAt',
  );
  @override
  late final GeneratedColumn<DateTime> watchExpiresAt =
      GeneratedColumn<DateTime>(
        'watch_expires_at',
        aliasedName,
        true,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _lastSyncAtMeta = const VerificationMeta(
    'lastSyncAt',
  );
  @override
  late final GeneratedColumn<DateTime> lastSyncAt = GeneratedColumn<DateTime>(
    'last_sync_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _lastFullSyncAtMeta = const VerificationMeta(
    'lastFullSyncAt',
  );
  @override
  late final GeneratedColumn<DateTime> lastFullSyncAt =
      GeneratedColumn<DateTime>(
        'last_full_sync_at',
        aliasedName,
        true,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _lastErrorCodeMeta = const VerificationMeta(
    'lastErrorCode',
  );
  @override
  late final GeneratedColumn<String> lastErrorCode = GeneratedColumn<String>(
    'last_error_code',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _lastErrorMessageMeta = const VerificationMeta(
    'lastErrorMessage',
  );
  @override
  late final GeneratedColumn<String> lastErrorMessage = GeneratedColumn<String>(
    'last_error_message',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    accountId,
    historyId,
    watchExpiresAt,
    lastSyncAt,
    lastFullSyncAt,
    lastErrorCode,
    lastErrorMessage,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'sync_cursors';
  @override
  VerificationContext validateIntegrity(
    Insertable<SyncCursor> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('account_id')) {
      context.handle(
        _accountIdMeta,
        accountId.isAcceptableOrUnknown(data['account_id']!, _accountIdMeta),
      );
    } else if (isInserting) {
      context.missing(_accountIdMeta);
    }
    if (data.containsKey('history_id')) {
      context.handle(
        _historyIdMeta,
        historyId.isAcceptableOrUnknown(data['history_id']!, _historyIdMeta),
      );
    }
    if (data.containsKey('watch_expires_at')) {
      context.handle(
        _watchExpiresAtMeta,
        watchExpiresAt.isAcceptableOrUnknown(
          data['watch_expires_at']!,
          _watchExpiresAtMeta,
        ),
      );
    }
    if (data.containsKey('last_sync_at')) {
      context.handle(
        _lastSyncAtMeta,
        lastSyncAt.isAcceptableOrUnknown(
          data['last_sync_at']!,
          _lastSyncAtMeta,
        ),
      );
    }
    if (data.containsKey('last_full_sync_at')) {
      context.handle(
        _lastFullSyncAtMeta,
        lastFullSyncAt.isAcceptableOrUnknown(
          data['last_full_sync_at']!,
          _lastFullSyncAtMeta,
        ),
      );
    }
    if (data.containsKey('last_error_code')) {
      context.handle(
        _lastErrorCodeMeta,
        lastErrorCode.isAcceptableOrUnknown(
          data['last_error_code']!,
          _lastErrorCodeMeta,
        ),
      );
    }
    if (data.containsKey('last_error_message')) {
      context.handle(
        _lastErrorMessageMeta,
        lastErrorMessage.isAcceptableOrUnknown(
          data['last_error_message']!,
          _lastErrorMessageMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {accountId};
  @override
  SyncCursor map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SyncCursor(
      accountId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}account_id'],
      )!,
      historyId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}history_id'],
      ),
      watchExpiresAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}watch_expires_at'],
      ),
      lastSyncAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_sync_at'],
      ),
      lastFullSyncAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_full_sync_at'],
      ),
      lastErrorCode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}last_error_code'],
      ),
      lastErrorMessage: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}last_error_message'],
      ),
    );
  }

  @override
  $SyncCursorsTable createAlias(String alias) {
    return $SyncCursorsTable(attachedDatabase, alias);
  }
}

class SyncCursor extends DataClass implements Insertable<SyncCursor> {
  final String accountId;
  final String? historyId;
  final DateTime? watchExpiresAt;
  final DateTime? lastSyncAt;
  final DateTime? lastFullSyncAt;
  final String? lastErrorCode;
  final String? lastErrorMessage;
  const SyncCursor({
    required this.accountId,
    this.historyId,
    this.watchExpiresAt,
    this.lastSyncAt,
    this.lastFullSyncAt,
    this.lastErrorCode,
    this.lastErrorMessage,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['account_id'] = Variable<String>(accountId);
    if (!nullToAbsent || historyId != null) {
      map['history_id'] = Variable<String>(historyId);
    }
    if (!nullToAbsent || watchExpiresAt != null) {
      map['watch_expires_at'] = Variable<DateTime>(watchExpiresAt);
    }
    if (!nullToAbsent || lastSyncAt != null) {
      map['last_sync_at'] = Variable<DateTime>(lastSyncAt);
    }
    if (!nullToAbsent || lastFullSyncAt != null) {
      map['last_full_sync_at'] = Variable<DateTime>(lastFullSyncAt);
    }
    if (!nullToAbsent || lastErrorCode != null) {
      map['last_error_code'] = Variable<String>(lastErrorCode);
    }
    if (!nullToAbsent || lastErrorMessage != null) {
      map['last_error_message'] = Variable<String>(lastErrorMessage);
    }
    return map;
  }

  SyncCursorsCompanion toCompanion(bool nullToAbsent) {
    return SyncCursorsCompanion(
      accountId: Value(accountId),
      historyId: historyId == null && nullToAbsent
          ? const Value.absent()
          : Value(historyId),
      watchExpiresAt: watchExpiresAt == null && nullToAbsent
          ? const Value.absent()
          : Value(watchExpiresAt),
      lastSyncAt: lastSyncAt == null && nullToAbsent
          ? const Value.absent()
          : Value(lastSyncAt),
      lastFullSyncAt: lastFullSyncAt == null && nullToAbsent
          ? const Value.absent()
          : Value(lastFullSyncAt),
      lastErrorCode: lastErrorCode == null && nullToAbsent
          ? const Value.absent()
          : Value(lastErrorCode),
      lastErrorMessage: lastErrorMessage == null && nullToAbsent
          ? const Value.absent()
          : Value(lastErrorMessage),
    );
  }

  factory SyncCursor.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SyncCursor(
      accountId: serializer.fromJson<String>(json['accountId']),
      historyId: serializer.fromJson<String?>(json['historyId']),
      watchExpiresAt: serializer.fromJson<DateTime?>(json['watchExpiresAt']),
      lastSyncAt: serializer.fromJson<DateTime?>(json['lastSyncAt']),
      lastFullSyncAt: serializer.fromJson<DateTime?>(json['lastFullSyncAt']),
      lastErrorCode: serializer.fromJson<String?>(json['lastErrorCode']),
      lastErrorMessage: serializer.fromJson<String?>(json['lastErrorMessage']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'accountId': serializer.toJson<String>(accountId),
      'historyId': serializer.toJson<String?>(historyId),
      'watchExpiresAt': serializer.toJson<DateTime?>(watchExpiresAt),
      'lastSyncAt': serializer.toJson<DateTime?>(lastSyncAt),
      'lastFullSyncAt': serializer.toJson<DateTime?>(lastFullSyncAt),
      'lastErrorCode': serializer.toJson<String?>(lastErrorCode),
      'lastErrorMessage': serializer.toJson<String?>(lastErrorMessage),
    };
  }

  SyncCursor copyWith({
    String? accountId,
    Value<String?> historyId = const Value.absent(),
    Value<DateTime?> watchExpiresAt = const Value.absent(),
    Value<DateTime?> lastSyncAt = const Value.absent(),
    Value<DateTime?> lastFullSyncAt = const Value.absent(),
    Value<String?> lastErrorCode = const Value.absent(),
    Value<String?> lastErrorMessage = const Value.absent(),
  }) => SyncCursor(
    accountId: accountId ?? this.accountId,
    historyId: historyId.present ? historyId.value : this.historyId,
    watchExpiresAt: watchExpiresAt.present
        ? watchExpiresAt.value
        : this.watchExpiresAt,
    lastSyncAt: lastSyncAt.present ? lastSyncAt.value : this.lastSyncAt,
    lastFullSyncAt: lastFullSyncAt.present
        ? lastFullSyncAt.value
        : this.lastFullSyncAt,
    lastErrorCode: lastErrorCode.present
        ? lastErrorCode.value
        : this.lastErrorCode,
    lastErrorMessage: lastErrorMessage.present
        ? lastErrorMessage.value
        : this.lastErrorMessage,
  );
  SyncCursor copyWithCompanion(SyncCursorsCompanion data) {
    return SyncCursor(
      accountId: data.accountId.present ? data.accountId.value : this.accountId,
      historyId: data.historyId.present ? data.historyId.value : this.historyId,
      watchExpiresAt: data.watchExpiresAt.present
          ? data.watchExpiresAt.value
          : this.watchExpiresAt,
      lastSyncAt: data.lastSyncAt.present
          ? data.lastSyncAt.value
          : this.lastSyncAt,
      lastFullSyncAt: data.lastFullSyncAt.present
          ? data.lastFullSyncAt.value
          : this.lastFullSyncAt,
      lastErrorCode: data.lastErrorCode.present
          ? data.lastErrorCode.value
          : this.lastErrorCode,
      lastErrorMessage: data.lastErrorMessage.present
          ? data.lastErrorMessage.value
          : this.lastErrorMessage,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SyncCursor(')
          ..write('accountId: $accountId, ')
          ..write('historyId: $historyId, ')
          ..write('watchExpiresAt: $watchExpiresAt, ')
          ..write('lastSyncAt: $lastSyncAt, ')
          ..write('lastFullSyncAt: $lastFullSyncAt, ')
          ..write('lastErrorCode: $lastErrorCode, ')
          ..write('lastErrorMessage: $lastErrorMessage')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    accountId,
    historyId,
    watchExpiresAt,
    lastSyncAt,
    lastFullSyncAt,
    lastErrorCode,
    lastErrorMessage,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SyncCursor &&
          other.accountId == this.accountId &&
          other.historyId == this.historyId &&
          other.watchExpiresAt == this.watchExpiresAt &&
          other.lastSyncAt == this.lastSyncAt &&
          other.lastFullSyncAt == this.lastFullSyncAt &&
          other.lastErrorCode == this.lastErrorCode &&
          other.lastErrorMessage == this.lastErrorMessage);
}

class SyncCursorsCompanion extends UpdateCompanion<SyncCursor> {
  final Value<String> accountId;
  final Value<String?> historyId;
  final Value<DateTime?> watchExpiresAt;
  final Value<DateTime?> lastSyncAt;
  final Value<DateTime?> lastFullSyncAt;
  final Value<String?> lastErrorCode;
  final Value<String?> lastErrorMessage;
  final Value<int> rowid;
  const SyncCursorsCompanion({
    this.accountId = const Value.absent(),
    this.historyId = const Value.absent(),
    this.watchExpiresAt = const Value.absent(),
    this.lastSyncAt = const Value.absent(),
    this.lastFullSyncAt = const Value.absent(),
    this.lastErrorCode = const Value.absent(),
    this.lastErrorMessage = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SyncCursorsCompanion.insert({
    required String accountId,
    this.historyId = const Value.absent(),
    this.watchExpiresAt = const Value.absent(),
    this.lastSyncAt = const Value.absent(),
    this.lastFullSyncAt = const Value.absent(),
    this.lastErrorCode = const Value.absent(),
    this.lastErrorMessage = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : accountId = Value(accountId);
  static Insertable<SyncCursor> custom({
    Expression<String>? accountId,
    Expression<String>? historyId,
    Expression<DateTime>? watchExpiresAt,
    Expression<DateTime>? lastSyncAt,
    Expression<DateTime>? lastFullSyncAt,
    Expression<String>? lastErrorCode,
    Expression<String>? lastErrorMessage,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (accountId != null) 'account_id': accountId,
      if (historyId != null) 'history_id': historyId,
      if (watchExpiresAt != null) 'watch_expires_at': watchExpiresAt,
      if (lastSyncAt != null) 'last_sync_at': lastSyncAt,
      if (lastFullSyncAt != null) 'last_full_sync_at': lastFullSyncAt,
      if (lastErrorCode != null) 'last_error_code': lastErrorCode,
      if (lastErrorMessage != null) 'last_error_message': lastErrorMessage,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SyncCursorsCompanion copyWith({
    Value<String>? accountId,
    Value<String?>? historyId,
    Value<DateTime?>? watchExpiresAt,
    Value<DateTime?>? lastSyncAt,
    Value<DateTime?>? lastFullSyncAt,
    Value<String?>? lastErrorCode,
    Value<String?>? lastErrorMessage,
    Value<int>? rowid,
  }) {
    return SyncCursorsCompanion(
      accountId: accountId ?? this.accountId,
      historyId: historyId ?? this.historyId,
      watchExpiresAt: watchExpiresAt ?? this.watchExpiresAt,
      lastSyncAt: lastSyncAt ?? this.lastSyncAt,
      lastFullSyncAt: lastFullSyncAt ?? this.lastFullSyncAt,
      lastErrorCode: lastErrorCode ?? this.lastErrorCode,
      lastErrorMessage: lastErrorMessage ?? this.lastErrorMessage,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (accountId.present) {
      map['account_id'] = Variable<String>(accountId.value);
    }
    if (historyId.present) {
      map['history_id'] = Variable<String>(historyId.value);
    }
    if (watchExpiresAt.present) {
      map['watch_expires_at'] = Variable<DateTime>(watchExpiresAt.value);
    }
    if (lastSyncAt.present) {
      map['last_sync_at'] = Variable<DateTime>(lastSyncAt.value);
    }
    if (lastFullSyncAt.present) {
      map['last_full_sync_at'] = Variable<DateTime>(lastFullSyncAt.value);
    }
    if (lastErrorCode.present) {
      map['last_error_code'] = Variable<String>(lastErrorCode.value);
    }
    if (lastErrorMessage.present) {
      map['last_error_message'] = Variable<String>(lastErrorMessage.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SyncCursorsCompanion(')
          ..write('accountId: $accountId, ')
          ..write('historyId: $historyId, ')
          ..write('watchExpiresAt: $watchExpiresAt, ')
          ..write('lastSyncAt: $lastSyncAt, ')
          ..write('lastFullSyncAt: $lastFullSyncAt, ')
          ..write('lastErrorCode: $lastErrorCode, ')
          ..write('lastErrorMessage: $lastErrorMessage, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $AppSettingsTable extends AppSettings
    with TableInfo<$AppSettingsTable, AppSetting> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AppSettingsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _keyMeta = const VerificationMeta('key');
  @override
  late final GeneratedColumn<String> key = GeneratedColumn<String>(
    'key',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _jsonValueMeta = const VerificationMeta(
    'jsonValue',
  );
  @override
  late final GeneratedColumn<String> jsonValue = GeneratedColumn<String>(
    'json_value',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [key, jsonValue, updatedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'app_settings';
  @override
  VerificationContext validateIntegrity(
    Insertable<AppSetting> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('key')) {
      context.handle(
        _keyMeta,
        key.isAcceptableOrUnknown(data['key']!, _keyMeta),
      );
    } else if (isInserting) {
      context.missing(_keyMeta);
    }
    if (data.containsKey('json_value')) {
      context.handle(
        _jsonValueMeta,
        jsonValue.isAcceptableOrUnknown(data['json_value']!, _jsonValueMeta),
      );
    } else if (isInserting) {
      context.missing(_jsonValueMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {key};
  @override
  AppSetting map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AppSetting(
      key: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}key'],
      )!,
      jsonValue: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}json_value'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $AppSettingsTable createAlias(String alias) {
    return $AppSettingsTable(attachedDatabase, alias);
  }
}

class AppSetting extends DataClass implements Insertable<AppSetting> {
  final String key;
  final String jsonValue;
  final DateTime updatedAt;
  const AppSetting({
    required this.key,
    required this.jsonValue,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['key'] = Variable<String>(key);
    map['json_value'] = Variable<String>(jsonValue);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  AppSettingsCompanion toCompanion(bool nullToAbsent) {
    return AppSettingsCompanion(
      key: Value(key),
      jsonValue: Value(jsonValue),
      updatedAt: Value(updatedAt),
    );
  }

  factory AppSetting.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AppSetting(
      key: serializer.fromJson<String>(json['key']),
      jsonValue: serializer.fromJson<String>(json['jsonValue']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'key': serializer.toJson<String>(key),
      'jsonValue': serializer.toJson<String>(jsonValue),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  AppSetting copyWith({String? key, String? jsonValue, DateTime? updatedAt}) =>
      AppSetting(
        key: key ?? this.key,
        jsonValue: jsonValue ?? this.jsonValue,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  AppSetting copyWithCompanion(AppSettingsCompanion data) {
    return AppSetting(
      key: data.key.present ? data.key.value : this.key,
      jsonValue: data.jsonValue.present ? data.jsonValue.value : this.jsonValue,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AppSetting(')
          ..write('key: $key, ')
          ..write('jsonValue: $jsonValue, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(key, jsonValue, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AppSetting &&
          other.key == this.key &&
          other.jsonValue == this.jsonValue &&
          other.updatedAt == this.updatedAt);
}

class AppSettingsCompanion extends UpdateCompanion<AppSetting> {
  final Value<String> key;
  final Value<String> jsonValue;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const AppSettingsCompanion({
    this.key = const Value.absent(),
    this.jsonValue = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  AppSettingsCompanion.insert({
    required String key,
    required String jsonValue,
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  }) : key = Value(key),
       jsonValue = Value(jsonValue),
       updatedAt = Value(updatedAt);
  static Insertable<AppSetting> custom({
    Expression<String>? key,
    Expression<String>? jsonValue,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (key != null) 'key': key,
      if (jsonValue != null) 'json_value': jsonValue,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  AppSettingsCompanion copyWith({
    Value<String>? key,
    Value<String>? jsonValue,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return AppSettingsCompanion(
      key: key ?? this.key,
      jsonValue: jsonValue ?? this.jsonValue,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (key.present) {
      map['key'] = Variable<String>(key.value);
    }
    if (jsonValue.present) {
      map['json_value'] = Variable<String>(jsonValue.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AppSettingsCompanion(')
          ..write('key: $key, ')
          ..write('jsonValue: $jsonValue, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ModelStatesTable extends ModelStates
    with TableInfo<$ModelStatesTable, ModelState> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ModelStatesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _providerMeta = const VerificationMeta(
    'provider',
  );
  @override
  late final GeneratedColumn<String> provider = GeneratedColumn<String>(
    'provider',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _modelMeta = const VerificationMeta('model');
  @override
  late final GeneratedColumn<String> model = GeneratedColumn<String>(
    'model',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _versionMeta = const VerificationMeta(
    'version',
  );
  @override
  late final GeneratedColumn<String> version = GeneratedColumn<String>(
    'version',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _localPathMeta = const VerificationMeta(
    'localPath',
  );
  @override
  late final GeneratedColumn<String> localPath = GeneratedColumn<String>(
    'local_path',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _sha256Meta = const VerificationMeta('sha256');
  @override
  late final GeneratedColumn<String> sha256 = GeneratedColumn<String>(
    'sha256',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _sizeBytesMeta = const VerificationMeta(
    'sizeBytes',
  );
  @override
  late final GeneratedColumn<int> sizeBytes = GeneratedColumn<int>(
    'size_bytes',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _downloadedAtMeta = const VerificationMeta(
    'downloadedAt',
  );
  @override
  late final GeneratedColumn<DateTime> downloadedAt = GeneratedColumn<DateTime>(
    'downloaded_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _lastErrorMeta = const VerificationMeta(
    'lastError',
  );
  @override
  late final GeneratedColumn<String> lastError = GeneratedColumn<String>(
    'last_error',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    provider,
    model,
    version,
    status,
    localPath,
    sha256,
    sizeBytes,
    downloadedAt,
    lastError,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'model_states';
  @override
  VerificationContext validateIntegrity(
    Insertable<ModelState> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('provider')) {
      context.handle(
        _providerMeta,
        provider.isAcceptableOrUnknown(data['provider']!, _providerMeta),
      );
    } else if (isInserting) {
      context.missing(_providerMeta);
    }
    if (data.containsKey('model')) {
      context.handle(
        _modelMeta,
        model.isAcceptableOrUnknown(data['model']!, _modelMeta),
      );
    } else if (isInserting) {
      context.missing(_modelMeta);
    }
    if (data.containsKey('version')) {
      context.handle(
        _versionMeta,
        version.isAcceptableOrUnknown(data['version']!, _versionMeta),
      );
    } else if (isInserting) {
      context.missing(_versionMeta);
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    } else if (isInserting) {
      context.missing(_statusMeta);
    }
    if (data.containsKey('local_path')) {
      context.handle(
        _localPathMeta,
        localPath.isAcceptableOrUnknown(data['local_path']!, _localPathMeta),
      );
    }
    if (data.containsKey('sha256')) {
      context.handle(
        _sha256Meta,
        sha256.isAcceptableOrUnknown(data['sha256']!, _sha256Meta),
      );
    }
    if (data.containsKey('size_bytes')) {
      context.handle(
        _sizeBytesMeta,
        sizeBytes.isAcceptableOrUnknown(data['size_bytes']!, _sizeBytesMeta),
      );
    }
    if (data.containsKey('downloaded_at')) {
      context.handle(
        _downloadedAtMeta,
        downloadedAt.isAcceptableOrUnknown(
          data['downloaded_at']!,
          _downloadedAtMeta,
        ),
      );
    }
    if (data.containsKey('last_error')) {
      context.handle(
        _lastErrorMeta,
        lastError.isAcceptableOrUnknown(data['last_error']!, _lastErrorMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ModelState map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ModelState(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      provider: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}provider'],
      )!,
      model: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}model'],
      )!,
      version: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}version'],
      )!,
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      localPath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}local_path'],
      ),
      sha256: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sha256'],
      ),
      sizeBytes: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}size_bytes'],
      ),
      downloadedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}downloaded_at'],
      ),
      lastError: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}last_error'],
      ),
    );
  }

  @override
  $ModelStatesTable createAlias(String alias) {
    return $ModelStatesTable(attachedDatabase, alias);
  }
}

class ModelState extends DataClass implements Insertable<ModelState> {
  final String id;
  final String provider;
  final String model;
  final String version;
  final String status;
  final String? localPath;
  final String? sha256;
  final int? sizeBytes;
  final DateTime? downloadedAt;
  final String? lastError;
  const ModelState({
    required this.id,
    required this.provider,
    required this.model,
    required this.version,
    required this.status,
    this.localPath,
    this.sha256,
    this.sizeBytes,
    this.downloadedAt,
    this.lastError,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['provider'] = Variable<String>(provider);
    map['model'] = Variable<String>(model);
    map['version'] = Variable<String>(version);
    map['status'] = Variable<String>(status);
    if (!nullToAbsent || localPath != null) {
      map['local_path'] = Variable<String>(localPath);
    }
    if (!nullToAbsent || sha256 != null) {
      map['sha256'] = Variable<String>(sha256);
    }
    if (!nullToAbsent || sizeBytes != null) {
      map['size_bytes'] = Variable<int>(sizeBytes);
    }
    if (!nullToAbsent || downloadedAt != null) {
      map['downloaded_at'] = Variable<DateTime>(downloadedAt);
    }
    if (!nullToAbsent || lastError != null) {
      map['last_error'] = Variable<String>(lastError);
    }
    return map;
  }

  ModelStatesCompanion toCompanion(bool nullToAbsent) {
    return ModelStatesCompanion(
      id: Value(id),
      provider: Value(provider),
      model: Value(model),
      version: Value(version),
      status: Value(status),
      localPath: localPath == null && nullToAbsent
          ? const Value.absent()
          : Value(localPath),
      sha256: sha256 == null && nullToAbsent
          ? const Value.absent()
          : Value(sha256),
      sizeBytes: sizeBytes == null && nullToAbsent
          ? const Value.absent()
          : Value(sizeBytes),
      downloadedAt: downloadedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(downloadedAt),
      lastError: lastError == null && nullToAbsent
          ? const Value.absent()
          : Value(lastError),
    );
  }

  factory ModelState.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ModelState(
      id: serializer.fromJson<String>(json['id']),
      provider: serializer.fromJson<String>(json['provider']),
      model: serializer.fromJson<String>(json['model']),
      version: serializer.fromJson<String>(json['version']),
      status: serializer.fromJson<String>(json['status']),
      localPath: serializer.fromJson<String?>(json['localPath']),
      sha256: serializer.fromJson<String?>(json['sha256']),
      sizeBytes: serializer.fromJson<int?>(json['sizeBytes']),
      downloadedAt: serializer.fromJson<DateTime?>(json['downloadedAt']),
      lastError: serializer.fromJson<String?>(json['lastError']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'provider': serializer.toJson<String>(provider),
      'model': serializer.toJson<String>(model),
      'version': serializer.toJson<String>(version),
      'status': serializer.toJson<String>(status),
      'localPath': serializer.toJson<String?>(localPath),
      'sha256': serializer.toJson<String?>(sha256),
      'sizeBytes': serializer.toJson<int?>(sizeBytes),
      'downloadedAt': serializer.toJson<DateTime?>(downloadedAt),
      'lastError': serializer.toJson<String?>(lastError),
    };
  }

  ModelState copyWith({
    String? id,
    String? provider,
    String? model,
    String? version,
    String? status,
    Value<String?> localPath = const Value.absent(),
    Value<String?> sha256 = const Value.absent(),
    Value<int?> sizeBytes = const Value.absent(),
    Value<DateTime?> downloadedAt = const Value.absent(),
    Value<String?> lastError = const Value.absent(),
  }) => ModelState(
    id: id ?? this.id,
    provider: provider ?? this.provider,
    model: model ?? this.model,
    version: version ?? this.version,
    status: status ?? this.status,
    localPath: localPath.present ? localPath.value : this.localPath,
    sha256: sha256.present ? sha256.value : this.sha256,
    sizeBytes: sizeBytes.present ? sizeBytes.value : this.sizeBytes,
    downloadedAt: downloadedAt.present ? downloadedAt.value : this.downloadedAt,
    lastError: lastError.present ? lastError.value : this.lastError,
  );
  ModelState copyWithCompanion(ModelStatesCompanion data) {
    return ModelState(
      id: data.id.present ? data.id.value : this.id,
      provider: data.provider.present ? data.provider.value : this.provider,
      model: data.model.present ? data.model.value : this.model,
      version: data.version.present ? data.version.value : this.version,
      status: data.status.present ? data.status.value : this.status,
      localPath: data.localPath.present ? data.localPath.value : this.localPath,
      sha256: data.sha256.present ? data.sha256.value : this.sha256,
      sizeBytes: data.sizeBytes.present ? data.sizeBytes.value : this.sizeBytes,
      downloadedAt: data.downloadedAt.present
          ? data.downloadedAt.value
          : this.downloadedAt,
      lastError: data.lastError.present ? data.lastError.value : this.lastError,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ModelState(')
          ..write('id: $id, ')
          ..write('provider: $provider, ')
          ..write('model: $model, ')
          ..write('version: $version, ')
          ..write('status: $status, ')
          ..write('localPath: $localPath, ')
          ..write('sha256: $sha256, ')
          ..write('sizeBytes: $sizeBytes, ')
          ..write('downloadedAt: $downloadedAt, ')
          ..write('lastError: $lastError')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    provider,
    model,
    version,
    status,
    localPath,
    sha256,
    sizeBytes,
    downloadedAt,
    lastError,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ModelState &&
          other.id == this.id &&
          other.provider == this.provider &&
          other.model == this.model &&
          other.version == this.version &&
          other.status == this.status &&
          other.localPath == this.localPath &&
          other.sha256 == this.sha256 &&
          other.sizeBytes == this.sizeBytes &&
          other.downloadedAt == this.downloadedAt &&
          other.lastError == this.lastError);
}

class ModelStatesCompanion extends UpdateCompanion<ModelState> {
  final Value<String> id;
  final Value<String> provider;
  final Value<String> model;
  final Value<String> version;
  final Value<String> status;
  final Value<String?> localPath;
  final Value<String?> sha256;
  final Value<int?> sizeBytes;
  final Value<DateTime?> downloadedAt;
  final Value<String?> lastError;
  final Value<int> rowid;
  const ModelStatesCompanion({
    this.id = const Value.absent(),
    this.provider = const Value.absent(),
    this.model = const Value.absent(),
    this.version = const Value.absent(),
    this.status = const Value.absent(),
    this.localPath = const Value.absent(),
    this.sha256 = const Value.absent(),
    this.sizeBytes = const Value.absent(),
    this.downloadedAt = const Value.absent(),
    this.lastError = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ModelStatesCompanion.insert({
    required String id,
    required String provider,
    required String model,
    required String version,
    required String status,
    this.localPath = const Value.absent(),
    this.sha256 = const Value.absent(),
    this.sizeBytes = const Value.absent(),
    this.downloadedAt = const Value.absent(),
    this.lastError = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       provider = Value(provider),
       model = Value(model),
       version = Value(version),
       status = Value(status);
  static Insertable<ModelState> custom({
    Expression<String>? id,
    Expression<String>? provider,
    Expression<String>? model,
    Expression<String>? version,
    Expression<String>? status,
    Expression<String>? localPath,
    Expression<String>? sha256,
    Expression<int>? sizeBytes,
    Expression<DateTime>? downloadedAt,
    Expression<String>? lastError,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (provider != null) 'provider': provider,
      if (model != null) 'model': model,
      if (version != null) 'version': version,
      if (status != null) 'status': status,
      if (localPath != null) 'local_path': localPath,
      if (sha256 != null) 'sha256': sha256,
      if (sizeBytes != null) 'size_bytes': sizeBytes,
      if (downloadedAt != null) 'downloaded_at': downloadedAt,
      if (lastError != null) 'last_error': lastError,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ModelStatesCompanion copyWith({
    Value<String>? id,
    Value<String>? provider,
    Value<String>? model,
    Value<String>? version,
    Value<String>? status,
    Value<String?>? localPath,
    Value<String?>? sha256,
    Value<int?>? sizeBytes,
    Value<DateTime?>? downloadedAt,
    Value<String?>? lastError,
    Value<int>? rowid,
  }) {
    return ModelStatesCompanion(
      id: id ?? this.id,
      provider: provider ?? this.provider,
      model: model ?? this.model,
      version: version ?? this.version,
      status: status ?? this.status,
      localPath: localPath ?? this.localPath,
      sha256: sha256 ?? this.sha256,
      sizeBytes: sizeBytes ?? this.sizeBytes,
      downloadedAt: downloadedAt ?? this.downloadedAt,
      lastError: lastError ?? this.lastError,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (provider.present) {
      map['provider'] = Variable<String>(provider.value);
    }
    if (model.present) {
      map['model'] = Variable<String>(model.value);
    }
    if (version.present) {
      map['version'] = Variable<String>(version.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (localPath.present) {
      map['local_path'] = Variable<String>(localPath.value);
    }
    if (sha256.present) {
      map['sha256'] = Variable<String>(sha256.value);
    }
    if (sizeBytes.present) {
      map['size_bytes'] = Variable<int>(sizeBytes.value);
    }
    if (downloadedAt.present) {
      map['downloaded_at'] = Variable<DateTime>(downloadedAt.value);
    }
    if (lastError.present) {
      map['last_error'] = Variable<String>(lastError.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ModelStatesCompanion(')
          ..write('id: $id, ')
          ..write('provider: $provider, ')
          ..write('model: $model, ')
          ..write('version: $version, ')
          ..write('status: $status, ')
          ..write('localPath: $localPath, ')
          ..write('sha256: $sha256, ')
          ..write('sizeBytes: $sizeBytes, ')
          ..write('downloadedAt: $downloadedAt, ')
          ..write('lastError: $lastError, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $WidgetStatesTable extends WidgetStates
    with TableInfo<$WidgetStatesTable, WidgetState> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $WidgetStatesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
  );
  static const VerificationMeta _privacyHiddenMeta = const VerificationMeta(
    'privacyHidden',
  );
  @override
  late final GeneratedColumn<bool> privacyHidden = GeneratedColumn<bool>(
    'privacy_hidden',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("privacy_hidden" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, privacyHidden, updatedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'widget_states';
  @override
  VerificationContext validateIntegrity(
    Insertable<WidgetState> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('privacy_hidden')) {
      context.handle(
        _privacyHiddenMeta,
        privacyHidden.isAcceptableOrUnknown(
          data['privacy_hidden']!,
          _privacyHiddenMeta,
        ),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  WidgetState map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return WidgetState(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      privacyHidden: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}privacy_hidden'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $WidgetStatesTable createAlias(String alias) {
    return $WidgetStatesTable(attachedDatabase, alias);
  }
}

class WidgetState extends DataClass implements Insertable<WidgetState> {
  final int id;
  final bool privacyHidden;
  final DateTime updatedAt;
  const WidgetState({
    required this.id,
    required this.privacyHidden,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['privacy_hidden'] = Variable<bool>(privacyHidden);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  WidgetStatesCompanion toCompanion(bool nullToAbsent) {
    return WidgetStatesCompanion(
      id: Value(id),
      privacyHidden: Value(privacyHidden),
      updatedAt: Value(updatedAt),
    );
  }

  factory WidgetState.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return WidgetState(
      id: serializer.fromJson<int>(json['id']),
      privacyHidden: serializer.fromJson<bool>(json['privacyHidden']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'privacyHidden': serializer.toJson<bool>(privacyHidden),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  WidgetState copyWith({int? id, bool? privacyHidden, DateTime? updatedAt}) =>
      WidgetState(
        id: id ?? this.id,
        privacyHidden: privacyHidden ?? this.privacyHidden,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  WidgetState copyWithCompanion(WidgetStatesCompanion data) {
    return WidgetState(
      id: data.id.present ? data.id.value : this.id,
      privacyHidden: data.privacyHidden.present
          ? data.privacyHidden.value
          : this.privacyHidden,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('WidgetState(')
          ..write('id: $id, ')
          ..write('privacyHidden: $privacyHidden, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, privacyHidden, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is WidgetState &&
          other.id == this.id &&
          other.privacyHidden == this.privacyHidden &&
          other.updatedAt == this.updatedAt);
}

class WidgetStatesCompanion extends UpdateCompanion<WidgetState> {
  final Value<int> id;
  final Value<bool> privacyHidden;
  final Value<DateTime> updatedAt;
  const WidgetStatesCompanion({
    this.id = const Value.absent(),
    this.privacyHidden = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  WidgetStatesCompanion.insert({
    this.id = const Value.absent(),
    this.privacyHidden = const Value.absent(),
    required DateTime updatedAt,
  }) : updatedAt = Value(updatedAt);
  static Insertable<WidgetState> custom({
    Expression<int>? id,
    Expression<bool>? privacyHidden,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (privacyHidden != null) 'privacy_hidden': privacyHidden,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  WidgetStatesCompanion copyWith({
    Value<int>? id,
    Value<bool>? privacyHidden,
    Value<DateTime>? updatedAt,
  }) {
    return WidgetStatesCompanion(
      id: id ?? this.id,
      privacyHidden: privacyHidden ?? this.privacyHidden,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (privacyHidden.present) {
      map['privacy_hidden'] = Variable<bool>(privacyHidden.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('WidgetStatesCompanion(')
          ..write('id: $id, ')
          ..write('privacyHidden: $privacyHidden, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $MetaEntriesTable metaEntries = $MetaEntriesTable(this);
  late final $GmailMessagesTable gmailMessages = $GmailMessagesTable(this);
  late final $AppAccountsTable appAccounts = $AppAccountsTable(this);
  late final $SourcesTable sources = $SourcesTable(this);
  late final $SourceAllowlistEntriesTable sourceAllowlistEntries =
      $SourceAllowlistEntriesTable(this);
  late final $GmailMessageAccountsTable gmailMessageAccounts =
      $GmailMessageAccountsTable(this);
  late final $GmailMessageBodiesTable gmailMessageBodies =
      $GmailMessageBodiesTable(this);
  late final $AttachmentsTable attachments = $AttachmentsTable(this);
  late final $ProposalsTable proposals = $ProposalsTable(this);
  late final $ProposalItemsTable proposalItems = $ProposalItemsTable(this);
  late final $EventsTable events = $EventsTable(this);
  late final $EventItemsTable eventItems = $EventItemsTable(this);
  late final $AlarmSchedulesTable alarmSchedules = $AlarmSchedulesTable(this);
  late final $SyncCursorsTable syncCursors = $SyncCursorsTable(this);
  late final $AppSettingsTable appSettings = $AppSettingsTable(this);
  late final $ModelStatesTable modelStates = $ModelStatesTable(this);
  late final $WidgetStatesTable widgetStates = $WidgetStatesTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    metaEntries,
    gmailMessages,
    appAccounts,
    sources,
    sourceAllowlistEntries,
    gmailMessageAccounts,
    gmailMessageBodies,
    attachments,
    proposals,
    proposalItems,
    events,
    eventItems,
    alarmSchedules,
    syncCursors,
    appSettings,
    modelStates,
    widgetStates,
  ];
  @override
  StreamQueryUpdateRules get streamUpdateRules => const StreamQueryUpdateRules([
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'app_accounts',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('sources', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'sources',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [
        TableUpdate('source_allowlist_entries', kind: UpdateKind.delete),
      ],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'gmail_messages',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('gmail_message_accounts', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'app_accounts',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('gmail_message_accounts', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'gmail_messages',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('gmail_message_bodies', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'gmail_messages',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('attachments', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'gmail_messages',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('proposals', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'sources',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('proposals', kind: UpdateKind.update)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'proposals',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('proposal_items', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'proposals',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('events', kind: UpdateKind.update)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'gmail_messages',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('events', kind: UpdateKind.update)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'app_accounts',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('events', kind: UpdateKind.update)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'events',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('event_items', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'events',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('alarm_schedules', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'app_accounts',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('sync_cursors', kind: UpdateKind.delete)],
    ),
  ]);
}

typedef $$MetaEntriesTableCreateCompanionBuilder =
    MetaEntriesCompanion Function({
      required String key,
      required String value,
      Value<int> rowid,
    });
typedef $$MetaEntriesTableUpdateCompanionBuilder =
    MetaEntriesCompanion Function({
      Value<String> key,
      Value<String> value,
      Value<int> rowid,
    });

class $$MetaEntriesTableFilterComposer
    extends Composer<_$AppDatabase, $MetaEntriesTable> {
  $$MetaEntriesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get key => $composableBuilder(
    column: $table.key,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get value => $composableBuilder(
    column: $table.value,
    builder: (column) => ColumnFilters(column),
  );
}

class $$MetaEntriesTableOrderingComposer
    extends Composer<_$AppDatabase, $MetaEntriesTable> {
  $$MetaEntriesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get key => $composableBuilder(
    column: $table.key,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get value => $composableBuilder(
    column: $table.value,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$MetaEntriesTableAnnotationComposer
    extends Composer<_$AppDatabase, $MetaEntriesTable> {
  $$MetaEntriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get key =>
      $composableBuilder(column: $table.key, builder: (column) => column);

  GeneratedColumn<String> get value =>
      $composableBuilder(column: $table.value, builder: (column) => column);
}

class $$MetaEntriesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $MetaEntriesTable,
          MetaEntry,
          $$MetaEntriesTableFilterComposer,
          $$MetaEntriesTableOrderingComposer,
          $$MetaEntriesTableAnnotationComposer,
          $$MetaEntriesTableCreateCompanionBuilder,
          $$MetaEntriesTableUpdateCompanionBuilder,
          (
            MetaEntry,
            BaseReferences<_$AppDatabase, $MetaEntriesTable, MetaEntry>,
          ),
          MetaEntry,
          PrefetchHooks Function()
        > {
  $$MetaEntriesTableTableManager(_$AppDatabase db, $MetaEntriesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MetaEntriesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MetaEntriesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$MetaEntriesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> key = const Value.absent(),
                Value<String> value = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => MetaEntriesCompanion(key: key, value: value, rowid: rowid),
          createCompanionCallback:
              ({
                required String key,
                required String value,
                Value<int> rowid = const Value.absent(),
              }) => MetaEntriesCompanion.insert(
                key: key,
                value: value,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$MetaEntriesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $MetaEntriesTable,
      MetaEntry,
      $$MetaEntriesTableFilterComposer,
      $$MetaEntriesTableOrderingComposer,
      $$MetaEntriesTableAnnotationComposer,
      $$MetaEntriesTableCreateCompanionBuilder,
      $$MetaEntriesTableUpdateCompanionBuilder,
      (MetaEntry, BaseReferences<_$AppDatabase, $MetaEntriesTable, MetaEntry>),
      MetaEntry,
      PrefetchHooks Function()
    >;
typedef $$GmailMessagesTableCreateCompanionBuilder =
    GmailMessagesCompanion Function({
      required String messageId,
      Value<String?> threadId,
      Value<int?> internalDateMs,
      Value<String?> fromRaw,
      Value<String?> subjectRaw,
      required String parseStatus,
      required String firstSeenAt,
      required String lastSeenAt,
      Value<int> rowid,
    });
typedef $$GmailMessagesTableUpdateCompanionBuilder =
    GmailMessagesCompanion Function({
      Value<String> messageId,
      Value<String?> threadId,
      Value<int?> internalDateMs,
      Value<String?> fromRaw,
      Value<String?> subjectRaw,
      Value<String> parseStatus,
      Value<String> firstSeenAt,
      Value<String> lastSeenAt,
      Value<int> rowid,
    });

final class $$GmailMessagesTableReferences
    extends BaseReferences<_$AppDatabase, $GmailMessagesTable, GmailMessage> {
  $$GmailMessagesTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static MultiTypedResultKey<
    $GmailMessageAccountsTable,
    List<GmailMessageAccount>
  >
  _gmailMessageAccountsRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.gmailMessageAccounts,
        aliasName:
            'gmail_messages__message_id__gmail_message_accounts__message_id',
      );

  $$GmailMessageAccountsTableProcessedTableManager
  get gmailMessageAccountsRefs {
    final manager =
        $$GmailMessageAccountsTableTableManager(
          $_db,
          $_db.gmailMessageAccounts,
        ).filter(
          (f) => f.messageId.messageId.sqlEquals(
            $_itemColumn<String>('message_id')!,
          ),
        );

    final cache = $_typedResult.readTableOrNull(
      _gmailMessageAccountsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$GmailMessageBodiesTable, List<GmailMessageBody>>
  _gmailMessageBodiesRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.gmailMessageBodies,
        aliasName:
            'gmail_messages__message_id__gmail_message_bodies__message_id',
      );

  $$GmailMessageBodiesTableProcessedTableManager get gmailMessageBodiesRefs {
    final manager =
        $$GmailMessageBodiesTableTableManager(
          $_db,
          $_db.gmailMessageBodies,
        ).filter(
          (f) => f.messageId.messageId.sqlEquals(
            $_itemColumn<String>('message_id')!,
          ),
        );

    final cache = $_typedResult.readTableOrNull(
      _gmailMessageBodiesRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$AttachmentsTable, List<Attachment>>
  _attachmentsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.attachments,
    aliasName: 'gmail_messages__message_id__attachments__message_id',
  );

  $$AttachmentsTableProcessedTableManager get attachmentsRefs {
    final manager = $$AttachmentsTableTableManager($_db, $_db.attachments)
        .filter(
          (f) => f.messageId.messageId.sqlEquals(
            $_itemColumn<String>('message_id')!,
          ),
        );

    final cache = $_typedResult.readTableOrNull(_attachmentsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$ProposalsTable, List<Proposal>>
  _proposalsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.proposals,
    aliasName: 'gmail_messages__message_id__proposals__message_id',
  );

  $$ProposalsTableProcessedTableManager get proposalsRefs {
    final manager = $$ProposalsTableTableManager($_db, $_db.proposals).filter(
      (f) =>
          f.messageId.messageId.sqlEquals($_itemColumn<String>('message_id')!),
    );

    final cache = $_typedResult.readTableOrNull(_proposalsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$EventsTable, List<Event>> _eventsRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.events,
    aliasName: 'gmail_messages__message_id__events__source_message_id',
  );

  $$EventsTableProcessedTableManager get eventsRefs {
    final manager = $$EventsTableTableManager($_db, $_db.events).filter(
      (f) => f.sourceMessageId.messageId.sqlEquals(
        $_itemColumn<String>('message_id')!,
      ),
    );

    final cache = $_typedResult.readTableOrNull(_eventsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$GmailMessagesTableFilterComposer
    extends Composer<_$AppDatabase, $GmailMessagesTable> {
  $$GmailMessagesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get messageId => $composableBuilder(
    column: $table.messageId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get threadId => $composableBuilder(
    column: $table.threadId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get internalDateMs => $composableBuilder(
    column: $table.internalDateMs,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get fromRaw => $composableBuilder(
    column: $table.fromRaw,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get subjectRaw => $composableBuilder(
    column: $table.subjectRaw,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get parseStatus => $composableBuilder(
    column: $table.parseStatus,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get firstSeenAt => $composableBuilder(
    column: $table.firstSeenAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get lastSeenAt => $composableBuilder(
    column: $table.lastSeenAt,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> gmailMessageAccountsRefs(
    Expression<bool> Function($$GmailMessageAccountsTableFilterComposer f) f,
  ) {
    final $$GmailMessageAccountsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.messageId,
      referencedTable: $db.gmailMessageAccounts,
      getReferencedColumn: (t) => t.messageId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$GmailMessageAccountsTableFilterComposer(
            $db: $db,
            $table: $db.gmailMessageAccounts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> gmailMessageBodiesRefs(
    Expression<bool> Function($$GmailMessageBodiesTableFilterComposer f) f,
  ) {
    final $$GmailMessageBodiesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.messageId,
      referencedTable: $db.gmailMessageBodies,
      getReferencedColumn: (t) => t.messageId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$GmailMessageBodiesTableFilterComposer(
            $db: $db,
            $table: $db.gmailMessageBodies,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> attachmentsRefs(
    Expression<bool> Function($$AttachmentsTableFilterComposer f) f,
  ) {
    final $$AttachmentsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.messageId,
      referencedTable: $db.attachments,
      getReferencedColumn: (t) => t.messageId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AttachmentsTableFilterComposer(
            $db: $db,
            $table: $db.attachments,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> proposalsRefs(
    Expression<bool> Function($$ProposalsTableFilterComposer f) f,
  ) {
    final $$ProposalsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.messageId,
      referencedTable: $db.proposals,
      getReferencedColumn: (t) => t.messageId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProposalsTableFilterComposer(
            $db: $db,
            $table: $db.proposals,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> eventsRefs(
    Expression<bool> Function($$EventsTableFilterComposer f) f,
  ) {
    final $$EventsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.messageId,
      referencedTable: $db.events,
      getReferencedColumn: (t) => t.sourceMessageId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EventsTableFilterComposer(
            $db: $db,
            $table: $db.events,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$GmailMessagesTableOrderingComposer
    extends Composer<_$AppDatabase, $GmailMessagesTable> {
  $$GmailMessagesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get messageId => $composableBuilder(
    column: $table.messageId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get threadId => $composableBuilder(
    column: $table.threadId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get internalDateMs => $composableBuilder(
    column: $table.internalDateMs,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get fromRaw => $composableBuilder(
    column: $table.fromRaw,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get subjectRaw => $composableBuilder(
    column: $table.subjectRaw,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get parseStatus => $composableBuilder(
    column: $table.parseStatus,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get firstSeenAt => $composableBuilder(
    column: $table.firstSeenAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get lastSeenAt => $composableBuilder(
    column: $table.lastSeenAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$GmailMessagesTableAnnotationComposer
    extends Composer<_$AppDatabase, $GmailMessagesTable> {
  $$GmailMessagesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get messageId =>
      $composableBuilder(column: $table.messageId, builder: (column) => column);

  GeneratedColumn<String> get threadId =>
      $composableBuilder(column: $table.threadId, builder: (column) => column);

  GeneratedColumn<int> get internalDateMs => $composableBuilder(
    column: $table.internalDateMs,
    builder: (column) => column,
  );

  GeneratedColumn<String> get fromRaw =>
      $composableBuilder(column: $table.fromRaw, builder: (column) => column);

  GeneratedColumn<String> get subjectRaw => $composableBuilder(
    column: $table.subjectRaw,
    builder: (column) => column,
  );

  GeneratedColumn<String> get parseStatus => $composableBuilder(
    column: $table.parseStatus,
    builder: (column) => column,
  );

  GeneratedColumn<String> get firstSeenAt => $composableBuilder(
    column: $table.firstSeenAt,
    builder: (column) => column,
  );

  GeneratedColumn<String> get lastSeenAt => $composableBuilder(
    column: $table.lastSeenAt,
    builder: (column) => column,
  );

  Expression<T> gmailMessageAccountsRefs<T extends Object>(
    Expression<T> Function($$GmailMessageAccountsTableAnnotationComposer a) f,
  ) {
    final $$GmailMessageAccountsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.messageId,
          referencedTable: $db.gmailMessageAccounts,
          getReferencedColumn: (t) => t.messageId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$GmailMessageAccountsTableAnnotationComposer(
                $db: $db,
                $table: $db.gmailMessageAccounts,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> gmailMessageBodiesRefs<T extends Object>(
    Expression<T> Function($$GmailMessageBodiesTableAnnotationComposer a) f,
  ) {
    final $$GmailMessageBodiesTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.messageId,
          referencedTable: $db.gmailMessageBodies,
          getReferencedColumn: (t) => t.messageId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$GmailMessageBodiesTableAnnotationComposer(
                $db: $db,
                $table: $db.gmailMessageBodies,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> attachmentsRefs<T extends Object>(
    Expression<T> Function($$AttachmentsTableAnnotationComposer a) f,
  ) {
    final $$AttachmentsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.messageId,
      referencedTable: $db.attachments,
      getReferencedColumn: (t) => t.messageId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AttachmentsTableAnnotationComposer(
            $db: $db,
            $table: $db.attachments,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> proposalsRefs<T extends Object>(
    Expression<T> Function($$ProposalsTableAnnotationComposer a) f,
  ) {
    final $$ProposalsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.messageId,
      referencedTable: $db.proposals,
      getReferencedColumn: (t) => t.messageId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProposalsTableAnnotationComposer(
            $db: $db,
            $table: $db.proposals,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> eventsRefs<T extends Object>(
    Expression<T> Function($$EventsTableAnnotationComposer a) f,
  ) {
    final $$EventsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.messageId,
      referencedTable: $db.events,
      getReferencedColumn: (t) => t.sourceMessageId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EventsTableAnnotationComposer(
            $db: $db,
            $table: $db.events,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$GmailMessagesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $GmailMessagesTable,
          GmailMessage,
          $$GmailMessagesTableFilterComposer,
          $$GmailMessagesTableOrderingComposer,
          $$GmailMessagesTableAnnotationComposer,
          $$GmailMessagesTableCreateCompanionBuilder,
          $$GmailMessagesTableUpdateCompanionBuilder,
          (GmailMessage, $$GmailMessagesTableReferences),
          GmailMessage,
          PrefetchHooks Function({
            bool gmailMessageAccountsRefs,
            bool gmailMessageBodiesRefs,
            bool attachmentsRefs,
            bool proposalsRefs,
            bool eventsRefs,
          })
        > {
  $$GmailMessagesTableTableManager(_$AppDatabase db, $GmailMessagesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$GmailMessagesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$GmailMessagesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$GmailMessagesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> messageId = const Value.absent(),
                Value<String?> threadId = const Value.absent(),
                Value<int?> internalDateMs = const Value.absent(),
                Value<String?> fromRaw = const Value.absent(),
                Value<String?> subjectRaw = const Value.absent(),
                Value<String> parseStatus = const Value.absent(),
                Value<String> firstSeenAt = const Value.absent(),
                Value<String> lastSeenAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => GmailMessagesCompanion(
                messageId: messageId,
                threadId: threadId,
                internalDateMs: internalDateMs,
                fromRaw: fromRaw,
                subjectRaw: subjectRaw,
                parseStatus: parseStatus,
                firstSeenAt: firstSeenAt,
                lastSeenAt: lastSeenAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String messageId,
                Value<String?> threadId = const Value.absent(),
                Value<int?> internalDateMs = const Value.absent(),
                Value<String?> fromRaw = const Value.absent(),
                Value<String?> subjectRaw = const Value.absent(),
                required String parseStatus,
                required String firstSeenAt,
                required String lastSeenAt,
                Value<int> rowid = const Value.absent(),
              }) => GmailMessagesCompanion.insert(
                messageId: messageId,
                threadId: threadId,
                internalDateMs: internalDateMs,
                fromRaw: fromRaw,
                subjectRaw: subjectRaw,
                parseStatus: parseStatus,
                firstSeenAt: firstSeenAt,
                lastSeenAt: lastSeenAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$GmailMessagesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                gmailMessageAccountsRefs = false,
                gmailMessageBodiesRefs = false,
                attachmentsRefs = false,
                proposalsRefs = false,
                eventsRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (gmailMessageAccountsRefs) db.gmailMessageAccounts,
                    if (gmailMessageBodiesRefs) db.gmailMessageBodies,
                    if (attachmentsRefs) db.attachments,
                    if (proposalsRefs) db.proposals,
                    if (eventsRefs) db.events,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (gmailMessageAccountsRefs)
                        await $_getPrefetchedData<
                          GmailMessage,
                          $GmailMessagesTable,
                          GmailMessageAccount
                        >(
                          currentTable: table,
                          referencedTable: $$GmailMessagesTableReferences
                              ._gmailMessageAccountsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$GmailMessagesTableReferences(
                                db,
                                table,
                                p0,
                              ).gmailMessageAccountsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.messageId == item.messageId,
                              ),
                          typedResults: items,
                        ),
                      if (gmailMessageBodiesRefs)
                        await $_getPrefetchedData<
                          GmailMessage,
                          $GmailMessagesTable,
                          GmailMessageBody
                        >(
                          currentTable: table,
                          referencedTable: $$GmailMessagesTableReferences
                              ._gmailMessageBodiesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$GmailMessagesTableReferences(
                                db,
                                table,
                                p0,
                              ).gmailMessageBodiesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.messageId == item.messageId,
                              ),
                          typedResults: items,
                        ),
                      if (attachmentsRefs)
                        await $_getPrefetchedData<
                          GmailMessage,
                          $GmailMessagesTable,
                          Attachment
                        >(
                          currentTable: table,
                          referencedTable: $$GmailMessagesTableReferences
                              ._attachmentsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$GmailMessagesTableReferences(
                                db,
                                table,
                                p0,
                              ).attachmentsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.messageId == item.messageId,
                              ),
                          typedResults: items,
                        ),
                      if (proposalsRefs)
                        await $_getPrefetchedData<
                          GmailMessage,
                          $GmailMessagesTable,
                          Proposal
                        >(
                          currentTable: table,
                          referencedTable: $$GmailMessagesTableReferences
                              ._proposalsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$GmailMessagesTableReferences(
                                db,
                                table,
                                p0,
                              ).proposalsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.messageId == item.messageId,
                              ),
                          typedResults: items,
                        ),
                      if (eventsRefs)
                        await $_getPrefetchedData<
                          GmailMessage,
                          $GmailMessagesTable,
                          Event
                        >(
                          currentTable: table,
                          referencedTable: $$GmailMessagesTableReferences
                              ._eventsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$GmailMessagesTableReferences(
                                db,
                                table,
                                p0,
                              ).eventsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.sourceMessageId == item.messageId,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$GmailMessagesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $GmailMessagesTable,
      GmailMessage,
      $$GmailMessagesTableFilterComposer,
      $$GmailMessagesTableOrderingComposer,
      $$GmailMessagesTableAnnotationComposer,
      $$GmailMessagesTableCreateCompanionBuilder,
      $$GmailMessagesTableUpdateCompanionBuilder,
      (GmailMessage, $$GmailMessagesTableReferences),
      GmailMessage,
      PrefetchHooks Function({
        bool gmailMessageAccountsRefs,
        bool gmailMessageBodiesRefs,
        bool attachmentsRefs,
        bool proposalsRefs,
        bool eventsRefs,
      })
    >;
typedef $$AppAccountsTableCreateCompanionBuilder =
    AppAccountsCompanion Function({
      required String id,
      required String email,
      Value<String?> displayName,
      Value<String?> backendAccountId,
      Value<String> status,
      required DateTime createdAt,
      required DateTime updatedAt,
      Value<int> rowid,
    });
typedef $$AppAccountsTableUpdateCompanionBuilder =
    AppAccountsCompanion Function({
      Value<String> id,
      Value<String> email,
      Value<String?> displayName,
      Value<String?> backendAccountId,
      Value<String> status,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

final class $$AppAccountsTableReferences
    extends BaseReferences<_$AppDatabase, $AppAccountsTable, AppAccount> {
  $$AppAccountsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$SourcesTable, List<Source>> _sourcesRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.sources,
    aliasName: 'app_accounts__id__sources__account_id',
  );

  $$SourcesTableProcessedTableManager get sourcesRefs {
    final manager = $$SourcesTableTableManager(
      $_db,
      $_db.sources,
    ).filter((f) => f.accountId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_sourcesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<
    $GmailMessageAccountsTable,
    List<GmailMessageAccount>
  >
  _gmailMessageAccountsRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.gmailMessageAccounts,
        aliasName: 'app_accounts__id__gmail_message_accounts__account_id',
      );

  $$GmailMessageAccountsTableProcessedTableManager
  get gmailMessageAccountsRefs {
    final manager = $$GmailMessageAccountsTableTableManager(
      $_db,
      $_db.gmailMessageAccounts,
    ).filter((f) => f.accountId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _gmailMessageAccountsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$EventsTable, List<Event>> _eventsRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.events,
    aliasName: 'app_accounts__id__events__account_id',
  );

  $$EventsTableProcessedTableManager get eventsRefs {
    final manager = $$EventsTableTableManager(
      $_db,
      $_db.events,
    ).filter((f) => f.accountId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_eventsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$SyncCursorsTable, List<SyncCursor>>
  _syncCursorsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.syncCursors,
    aliasName: 'app_accounts__id__sync_cursors__account_id',
  );

  $$SyncCursorsTableProcessedTableManager get syncCursorsRefs {
    final manager = $$SyncCursorsTableTableManager(
      $_db,
      $_db.syncCursors,
    ).filter((f) => f.accountId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_syncCursorsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$AppAccountsTableFilterComposer
    extends Composer<_$AppDatabase, $AppAccountsTable> {
  $$AppAccountsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get email => $composableBuilder(
    column: $table.email,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get displayName => $composableBuilder(
    column: $table.displayName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get backendAccountId => $composableBuilder(
    column: $table.backendAccountId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> sourcesRefs(
    Expression<bool> Function($$SourcesTableFilterComposer f) f,
  ) {
    final $$SourcesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.sources,
      getReferencedColumn: (t) => t.accountId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SourcesTableFilterComposer(
            $db: $db,
            $table: $db.sources,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> gmailMessageAccountsRefs(
    Expression<bool> Function($$GmailMessageAccountsTableFilterComposer f) f,
  ) {
    final $$GmailMessageAccountsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.gmailMessageAccounts,
      getReferencedColumn: (t) => t.accountId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$GmailMessageAccountsTableFilterComposer(
            $db: $db,
            $table: $db.gmailMessageAccounts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> eventsRefs(
    Expression<bool> Function($$EventsTableFilterComposer f) f,
  ) {
    final $$EventsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.events,
      getReferencedColumn: (t) => t.accountId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EventsTableFilterComposer(
            $db: $db,
            $table: $db.events,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> syncCursorsRefs(
    Expression<bool> Function($$SyncCursorsTableFilterComposer f) f,
  ) {
    final $$SyncCursorsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.syncCursors,
      getReferencedColumn: (t) => t.accountId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SyncCursorsTableFilterComposer(
            $db: $db,
            $table: $db.syncCursors,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$AppAccountsTableOrderingComposer
    extends Composer<_$AppDatabase, $AppAccountsTable> {
  $$AppAccountsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get email => $composableBuilder(
    column: $table.email,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get displayName => $composableBuilder(
    column: $table.displayName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get backendAccountId => $composableBuilder(
    column: $table.backendAccountId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$AppAccountsTableAnnotationComposer
    extends Composer<_$AppDatabase, $AppAccountsTable> {
  $$AppAccountsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get email =>
      $composableBuilder(column: $table.email, builder: (column) => column);

  GeneratedColumn<String> get displayName => $composableBuilder(
    column: $table.displayName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get backendAccountId => $composableBuilder(
    column: $table.backendAccountId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  Expression<T> sourcesRefs<T extends Object>(
    Expression<T> Function($$SourcesTableAnnotationComposer a) f,
  ) {
    final $$SourcesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.sources,
      getReferencedColumn: (t) => t.accountId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SourcesTableAnnotationComposer(
            $db: $db,
            $table: $db.sources,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> gmailMessageAccountsRefs<T extends Object>(
    Expression<T> Function($$GmailMessageAccountsTableAnnotationComposer a) f,
  ) {
    final $$GmailMessageAccountsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.gmailMessageAccounts,
          getReferencedColumn: (t) => t.accountId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$GmailMessageAccountsTableAnnotationComposer(
                $db: $db,
                $table: $db.gmailMessageAccounts,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> eventsRefs<T extends Object>(
    Expression<T> Function($$EventsTableAnnotationComposer a) f,
  ) {
    final $$EventsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.events,
      getReferencedColumn: (t) => t.accountId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EventsTableAnnotationComposer(
            $db: $db,
            $table: $db.events,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> syncCursorsRefs<T extends Object>(
    Expression<T> Function($$SyncCursorsTableAnnotationComposer a) f,
  ) {
    final $$SyncCursorsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.syncCursors,
      getReferencedColumn: (t) => t.accountId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SyncCursorsTableAnnotationComposer(
            $db: $db,
            $table: $db.syncCursors,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$AppAccountsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $AppAccountsTable,
          AppAccount,
          $$AppAccountsTableFilterComposer,
          $$AppAccountsTableOrderingComposer,
          $$AppAccountsTableAnnotationComposer,
          $$AppAccountsTableCreateCompanionBuilder,
          $$AppAccountsTableUpdateCompanionBuilder,
          (AppAccount, $$AppAccountsTableReferences),
          AppAccount,
          PrefetchHooks Function({
            bool sourcesRefs,
            bool gmailMessageAccountsRefs,
            bool eventsRefs,
            bool syncCursorsRefs,
          })
        > {
  $$AppAccountsTableTableManager(_$AppDatabase db, $AppAccountsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AppAccountsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AppAccountsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AppAccountsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> email = const Value.absent(),
                Value<String?> displayName = const Value.absent(),
                Value<String?> backendAccountId = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => AppAccountsCompanion(
                id: id,
                email: email,
                displayName: displayName,
                backendAccountId: backendAccountId,
                status: status,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String email,
                Value<String?> displayName = const Value.absent(),
                Value<String?> backendAccountId = const Value.absent(),
                Value<String> status = const Value.absent(),
                required DateTime createdAt,
                required DateTime updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => AppAccountsCompanion.insert(
                id: id,
                email: email,
                displayName: displayName,
                backendAccountId: backendAccountId,
                status: status,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$AppAccountsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                sourcesRefs = false,
                gmailMessageAccountsRefs = false,
                eventsRefs = false,
                syncCursorsRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (sourcesRefs) db.sources,
                    if (gmailMessageAccountsRefs) db.gmailMessageAccounts,
                    if (eventsRefs) db.events,
                    if (syncCursorsRefs) db.syncCursors,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (sourcesRefs)
                        await $_getPrefetchedData<
                          AppAccount,
                          $AppAccountsTable,
                          Source
                        >(
                          currentTable: table,
                          referencedTable: $$AppAccountsTableReferences
                              ._sourcesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$AppAccountsTableReferences(
                                db,
                                table,
                                p0,
                              ).sourcesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.accountId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (gmailMessageAccountsRefs)
                        await $_getPrefetchedData<
                          AppAccount,
                          $AppAccountsTable,
                          GmailMessageAccount
                        >(
                          currentTable: table,
                          referencedTable: $$AppAccountsTableReferences
                              ._gmailMessageAccountsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$AppAccountsTableReferences(
                                db,
                                table,
                                p0,
                              ).gmailMessageAccountsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.accountId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (eventsRefs)
                        await $_getPrefetchedData<
                          AppAccount,
                          $AppAccountsTable,
                          Event
                        >(
                          currentTable: table,
                          referencedTable: $$AppAccountsTableReferences
                              ._eventsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$AppAccountsTableReferences(
                                db,
                                table,
                                p0,
                              ).eventsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.accountId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (syncCursorsRefs)
                        await $_getPrefetchedData<
                          AppAccount,
                          $AppAccountsTable,
                          SyncCursor
                        >(
                          currentTable: table,
                          referencedTable: $$AppAccountsTableReferences
                              ._syncCursorsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$AppAccountsTableReferences(
                                db,
                                table,
                                p0,
                              ).syncCursorsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.accountId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$AppAccountsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $AppAccountsTable,
      AppAccount,
      $$AppAccountsTableFilterComposer,
      $$AppAccountsTableOrderingComposer,
      $$AppAccountsTableAnnotationComposer,
      $$AppAccountsTableCreateCompanionBuilder,
      $$AppAccountsTableUpdateCompanionBuilder,
      (AppAccount, $$AppAccountsTableReferences),
      AppAccount,
      PrefetchHooks Function({
        bool sourcesRefs,
        bool gmailMessageAccountsRefs,
        bool eventsRefs,
        bool syncCursorsRefs,
      })
    >;
typedef $$SourcesTableCreateCompanionBuilder =
    SourcesCompanion Function({
      required String id,
      required String accountId,
      required String label,
      Value<String> rulePack,
      Value<bool> enabled,
      required DateTime createdAt,
      required DateTime updatedAt,
      Value<int> rowid,
    });
typedef $$SourcesTableUpdateCompanionBuilder =
    SourcesCompanion Function({
      Value<String> id,
      Value<String> accountId,
      Value<String> label,
      Value<String> rulePack,
      Value<bool> enabled,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

final class $$SourcesTableReferences
    extends BaseReferences<_$AppDatabase, $SourcesTable, Source> {
  $$SourcesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $AppAccountsTable _accountIdTable(_$AppDatabase db) =>
      db.appAccounts.createAlias('sources__account_id__app_accounts__id');

  $$AppAccountsTableProcessedTableManager get accountId {
    final $_column = $_itemColumn<String>('account_id')!;

    final manager = $$AppAccountsTableTableManager(
      $_db,
      $_db.appAccounts,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_accountIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<
    $SourceAllowlistEntriesTable,
    List<SourceAllowlistEntry>
  >
  _sourceAllowlistEntriesRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.sourceAllowlistEntries,
        aliasName: 'sources__id__source_allowlist_entries__source_id',
      );

  $$SourceAllowlistEntriesTableProcessedTableManager
  get sourceAllowlistEntriesRefs {
    final manager = $$SourceAllowlistEntriesTableTableManager(
      $_db,
      $_db.sourceAllowlistEntries,
    ).filter((f) => f.sourceId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _sourceAllowlistEntriesRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$ProposalsTable, List<Proposal>>
  _proposalsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.proposals,
    aliasName: 'sources__id__proposals__source_id',
  );

  $$ProposalsTableProcessedTableManager get proposalsRefs {
    final manager = $$ProposalsTableTableManager(
      $_db,
      $_db.proposals,
    ).filter((f) => f.sourceId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_proposalsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$SourcesTableFilterComposer
    extends Composer<_$AppDatabase, $SourcesTable> {
  $$SourcesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get label => $composableBuilder(
    column: $table.label,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get rulePack => $composableBuilder(
    column: $table.rulePack,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get enabled => $composableBuilder(
    column: $table.enabled,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$AppAccountsTableFilterComposer get accountId {
    final $$AppAccountsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.accountId,
      referencedTable: $db.appAccounts,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AppAccountsTableFilterComposer(
            $db: $db,
            $table: $db.appAccounts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> sourceAllowlistEntriesRefs(
    Expression<bool> Function($$SourceAllowlistEntriesTableFilterComposer f) f,
  ) {
    final $$SourceAllowlistEntriesTableFilterComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.sourceAllowlistEntries,
          getReferencedColumn: (t) => t.sourceId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$SourceAllowlistEntriesTableFilterComposer(
                $db: $db,
                $table: $db.sourceAllowlistEntries,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<bool> proposalsRefs(
    Expression<bool> Function($$ProposalsTableFilterComposer f) f,
  ) {
    final $$ProposalsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.proposals,
      getReferencedColumn: (t) => t.sourceId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProposalsTableFilterComposer(
            $db: $db,
            $table: $db.proposals,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$SourcesTableOrderingComposer
    extends Composer<_$AppDatabase, $SourcesTable> {
  $$SourcesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get label => $composableBuilder(
    column: $table.label,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get rulePack => $composableBuilder(
    column: $table.rulePack,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get enabled => $composableBuilder(
    column: $table.enabled,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$AppAccountsTableOrderingComposer get accountId {
    final $$AppAccountsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.accountId,
      referencedTable: $db.appAccounts,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AppAccountsTableOrderingComposer(
            $db: $db,
            $table: $db.appAccounts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$SourcesTableAnnotationComposer
    extends Composer<_$AppDatabase, $SourcesTable> {
  $$SourcesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get label =>
      $composableBuilder(column: $table.label, builder: (column) => column);

  GeneratedColumn<String> get rulePack =>
      $composableBuilder(column: $table.rulePack, builder: (column) => column);

  GeneratedColumn<bool> get enabled =>
      $composableBuilder(column: $table.enabled, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$AppAccountsTableAnnotationComposer get accountId {
    final $$AppAccountsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.accountId,
      referencedTable: $db.appAccounts,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AppAccountsTableAnnotationComposer(
            $db: $db,
            $table: $db.appAccounts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> sourceAllowlistEntriesRefs<T extends Object>(
    Expression<T> Function($$SourceAllowlistEntriesTableAnnotationComposer a) f,
  ) {
    final $$SourceAllowlistEntriesTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.sourceAllowlistEntries,
          getReferencedColumn: (t) => t.sourceId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$SourceAllowlistEntriesTableAnnotationComposer(
                $db: $db,
                $table: $db.sourceAllowlistEntries,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> proposalsRefs<T extends Object>(
    Expression<T> Function($$ProposalsTableAnnotationComposer a) f,
  ) {
    final $$ProposalsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.proposals,
      getReferencedColumn: (t) => t.sourceId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProposalsTableAnnotationComposer(
            $db: $db,
            $table: $db.proposals,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$SourcesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SourcesTable,
          Source,
          $$SourcesTableFilterComposer,
          $$SourcesTableOrderingComposer,
          $$SourcesTableAnnotationComposer,
          $$SourcesTableCreateCompanionBuilder,
          $$SourcesTableUpdateCompanionBuilder,
          (Source, $$SourcesTableReferences),
          Source,
          PrefetchHooks Function({
            bool accountId,
            bool sourceAllowlistEntriesRefs,
            bool proposalsRefs,
          })
        > {
  $$SourcesTableTableManager(_$AppDatabase db, $SourcesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SourcesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SourcesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SourcesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> accountId = const Value.absent(),
                Value<String> label = const Value.absent(),
                Value<String> rulePack = const Value.absent(),
                Value<bool> enabled = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SourcesCompanion(
                id: id,
                accountId: accountId,
                label: label,
                rulePack: rulePack,
                enabled: enabled,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String accountId,
                required String label,
                Value<String> rulePack = const Value.absent(),
                Value<bool> enabled = const Value.absent(),
                required DateTime createdAt,
                required DateTime updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => SourcesCompanion.insert(
                id: id,
                accountId: accountId,
                label: label,
                rulePack: rulePack,
                enabled: enabled,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$SourcesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                accountId = false,
                sourceAllowlistEntriesRefs = false,
                proposalsRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (sourceAllowlistEntriesRefs) db.sourceAllowlistEntries,
                    if (proposalsRefs) db.proposals,
                  ],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (accountId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.accountId,
                                    referencedTable: $$SourcesTableReferences
                                        ._accountIdTable(db),
                                    referencedColumn: $$SourcesTableReferences
                                        ._accountIdTable(db)
                                        .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (sourceAllowlistEntriesRefs)
                        await $_getPrefetchedData<
                          Source,
                          $SourcesTable,
                          SourceAllowlistEntry
                        >(
                          currentTable: table,
                          referencedTable: $$SourcesTableReferences
                              ._sourceAllowlistEntriesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$SourcesTableReferences(
                                db,
                                table,
                                p0,
                              ).sourceAllowlistEntriesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.sourceId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (proposalsRefs)
                        await $_getPrefetchedData<
                          Source,
                          $SourcesTable,
                          Proposal
                        >(
                          currentTable: table,
                          referencedTable: $$SourcesTableReferences
                              ._proposalsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$SourcesTableReferences(
                                db,
                                table,
                                p0,
                              ).proposalsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.sourceId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$SourcesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SourcesTable,
      Source,
      $$SourcesTableFilterComposer,
      $$SourcesTableOrderingComposer,
      $$SourcesTableAnnotationComposer,
      $$SourcesTableCreateCompanionBuilder,
      $$SourcesTableUpdateCompanionBuilder,
      (Source, $$SourcesTableReferences),
      Source,
      PrefetchHooks Function({
        bool accountId,
        bool sourceAllowlistEntriesRefs,
        bool proposalsRefs,
      })
    >;
typedef $$SourceAllowlistEntriesTableCreateCompanionBuilder =
    SourceAllowlistEntriesCompanion Function({
      required String id,
      required String sourceId,
      required String kind,
      required String value,
      required DateTime createdAt,
      Value<int> rowid,
    });
typedef $$SourceAllowlistEntriesTableUpdateCompanionBuilder =
    SourceAllowlistEntriesCompanion Function({
      Value<String> id,
      Value<String> sourceId,
      Value<String> kind,
      Value<String> value,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });

final class $$SourceAllowlistEntriesTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $SourceAllowlistEntriesTable,
          SourceAllowlistEntry
        > {
  $$SourceAllowlistEntriesTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $SourcesTable _sourceIdTable(_$AppDatabase db) => db.sources
      .createAlias('source_allowlist_entries__source_id__sources__id');

  $$SourcesTableProcessedTableManager get sourceId {
    final $_column = $_itemColumn<String>('source_id')!;

    final manager = $$SourcesTableTableManager(
      $_db,
      $_db.sources,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_sourceIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$SourceAllowlistEntriesTableFilterComposer
    extends Composer<_$AppDatabase, $SourceAllowlistEntriesTable> {
  $$SourceAllowlistEntriesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get kind => $composableBuilder(
    column: $table.kind,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get value => $composableBuilder(
    column: $table.value,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  $$SourcesTableFilterComposer get sourceId {
    final $$SourcesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.sourceId,
      referencedTable: $db.sources,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SourcesTableFilterComposer(
            $db: $db,
            $table: $db.sources,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$SourceAllowlistEntriesTableOrderingComposer
    extends Composer<_$AppDatabase, $SourceAllowlistEntriesTable> {
  $$SourceAllowlistEntriesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get kind => $composableBuilder(
    column: $table.kind,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get value => $composableBuilder(
    column: $table.value,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$SourcesTableOrderingComposer get sourceId {
    final $$SourcesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.sourceId,
      referencedTable: $db.sources,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SourcesTableOrderingComposer(
            $db: $db,
            $table: $db.sources,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$SourceAllowlistEntriesTableAnnotationComposer
    extends Composer<_$AppDatabase, $SourceAllowlistEntriesTable> {
  $$SourceAllowlistEntriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get kind =>
      $composableBuilder(column: $table.kind, builder: (column) => column);

  GeneratedColumn<String> get value =>
      $composableBuilder(column: $table.value, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$SourcesTableAnnotationComposer get sourceId {
    final $$SourcesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.sourceId,
      referencedTable: $db.sources,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SourcesTableAnnotationComposer(
            $db: $db,
            $table: $db.sources,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$SourceAllowlistEntriesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SourceAllowlistEntriesTable,
          SourceAllowlistEntry,
          $$SourceAllowlistEntriesTableFilterComposer,
          $$SourceAllowlistEntriesTableOrderingComposer,
          $$SourceAllowlistEntriesTableAnnotationComposer,
          $$SourceAllowlistEntriesTableCreateCompanionBuilder,
          $$SourceAllowlistEntriesTableUpdateCompanionBuilder,
          (SourceAllowlistEntry, $$SourceAllowlistEntriesTableReferences),
          SourceAllowlistEntry,
          PrefetchHooks Function({bool sourceId})
        > {
  $$SourceAllowlistEntriesTableTableManager(
    _$AppDatabase db,
    $SourceAllowlistEntriesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SourceAllowlistEntriesTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer: () =>
              $$SourceAllowlistEntriesTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$SourceAllowlistEntriesTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> sourceId = const Value.absent(),
                Value<String> kind = const Value.absent(),
                Value<String> value = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SourceAllowlistEntriesCompanion(
                id: id,
                sourceId: sourceId,
                kind: kind,
                value: value,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String sourceId,
                required String kind,
                required String value,
                required DateTime createdAt,
                Value<int> rowid = const Value.absent(),
              }) => SourceAllowlistEntriesCompanion.insert(
                id: id,
                sourceId: sourceId,
                kind: kind,
                value: value,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$SourceAllowlistEntriesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({sourceId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (sourceId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.sourceId,
                                referencedTable:
                                    $$SourceAllowlistEntriesTableReferences
                                        ._sourceIdTable(db),
                                referencedColumn:
                                    $$SourceAllowlistEntriesTableReferences
                                        ._sourceIdTable(db)
                                        .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$SourceAllowlistEntriesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SourceAllowlistEntriesTable,
      SourceAllowlistEntry,
      $$SourceAllowlistEntriesTableFilterComposer,
      $$SourceAllowlistEntriesTableOrderingComposer,
      $$SourceAllowlistEntriesTableAnnotationComposer,
      $$SourceAllowlistEntriesTableCreateCompanionBuilder,
      $$SourceAllowlistEntriesTableUpdateCompanionBuilder,
      (SourceAllowlistEntry, $$SourceAllowlistEntriesTableReferences),
      SourceAllowlistEntry,
      PrefetchHooks Function({bool sourceId})
    >;
typedef $$GmailMessageAccountsTableCreateCompanionBuilder =
    GmailMessageAccountsCompanion Function({
      required String messageId,
      required String accountId,
      Value<int> rowid,
    });
typedef $$GmailMessageAccountsTableUpdateCompanionBuilder =
    GmailMessageAccountsCompanion Function({
      Value<String> messageId,
      Value<String> accountId,
      Value<int> rowid,
    });

final class $$GmailMessageAccountsTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $GmailMessageAccountsTable,
          GmailMessageAccount
        > {
  $$GmailMessageAccountsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $GmailMessagesTable _messageIdTable(_$AppDatabase db) =>
      db.gmailMessages.createAlias(
        'gmail_message_accounts__message_id__gmail_messages__message_id',
      );

  $$GmailMessagesTableProcessedTableManager get messageId {
    final $_column = $_itemColumn<String>('message_id')!;

    final manager = $$GmailMessagesTableTableManager(
      $_db,
      $_db.gmailMessages,
    ).filter((f) => f.messageId.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_messageIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $AppAccountsTable _accountIdTable(_$AppDatabase db) => db.appAccounts
      .createAlias('gmail_message_accounts__account_id__app_accounts__id');

  $$AppAccountsTableProcessedTableManager get accountId {
    final $_column = $_itemColumn<String>('account_id')!;

    final manager = $$AppAccountsTableTableManager(
      $_db,
      $_db.appAccounts,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_accountIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$GmailMessageAccountsTableFilterComposer
    extends Composer<_$AppDatabase, $GmailMessageAccountsTable> {
  $$GmailMessageAccountsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  $$GmailMessagesTableFilterComposer get messageId {
    final $$GmailMessagesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.messageId,
      referencedTable: $db.gmailMessages,
      getReferencedColumn: (t) => t.messageId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$GmailMessagesTableFilterComposer(
            $db: $db,
            $table: $db.gmailMessages,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$AppAccountsTableFilterComposer get accountId {
    final $$AppAccountsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.accountId,
      referencedTable: $db.appAccounts,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AppAccountsTableFilterComposer(
            $db: $db,
            $table: $db.appAccounts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$GmailMessageAccountsTableOrderingComposer
    extends Composer<_$AppDatabase, $GmailMessageAccountsTable> {
  $$GmailMessageAccountsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  $$GmailMessagesTableOrderingComposer get messageId {
    final $$GmailMessagesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.messageId,
      referencedTable: $db.gmailMessages,
      getReferencedColumn: (t) => t.messageId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$GmailMessagesTableOrderingComposer(
            $db: $db,
            $table: $db.gmailMessages,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$AppAccountsTableOrderingComposer get accountId {
    final $$AppAccountsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.accountId,
      referencedTable: $db.appAccounts,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AppAccountsTableOrderingComposer(
            $db: $db,
            $table: $db.appAccounts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$GmailMessageAccountsTableAnnotationComposer
    extends Composer<_$AppDatabase, $GmailMessageAccountsTable> {
  $$GmailMessageAccountsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  $$GmailMessagesTableAnnotationComposer get messageId {
    final $$GmailMessagesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.messageId,
      referencedTable: $db.gmailMessages,
      getReferencedColumn: (t) => t.messageId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$GmailMessagesTableAnnotationComposer(
            $db: $db,
            $table: $db.gmailMessages,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$AppAccountsTableAnnotationComposer get accountId {
    final $$AppAccountsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.accountId,
      referencedTable: $db.appAccounts,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AppAccountsTableAnnotationComposer(
            $db: $db,
            $table: $db.appAccounts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$GmailMessageAccountsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $GmailMessageAccountsTable,
          GmailMessageAccount,
          $$GmailMessageAccountsTableFilterComposer,
          $$GmailMessageAccountsTableOrderingComposer,
          $$GmailMessageAccountsTableAnnotationComposer,
          $$GmailMessageAccountsTableCreateCompanionBuilder,
          $$GmailMessageAccountsTableUpdateCompanionBuilder,
          (GmailMessageAccount, $$GmailMessageAccountsTableReferences),
          GmailMessageAccount,
          PrefetchHooks Function({bool messageId, bool accountId})
        > {
  $$GmailMessageAccountsTableTableManager(
    _$AppDatabase db,
    $GmailMessageAccountsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$GmailMessageAccountsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$GmailMessageAccountsTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$GmailMessageAccountsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> messageId = const Value.absent(),
                Value<String> accountId = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => GmailMessageAccountsCompanion(
                messageId: messageId,
                accountId: accountId,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String messageId,
                required String accountId,
                Value<int> rowid = const Value.absent(),
              }) => GmailMessageAccountsCompanion.insert(
                messageId: messageId,
                accountId: accountId,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$GmailMessageAccountsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({messageId = false, accountId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (messageId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.messageId,
                                referencedTable:
                                    $$GmailMessageAccountsTableReferences
                                        ._messageIdTable(db),
                                referencedColumn:
                                    $$GmailMessageAccountsTableReferences
                                        ._messageIdTable(db)
                                        .messageId,
                              )
                              as T;
                    }
                    if (accountId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.accountId,
                                referencedTable:
                                    $$GmailMessageAccountsTableReferences
                                        ._accountIdTable(db),
                                referencedColumn:
                                    $$GmailMessageAccountsTableReferences
                                        ._accountIdTable(db)
                                        .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$GmailMessageAccountsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $GmailMessageAccountsTable,
      GmailMessageAccount,
      $$GmailMessageAccountsTableFilterComposer,
      $$GmailMessageAccountsTableOrderingComposer,
      $$GmailMessageAccountsTableAnnotationComposer,
      $$GmailMessageAccountsTableCreateCompanionBuilder,
      $$GmailMessageAccountsTableUpdateCompanionBuilder,
      (GmailMessageAccount, $$GmailMessageAccountsTableReferences),
      GmailMessageAccount,
      PrefetchHooks Function({bool messageId, bool accountId})
    >;
typedef $$GmailMessageBodiesTableCreateCompanionBuilder =
    GmailMessageBodiesCompanion Function({
      required String messageId,
      required String normalizedBody,
      required DateTime fetchedAt,
      required DateTime expiresAt,
      Value<String?> parserVersion,
      Value<int> rowid,
    });
typedef $$GmailMessageBodiesTableUpdateCompanionBuilder =
    GmailMessageBodiesCompanion Function({
      Value<String> messageId,
      Value<String> normalizedBody,
      Value<DateTime> fetchedAt,
      Value<DateTime> expiresAt,
      Value<String?> parserVersion,
      Value<int> rowid,
    });

final class $$GmailMessageBodiesTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $GmailMessageBodiesTable,
          GmailMessageBody
        > {
  $$GmailMessageBodiesTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $GmailMessagesTable _messageIdTable(_$AppDatabase db) =>
      db.gmailMessages.createAlias(
        'gmail_message_bodies__message_id__gmail_messages__message_id',
      );

  $$GmailMessagesTableProcessedTableManager get messageId {
    final $_column = $_itemColumn<String>('message_id')!;

    final manager = $$GmailMessagesTableTableManager(
      $_db,
      $_db.gmailMessages,
    ).filter((f) => f.messageId.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_messageIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$GmailMessageBodiesTableFilterComposer
    extends Composer<_$AppDatabase, $GmailMessageBodiesTable> {
  $$GmailMessageBodiesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get normalizedBody => $composableBuilder(
    column: $table.normalizedBody,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get fetchedAt => $composableBuilder(
    column: $table.fetchedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get expiresAt => $composableBuilder(
    column: $table.expiresAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get parserVersion => $composableBuilder(
    column: $table.parserVersion,
    builder: (column) => ColumnFilters(column),
  );

  $$GmailMessagesTableFilterComposer get messageId {
    final $$GmailMessagesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.messageId,
      referencedTable: $db.gmailMessages,
      getReferencedColumn: (t) => t.messageId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$GmailMessagesTableFilterComposer(
            $db: $db,
            $table: $db.gmailMessages,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$GmailMessageBodiesTableOrderingComposer
    extends Composer<_$AppDatabase, $GmailMessageBodiesTable> {
  $$GmailMessageBodiesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get normalizedBody => $composableBuilder(
    column: $table.normalizedBody,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get fetchedAt => $composableBuilder(
    column: $table.fetchedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get expiresAt => $composableBuilder(
    column: $table.expiresAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get parserVersion => $composableBuilder(
    column: $table.parserVersion,
    builder: (column) => ColumnOrderings(column),
  );

  $$GmailMessagesTableOrderingComposer get messageId {
    final $$GmailMessagesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.messageId,
      referencedTable: $db.gmailMessages,
      getReferencedColumn: (t) => t.messageId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$GmailMessagesTableOrderingComposer(
            $db: $db,
            $table: $db.gmailMessages,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$GmailMessageBodiesTableAnnotationComposer
    extends Composer<_$AppDatabase, $GmailMessageBodiesTable> {
  $$GmailMessageBodiesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get normalizedBody => $composableBuilder(
    column: $table.normalizedBody,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get fetchedAt =>
      $composableBuilder(column: $table.fetchedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get expiresAt =>
      $composableBuilder(column: $table.expiresAt, builder: (column) => column);

  GeneratedColumn<String> get parserVersion => $composableBuilder(
    column: $table.parserVersion,
    builder: (column) => column,
  );

  $$GmailMessagesTableAnnotationComposer get messageId {
    final $$GmailMessagesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.messageId,
      referencedTable: $db.gmailMessages,
      getReferencedColumn: (t) => t.messageId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$GmailMessagesTableAnnotationComposer(
            $db: $db,
            $table: $db.gmailMessages,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$GmailMessageBodiesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $GmailMessageBodiesTable,
          GmailMessageBody,
          $$GmailMessageBodiesTableFilterComposer,
          $$GmailMessageBodiesTableOrderingComposer,
          $$GmailMessageBodiesTableAnnotationComposer,
          $$GmailMessageBodiesTableCreateCompanionBuilder,
          $$GmailMessageBodiesTableUpdateCompanionBuilder,
          (GmailMessageBody, $$GmailMessageBodiesTableReferences),
          GmailMessageBody,
          PrefetchHooks Function({bool messageId})
        > {
  $$GmailMessageBodiesTableTableManager(
    _$AppDatabase db,
    $GmailMessageBodiesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$GmailMessageBodiesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$GmailMessageBodiesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$GmailMessageBodiesTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> messageId = const Value.absent(),
                Value<String> normalizedBody = const Value.absent(),
                Value<DateTime> fetchedAt = const Value.absent(),
                Value<DateTime> expiresAt = const Value.absent(),
                Value<String?> parserVersion = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => GmailMessageBodiesCompanion(
                messageId: messageId,
                normalizedBody: normalizedBody,
                fetchedAt: fetchedAt,
                expiresAt: expiresAt,
                parserVersion: parserVersion,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String messageId,
                required String normalizedBody,
                required DateTime fetchedAt,
                required DateTime expiresAt,
                Value<String?> parserVersion = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => GmailMessageBodiesCompanion.insert(
                messageId: messageId,
                normalizedBody: normalizedBody,
                fetchedAt: fetchedAt,
                expiresAt: expiresAt,
                parserVersion: parserVersion,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$GmailMessageBodiesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({messageId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (messageId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.messageId,
                                referencedTable:
                                    $$GmailMessageBodiesTableReferences
                                        ._messageIdTable(db),
                                referencedColumn:
                                    $$GmailMessageBodiesTableReferences
                                        ._messageIdTable(db)
                                        .messageId,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$GmailMessageBodiesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $GmailMessageBodiesTable,
      GmailMessageBody,
      $$GmailMessageBodiesTableFilterComposer,
      $$GmailMessageBodiesTableOrderingComposer,
      $$GmailMessageBodiesTableAnnotationComposer,
      $$GmailMessageBodiesTableCreateCompanionBuilder,
      $$GmailMessageBodiesTableUpdateCompanionBuilder,
      (GmailMessageBody, $$GmailMessageBodiesTableReferences),
      GmailMessageBody,
      PrefetchHooks Function({bool messageId})
    >;
typedef $$AttachmentsTableCreateCompanionBuilder =
    AttachmentsCompanion Function({
      required String id,
      required String messageId,
      Value<String?> gmailAttachmentId,
      required String fileName,
      required String mimeType,
      Value<int?> sizeBytes,
      Value<String?> localPath,
      Value<String?> sha256,
      Value<String?> extractedText,
      Value<String> status,
      Value<DateTime?> expiresAt,
      required DateTime createdAt,
      required DateTime updatedAt,
      Value<int> rowid,
    });
typedef $$AttachmentsTableUpdateCompanionBuilder =
    AttachmentsCompanion Function({
      Value<String> id,
      Value<String> messageId,
      Value<String?> gmailAttachmentId,
      Value<String> fileName,
      Value<String> mimeType,
      Value<int?> sizeBytes,
      Value<String?> localPath,
      Value<String?> sha256,
      Value<String?> extractedText,
      Value<String> status,
      Value<DateTime?> expiresAt,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

final class $$AttachmentsTableReferences
    extends BaseReferences<_$AppDatabase, $AttachmentsTable, Attachment> {
  $$AttachmentsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $GmailMessagesTable _messageIdTable(_$AppDatabase db) => db
      .gmailMessages
      .createAlias('attachments__message_id__gmail_messages__message_id');

  $$GmailMessagesTableProcessedTableManager get messageId {
    final $_column = $_itemColumn<String>('message_id')!;

    final manager = $$GmailMessagesTableTableManager(
      $_db,
      $_db.gmailMessages,
    ).filter((f) => f.messageId.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_messageIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$AttachmentsTableFilterComposer
    extends Composer<_$AppDatabase, $AttachmentsTable> {
  $$AttachmentsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get gmailAttachmentId => $composableBuilder(
    column: $table.gmailAttachmentId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get fileName => $composableBuilder(
    column: $table.fileName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get mimeType => $composableBuilder(
    column: $table.mimeType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get sizeBytes => $composableBuilder(
    column: $table.sizeBytes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get localPath => $composableBuilder(
    column: $table.localPath,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get sha256 => $composableBuilder(
    column: $table.sha256,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get extractedText => $composableBuilder(
    column: $table.extractedText,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get expiresAt => $composableBuilder(
    column: $table.expiresAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$GmailMessagesTableFilterComposer get messageId {
    final $$GmailMessagesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.messageId,
      referencedTable: $db.gmailMessages,
      getReferencedColumn: (t) => t.messageId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$GmailMessagesTableFilterComposer(
            $db: $db,
            $table: $db.gmailMessages,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$AttachmentsTableOrderingComposer
    extends Composer<_$AppDatabase, $AttachmentsTable> {
  $$AttachmentsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get gmailAttachmentId => $composableBuilder(
    column: $table.gmailAttachmentId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get fileName => $composableBuilder(
    column: $table.fileName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get mimeType => $composableBuilder(
    column: $table.mimeType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sizeBytes => $composableBuilder(
    column: $table.sizeBytes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get localPath => $composableBuilder(
    column: $table.localPath,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get sha256 => $composableBuilder(
    column: $table.sha256,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get extractedText => $composableBuilder(
    column: $table.extractedText,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get expiresAt => $composableBuilder(
    column: $table.expiresAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$GmailMessagesTableOrderingComposer get messageId {
    final $$GmailMessagesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.messageId,
      referencedTable: $db.gmailMessages,
      getReferencedColumn: (t) => t.messageId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$GmailMessagesTableOrderingComposer(
            $db: $db,
            $table: $db.gmailMessages,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$AttachmentsTableAnnotationComposer
    extends Composer<_$AppDatabase, $AttachmentsTable> {
  $$AttachmentsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get gmailAttachmentId => $composableBuilder(
    column: $table.gmailAttachmentId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get fileName =>
      $composableBuilder(column: $table.fileName, builder: (column) => column);

  GeneratedColumn<String> get mimeType =>
      $composableBuilder(column: $table.mimeType, builder: (column) => column);

  GeneratedColumn<int> get sizeBytes =>
      $composableBuilder(column: $table.sizeBytes, builder: (column) => column);

  GeneratedColumn<String> get localPath =>
      $composableBuilder(column: $table.localPath, builder: (column) => column);

  GeneratedColumn<String> get sha256 =>
      $composableBuilder(column: $table.sha256, builder: (column) => column);

  GeneratedColumn<String> get extractedText => $composableBuilder(
    column: $table.extractedText,
    builder: (column) => column,
  );

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<DateTime> get expiresAt =>
      $composableBuilder(column: $table.expiresAt, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$GmailMessagesTableAnnotationComposer get messageId {
    final $$GmailMessagesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.messageId,
      referencedTable: $db.gmailMessages,
      getReferencedColumn: (t) => t.messageId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$GmailMessagesTableAnnotationComposer(
            $db: $db,
            $table: $db.gmailMessages,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$AttachmentsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $AttachmentsTable,
          Attachment,
          $$AttachmentsTableFilterComposer,
          $$AttachmentsTableOrderingComposer,
          $$AttachmentsTableAnnotationComposer,
          $$AttachmentsTableCreateCompanionBuilder,
          $$AttachmentsTableUpdateCompanionBuilder,
          (Attachment, $$AttachmentsTableReferences),
          Attachment,
          PrefetchHooks Function({bool messageId})
        > {
  $$AttachmentsTableTableManager(_$AppDatabase db, $AttachmentsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AttachmentsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AttachmentsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AttachmentsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> messageId = const Value.absent(),
                Value<String?> gmailAttachmentId = const Value.absent(),
                Value<String> fileName = const Value.absent(),
                Value<String> mimeType = const Value.absent(),
                Value<int?> sizeBytes = const Value.absent(),
                Value<String?> localPath = const Value.absent(),
                Value<String?> sha256 = const Value.absent(),
                Value<String?> extractedText = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<DateTime?> expiresAt = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => AttachmentsCompanion(
                id: id,
                messageId: messageId,
                gmailAttachmentId: gmailAttachmentId,
                fileName: fileName,
                mimeType: mimeType,
                sizeBytes: sizeBytes,
                localPath: localPath,
                sha256: sha256,
                extractedText: extractedText,
                status: status,
                expiresAt: expiresAt,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String messageId,
                Value<String?> gmailAttachmentId = const Value.absent(),
                required String fileName,
                required String mimeType,
                Value<int?> sizeBytes = const Value.absent(),
                Value<String?> localPath = const Value.absent(),
                Value<String?> sha256 = const Value.absent(),
                Value<String?> extractedText = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<DateTime?> expiresAt = const Value.absent(),
                required DateTime createdAt,
                required DateTime updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => AttachmentsCompanion.insert(
                id: id,
                messageId: messageId,
                gmailAttachmentId: gmailAttachmentId,
                fileName: fileName,
                mimeType: mimeType,
                sizeBytes: sizeBytes,
                localPath: localPath,
                sha256: sha256,
                extractedText: extractedText,
                status: status,
                expiresAt: expiresAt,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$AttachmentsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({messageId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (messageId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.messageId,
                                referencedTable: $$AttachmentsTableReferences
                                    ._messageIdTable(db),
                                referencedColumn: $$AttachmentsTableReferences
                                    ._messageIdTable(db)
                                    .messageId,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$AttachmentsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $AttachmentsTable,
      Attachment,
      $$AttachmentsTableFilterComposer,
      $$AttachmentsTableOrderingComposer,
      $$AttachmentsTableAnnotationComposer,
      $$AttachmentsTableCreateCompanionBuilder,
      $$AttachmentsTableUpdateCompanionBuilder,
      (Attachment, $$AttachmentsTableReferences),
      Attachment,
      PrefetchHooks Function({bool messageId})
    >;
typedef $$ProposalsTableCreateCompanionBuilder =
    ProposalsCompanion Function({
      required String id,
      required String messageId,
      Value<String?> sourceId,
      required String type,
      Value<String> status,
      Value<DateTime?> proposedDate,
      Value<bool?> allDay,
      Value<String?> location,
      Value<String> urgency,
      Value<String?> whenHint,
      required String subject,
      required String fromRaw,
      required String evidence,
      required String parserVersion,
      Value<String?> modelVersion,
      required DateTime createdAt,
      required DateTime updatedAt,
      Value<int> rowid,
    });
typedef $$ProposalsTableUpdateCompanionBuilder =
    ProposalsCompanion Function({
      Value<String> id,
      Value<String> messageId,
      Value<String?> sourceId,
      Value<String> type,
      Value<String> status,
      Value<DateTime?> proposedDate,
      Value<bool?> allDay,
      Value<String?> location,
      Value<String> urgency,
      Value<String?> whenHint,
      Value<String> subject,
      Value<String> fromRaw,
      Value<String> evidence,
      Value<String> parserVersion,
      Value<String?> modelVersion,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

final class $$ProposalsTableReferences
    extends BaseReferences<_$AppDatabase, $ProposalsTable, Proposal> {
  $$ProposalsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $GmailMessagesTable _messageIdTable(_$AppDatabase db) => db
      .gmailMessages
      .createAlias('proposals__message_id__gmail_messages__message_id');

  $$GmailMessagesTableProcessedTableManager get messageId {
    final $_column = $_itemColumn<String>('message_id')!;

    final manager = $$GmailMessagesTableTableManager(
      $_db,
      $_db.gmailMessages,
    ).filter((f) => f.messageId.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_messageIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $SourcesTable _sourceIdTable(_$AppDatabase db) =>
      db.sources.createAlias('proposals__source_id__sources__id');

  $$SourcesTableProcessedTableManager? get sourceId {
    final $_column = $_itemColumn<String>('source_id');
    if ($_column == null) return null;
    final manager = $$SourcesTableTableManager(
      $_db,
      $_db.sources,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_sourceIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$ProposalItemsTable, List<ProposalItem>>
  _proposalItemsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.proposalItems,
    aliasName: 'proposals__id__proposal_items__proposal_id',
  );

  $$ProposalItemsTableProcessedTableManager get proposalItemsRefs {
    final manager = $$ProposalItemsTableTableManager(
      $_db,
      $_db.proposalItems,
    ).filter((f) => f.proposalId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_proposalItemsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$EventsTable, List<Event>> _eventsRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.events,
    aliasName: 'proposals__id__events__proposal_id',
  );

  $$EventsTableProcessedTableManager get eventsRefs {
    final manager = $$EventsTableTableManager(
      $_db,
      $_db.events,
    ).filter((f) => f.proposalId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_eventsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$ProposalsTableFilterComposer
    extends Composer<_$AppDatabase, $ProposalsTable> {
  $$ProposalsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get proposedDate => $composableBuilder(
    column: $table.proposedDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get allDay => $composableBuilder(
    column: $table.allDay,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get location => $composableBuilder(
    column: $table.location,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get urgency => $composableBuilder(
    column: $table.urgency,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get whenHint => $composableBuilder(
    column: $table.whenHint,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get subject => $composableBuilder(
    column: $table.subject,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get fromRaw => $composableBuilder(
    column: $table.fromRaw,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get evidence => $composableBuilder(
    column: $table.evidence,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get parserVersion => $composableBuilder(
    column: $table.parserVersion,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get modelVersion => $composableBuilder(
    column: $table.modelVersion,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$GmailMessagesTableFilterComposer get messageId {
    final $$GmailMessagesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.messageId,
      referencedTable: $db.gmailMessages,
      getReferencedColumn: (t) => t.messageId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$GmailMessagesTableFilterComposer(
            $db: $db,
            $table: $db.gmailMessages,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$SourcesTableFilterComposer get sourceId {
    final $$SourcesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.sourceId,
      referencedTable: $db.sources,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SourcesTableFilterComposer(
            $db: $db,
            $table: $db.sources,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> proposalItemsRefs(
    Expression<bool> Function($$ProposalItemsTableFilterComposer f) f,
  ) {
    final $$ProposalItemsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.proposalItems,
      getReferencedColumn: (t) => t.proposalId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProposalItemsTableFilterComposer(
            $db: $db,
            $table: $db.proposalItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> eventsRefs(
    Expression<bool> Function($$EventsTableFilterComposer f) f,
  ) {
    final $$EventsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.events,
      getReferencedColumn: (t) => t.proposalId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EventsTableFilterComposer(
            $db: $db,
            $table: $db.events,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ProposalsTableOrderingComposer
    extends Composer<_$AppDatabase, $ProposalsTable> {
  $$ProposalsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get proposedDate => $composableBuilder(
    column: $table.proposedDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get allDay => $composableBuilder(
    column: $table.allDay,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get location => $composableBuilder(
    column: $table.location,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get urgency => $composableBuilder(
    column: $table.urgency,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get whenHint => $composableBuilder(
    column: $table.whenHint,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get subject => $composableBuilder(
    column: $table.subject,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get fromRaw => $composableBuilder(
    column: $table.fromRaw,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get evidence => $composableBuilder(
    column: $table.evidence,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get parserVersion => $composableBuilder(
    column: $table.parserVersion,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get modelVersion => $composableBuilder(
    column: $table.modelVersion,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$GmailMessagesTableOrderingComposer get messageId {
    final $$GmailMessagesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.messageId,
      referencedTable: $db.gmailMessages,
      getReferencedColumn: (t) => t.messageId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$GmailMessagesTableOrderingComposer(
            $db: $db,
            $table: $db.gmailMessages,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$SourcesTableOrderingComposer get sourceId {
    final $$SourcesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.sourceId,
      referencedTable: $db.sources,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SourcesTableOrderingComposer(
            $db: $db,
            $table: $db.sources,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ProposalsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ProposalsTable> {
  $$ProposalsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<DateTime> get proposedDate => $composableBuilder(
    column: $table.proposedDate,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get allDay =>
      $composableBuilder(column: $table.allDay, builder: (column) => column);

  GeneratedColumn<String> get location =>
      $composableBuilder(column: $table.location, builder: (column) => column);

  GeneratedColumn<String> get urgency =>
      $composableBuilder(column: $table.urgency, builder: (column) => column);

  GeneratedColumn<String> get whenHint =>
      $composableBuilder(column: $table.whenHint, builder: (column) => column);

  GeneratedColumn<String> get subject =>
      $composableBuilder(column: $table.subject, builder: (column) => column);

  GeneratedColumn<String> get fromRaw =>
      $composableBuilder(column: $table.fromRaw, builder: (column) => column);

  GeneratedColumn<String> get evidence =>
      $composableBuilder(column: $table.evidence, builder: (column) => column);

  GeneratedColumn<String> get parserVersion => $composableBuilder(
    column: $table.parserVersion,
    builder: (column) => column,
  );

  GeneratedColumn<String> get modelVersion => $composableBuilder(
    column: $table.modelVersion,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$GmailMessagesTableAnnotationComposer get messageId {
    final $$GmailMessagesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.messageId,
      referencedTable: $db.gmailMessages,
      getReferencedColumn: (t) => t.messageId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$GmailMessagesTableAnnotationComposer(
            $db: $db,
            $table: $db.gmailMessages,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$SourcesTableAnnotationComposer get sourceId {
    final $$SourcesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.sourceId,
      referencedTable: $db.sources,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SourcesTableAnnotationComposer(
            $db: $db,
            $table: $db.sources,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> proposalItemsRefs<T extends Object>(
    Expression<T> Function($$ProposalItemsTableAnnotationComposer a) f,
  ) {
    final $$ProposalItemsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.proposalItems,
      getReferencedColumn: (t) => t.proposalId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProposalItemsTableAnnotationComposer(
            $db: $db,
            $table: $db.proposalItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> eventsRefs<T extends Object>(
    Expression<T> Function($$EventsTableAnnotationComposer a) f,
  ) {
    final $$EventsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.events,
      getReferencedColumn: (t) => t.proposalId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EventsTableAnnotationComposer(
            $db: $db,
            $table: $db.events,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ProposalsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ProposalsTable,
          Proposal,
          $$ProposalsTableFilterComposer,
          $$ProposalsTableOrderingComposer,
          $$ProposalsTableAnnotationComposer,
          $$ProposalsTableCreateCompanionBuilder,
          $$ProposalsTableUpdateCompanionBuilder,
          (Proposal, $$ProposalsTableReferences),
          Proposal,
          PrefetchHooks Function({
            bool messageId,
            bool sourceId,
            bool proposalItemsRefs,
            bool eventsRefs,
          })
        > {
  $$ProposalsTableTableManager(_$AppDatabase db, $ProposalsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ProposalsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ProposalsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ProposalsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> messageId = const Value.absent(),
                Value<String?> sourceId = const Value.absent(),
                Value<String> type = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<DateTime?> proposedDate = const Value.absent(),
                Value<bool?> allDay = const Value.absent(),
                Value<String?> location = const Value.absent(),
                Value<String> urgency = const Value.absent(),
                Value<String?> whenHint = const Value.absent(),
                Value<String> subject = const Value.absent(),
                Value<String> fromRaw = const Value.absent(),
                Value<String> evidence = const Value.absent(),
                Value<String> parserVersion = const Value.absent(),
                Value<String?> modelVersion = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ProposalsCompanion(
                id: id,
                messageId: messageId,
                sourceId: sourceId,
                type: type,
                status: status,
                proposedDate: proposedDate,
                allDay: allDay,
                location: location,
                urgency: urgency,
                whenHint: whenHint,
                subject: subject,
                fromRaw: fromRaw,
                evidence: evidence,
                parserVersion: parserVersion,
                modelVersion: modelVersion,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String messageId,
                Value<String?> sourceId = const Value.absent(),
                required String type,
                Value<String> status = const Value.absent(),
                Value<DateTime?> proposedDate = const Value.absent(),
                Value<bool?> allDay = const Value.absent(),
                Value<String?> location = const Value.absent(),
                Value<String> urgency = const Value.absent(),
                Value<String?> whenHint = const Value.absent(),
                required String subject,
                required String fromRaw,
                required String evidence,
                required String parserVersion,
                Value<String?> modelVersion = const Value.absent(),
                required DateTime createdAt,
                required DateTime updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => ProposalsCompanion.insert(
                id: id,
                messageId: messageId,
                sourceId: sourceId,
                type: type,
                status: status,
                proposedDate: proposedDate,
                allDay: allDay,
                location: location,
                urgency: urgency,
                whenHint: whenHint,
                subject: subject,
                fromRaw: fromRaw,
                evidence: evidence,
                parserVersion: parserVersion,
                modelVersion: modelVersion,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$ProposalsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                messageId = false,
                sourceId = false,
                proposalItemsRefs = false,
                eventsRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (proposalItemsRefs) db.proposalItems,
                    if (eventsRefs) db.events,
                  ],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (messageId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.messageId,
                                    referencedTable: $$ProposalsTableReferences
                                        ._messageIdTable(db),
                                    referencedColumn: $$ProposalsTableReferences
                                        ._messageIdTable(db)
                                        .messageId,
                                  )
                                  as T;
                        }
                        if (sourceId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.sourceId,
                                    referencedTable: $$ProposalsTableReferences
                                        ._sourceIdTable(db),
                                    referencedColumn: $$ProposalsTableReferences
                                        ._sourceIdTable(db)
                                        .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (proposalItemsRefs)
                        await $_getPrefetchedData<
                          Proposal,
                          $ProposalsTable,
                          ProposalItem
                        >(
                          currentTable: table,
                          referencedTable: $$ProposalsTableReferences
                              ._proposalItemsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ProposalsTableReferences(
                                db,
                                table,
                                p0,
                              ).proposalItemsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.proposalId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (eventsRefs)
                        await $_getPrefetchedData<
                          Proposal,
                          $ProposalsTable,
                          Event
                        >(
                          currentTable: table,
                          referencedTable: $$ProposalsTableReferences
                              ._eventsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ProposalsTableReferences(
                                db,
                                table,
                                p0,
                              ).eventsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.proposalId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$ProposalsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ProposalsTable,
      Proposal,
      $$ProposalsTableFilterComposer,
      $$ProposalsTableOrderingComposer,
      $$ProposalsTableAnnotationComposer,
      $$ProposalsTableCreateCompanionBuilder,
      $$ProposalsTableUpdateCompanionBuilder,
      (Proposal, $$ProposalsTableReferences),
      Proposal,
      PrefetchHooks Function({
        bool messageId,
        bool sourceId,
        bool proposalItemsRefs,
        bool eventsRefs,
      })
    >;
typedef $$ProposalItemsTableCreateCompanionBuilder =
    ProposalItemsCompanion Function({
      required String id,
      required String proposalId,
      required int position,
      required String kind,
      required String textRaw,
      Value<String?> location,
      Value<bool> completed,
      Value<int> rowid,
    });
typedef $$ProposalItemsTableUpdateCompanionBuilder =
    ProposalItemsCompanion Function({
      Value<String> id,
      Value<String> proposalId,
      Value<int> position,
      Value<String> kind,
      Value<String> textRaw,
      Value<String?> location,
      Value<bool> completed,
      Value<int> rowid,
    });

final class $$ProposalItemsTableReferences
    extends BaseReferences<_$AppDatabase, $ProposalItemsTable, ProposalItem> {
  $$ProposalItemsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $ProposalsTable _proposalIdTable(_$AppDatabase db) =>
      db.proposals.createAlias('proposal_items__proposal_id__proposals__id');

  $$ProposalsTableProcessedTableManager get proposalId {
    final $_column = $_itemColumn<String>('proposal_id')!;

    final manager = $$ProposalsTableTableManager(
      $_db,
      $_db.proposals,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_proposalIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$ProposalItemsTableFilterComposer
    extends Composer<_$AppDatabase, $ProposalItemsTable> {
  $$ProposalItemsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get position => $composableBuilder(
    column: $table.position,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get kind => $composableBuilder(
    column: $table.kind,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get textRaw => $composableBuilder(
    column: $table.textRaw,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get location => $composableBuilder(
    column: $table.location,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get completed => $composableBuilder(
    column: $table.completed,
    builder: (column) => ColumnFilters(column),
  );

  $$ProposalsTableFilterComposer get proposalId {
    final $$ProposalsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.proposalId,
      referencedTable: $db.proposals,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProposalsTableFilterComposer(
            $db: $db,
            $table: $db.proposals,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ProposalItemsTableOrderingComposer
    extends Composer<_$AppDatabase, $ProposalItemsTable> {
  $$ProposalItemsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get position => $composableBuilder(
    column: $table.position,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get kind => $composableBuilder(
    column: $table.kind,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get textRaw => $composableBuilder(
    column: $table.textRaw,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get location => $composableBuilder(
    column: $table.location,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get completed => $composableBuilder(
    column: $table.completed,
    builder: (column) => ColumnOrderings(column),
  );

  $$ProposalsTableOrderingComposer get proposalId {
    final $$ProposalsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.proposalId,
      referencedTable: $db.proposals,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProposalsTableOrderingComposer(
            $db: $db,
            $table: $db.proposals,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ProposalItemsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ProposalItemsTable> {
  $$ProposalItemsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get position =>
      $composableBuilder(column: $table.position, builder: (column) => column);

  GeneratedColumn<String> get kind =>
      $composableBuilder(column: $table.kind, builder: (column) => column);

  GeneratedColumn<String> get textRaw =>
      $composableBuilder(column: $table.textRaw, builder: (column) => column);

  GeneratedColumn<String> get location =>
      $composableBuilder(column: $table.location, builder: (column) => column);

  GeneratedColumn<bool> get completed =>
      $composableBuilder(column: $table.completed, builder: (column) => column);

  $$ProposalsTableAnnotationComposer get proposalId {
    final $$ProposalsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.proposalId,
      referencedTable: $db.proposals,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProposalsTableAnnotationComposer(
            $db: $db,
            $table: $db.proposals,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ProposalItemsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ProposalItemsTable,
          ProposalItem,
          $$ProposalItemsTableFilterComposer,
          $$ProposalItemsTableOrderingComposer,
          $$ProposalItemsTableAnnotationComposer,
          $$ProposalItemsTableCreateCompanionBuilder,
          $$ProposalItemsTableUpdateCompanionBuilder,
          (ProposalItem, $$ProposalItemsTableReferences),
          ProposalItem,
          PrefetchHooks Function({bool proposalId})
        > {
  $$ProposalItemsTableTableManager(_$AppDatabase db, $ProposalItemsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ProposalItemsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ProposalItemsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ProposalItemsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> proposalId = const Value.absent(),
                Value<int> position = const Value.absent(),
                Value<String> kind = const Value.absent(),
                Value<String> textRaw = const Value.absent(),
                Value<String?> location = const Value.absent(),
                Value<bool> completed = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ProposalItemsCompanion(
                id: id,
                proposalId: proposalId,
                position: position,
                kind: kind,
                textRaw: textRaw,
                location: location,
                completed: completed,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String proposalId,
                required int position,
                required String kind,
                required String textRaw,
                Value<String?> location = const Value.absent(),
                Value<bool> completed = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ProposalItemsCompanion.insert(
                id: id,
                proposalId: proposalId,
                position: position,
                kind: kind,
                textRaw: textRaw,
                location: location,
                completed: completed,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$ProposalItemsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({proposalId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (proposalId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.proposalId,
                                referencedTable: $$ProposalItemsTableReferences
                                    ._proposalIdTable(db),
                                referencedColumn: $$ProposalItemsTableReferences
                                    ._proposalIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$ProposalItemsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ProposalItemsTable,
      ProposalItem,
      $$ProposalItemsTableFilterComposer,
      $$ProposalItemsTableOrderingComposer,
      $$ProposalItemsTableAnnotationComposer,
      $$ProposalItemsTableCreateCompanionBuilder,
      $$ProposalItemsTableUpdateCompanionBuilder,
      (ProposalItem, $$ProposalItemsTableReferences),
      ProposalItem,
      PrefetchHooks Function({bool proposalId})
    >;
typedef $$EventsTableCreateCompanionBuilder =
    EventsCompanion Function({
      required String id,
      Value<String?> proposalId,
      Value<String?> sourceMessageId,
      Value<String?> accountId,
      required String title,
      Value<DateTime?> startsAt,
      Value<bool> allDay,
      Value<String?> location,
      Value<String> status,
      Value<String?> notes,
      Value<String?> exportedCalendarId,
      Value<String?> exportedEventId,
      required DateTime createdAt,
      required DateTime updatedAt,
      Value<int> rowid,
    });
typedef $$EventsTableUpdateCompanionBuilder =
    EventsCompanion Function({
      Value<String> id,
      Value<String?> proposalId,
      Value<String?> sourceMessageId,
      Value<String?> accountId,
      Value<String> title,
      Value<DateTime?> startsAt,
      Value<bool> allDay,
      Value<String?> location,
      Value<String> status,
      Value<String?> notes,
      Value<String?> exportedCalendarId,
      Value<String?> exportedEventId,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

final class $$EventsTableReferences
    extends BaseReferences<_$AppDatabase, $EventsTable, Event> {
  $$EventsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $ProposalsTable _proposalIdTable(_$AppDatabase db) =>
      db.proposals.createAlias('events__proposal_id__proposals__id');

  $$ProposalsTableProcessedTableManager? get proposalId {
    final $_column = $_itemColumn<String>('proposal_id');
    if ($_column == null) return null;
    final manager = $$ProposalsTableTableManager(
      $_db,
      $_db.proposals,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_proposalIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $GmailMessagesTable _sourceMessageIdTable(_$AppDatabase db) => db
      .gmailMessages
      .createAlias('events__source_message_id__gmail_messages__message_id');

  $$GmailMessagesTableProcessedTableManager? get sourceMessageId {
    final $_column = $_itemColumn<String>('source_message_id');
    if ($_column == null) return null;
    final manager = $$GmailMessagesTableTableManager(
      $_db,
      $_db.gmailMessages,
    ).filter((f) => f.messageId.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_sourceMessageIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $AppAccountsTable _accountIdTable(_$AppDatabase db) =>
      db.appAccounts.createAlias('events__account_id__app_accounts__id');

  $$AppAccountsTableProcessedTableManager? get accountId {
    final $_column = $_itemColumn<String>('account_id');
    if ($_column == null) return null;
    final manager = $$AppAccountsTableTableManager(
      $_db,
      $_db.appAccounts,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_accountIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$EventItemsTable, List<EventItem>>
  _eventItemsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.eventItems,
    aliasName: 'events__id__event_items__event_id',
  );

  $$EventItemsTableProcessedTableManager get eventItemsRefs {
    final manager = $$EventItemsTableTableManager(
      $_db,
      $_db.eventItems,
    ).filter((f) => f.eventId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_eventItemsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$AlarmSchedulesTable, List<AlarmSchedule>>
  _alarmSchedulesRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.alarmSchedules,
    aliasName: 'events__id__alarm_schedules__event_id',
  );

  $$AlarmSchedulesTableProcessedTableManager get alarmSchedulesRefs {
    final manager = $$AlarmSchedulesTableTableManager(
      $_db,
      $_db.alarmSchedules,
    ).filter((f) => f.eventId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_alarmSchedulesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$EventsTableFilterComposer
    extends Composer<_$AppDatabase, $EventsTable> {
  $$EventsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get startsAt => $composableBuilder(
    column: $table.startsAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get allDay => $composableBuilder(
    column: $table.allDay,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get location => $composableBuilder(
    column: $table.location,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get exportedCalendarId => $composableBuilder(
    column: $table.exportedCalendarId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get exportedEventId => $composableBuilder(
    column: $table.exportedEventId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$ProposalsTableFilterComposer get proposalId {
    final $$ProposalsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.proposalId,
      referencedTable: $db.proposals,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProposalsTableFilterComposer(
            $db: $db,
            $table: $db.proposals,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$GmailMessagesTableFilterComposer get sourceMessageId {
    final $$GmailMessagesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.sourceMessageId,
      referencedTable: $db.gmailMessages,
      getReferencedColumn: (t) => t.messageId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$GmailMessagesTableFilterComposer(
            $db: $db,
            $table: $db.gmailMessages,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$AppAccountsTableFilterComposer get accountId {
    final $$AppAccountsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.accountId,
      referencedTable: $db.appAccounts,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AppAccountsTableFilterComposer(
            $db: $db,
            $table: $db.appAccounts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> eventItemsRefs(
    Expression<bool> Function($$EventItemsTableFilterComposer f) f,
  ) {
    final $$EventItemsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.eventItems,
      getReferencedColumn: (t) => t.eventId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EventItemsTableFilterComposer(
            $db: $db,
            $table: $db.eventItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> alarmSchedulesRefs(
    Expression<bool> Function($$AlarmSchedulesTableFilterComposer f) f,
  ) {
    final $$AlarmSchedulesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.alarmSchedules,
      getReferencedColumn: (t) => t.eventId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AlarmSchedulesTableFilterComposer(
            $db: $db,
            $table: $db.alarmSchedules,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$EventsTableOrderingComposer
    extends Composer<_$AppDatabase, $EventsTable> {
  $$EventsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get startsAt => $composableBuilder(
    column: $table.startsAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get allDay => $composableBuilder(
    column: $table.allDay,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get location => $composableBuilder(
    column: $table.location,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get exportedCalendarId => $composableBuilder(
    column: $table.exportedCalendarId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get exportedEventId => $composableBuilder(
    column: $table.exportedEventId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$ProposalsTableOrderingComposer get proposalId {
    final $$ProposalsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.proposalId,
      referencedTable: $db.proposals,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProposalsTableOrderingComposer(
            $db: $db,
            $table: $db.proposals,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$GmailMessagesTableOrderingComposer get sourceMessageId {
    final $$GmailMessagesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.sourceMessageId,
      referencedTable: $db.gmailMessages,
      getReferencedColumn: (t) => t.messageId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$GmailMessagesTableOrderingComposer(
            $db: $db,
            $table: $db.gmailMessages,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$AppAccountsTableOrderingComposer get accountId {
    final $$AppAccountsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.accountId,
      referencedTable: $db.appAccounts,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AppAccountsTableOrderingComposer(
            $db: $db,
            $table: $db.appAccounts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$EventsTableAnnotationComposer
    extends Composer<_$AppDatabase, $EventsTable> {
  $$EventsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<DateTime> get startsAt =>
      $composableBuilder(column: $table.startsAt, builder: (column) => column);

  GeneratedColumn<bool> get allDay =>
      $composableBuilder(column: $table.allDay, builder: (column) => column);

  GeneratedColumn<String> get location =>
      $composableBuilder(column: $table.location, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<String> get exportedCalendarId => $composableBuilder(
    column: $table.exportedCalendarId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get exportedEventId => $composableBuilder(
    column: $table.exportedEventId,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$ProposalsTableAnnotationComposer get proposalId {
    final $$ProposalsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.proposalId,
      referencedTable: $db.proposals,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProposalsTableAnnotationComposer(
            $db: $db,
            $table: $db.proposals,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$GmailMessagesTableAnnotationComposer get sourceMessageId {
    final $$GmailMessagesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.sourceMessageId,
      referencedTable: $db.gmailMessages,
      getReferencedColumn: (t) => t.messageId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$GmailMessagesTableAnnotationComposer(
            $db: $db,
            $table: $db.gmailMessages,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$AppAccountsTableAnnotationComposer get accountId {
    final $$AppAccountsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.accountId,
      referencedTable: $db.appAccounts,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AppAccountsTableAnnotationComposer(
            $db: $db,
            $table: $db.appAccounts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> eventItemsRefs<T extends Object>(
    Expression<T> Function($$EventItemsTableAnnotationComposer a) f,
  ) {
    final $$EventItemsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.eventItems,
      getReferencedColumn: (t) => t.eventId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EventItemsTableAnnotationComposer(
            $db: $db,
            $table: $db.eventItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> alarmSchedulesRefs<T extends Object>(
    Expression<T> Function($$AlarmSchedulesTableAnnotationComposer a) f,
  ) {
    final $$AlarmSchedulesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.alarmSchedules,
      getReferencedColumn: (t) => t.eventId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AlarmSchedulesTableAnnotationComposer(
            $db: $db,
            $table: $db.alarmSchedules,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$EventsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $EventsTable,
          Event,
          $$EventsTableFilterComposer,
          $$EventsTableOrderingComposer,
          $$EventsTableAnnotationComposer,
          $$EventsTableCreateCompanionBuilder,
          $$EventsTableUpdateCompanionBuilder,
          (Event, $$EventsTableReferences),
          Event,
          PrefetchHooks Function({
            bool proposalId,
            bool sourceMessageId,
            bool accountId,
            bool eventItemsRefs,
            bool alarmSchedulesRefs,
          })
        > {
  $$EventsTableTableManager(_$AppDatabase db, $EventsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$EventsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$EventsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$EventsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String?> proposalId = const Value.absent(),
                Value<String?> sourceMessageId = const Value.absent(),
                Value<String?> accountId = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<DateTime?> startsAt = const Value.absent(),
                Value<bool> allDay = const Value.absent(),
                Value<String?> location = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<String?> exportedCalendarId = const Value.absent(),
                Value<String?> exportedEventId = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => EventsCompanion(
                id: id,
                proposalId: proposalId,
                sourceMessageId: sourceMessageId,
                accountId: accountId,
                title: title,
                startsAt: startsAt,
                allDay: allDay,
                location: location,
                status: status,
                notes: notes,
                exportedCalendarId: exportedCalendarId,
                exportedEventId: exportedEventId,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                Value<String?> proposalId = const Value.absent(),
                Value<String?> sourceMessageId = const Value.absent(),
                Value<String?> accountId = const Value.absent(),
                required String title,
                Value<DateTime?> startsAt = const Value.absent(),
                Value<bool> allDay = const Value.absent(),
                Value<String?> location = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<String?> exportedCalendarId = const Value.absent(),
                Value<String?> exportedEventId = const Value.absent(),
                required DateTime createdAt,
                required DateTime updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => EventsCompanion.insert(
                id: id,
                proposalId: proposalId,
                sourceMessageId: sourceMessageId,
                accountId: accountId,
                title: title,
                startsAt: startsAt,
                allDay: allDay,
                location: location,
                status: status,
                notes: notes,
                exportedCalendarId: exportedCalendarId,
                exportedEventId: exportedEventId,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) =>
                    (e.readTable(table), $$EventsTableReferences(db, table, e)),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                proposalId = false,
                sourceMessageId = false,
                accountId = false,
                eventItemsRefs = false,
                alarmSchedulesRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (eventItemsRefs) db.eventItems,
                    if (alarmSchedulesRefs) db.alarmSchedules,
                  ],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (proposalId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.proposalId,
                                    referencedTable: $$EventsTableReferences
                                        ._proposalIdTable(db),
                                    referencedColumn: $$EventsTableReferences
                                        ._proposalIdTable(db)
                                        .id,
                                  )
                                  as T;
                        }
                        if (sourceMessageId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.sourceMessageId,
                                    referencedTable: $$EventsTableReferences
                                        ._sourceMessageIdTable(db),
                                    referencedColumn: $$EventsTableReferences
                                        ._sourceMessageIdTable(db)
                                        .messageId,
                                  )
                                  as T;
                        }
                        if (accountId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.accountId,
                                    referencedTable: $$EventsTableReferences
                                        ._accountIdTable(db),
                                    referencedColumn: $$EventsTableReferences
                                        ._accountIdTable(db)
                                        .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (eventItemsRefs)
                        await $_getPrefetchedData<
                          Event,
                          $EventsTable,
                          EventItem
                        >(
                          currentTable: table,
                          referencedTable: $$EventsTableReferences
                              ._eventItemsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$EventsTableReferences(
                                db,
                                table,
                                p0,
                              ).eventItemsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.eventId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (alarmSchedulesRefs)
                        await $_getPrefetchedData<
                          Event,
                          $EventsTable,
                          AlarmSchedule
                        >(
                          currentTable: table,
                          referencedTable: $$EventsTableReferences
                              ._alarmSchedulesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$EventsTableReferences(
                                db,
                                table,
                                p0,
                              ).alarmSchedulesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.eventId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$EventsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $EventsTable,
      Event,
      $$EventsTableFilterComposer,
      $$EventsTableOrderingComposer,
      $$EventsTableAnnotationComposer,
      $$EventsTableCreateCompanionBuilder,
      $$EventsTableUpdateCompanionBuilder,
      (Event, $$EventsTableReferences),
      Event,
      PrefetchHooks Function({
        bool proposalId,
        bool sourceMessageId,
        bool accountId,
        bool eventItemsRefs,
        bool alarmSchedulesRefs,
      })
    >;
typedef $$EventItemsTableCreateCompanionBuilder =
    EventItemsCompanion Function({
      required String id,
      required String eventId,
      required int position,
      required String kind,
      required String content,
      Value<String?> location,
      Value<bool> completed,
      Value<int> rowid,
    });
typedef $$EventItemsTableUpdateCompanionBuilder =
    EventItemsCompanion Function({
      Value<String> id,
      Value<String> eventId,
      Value<int> position,
      Value<String> kind,
      Value<String> content,
      Value<String?> location,
      Value<bool> completed,
      Value<int> rowid,
    });

final class $$EventItemsTableReferences
    extends BaseReferences<_$AppDatabase, $EventItemsTable, EventItem> {
  $$EventItemsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $EventsTable _eventIdTable(_$AppDatabase db) =>
      db.events.createAlias('event_items__event_id__events__id');

  $$EventsTableProcessedTableManager get eventId {
    final $_column = $_itemColumn<String>('event_id')!;

    final manager = $$EventsTableTableManager(
      $_db,
      $_db.events,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_eventIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$EventItemsTableFilterComposer
    extends Composer<_$AppDatabase, $EventItemsTable> {
  $$EventItemsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get position => $composableBuilder(
    column: $table.position,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get kind => $composableBuilder(
    column: $table.kind,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get content => $composableBuilder(
    column: $table.content,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get location => $composableBuilder(
    column: $table.location,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get completed => $composableBuilder(
    column: $table.completed,
    builder: (column) => ColumnFilters(column),
  );

  $$EventsTableFilterComposer get eventId {
    final $$EventsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.eventId,
      referencedTable: $db.events,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EventsTableFilterComposer(
            $db: $db,
            $table: $db.events,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$EventItemsTableOrderingComposer
    extends Composer<_$AppDatabase, $EventItemsTable> {
  $$EventItemsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get position => $composableBuilder(
    column: $table.position,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get kind => $composableBuilder(
    column: $table.kind,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get content => $composableBuilder(
    column: $table.content,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get location => $composableBuilder(
    column: $table.location,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get completed => $composableBuilder(
    column: $table.completed,
    builder: (column) => ColumnOrderings(column),
  );

  $$EventsTableOrderingComposer get eventId {
    final $$EventsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.eventId,
      referencedTable: $db.events,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EventsTableOrderingComposer(
            $db: $db,
            $table: $db.events,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$EventItemsTableAnnotationComposer
    extends Composer<_$AppDatabase, $EventItemsTable> {
  $$EventItemsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get position =>
      $composableBuilder(column: $table.position, builder: (column) => column);

  GeneratedColumn<String> get kind =>
      $composableBuilder(column: $table.kind, builder: (column) => column);

  GeneratedColumn<String> get content =>
      $composableBuilder(column: $table.content, builder: (column) => column);

  GeneratedColumn<String> get location =>
      $composableBuilder(column: $table.location, builder: (column) => column);

  GeneratedColumn<bool> get completed =>
      $composableBuilder(column: $table.completed, builder: (column) => column);

  $$EventsTableAnnotationComposer get eventId {
    final $$EventsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.eventId,
      referencedTable: $db.events,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EventsTableAnnotationComposer(
            $db: $db,
            $table: $db.events,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$EventItemsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $EventItemsTable,
          EventItem,
          $$EventItemsTableFilterComposer,
          $$EventItemsTableOrderingComposer,
          $$EventItemsTableAnnotationComposer,
          $$EventItemsTableCreateCompanionBuilder,
          $$EventItemsTableUpdateCompanionBuilder,
          (EventItem, $$EventItemsTableReferences),
          EventItem,
          PrefetchHooks Function({bool eventId})
        > {
  $$EventItemsTableTableManager(_$AppDatabase db, $EventItemsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$EventItemsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$EventItemsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$EventItemsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> eventId = const Value.absent(),
                Value<int> position = const Value.absent(),
                Value<String> kind = const Value.absent(),
                Value<String> content = const Value.absent(),
                Value<String?> location = const Value.absent(),
                Value<bool> completed = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => EventItemsCompanion(
                id: id,
                eventId: eventId,
                position: position,
                kind: kind,
                content: content,
                location: location,
                completed: completed,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String eventId,
                required int position,
                required String kind,
                required String content,
                Value<String?> location = const Value.absent(),
                Value<bool> completed = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => EventItemsCompanion.insert(
                id: id,
                eventId: eventId,
                position: position,
                kind: kind,
                content: content,
                location: location,
                completed: completed,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$EventItemsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({eventId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (eventId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.eventId,
                                referencedTable: $$EventItemsTableReferences
                                    ._eventIdTable(db),
                                referencedColumn: $$EventItemsTableReferences
                                    ._eventIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$EventItemsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $EventItemsTable,
      EventItem,
      $$EventItemsTableFilterComposer,
      $$EventItemsTableOrderingComposer,
      $$EventItemsTableAnnotationComposer,
      $$EventItemsTableCreateCompanionBuilder,
      $$EventItemsTableUpdateCompanionBuilder,
      (EventItem, $$EventItemsTableReferences),
      EventItem,
      PrefetchHooks Function({bool eventId})
    >;
typedef $$AlarmSchedulesTableCreateCompanionBuilder =
    AlarmSchedulesCompanion Function({
      required String id,
      Value<String?> eventId,
      required String kind,
      required DateTime fireAt,
      Value<String> status,
      Value<String?> snoozeParentId,
      required int notificationId,
      required DateTime createdAt,
      required DateTime updatedAt,
      Value<int> rowid,
    });
typedef $$AlarmSchedulesTableUpdateCompanionBuilder =
    AlarmSchedulesCompanion Function({
      Value<String> id,
      Value<String?> eventId,
      Value<String> kind,
      Value<DateTime> fireAt,
      Value<String> status,
      Value<String?> snoozeParentId,
      Value<int> notificationId,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

final class $$AlarmSchedulesTableReferences
    extends BaseReferences<_$AppDatabase, $AlarmSchedulesTable, AlarmSchedule> {
  $$AlarmSchedulesTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $EventsTable _eventIdTable(_$AppDatabase db) =>
      db.events.createAlias('alarm_schedules__event_id__events__id');

  $$EventsTableProcessedTableManager? get eventId {
    final $_column = $_itemColumn<String>('event_id');
    if ($_column == null) return null;
    final manager = $$EventsTableTableManager(
      $_db,
      $_db.events,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_eventIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$AlarmSchedulesTableFilterComposer
    extends Composer<_$AppDatabase, $AlarmSchedulesTable> {
  $$AlarmSchedulesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get kind => $composableBuilder(
    column: $table.kind,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get fireAt => $composableBuilder(
    column: $table.fireAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get snoozeParentId => $composableBuilder(
    column: $table.snoozeParentId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get notificationId => $composableBuilder(
    column: $table.notificationId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$EventsTableFilterComposer get eventId {
    final $$EventsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.eventId,
      referencedTable: $db.events,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EventsTableFilterComposer(
            $db: $db,
            $table: $db.events,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$AlarmSchedulesTableOrderingComposer
    extends Composer<_$AppDatabase, $AlarmSchedulesTable> {
  $$AlarmSchedulesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get kind => $composableBuilder(
    column: $table.kind,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get fireAt => $composableBuilder(
    column: $table.fireAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get snoozeParentId => $composableBuilder(
    column: $table.snoozeParentId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get notificationId => $composableBuilder(
    column: $table.notificationId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$EventsTableOrderingComposer get eventId {
    final $$EventsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.eventId,
      referencedTable: $db.events,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EventsTableOrderingComposer(
            $db: $db,
            $table: $db.events,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$AlarmSchedulesTableAnnotationComposer
    extends Composer<_$AppDatabase, $AlarmSchedulesTable> {
  $$AlarmSchedulesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get kind =>
      $composableBuilder(column: $table.kind, builder: (column) => column);

  GeneratedColumn<DateTime> get fireAt =>
      $composableBuilder(column: $table.fireAt, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<String> get snoozeParentId => $composableBuilder(
    column: $table.snoozeParentId,
    builder: (column) => column,
  );

  GeneratedColumn<int> get notificationId => $composableBuilder(
    column: $table.notificationId,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$EventsTableAnnotationComposer get eventId {
    final $$EventsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.eventId,
      referencedTable: $db.events,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EventsTableAnnotationComposer(
            $db: $db,
            $table: $db.events,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$AlarmSchedulesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $AlarmSchedulesTable,
          AlarmSchedule,
          $$AlarmSchedulesTableFilterComposer,
          $$AlarmSchedulesTableOrderingComposer,
          $$AlarmSchedulesTableAnnotationComposer,
          $$AlarmSchedulesTableCreateCompanionBuilder,
          $$AlarmSchedulesTableUpdateCompanionBuilder,
          (AlarmSchedule, $$AlarmSchedulesTableReferences),
          AlarmSchedule,
          PrefetchHooks Function({bool eventId})
        > {
  $$AlarmSchedulesTableTableManager(
    _$AppDatabase db,
    $AlarmSchedulesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AlarmSchedulesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AlarmSchedulesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AlarmSchedulesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String?> eventId = const Value.absent(),
                Value<String> kind = const Value.absent(),
                Value<DateTime> fireAt = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<String?> snoozeParentId = const Value.absent(),
                Value<int> notificationId = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => AlarmSchedulesCompanion(
                id: id,
                eventId: eventId,
                kind: kind,
                fireAt: fireAt,
                status: status,
                snoozeParentId: snoozeParentId,
                notificationId: notificationId,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                Value<String?> eventId = const Value.absent(),
                required String kind,
                required DateTime fireAt,
                Value<String> status = const Value.absent(),
                Value<String?> snoozeParentId = const Value.absent(),
                required int notificationId,
                required DateTime createdAt,
                required DateTime updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => AlarmSchedulesCompanion.insert(
                id: id,
                eventId: eventId,
                kind: kind,
                fireAt: fireAt,
                status: status,
                snoozeParentId: snoozeParentId,
                notificationId: notificationId,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$AlarmSchedulesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({eventId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (eventId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.eventId,
                                referencedTable: $$AlarmSchedulesTableReferences
                                    ._eventIdTable(db),
                                referencedColumn:
                                    $$AlarmSchedulesTableReferences
                                        ._eventIdTable(db)
                                        .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$AlarmSchedulesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $AlarmSchedulesTable,
      AlarmSchedule,
      $$AlarmSchedulesTableFilterComposer,
      $$AlarmSchedulesTableOrderingComposer,
      $$AlarmSchedulesTableAnnotationComposer,
      $$AlarmSchedulesTableCreateCompanionBuilder,
      $$AlarmSchedulesTableUpdateCompanionBuilder,
      (AlarmSchedule, $$AlarmSchedulesTableReferences),
      AlarmSchedule,
      PrefetchHooks Function({bool eventId})
    >;
typedef $$SyncCursorsTableCreateCompanionBuilder =
    SyncCursorsCompanion Function({
      required String accountId,
      Value<String?> historyId,
      Value<DateTime?> watchExpiresAt,
      Value<DateTime?> lastSyncAt,
      Value<DateTime?> lastFullSyncAt,
      Value<String?> lastErrorCode,
      Value<String?> lastErrorMessage,
      Value<int> rowid,
    });
typedef $$SyncCursorsTableUpdateCompanionBuilder =
    SyncCursorsCompanion Function({
      Value<String> accountId,
      Value<String?> historyId,
      Value<DateTime?> watchExpiresAt,
      Value<DateTime?> lastSyncAt,
      Value<DateTime?> lastFullSyncAt,
      Value<String?> lastErrorCode,
      Value<String?> lastErrorMessage,
      Value<int> rowid,
    });

final class $$SyncCursorsTableReferences
    extends BaseReferences<_$AppDatabase, $SyncCursorsTable, SyncCursor> {
  $$SyncCursorsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $AppAccountsTable _accountIdTable(_$AppDatabase db) =>
      db.appAccounts.createAlias('sync_cursors__account_id__app_accounts__id');

  $$AppAccountsTableProcessedTableManager get accountId {
    final $_column = $_itemColumn<String>('account_id')!;

    final manager = $$AppAccountsTableTableManager(
      $_db,
      $_db.appAccounts,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_accountIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$SyncCursorsTableFilterComposer
    extends Composer<_$AppDatabase, $SyncCursorsTable> {
  $$SyncCursorsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get historyId => $composableBuilder(
    column: $table.historyId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get watchExpiresAt => $composableBuilder(
    column: $table.watchExpiresAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lastSyncAt => $composableBuilder(
    column: $table.lastSyncAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lastFullSyncAt => $composableBuilder(
    column: $table.lastFullSyncAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get lastErrorCode => $composableBuilder(
    column: $table.lastErrorCode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get lastErrorMessage => $composableBuilder(
    column: $table.lastErrorMessage,
    builder: (column) => ColumnFilters(column),
  );

  $$AppAccountsTableFilterComposer get accountId {
    final $$AppAccountsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.accountId,
      referencedTable: $db.appAccounts,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AppAccountsTableFilterComposer(
            $db: $db,
            $table: $db.appAccounts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$SyncCursorsTableOrderingComposer
    extends Composer<_$AppDatabase, $SyncCursorsTable> {
  $$SyncCursorsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get historyId => $composableBuilder(
    column: $table.historyId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get watchExpiresAt => $composableBuilder(
    column: $table.watchExpiresAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastSyncAt => $composableBuilder(
    column: $table.lastSyncAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastFullSyncAt => $composableBuilder(
    column: $table.lastFullSyncAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get lastErrorCode => $composableBuilder(
    column: $table.lastErrorCode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get lastErrorMessage => $composableBuilder(
    column: $table.lastErrorMessage,
    builder: (column) => ColumnOrderings(column),
  );

  $$AppAccountsTableOrderingComposer get accountId {
    final $$AppAccountsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.accountId,
      referencedTable: $db.appAccounts,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AppAccountsTableOrderingComposer(
            $db: $db,
            $table: $db.appAccounts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$SyncCursorsTableAnnotationComposer
    extends Composer<_$AppDatabase, $SyncCursorsTable> {
  $$SyncCursorsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get historyId =>
      $composableBuilder(column: $table.historyId, builder: (column) => column);

  GeneratedColumn<DateTime> get watchExpiresAt => $composableBuilder(
    column: $table.watchExpiresAt,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get lastSyncAt => $composableBuilder(
    column: $table.lastSyncAt,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get lastFullSyncAt => $composableBuilder(
    column: $table.lastFullSyncAt,
    builder: (column) => column,
  );

  GeneratedColumn<String> get lastErrorCode => $composableBuilder(
    column: $table.lastErrorCode,
    builder: (column) => column,
  );

  GeneratedColumn<String> get lastErrorMessage => $composableBuilder(
    column: $table.lastErrorMessage,
    builder: (column) => column,
  );

  $$AppAccountsTableAnnotationComposer get accountId {
    final $$AppAccountsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.accountId,
      referencedTable: $db.appAccounts,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AppAccountsTableAnnotationComposer(
            $db: $db,
            $table: $db.appAccounts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$SyncCursorsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SyncCursorsTable,
          SyncCursor,
          $$SyncCursorsTableFilterComposer,
          $$SyncCursorsTableOrderingComposer,
          $$SyncCursorsTableAnnotationComposer,
          $$SyncCursorsTableCreateCompanionBuilder,
          $$SyncCursorsTableUpdateCompanionBuilder,
          (SyncCursor, $$SyncCursorsTableReferences),
          SyncCursor,
          PrefetchHooks Function({bool accountId})
        > {
  $$SyncCursorsTableTableManager(_$AppDatabase db, $SyncCursorsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SyncCursorsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SyncCursorsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SyncCursorsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> accountId = const Value.absent(),
                Value<String?> historyId = const Value.absent(),
                Value<DateTime?> watchExpiresAt = const Value.absent(),
                Value<DateTime?> lastSyncAt = const Value.absent(),
                Value<DateTime?> lastFullSyncAt = const Value.absent(),
                Value<String?> lastErrorCode = const Value.absent(),
                Value<String?> lastErrorMessage = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SyncCursorsCompanion(
                accountId: accountId,
                historyId: historyId,
                watchExpiresAt: watchExpiresAt,
                lastSyncAt: lastSyncAt,
                lastFullSyncAt: lastFullSyncAt,
                lastErrorCode: lastErrorCode,
                lastErrorMessage: lastErrorMessage,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String accountId,
                Value<String?> historyId = const Value.absent(),
                Value<DateTime?> watchExpiresAt = const Value.absent(),
                Value<DateTime?> lastSyncAt = const Value.absent(),
                Value<DateTime?> lastFullSyncAt = const Value.absent(),
                Value<String?> lastErrorCode = const Value.absent(),
                Value<String?> lastErrorMessage = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SyncCursorsCompanion.insert(
                accountId: accountId,
                historyId: historyId,
                watchExpiresAt: watchExpiresAt,
                lastSyncAt: lastSyncAt,
                lastFullSyncAt: lastFullSyncAt,
                lastErrorCode: lastErrorCode,
                lastErrorMessage: lastErrorMessage,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$SyncCursorsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({accountId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (accountId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.accountId,
                                referencedTable: $$SyncCursorsTableReferences
                                    ._accountIdTable(db),
                                referencedColumn: $$SyncCursorsTableReferences
                                    ._accountIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$SyncCursorsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SyncCursorsTable,
      SyncCursor,
      $$SyncCursorsTableFilterComposer,
      $$SyncCursorsTableOrderingComposer,
      $$SyncCursorsTableAnnotationComposer,
      $$SyncCursorsTableCreateCompanionBuilder,
      $$SyncCursorsTableUpdateCompanionBuilder,
      (SyncCursor, $$SyncCursorsTableReferences),
      SyncCursor,
      PrefetchHooks Function({bool accountId})
    >;
typedef $$AppSettingsTableCreateCompanionBuilder =
    AppSettingsCompanion Function({
      required String key,
      required String jsonValue,
      required DateTime updatedAt,
      Value<int> rowid,
    });
typedef $$AppSettingsTableUpdateCompanionBuilder =
    AppSettingsCompanion Function({
      Value<String> key,
      Value<String> jsonValue,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

class $$AppSettingsTableFilterComposer
    extends Composer<_$AppDatabase, $AppSettingsTable> {
  $$AppSettingsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get key => $composableBuilder(
    column: $table.key,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get jsonValue => $composableBuilder(
    column: $table.jsonValue,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$AppSettingsTableOrderingComposer
    extends Composer<_$AppDatabase, $AppSettingsTable> {
  $$AppSettingsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get key => $composableBuilder(
    column: $table.key,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get jsonValue => $composableBuilder(
    column: $table.jsonValue,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$AppSettingsTableAnnotationComposer
    extends Composer<_$AppDatabase, $AppSettingsTable> {
  $$AppSettingsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get key =>
      $composableBuilder(column: $table.key, builder: (column) => column);

  GeneratedColumn<String> get jsonValue =>
      $composableBuilder(column: $table.jsonValue, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$AppSettingsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $AppSettingsTable,
          AppSetting,
          $$AppSettingsTableFilterComposer,
          $$AppSettingsTableOrderingComposer,
          $$AppSettingsTableAnnotationComposer,
          $$AppSettingsTableCreateCompanionBuilder,
          $$AppSettingsTableUpdateCompanionBuilder,
          (
            AppSetting,
            BaseReferences<_$AppDatabase, $AppSettingsTable, AppSetting>,
          ),
          AppSetting,
          PrefetchHooks Function()
        > {
  $$AppSettingsTableTableManager(_$AppDatabase db, $AppSettingsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AppSettingsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AppSettingsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AppSettingsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> key = const Value.absent(),
                Value<String> jsonValue = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => AppSettingsCompanion(
                key: key,
                jsonValue: jsonValue,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String key,
                required String jsonValue,
                required DateTime updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => AppSettingsCompanion.insert(
                key: key,
                jsonValue: jsonValue,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$AppSettingsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $AppSettingsTable,
      AppSetting,
      $$AppSettingsTableFilterComposer,
      $$AppSettingsTableOrderingComposer,
      $$AppSettingsTableAnnotationComposer,
      $$AppSettingsTableCreateCompanionBuilder,
      $$AppSettingsTableUpdateCompanionBuilder,
      (
        AppSetting,
        BaseReferences<_$AppDatabase, $AppSettingsTable, AppSetting>,
      ),
      AppSetting,
      PrefetchHooks Function()
    >;
typedef $$ModelStatesTableCreateCompanionBuilder =
    ModelStatesCompanion Function({
      required String id,
      required String provider,
      required String model,
      required String version,
      required String status,
      Value<String?> localPath,
      Value<String?> sha256,
      Value<int?> sizeBytes,
      Value<DateTime?> downloadedAt,
      Value<String?> lastError,
      Value<int> rowid,
    });
typedef $$ModelStatesTableUpdateCompanionBuilder =
    ModelStatesCompanion Function({
      Value<String> id,
      Value<String> provider,
      Value<String> model,
      Value<String> version,
      Value<String> status,
      Value<String?> localPath,
      Value<String?> sha256,
      Value<int?> sizeBytes,
      Value<DateTime?> downloadedAt,
      Value<String?> lastError,
      Value<int> rowid,
    });

class $$ModelStatesTableFilterComposer
    extends Composer<_$AppDatabase, $ModelStatesTable> {
  $$ModelStatesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get provider => $composableBuilder(
    column: $table.provider,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get model => $composableBuilder(
    column: $table.model,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get version => $composableBuilder(
    column: $table.version,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get localPath => $composableBuilder(
    column: $table.localPath,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get sha256 => $composableBuilder(
    column: $table.sha256,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get sizeBytes => $composableBuilder(
    column: $table.sizeBytes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get downloadedAt => $composableBuilder(
    column: $table.downloadedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get lastError => $composableBuilder(
    column: $table.lastError,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ModelStatesTableOrderingComposer
    extends Composer<_$AppDatabase, $ModelStatesTable> {
  $$ModelStatesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get provider => $composableBuilder(
    column: $table.provider,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get model => $composableBuilder(
    column: $table.model,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get version => $composableBuilder(
    column: $table.version,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get localPath => $composableBuilder(
    column: $table.localPath,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get sha256 => $composableBuilder(
    column: $table.sha256,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sizeBytes => $composableBuilder(
    column: $table.sizeBytes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get downloadedAt => $composableBuilder(
    column: $table.downloadedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get lastError => $composableBuilder(
    column: $table.lastError,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ModelStatesTableAnnotationComposer
    extends Composer<_$AppDatabase, $ModelStatesTable> {
  $$ModelStatesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get provider =>
      $composableBuilder(column: $table.provider, builder: (column) => column);

  GeneratedColumn<String> get model =>
      $composableBuilder(column: $table.model, builder: (column) => column);

  GeneratedColumn<String> get version =>
      $composableBuilder(column: $table.version, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<String> get localPath =>
      $composableBuilder(column: $table.localPath, builder: (column) => column);

  GeneratedColumn<String> get sha256 =>
      $composableBuilder(column: $table.sha256, builder: (column) => column);

  GeneratedColumn<int> get sizeBytes =>
      $composableBuilder(column: $table.sizeBytes, builder: (column) => column);

  GeneratedColumn<DateTime> get downloadedAt => $composableBuilder(
    column: $table.downloadedAt,
    builder: (column) => column,
  );

  GeneratedColumn<String> get lastError =>
      $composableBuilder(column: $table.lastError, builder: (column) => column);
}

class $$ModelStatesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ModelStatesTable,
          ModelState,
          $$ModelStatesTableFilterComposer,
          $$ModelStatesTableOrderingComposer,
          $$ModelStatesTableAnnotationComposer,
          $$ModelStatesTableCreateCompanionBuilder,
          $$ModelStatesTableUpdateCompanionBuilder,
          (
            ModelState,
            BaseReferences<_$AppDatabase, $ModelStatesTable, ModelState>,
          ),
          ModelState,
          PrefetchHooks Function()
        > {
  $$ModelStatesTableTableManager(_$AppDatabase db, $ModelStatesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ModelStatesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ModelStatesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ModelStatesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> provider = const Value.absent(),
                Value<String> model = const Value.absent(),
                Value<String> version = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<String?> localPath = const Value.absent(),
                Value<String?> sha256 = const Value.absent(),
                Value<int?> sizeBytes = const Value.absent(),
                Value<DateTime?> downloadedAt = const Value.absent(),
                Value<String?> lastError = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ModelStatesCompanion(
                id: id,
                provider: provider,
                model: model,
                version: version,
                status: status,
                localPath: localPath,
                sha256: sha256,
                sizeBytes: sizeBytes,
                downloadedAt: downloadedAt,
                lastError: lastError,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String provider,
                required String model,
                required String version,
                required String status,
                Value<String?> localPath = const Value.absent(),
                Value<String?> sha256 = const Value.absent(),
                Value<int?> sizeBytes = const Value.absent(),
                Value<DateTime?> downloadedAt = const Value.absent(),
                Value<String?> lastError = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ModelStatesCompanion.insert(
                id: id,
                provider: provider,
                model: model,
                version: version,
                status: status,
                localPath: localPath,
                sha256: sha256,
                sizeBytes: sizeBytes,
                downloadedAt: downloadedAt,
                lastError: lastError,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ModelStatesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ModelStatesTable,
      ModelState,
      $$ModelStatesTableFilterComposer,
      $$ModelStatesTableOrderingComposer,
      $$ModelStatesTableAnnotationComposer,
      $$ModelStatesTableCreateCompanionBuilder,
      $$ModelStatesTableUpdateCompanionBuilder,
      (
        ModelState,
        BaseReferences<_$AppDatabase, $ModelStatesTable, ModelState>,
      ),
      ModelState,
      PrefetchHooks Function()
    >;
typedef $$WidgetStatesTableCreateCompanionBuilder =
    WidgetStatesCompanion Function({
      Value<int> id,
      Value<bool> privacyHidden,
      required DateTime updatedAt,
    });
typedef $$WidgetStatesTableUpdateCompanionBuilder =
    WidgetStatesCompanion Function({
      Value<int> id,
      Value<bool> privacyHidden,
      Value<DateTime> updatedAt,
    });

class $$WidgetStatesTableFilterComposer
    extends Composer<_$AppDatabase, $WidgetStatesTable> {
  $$WidgetStatesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get privacyHidden => $composableBuilder(
    column: $table.privacyHidden,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$WidgetStatesTableOrderingComposer
    extends Composer<_$AppDatabase, $WidgetStatesTable> {
  $$WidgetStatesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get privacyHidden => $composableBuilder(
    column: $table.privacyHidden,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$WidgetStatesTableAnnotationComposer
    extends Composer<_$AppDatabase, $WidgetStatesTable> {
  $$WidgetStatesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<bool> get privacyHidden => $composableBuilder(
    column: $table.privacyHidden,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$WidgetStatesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $WidgetStatesTable,
          WidgetState,
          $$WidgetStatesTableFilterComposer,
          $$WidgetStatesTableOrderingComposer,
          $$WidgetStatesTableAnnotationComposer,
          $$WidgetStatesTableCreateCompanionBuilder,
          $$WidgetStatesTableUpdateCompanionBuilder,
          (
            WidgetState,
            BaseReferences<_$AppDatabase, $WidgetStatesTable, WidgetState>,
          ),
          WidgetState,
          PrefetchHooks Function()
        > {
  $$WidgetStatesTableTableManager(_$AppDatabase db, $WidgetStatesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$WidgetStatesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$WidgetStatesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$WidgetStatesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<bool> privacyHidden = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => WidgetStatesCompanion(
                id: id,
                privacyHidden: privacyHidden,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<bool> privacyHidden = const Value.absent(),
                required DateTime updatedAt,
              }) => WidgetStatesCompanion.insert(
                id: id,
                privacyHidden: privacyHidden,
                updatedAt: updatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$WidgetStatesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $WidgetStatesTable,
      WidgetState,
      $$WidgetStatesTableFilterComposer,
      $$WidgetStatesTableOrderingComposer,
      $$WidgetStatesTableAnnotationComposer,
      $$WidgetStatesTableCreateCompanionBuilder,
      $$WidgetStatesTableUpdateCompanionBuilder,
      (
        WidgetState,
        BaseReferences<_$AppDatabase, $WidgetStatesTable, WidgetState>,
      ),
      WidgetState,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$MetaEntriesTableTableManager get metaEntries =>
      $$MetaEntriesTableTableManager(_db, _db.metaEntries);
  $$GmailMessagesTableTableManager get gmailMessages =>
      $$GmailMessagesTableTableManager(_db, _db.gmailMessages);
  $$AppAccountsTableTableManager get appAccounts =>
      $$AppAccountsTableTableManager(_db, _db.appAccounts);
  $$SourcesTableTableManager get sources =>
      $$SourcesTableTableManager(_db, _db.sources);
  $$SourceAllowlistEntriesTableTableManager get sourceAllowlistEntries =>
      $$SourceAllowlistEntriesTableTableManager(
        _db,
        _db.sourceAllowlistEntries,
      );
  $$GmailMessageAccountsTableTableManager get gmailMessageAccounts =>
      $$GmailMessageAccountsTableTableManager(_db, _db.gmailMessageAccounts);
  $$GmailMessageBodiesTableTableManager get gmailMessageBodies =>
      $$GmailMessageBodiesTableTableManager(_db, _db.gmailMessageBodies);
  $$AttachmentsTableTableManager get attachments =>
      $$AttachmentsTableTableManager(_db, _db.attachments);
  $$ProposalsTableTableManager get proposals =>
      $$ProposalsTableTableManager(_db, _db.proposals);
  $$ProposalItemsTableTableManager get proposalItems =>
      $$ProposalItemsTableTableManager(_db, _db.proposalItems);
  $$EventsTableTableManager get events =>
      $$EventsTableTableManager(_db, _db.events);
  $$EventItemsTableTableManager get eventItems =>
      $$EventItemsTableTableManager(_db, _db.eventItems);
  $$AlarmSchedulesTableTableManager get alarmSchedules =>
      $$AlarmSchedulesTableTableManager(_db, _db.alarmSchedules);
  $$SyncCursorsTableTableManager get syncCursors =>
      $$SyncCursorsTableTableManager(_db, _db.syncCursors);
  $$AppSettingsTableTableManager get appSettings =>
      $$AppSettingsTableTableManager(_db, _db.appSettings);
  $$ModelStatesTableTableManager get modelStates =>
      $$ModelStatesTableTableManager(_db, _db.modelStates);
  $$WidgetStatesTableTableManager get widgetStates =>
      $$WidgetStatesTableTableManager(_db, _db.widgetStates);
}
