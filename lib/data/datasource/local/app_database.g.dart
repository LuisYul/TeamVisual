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

  CourseDao? _courseDaoInstance;

  EvaluationDao? _evaluationDaoInstance;

  VideoDao? _videoDaoInstance;

  FileDao? _fileDaoInstance;

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
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `lista_curso` (`id` INTEGER NOT NULL, `course` TEXT NOT NULL, `author` TEXT NOT NULL, `resume` TEXT NOT NULL, `userId` INTEGER NOT NULL, `startDate` TEXT NOT NULL, `endDate` TEXT NOT NULL, `note` INTEGER NOT NULL, `advPercent` INTEGER NOT NULL, `specAreaId` INTEGER NOT NULL, `specArea` TEXT NOT NULL, `learningGroupId` INTEGER NOT NULL, `learningGroup` TEXT NOT NULL, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `lista_evaluaciones` (`id` INTEGER NOT NULL, `userId` INTEGER NOT NULL, `courseId` INTEGER NOT NULL, `name` TEXT NOT NULL, `maxNote` INTEGER NOT NULL, `minNote` INTEGER NOT NULL, `questionId` INTEGER NOT NULL, `question` TEXT NOT NULL, `note` INTEGER NOT NULL, `questionTypeId` INTEGER NOT NULL, `questionOrder` INTEGER NOT NULL, `type` TEXT NOT NULL, `alternativeId` INTEGER NOT NULL, `alternative` TEXT NOT NULL, `correct` INTEGER NOT NULL, `alternativeOrder` INTEGER NOT NULL, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `lista_videos` (`id` INTEGER NOT NULL, `userId` INTEGER NOT NULL, `courseId` INTEGER NOT NULL, `videoFile` TEXT NOT NULL, `name` TEXT NOT NULL, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `lista_archivos` (`id` INTEGER NOT NULL, PRIMARY KEY (`id`))');

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

  @override
  CourseDao get courseDao {
    return _courseDaoInstance ??= _$CourseDao(database, changeListener);
  }

  @override
  EvaluationDao get evaluationDao {
    return _evaluationDaoInstance ??= _$EvaluationDao(database, changeListener);
  }

  @override
  VideoDao get videoDao {
    return _videoDaoInstance ??= _$VideoDao(database, changeListener);
  }

  @override
  FileDao get fileDao {
    return _fileDaoInstance ??= _$FileDao(database, changeListener);
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

class _$CourseDao extends CourseDao {
  _$CourseDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _courseEntityInsertionAdapter = InsertionAdapter(
            database,
            'lista_curso',
            (CourseEntity item) => <String, Object?>{
                  'id': item.id,
                  'course': item.course,
                  'author': item.author,
                  'resume': item.resume,
                  'userId': item.userId,
                  'startDate': item.startDate,
                  'endDate': item.endDate,
                  'note': item.note,
                  'advPercent': item.advPercent,
                  'specAreaId': item.specAreaId,
                  'specArea': item.specArea,
                  'learningGroupId': item.learningGroupId,
                  'learningGroup': item.learningGroup
                }),
        _courseEntityUpdateAdapter = UpdateAdapter(
            database,
            'lista_curso',
            ['id'],
            (CourseEntity item) => <String, Object?>{
                  'id': item.id,
                  'course': item.course,
                  'author': item.author,
                  'resume': item.resume,
                  'userId': item.userId,
                  'startDate': item.startDate,
                  'endDate': item.endDate,
                  'note': item.note,
                  'advPercent': item.advPercent,
                  'specAreaId': item.specAreaId,
                  'specArea': item.specArea,
                  'learningGroupId': item.learningGroupId,
                  'learningGroup': item.learningGroup
                }),
        _courseEntityDeletionAdapter = DeletionAdapter(
            database,
            'lista_curso',
            ['id'],
            (CourseEntity item) => <String, Object?>{
                  'id': item.id,
                  'course': item.course,
                  'author': item.author,
                  'resume': item.resume,
                  'userId': item.userId,
                  'startDate': item.startDate,
                  'endDate': item.endDate,
                  'note': item.note,
                  'advPercent': item.advPercent,
                  'specAreaId': item.specAreaId,
                  'specArea': item.specArea,
                  'learningGroupId': item.learningGroupId,
                  'learningGroup': item.learningGroup
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<CourseEntity> _courseEntityInsertionAdapter;

  final UpdateAdapter<CourseEntity> _courseEntityUpdateAdapter;

  final DeletionAdapter<CourseEntity> _courseEntityDeletionAdapter;

  @override
  Future<List<CourseEntity>> getAll() async {
    return _queryAdapter.queryList('SELECT * FROM lista_curso',
        mapper: (Map<String, Object?> row) => CourseEntity(
            id: row['id'] as int,
            course: row['course'] as String,
            author: row['author'] as String,
            resume: row['resume'] as String,
            userId: row['userId'] as int,
            startDate: row['startDate'] as String,
            endDate: row['endDate'] as String,
            note: row['note'] as int,
            advPercent: row['advPercent'] as int,
            specAreaId: row['specAreaId'] as int,
            specArea: row['specArea'] as String,
            learningGroupId: row['learningGroupId'] as int,
            learningGroup: row['learningGroup'] as String));
  }

  @override
  Future<void> deleteAll() async {
    await _queryAdapter.queryNoReturn('DELETE FROM lista_curso');
  }

  @override
  Future<int> insertEntity(CourseEntity entity) {
    return _courseEntityInsertionAdapter.insertAndReturnId(
        entity, OnConflictStrategy.replace);
  }

  @override
  Future<List<int>> insertList(List<CourseEntity> entities) {
    return _courseEntityInsertionAdapter.insertListAndReturnIds(
        entities, OnConflictStrategy.replace);
  }

  @override
  Future<int> updateEntity(CourseEntity entity) {
    return _courseEntityUpdateAdapter.updateAndReturnChangedRows(
        entity, OnConflictStrategy.abort);
  }

  @override
  Future<int> deleteEntity(CourseEntity entity) {
    return _courseEntityDeletionAdapter.deleteAndReturnChangedRows(entity);
  }
}

class _$EvaluationDao extends EvaluationDao {
  _$EvaluationDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _evaluationEntityInsertionAdapter = InsertionAdapter(
            database,
            'lista_evaluaciones',
            (EvaluationEntity item) => <String, Object?>{
                  'id': item.id,
                  'userId': item.userId,
                  'courseId': item.courseId,
                  'name': item.name,
                  'maxNote': item.maxNote,
                  'minNote': item.minNote,
                  'questionId': item.questionId,
                  'question': item.question,
                  'note': item.note,
                  'questionTypeId': item.questionTypeId,
                  'questionOrder': item.questionOrder,
                  'type': item.type,
                  'alternativeId': item.alternativeId,
                  'alternative': item.alternative,
                  'correct': item.correct,
                  'alternativeOrder': item.alternativeOrder
                }),
        _evaluationEntityUpdateAdapter = UpdateAdapter(
            database,
            'lista_evaluaciones',
            ['id'],
            (EvaluationEntity item) => <String, Object?>{
                  'id': item.id,
                  'userId': item.userId,
                  'courseId': item.courseId,
                  'name': item.name,
                  'maxNote': item.maxNote,
                  'minNote': item.minNote,
                  'questionId': item.questionId,
                  'question': item.question,
                  'note': item.note,
                  'questionTypeId': item.questionTypeId,
                  'questionOrder': item.questionOrder,
                  'type': item.type,
                  'alternativeId': item.alternativeId,
                  'alternative': item.alternative,
                  'correct': item.correct,
                  'alternativeOrder': item.alternativeOrder
                }),
        _evaluationEntityDeletionAdapter = DeletionAdapter(
            database,
            'lista_evaluaciones',
            ['id'],
            (EvaluationEntity item) => <String, Object?>{
                  'id': item.id,
                  'userId': item.userId,
                  'courseId': item.courseId,
                  'name': item.name,
                  'maxNote': item.maxNote,
                  'minNote': item.minNote,
                  'questionId': item.questionId,
                  'question': item.question,
                  'note': item.note,
                  'questionTypeId': item.questionTypeId,
                  'questionOrder': item.questionOrder,
                  'type': item.type,
                  'alternativeId': item.alternativeId,
                  'alternative': item.alternative,
                  'correct': item.correct,
                  'alternativeOrder': item.alternativeOrder
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<EvaluationEntity> _evaluationEntityInsertionAdapter;

  final UpdateAdapter<EvaluationEntity> _evaluationEntityUpdateAdapter;

  final DeletionAdapter<EvaluationEntity> _evaluationEntityDeletionAdapter;

  @override
  Future<List<EvaluationEntity>> getAll() async {
    return _queryAdapter.queryList('SELECT * FROM lista_evaluaciones',
        mapper: (Map<String, Object?> row) => EvaluationEntity(
            id: row['id'] as int,
            userId: row['userId'] as int,
            courseId: row['courseId'] as int,
            name: row['name'] as String,
            maxNote: row['maxNote'] as int,
            minNote: row['minNote'] as int,
            questionId: row['questionId'] as int,
            question: row['question'] as String,
            note: row['note'] as int,
            questionTypeId: row['questionTypeId'] as int,
            questionOrder: row['questionOrder'] as int,
            type: row['type'] as String,
            alternativeId: row['alternativeId'] as int,
            alternative: row['alternative'] as String,
            correct: row['correct'] as int,
            alternativeOrder: row['alternativeOrder'] as int));
  }

  @override
  Future<void> deleteAll() async {
    await _queryAdapter.queryNoReturn('DELETE FROM lista_evaluaciones');
  }

  @override
  Future<int> insertEntity(EvaluationEntity entity) {
    return _evaluationEntityInsertionAdapter.insertAndReturnId(
        entity, OnConflictStrategy.replace);
  }

  @override
  Future<List<int>> insertList(List<EvaluationEntity> entities) {
    return _evaluationEntityInsertionAdapter.insertListAndReturnIds(
        entities, OnConflictStrategy.replace);
  }

  @override
  Future<int> updateEntity(EvaluationEntity entity) {
    return _evaluationEntityUpdateAdapter.updateAndReturnChangedRows(
        entity, OnConflictStrategy.abort);
  }

  @override
  Future<int> deleteEntity(EvaluationEntity entity) {
    return _evaluationEntityDeletionAdapter.deleteAndReturnChangedRows(entity);
  }
}

class _$VideoDao extends VideoDao {
  _$VideoDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _videoEntityInsertionAdapter = InsertionAdapter(
            database,
            'lista_videos',
            (VideoEntity item) => <String, Object?>{
                  'id': item.id,
                  'userId': item.userId,
                  'courseId': item.courseId,
                  'videoFile': item.videoFile,
                  'name': item.name
                }),
        _videoEntityUpdateAdapter = UpdateAdapter(
            database,
            'lista_videos',
            ['id'],
            (VideoEntity item) => <String, Object?>{
                  'id': item.id,
                  'userId': item.userId,
                  'courseId': item.courseId,
                  'videoFile': item.videoFile,
                  'name': item.name
                }),
        _videoEntityDeletionAdapter = DeletionAdapter(
            database,
            'lista_videos',
            ['id'],
            (VideoEntity item) => <String, Object?>{
                  'id': item.id,
                  'userId': item.userId,
                  'courseId': item.courseId,
                  'videoFile': item.videoFile,
                  'name': item.name
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<VideoEntity> _videoEntityInsertionAdapter;

  final UpdateAdapter<VideoEntity> _videoEntityUpdateAdapter;

  final DeletionAdapter<VideoEntity> _videoEntityDeletionAdapter;

  @override
  Future<List<VideoEntity>> getAll() async {
    return _queryAdapter.queryList('SELECT * FROM lista_videos',
        mapper: (Map<String, Object?> row) => VideoEntity(
            id: row['id'] as int,
            userId: row['userId'] as int,
            courseId: row['courseId'] as int,
            videoFile: row['videoFile'] as String,
            name: row['name'] as String));
  }

  @override
  Future<void> deleteAll() async {
    await _queryAdapter.queryNoReturn('DELETE FROM lista_videos');
  }

  @override
  Future<int> insertEntity(VideoEntity entity) {
    return _videoEntityInsertionAdapter.insertAndReturnId(
        entity, OnConflictStrategy.replace);
  }

  @override
  Future<List<int>> insertList(List<VideoEntity> entities) {
    return _videoEntityInsertionAdapter.insertListAndReturnIds(
        entities, OnConflictStrategy.replace);
  }

  @override
  Future<int> updateEntity(VideoEntity entity) {
    return _videoEntityUpdateAdapter.updateAndReturnChangedRows(
        entity, OnConflictStrategy.abort);
  }

  @override
  Future<int> deleteEntity(VideoEntity entity) {
    return _videoEntityDeletionAdapter.deleteAndReturnChangedRows(entity);
  }
}

class _$FileDao extends FileDao {
  _$FileDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _fileEntityInsertionAdapter = InsertionAdapter(
            database,
            'lista_archivos',
            (FileEntity item) => <String, Object?>{'id': item.id}),
        _fileEntityUpdateAdapter = UpdateAdapter(database, 'lista_archivos',
            ['id'], (FileEntity item) => <String, Object?>{'id': item.id}),
        _fileEntityDeletionAdapter = DeletionAdapter(database, 'lista_archivos',
            ['id'], (FileEntity item) => <String, Object?>{'id': item.id});

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<FileEntity> _fileEntityInsertionAdapter;

  final UpdateAdapter<FileEntity> _fileEntityUpdateAdapter;

  final DeletionAdapter<FileEntity> _fileEntityDeletionAdapter;

  @override
  Future<List<FileEntity>> getAll() async {
    return _queryAdapter.queryList('SELECT * FROM lista_archivos',
        mapper: (Map<String, Object?> row) => FileEntity(id: row['id'] as int));
  }

  @override
  Future<void> deleteAll() async {
    await _queryAdapter.queryNoReturn('DELETE FROM lista_archivos');
  }

  @override
  Future<int> insertEntity(FileEntity entity) {
    return _fileEntityInsertionAdapter.insertAndReturnId(
        entity, OnConflictStrategy.replace);
  }

  @override
  Future<List<int>> insertList(List<FileEntity> entities) {
    return _fileEntityInsertionAdapter.insertListAndReturnIds(
        entities, OnConflictStrategy.replace);
  }

  @override
  Future<int> updateEntity(FileEntity entity) {
    return _fileEntityUpdateAdapter.updateAndReturnChangedRows(
        entity, OnConflictStrategy.abort);
  }

  @override
  Future<int> deleteEntity(FileEntity entity) {
    return _fileEntityDeletionAdapter.deleteAndReturnChangedRows(entity);
  }
}
