import 'package:teamvisual/data/datasource/local/app_database.dart';
import 'package:teamvisual/data/datasource/remote/remote.dart';
import 'package:teamvisual/data/mapper/entity_mapper.dart';
import 'package:teamvisual/domain/model/assistance_type_entity.dart';
import 'package:teamvisual/domain/model/module_entity.dart';
import 'package:teamvisual/domain/model/sign_in_entity.dart';
import 'package:teamvisual/domain/model/sync_entity.dart';
import 'package:teamvisual/domain/model/user_entity.dart';
import 'package:teamvisual/domain/model/val_version_entity.dart';
import 'package:teamvisual/domain/repository/app_repository.dart';
import 'package:teamvisual/presentation/utils/string_extension.dart';

class AppRepositoryImpl extends AppRepository {

  final Remote _remote;
  final EntityMapper _mapper;
  final AppDatabase _database;

  AppRepositoryImpl(this._remote, this._mapper, this._database);

  @override
  Future<UserEntity?> signIn(SignInEntity signInEntity) async {
    final response = await _remote.signIn(signInEntity);
    return _mapper.toUserEntity(response);
  }

  @override
  Future<bool> valVersion(ValVersionEntity valVersionEntity) async {
    final response = await _remote.valVersion(valVersionEntity);
    return _mapper.toIsValid(response);
  }

  @override
  Future<bool> sync(SyncEntity syncEntity) async {
    final response = await _remote.sync(syncEntity);
    final assistanceTypeEntity = _mapper.toAssistanceTypeEntity(response);
    final moduleEntity = _mapper.toModuleEntity(response);
    await _database.assistanceTypeDao.deleteAll();
    await _database.moduleDao.deleteAll();
    await _database.assistanceTypeDao.insertList(assistanceTypeEntity);
    await _database.moduleDao.insertList(moduleEntity);
    return Future.value(response?.status?.equalsIgnoreCase("true"));
  }

  @override
  Future<List<AssistanceTypeEntity>> getAssistanceTypes() async {
    return await _database.assistanceTypeDao.getAll();
  }

  @override
  Future<List<ModuleEntity>> getModules() async {
    return await _database.moduleDao.getAll();
  }

}