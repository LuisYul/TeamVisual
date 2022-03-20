import 'package:shared_preferences/shared_preferences.dart';
import 'package:teamvisual/data/datasource/local/app_database.dart';
import 'package:teamvisual/data/datasource/remote/remote.dart';
import 'package:teamvisual/data/mapper/entity_mapper.dart';
import 'package:teamvisual/domain/model/assist_type_entity.dart';
import 'package:teamvisual/domain/model/module_entity.dart';
import 'package:teamvisual/domain/model/sign_in_entity.dart';
import 'package:teamvisual/domain/model/sync_entity.dart';
import 'package:teamvisual/domain/model/user_entity.dart';
import 'package:teamvisual/domain/model/val_version_entity.dart';
import 'package:teamvisual/domain/repository/app_repository.dart';
import 'package:teamvisual/presentation/utils/app_constants.dart';
import 'package:teamvisual/presentation/utils/string_extension.dart';
import '../../domain/model/assist_entity.dart';
import '../../domain/model/assist_list_entity.dart';
import 'package:collection/collection.dart';

class AppRepositoryImpl extends AppRepository {

  final Remote _remote;
  final EntityMapper _mapper;
  final AppDatabase _database;
  final SharedPreferences _prefs;

  AppRepositoryImpl(this._remote, this._mapper, this._database, this._prefs);

  @override
  Future<UserEntity> signIn(SignInEntity signInEntity) async {
    final response = await _remote.signIn(signInEntity);
    final userEntity = _mapper.toUserEntity(response);
    _prefs.setString(AppConstants.prefsUserId, userEntity.idUser);
    _prefs.setString(AppConstants.prefsUserName, userEntity.name);
    _prefs.setString(AppConstants.prefsUserDocNumber, userEntity.docNumber);
    _prefs.setString(AppConstants.prefsUserTypeId, userEntity.idUserType);
    _prefs.setString(AppConstants.prefsUserType, userEntity.userType);
    _prefs.setString(AppConstants.prefsUserPhoto, userEntity.photoUrl);
    _prefs.setInt(AppConstants.prefsIdAssist, int.parse(userEntity.idAssistType));
    return userEntity;
  }

  @override
  Future<bool> valVersion(ValVersionEntity valVersionEntity) async {
    final response = await _remote.valVersion(valVersionEntity);
    return _mapper.toIsValid(response);
  }

  @override
  Future<bool> sync(SyncEntity syncEntity) async {
    final response = await _remote.sync(syncEntity);
    final assistTypesEntity = _mapper.toAssistTypeEntity(response);
    final modulesEntity = _mapper.toModuleEntity(response);
    final coursesEntity = _mapper.toCourseEntity(response);
    final videosEntity = _mapper.toVideoEntity(response);
    final filesEntity = _mapper.toFileEntity(response);
    final evaluationsEntity = _mapper.toEvaluationEntity(response);
    final questionEntity = _mapper.toQuestionEntity(response);
    final alternativeEntity = _mapper.toAlternativeEntity(response);
    await _database.assistTypeDao.deleteAll();
    await _database.moduleDao.deleteAll();
    await _database.courseDao.deleteAll();
    await _database.evaluationDao.deleteAll();
    await _database.videoDao.deleteAll();
    await _database.fileDao.deleteAll();
    await _database.questionDao.deleteAll();
    await _database.alternativeDao.deleteAll();
    await _database.assistTypeDao.insertList(assistTypesEntity);
    await _database.moduleDao.insertList(modulesEntity);
    await _database.courseDao.insertList(coursesEntity);
    await _database.videoDao.insertList(videosEntity);
    await _database.fileDao.insertList(filesEntity);
    await _database.evaluationDao.insertList(evaluationsEntity);
    await _database.questionDao.insertList(questionEntity);
    await _database.alternativeDao.insertList(alternativeEntity);
    return Future.value(response?.status?.equalsIgnoreCase("true"));
  }

  @override
  Future<List<AssistTypeEntity>> getAssistTypes() async {
    final int idAssist = _prefs.getInt(AppConstants.prefsIdAssist) ?? 0;
    final assistTypes = await _database.assistTypeDao.getAll();
    int indexOk = -1;
    assistTypes.forEachIndexed((index, element) {
      element.index = index;
      element.current = false;
      if(element.id == idAssist){
        indexOk = index;
      }
    });
    assistTypes[indexOk +1].current =  true;
    return assistTypes;
  }

  @override
  Future<List<ModuleEntity>> getModules() async {
    return await _database.moduleDao.getAll();
  }

  @override
  Future<int> saveAssist(AssistEntity assist) async {
    _prefs.setInt(AppConstants.prefsIdAssist,
        int.parse(assist.idAssistType));
    return await _database.assistDao.insertEntity(assist);
  }

  @override
  Future<bool> sendAssists(AssistListEntity assists) async {
    _prefs.setInt(AppConstants.prefsIdAssist,
        int.parse(assists.assists.first.idAssistType));
    final response = await _remote.sendAssist(assists);
    return Future.value(response?.status?.equalsIgnoreCase("true"));
  }

  @override
  Future<void> deleteTables() async {
    await _database.assistDao.deleteAll();
    await _database.assistTypeDao.deleteAll();
    await _database.assistDao.deleteAll();
    await _database.courseDao.deleteAll();
    await _database.evaluationDao.deleteAll();
    await _database.videoDao.deleteAll();
    await _database.fileDao.deleteAll();
  }

}