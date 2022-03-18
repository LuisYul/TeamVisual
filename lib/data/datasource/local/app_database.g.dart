// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

// ignore: avoid_classes_with_only_static_members
class $FloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder {
  _$AppDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  /// Adds migrations to the builder.
  _$AppDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$AppDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<AppDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$AppDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AppDatabase extends AppDatabase {
  _$AppDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  AssistTypeDao? _assistTypeDaoInstance;

  ModuleDao? _moduleDaoInstance;

  AssistDao? _assistDaoInstance;

  Future<sqflite.Database> open(String path, List<Migration> migrations,
      [Callback? callback]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `tipo_asistencia` (`id` INTEGER NOT NULL, `name` TEXT NOT NULL, `order` INTEGER NOT NULL, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `modulos` (`id` INTEGER NOT NULL, `name` TEXT NOT NULL, `required` INTEGER NOT NULL, `order` INTEGER NOT NULL, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `asistencia` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `userId` TEXT, `userName` TEXT, `date` TEXT NOT NULL, `hour` TEXT NOT NULL, `lat` TEXT NOT NULL, `lng` TEXT NOT NULL, `photoPath` TEXT, `idAssistType` TEXT NOT NULL, `obs` TEXT NOT NULL, `idUserType` TEXT, `userType` TEXT, `numDoc` TEXT, `demo` TEXT)');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  AssistTypeDao get assistTypeDao {
    return _assistTypeDaoInstance ??= _$AssistTypeDao(database, changeListener);
  }

  @override
  ModuleDao get moduleDao {
    return _moduleDaoInstance ??= _$ModuleDao(database, changeListener);
  }

  @override
  AssistDao get assistDao {
    return _assistDaoInstance ??= _$AssistDao(database, changeListener);
  }
}

class _$AssistTypeDao extends AssistTypeDao {
  _$AssistTypeDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _assistTypeEntityInsertionAdapter = InsertionAdapter(
            database,
            'tipo_asistencia',
            (AssistTypeEntity item) => <String, Object?>{
                  'id': item.id,
                  'name': item.name,
                  'order': item.order
                }),
        _assistTypeEntityUpdateAdapter = UpdateAdapter(
            database,
            'tipo_asistencia',
            ['id'],
            (AssistTypeEntity item) => <String, Object?>{
                  'id': item.id,
                  'name': item.name,
                  'order': item.order
                }),
        _assistTypeEntityDeletionAdapter = DeletionAdapter(
            database,
            'tipo_asistencia',
            ['id'],
            (AssistTypeEntity item) => <String, Object?>{
                  'id': item.id,
                  'name': item.name,
                  'order': item.order
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<AssistTypeEntity> _assistTypeEntityInsertionAdapter;

  final UpdateAdapter<AssistTypeEntity> _assistTypeEntityUpdateAdapter;

  final DeletionAdapter<AssistTypeEntity> _assistTypeEntityDeletionAdapter;

  @override
  Future<List<AssistTypeEntity>> getAll() async {
    return _queryAdapter.queryList('SELECT * FROM tipo_asistencia',
        mapper: (Map<String, Object?> row) => AssistTypeEntity(
            id: row['id'] as int,
            name: row['name'] as String,
            order: row['order'] as int));
  }

  @override
  Future<void> deleteAll() async {
    await _queryAdapter.queryNoReturn('DELETE FROM tipo_asistencia');
  }

  @override
  Future<int> insertEntity(AssistTypeEntity entity) {
    return _assistTypeEntityInsertionAdapter.insertAndReturnId(
        entity, OnConflictStrategy.replace);
  }

  @override
  Future<List<int>> insertList(List<AssistTypeEntity> entities) {
    return _assistTypeEntityInsertionAdapter.insertListAndReturnIds(
        entities, OnConflictStrategy.replace);
  }

  @override
  Future<int> updateEntity(AssistTypeEntity entity) {
    return _assistTypeEntityUpdateAdapter.updateAndReturnChangedRows(
        entity, OnConflictStrategy.abort);
  }

  @override
  Future<int> deleteEntity(AssistTypeEntity entity) {
    return _assistTypeEntityDeletionAdapter.deleteAndReturnChangedRows(entity);
  }
}

class _$ModuleDao extends ModuleDao {
  _$ModuleDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _moduleEntityInsertionAdapter = InsertionAdapter(
            database,
            'modulos',
            (ModuleEntity item) => <String, Object?>{
                  'id': item.id,
                  'name': item.name,
                  'required': item.required,
                  'order': item.order
                }),
        _moduleEntityUpdateAdapter = UpdateAdapter(
            database,
            'modulos',
            ['id'],
            (ModuleEntity item) => <String, Object?>{
                  'id': item.id,
                  'name': item.name,
                  'required': item.required,
                  'order': item.order
                }),
        _moduleEntityDeletionAdapter = DeletionAdapter(
            database,
            'modulos',
            ['id'],
            (ModuleEntity item) => <String, Object?>{
                  'id': item.id,
                  'name': item.name,
                  'required': item.required,
                  'order': item.order
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<ModuleEntity> _moduleEntityInsertionAdapter;

  final UpdateAdapter<ModuleEntity> _moduleEntityUpdateAdapter;

  final DeletionAdapter<ModuleEntity> _moduleEntityDeletionAdapter;

  @override
  Future<List<ModuleEntity>> getAll() async {
    return _queryAdapter.queryList('SELECT * FROM modulos',
        mapper: (Map<String, Object?> row) => ModuleEntity(
            id: row['id'] as int,
            name: row['name'] as String,
            required: row['required'] as int,
            order: row['order'] as int));
  }

  @override
  Future<void> deleteAll() async {
    await _queryAdapter.queryNoReturn('DELETE FROM modulos');
  }

  @override
  Future<int> insertEntity(ModuleEntity entity) {
    return _moduleEntityInsertionAdapter.insertAndReturnId(
        entity, OnConflictStrategy.replace);
  }

  @override
  Future<List<int>> insertList(List<ModuleEntity> entities) {
    return _moduleEntityInsertionAdapter.insertListAndReturnIds(
        entities, OnConflictStrategy.replace);
  }

  @override
  Future<int> updateEntity(ModuleEntity entity) {
    return _moduleEntityUpdateAdapter.updateAndReturnChangedRows(
        entity, OnConflictStrategy.abort);
  }

  @override
  Future<int> deleteEntity(ModuleEntity entity) {
    return _moduleEntityDeletionAdapter.deleteAndReturnChangedRows(entity);
  }
}

class _$AssistDao extends AssistDao {
  _$AssistDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _assistEntityInsertionAdapter = InsertionAdapter(
            database,
            'asistencia',
            (AssistEntity item) => <String, Object?>{
                  'id': item.id,
                  'userId': item.userId,
                  'userName': item.userName,
                  'date': item.date,
                  'hour': item.hour,
                  'lat': item.lat,
                  'lng': item.lng,
                  'photoPath': item.photoPath,
                  'idAssistType': item.idAssistType,
                  'obs': item.obs,
                  'idUserType': item.idUserType,
                  'userType': item.userType,
                  'numDoc': item.numDoc,
                  'demo': item.demo
                }),
        _assistEntityUpdateAdapter = UpdateAdapter(
            database,
            'asistencia',
            ['id'],
            (AssistEntity item) => <String, Object?>{
                  'id': item.id,
                  'userId': item.userId,
                  'userName': item.userName,
                  'date': item.date,
                  'hour': item.hour,
                  'lat': item.lat,
                  'lng': item.lng,
                  'photoPath': item.photoPath,
                  'idAssistType': item.idAssistType,
                  'obs': item.obs,
                  'idUserType': item.idUserType,
                  'userType': item.userType,
                  'numDoc': item.numDoc,
                  'demo': item.demo
                }),
        _assistEntityDeletionAdapter = DeletionAdapter(
            database,
            'asistencia',
            ['id'],
            (AssistEntity item) => <String, Object?>{
                  'id': item.id,
                  'userId': item.userId,
                  'userName': item.userName,
                  'date': item.date,
                  'hour': item.hour,
                  'lat': item.lat,
                  'lng': item.lng,
                  'photoPath': item.photoPath,
                  'idAssistType': item.idAssistType,
                  'obs': item.obs,
                  'idUserType': item.idUserType,
                  'userType': item.userType,
                  'numDoc': item.numDoc,
                  'demo': item.demo
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<AssistEntity> _assistEntityInsertionAdapter;

  final UpdateAdapter<AssistEntity> _assistEntityUpdateAdapter;

  final DeletionAdapter<AssistEntity> _assistEntityDeletionAdapter;

  @override
  Future<List<AssistEntity>> getAll() async {
    return _queryAdapter.queryList('SELECT * FROM asistencia',
        mapper: (Map<String, Object?> row) => AssistEntity(
            userId: row['userId'] as String?,
            userName: row['userName'] as String?,
            date: row['date'] as String,
            hour: row['hour'] as String,
            lat: row['lat'] as String,
            lng: row['lng'] as String,
            photoPath: row['photoPath'] as String?,
            idAssistType: row['idAssistType'] as String,
            obs: row['obs'] as String,
            idUserType: row['idUserType'] as String?,
            userType: row['userType'] as String?,
            numDoc: row['numDoc'] as String?,
            demo: row['demo'] as String?));
  }

  @override
  Future<void> deleteAll() async {
    await _queryAdapter.queryNoReturn('DELETE FROM asistencia');
  }

  @override
  Future<int> insertEntity(AssistEntity entity) {
    return _assistEntityInsertionAdapter.insertAndReturnId(
        entity, OnConflictStrategy.replace);
  }

  @override
  Future<List<int>> insertList(List<AssistEntity> entities) {
    return _assistEntityInsertionAdapter.insertListAndReturnIds(
        entities, OnConflictStrategy.replace);
  }

  @override
  Future<int> updateEntity(AssistEntity entity) {
    return _assistEntityUpdateAdapter.updateAndReturnChangedRows(
        entity, OnConflictStrategy.abort);
  }

  @override
  Future<int> deleteEntity(AssistEntity entity) {
    return _assistEntityDeletionAdapter.deleteAndReturnChangedRows(entity);
  }
}
