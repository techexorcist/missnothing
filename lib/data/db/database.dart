import 'package:drift/drift.dart';

part 'database.g.dart';

class MetaEntries extends Table {
  @override
  String get tableName => 'meta';

  TextColumn get key => text().named('k')();
  TextColumn get value => text().named('v')();

  @override
  Set<Column<Object>> get primaryKey => {key};
}

class GmailMessages extends Table {
  TextColumn get messageId => text()();
  TextColumn get threadId => text().nullable()();
  IntColumn get internalDateMs => integer().nullable()();
  TextColumn get fromRaw => text().nullable()();
  TextColumn get subjectRaw => text().nullable()();
  TextColumn get parseStatus => text()();
  TextColumn get firstSeenAt => text()();
  TextColumn get lastSeenAt => text()();

  @override
  Set<Column<Object>> get primaryKey => {messageId};
}

class AppAccounts extends Table {
  TextColumn get id => text()();
  TextColumn get email => text().unique()();
  TextColumn get displayName => text().nullable()();
  TextColumn get backendAccountId => text().nullable().unique()();
  TextColumn get status => text().withDefault(const Constant('connected'))();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

class Sources extends Table {
  TextColumn get id => text()();
  TextColumn get accountId =>
      text().references(AppAccounts, #id, onDelete: KeyAction.cascade)();
  TextColumn get label => text()();
  TextColumn get rulePack => text().withDefault(const Constant('school_in'))();
  BoolColumn get enabled => boolean().withDefault(const Constant(true))();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

class SourceAllowlistEntries extends Table {
  TextColumn get id => text()();
  TextColumn get sourceId =>
      text().references(Sources, #id, onDelete: KeyAction.cascade)();
  TextColumn get kind => text()();
  TextColumn get value => text()();
  DateTimeColumn get createdAt => dateTime()();

  @override
  Set<Column<Object>> get primaryKey => {id};

  @override
  List<String> get customConstraints => [
    'UNIQUE(source_id, kind, value)',
    "CHECK(kind IN ('mailbox', 'domain'))",
  ];
}

class GmailMessageAccounts extends Table {
  TextColumn get messageId => text().references(
    GmailMessages,
    #messageId,
    onDelete: KeyAction.cascade,
  )();
  TextColumn get accountId =>
      text().references(AppAccounts, #id, onDelete: KeyAction.cascade)();

  @override
  Set<Column<Object>> get primaryKey => {messageId, accountId};
}

class GmailMessageBodies extends Table {
  TextColumn get messageId => text().references(
    GmailMessages,
    #messageId,
    onDelete: KeyAction.cascade,
  )();
  TextColumn get normalizedBody => text()();
  DateTimeColumn get fetchedAt => dateTime()();
  DateTimeColumn get expiresAt => dateTime()();
  TextColumn get parserVersion => text().nullable()();

  @override
  Set<Column<Object>> get primaryKey => {messageId};
}

class Attachments extends Table {
  TextColumn get id => text()();
  TextColumn get messageId => text().references(
    GmailMessages,
    #messageId,
    onDelete: KeyAction.cascade,
  )();
  TextColumn get gmailAttachmentId => text().nullable()();
  TextColumn get fileName => text()();
  TextColumn get mimeType => text()();
  IntColumn get sizeBytes => integer().nullable()();
  TextColumn get localPath => text().nullable()();
  TextColumn get sha256 => text().nullable()();
  TextColumn get extractedText => text().nullable()();
  TextColumn get status => text().withDefault(const Constant('listed'))();
  DateTimeColumn get expiresAt => dateTime().nullable()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

class Proposals extends Table {
  TextColumn get id => text()();
  TextColumn get messageId => text().references(
    GmailMessages,
    #messageId,
    onDelete: KeyAction.cascade,
  )();
  TextColumn get sourceId =>
      text().nullable().references(Sources, #id, onDelete: KeyAction.setNull)();
  TextColumn get type => text()();
  TextColumn get status => text().withDefault(const Constant('unreviewed'))();
  DateTimeColumn get proposedDate => dateTime().nullable()();
  BoolColumn get allDay => boolean().nullable()();
  TextColumn get location => text().nullable()();
  TextColumn get urgency => text().withDefault(const Constant('none'))();
  TextColumn get whenHint => text().nullable()();
  TextColumn get subject => text()();
  TextColumn get fromRaw => text()();
  TextColumn get evidence => text()();
  TextColumn get parserVersion => text()();
  TextColumn get modelVersion => text().nullable()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

class ProposalItems extends Table {
  TextColumn get id => text()();
  TextColumn get proposalId =>
      text().references(Proposals, #id, onDelete: KeyAction.cascade)();
  IntColumn get position => integer()();
  TextColumn get kind => text()();
  TextColumn get textRaw => text()();
  TextColumn get location => text().nullable()();
  BoolColumn get completed => boolean().withDefault(const Constant(false))();

  @override
  Set<Column<Object>> get primaryKey => {id};

  @override
  List<String> get customConstraints => ['UNIQUE(proposal_id, position)'];
}

class Events extends Table {
  TextColumn get id => text()();
  TextColumn get proposalId => text().nullable().references(
    Proposals,
    #id,
    onDelete: KeyAction.setNull,
  )();
  TextColumn get sourceMessageId => text().nullable().references(
    GmailMessages,
    #messageId,
    onDelete: KeyAction.setNull,
  )();
  TextColumn get accountId => text().nullable().references(
    AppAccounts,
    #id,
    onDelete: KeyAction.setNull,
  )();
  TextColumn get title => text()();
  DateTimeColumn get startsAt => dateTime().nullable()();
  BoolColumn get allDay => boolean().withDefault(const Constant(true))();
  TextColumn get location => text().nullable()();
  TextColumn get status => text().withDefault(const Constant('active'))();
  TextColumn get notes => text().nullable()();
  TextColumn get exportedCalendarId => text().nullable()();
  TextColumn get exportedEventId => text().nullable()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

class EventItems extends Table {
  TextColumn get id => text()();
  TextColumn get eventId =>
      text().references(Events, #id, onDelete: KeyAction.cascade)();
  IntColumn get position => integer()();
  TextColumn get kind => text()();
  TextColumn get content => text().named('text')();
  TextColumn get location => text().nullable()();
  BoolColumn get completed => boolean().withDefault(const Constant(false))();

  @override
  Set<Column<Object>> get primaryKey => {id};

  @override
  List<String> get customConstraints => ['UNIQUE(event_id, position)'];
}

class AlarmSchedules extends Table {
  TextColumn get id => text()();
  TextColumn get eventId =>
      text().nullable().references(Events, #id, onDelete: KeyAction.cascade)();
  TextColumn get kind => text()();
  DateTimeColumn get fireAt => dateTime()();
  TextColumn get status => text().withDefault(const Constant('scheduled'))();
  TextColumn get snoozeParentId => text().nullable()();
  IntColumn get notificationId => integer().unique()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

class SyncCursors extends Table {
  TextColumn get accountId =>
      text().references(AppAccounts, #id, onDelete: KeyAction.cascade)();
  TextColumn get historyId => text().nullable()();
  DateTimeColumn get watchExpiresAt => dateTime().nullable()();
  DateTimeColumn get lastSyncAt => dateTime().nullable()();
  DateTimeColumn get lastFullSyncAt => dateTime().nullable()();
  TextColumn get lastErrorCode => text().nullable()();
  TextColumn get lastErrorMessage => text().nullable()();

  @override
  Set<Column<Object>> get primaryKey => {accountId};
}

class AppSettings extends Table {
  TextColumn get key => text()();
  TextColumn get jsonValue => text()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column<Object>> get primaryKey => {key};
}

class ModelStates extends Table {
  TextColumn get id => text()();
  TextColumn get provider => text()();
  TextColumn get model => text()();
  TextColumn get version => text()();
  TextColumn get status => text()();
  TextColumn get localPath => text().nullable()();
  TextColumn get sha256 => text().nullable()();
  IntColumn get sizeBytes => integer().nullable()();
  DateTimeColumn get downloadedAt => dateTime().nullable()();
  TextColumn get lastError => text().nullable()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

class WidgetStates extends Table {
  IntColumn get id => integer().withDefault(const Constant(1))();
  BoolColumn get privacyHidden =>
      boolean().withDefault(const Constant(false))();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column<Object>> get primaryKey => {id};

  @override
  List<String> get customConstraints => ['CHECK(id = 1)'];
}

@DriftDatabase(
  tables: [
    MetaEntries,
    GmailMessages,
    AppAccounts,
    Sources,
    SourceAllowlistEntries,
    GmailMessageAccounts,
    GmailMessageBodies,
    Attachments,
    Proposals,
    ProposalItems,
    Events,
    EventItems,
    AlarmSchedules,
    SyncCursors,
    AppSettings,
    ModelStates,
    WidgetStates,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase(super.executor);

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (migrator) async {
      await migrator.createAll();
    },
    onUpgrade: (migrator, from, to) async {
      if (from < 1) {
        await migrator.createAll();
      }
    },
    beforeOpen: (details) async {
      await customStatement('PRAGMA foreign_keys = ON;');
      await customStatement(
        'CREATE INDEX IF NOT EXISTS gmail_messages_parse_status '
        'ON gmail_messages(parse_status);',
      );
    },
  );
}
