import 'package:teamvisual/domain/model/assist_entity.dart';
import 'package:teamvisual/domain/model/assist_type_entity.dart';
import 'package:teamvisual/domain/model/module_entity.dart';
import 'package:teamvisual/domain/model/sign_in_entity.dart';
import 'package:teamvisual/domain/model/sync_entity.dart';
import 'package:teamvisual/domain/model/user_entity.dart';
import 'package:teamvisual/domain/model/val_version_entity.dart';

abstract class AppRepository {

    Future<UserEntity> signIn(SignInEntity signInEntity);
    Future<bool> valVersion(ValVersionEntity valVersionEntity);
    Future<bool> sync(SyncEntity syncEntity);
    Future<List<ModuleEntity>> getModules();
    Future<List<AssistTypeEntity>> getAssistTypes();
    Future<int> saveAssist(AssistEntity assist);
    Future<bool> sendAssists(List<AssistEntity> assists);

}