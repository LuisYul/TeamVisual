import 'package:teamvisual/data/model/sync_response.dart';
import 'package:teamvisual/data/model/user_response.dart';
import 'package:teamvisual/data/model/val_version_response.dart';
import 'package:teamvisual/domain/model/assistance_type_entity.dart';
import 'package:teamvisual/domain/model/module_entity.dart';
import 'package:teamvisual/domain/model/user_entity.dart';

abstract class EntityMapper {
  UserEntity toUserEntity(UserResponse? userResponse);
  bool toIsValid(ValVersionResponse? valVersionResponse);
  List<AssistanceTypeEntity> toAssistanceTypeEntity(SyncResponse? syncResponse);
  List<ModuleEntity> toModuleEntity(SyncResponse? syncResponse);
}