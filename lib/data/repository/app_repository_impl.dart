import 'dart:convert';
import 'dart:developer';

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
    final assistTypeEntity = _mapper.toAssistTypeEntity(response);
    final moduleEntity = _mapper.toModuleEntity(response);
    await _database.assistTypeDao.deleteAll();
    await _database.moduleDao.deleteAll();
    await _database.assistTypeDao.insertList(assistTypeEntity);
    await _database.moduleDao.insertList(moduleEntity);
    return Future.value(response?.status?.equalsIgnoreCase("true"));
  }

  @override
  Future<List<AssistTypeEntity>> getAssistTypes() async {
    final int idAssist = _prefs.getInt(AppConstants.prefsIdAssist) ?? 1;
    final assistTypes = await _database.assistTypeDao.getAll();
    return List<AssistTypeEntity>.from(assistTypes.map((e) => AssistTypeEntity
      (id: e.id, name: e.name, order: e.order, current: e.id == idAssist + 1)));
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
  Future<bool> sendAssists(List<AssistEntity> assists) async {
    final response = await _remote.sendAssist(assists);
    return Future.value(response?.status?.equalsIgnoreCase("true"));
  }

}