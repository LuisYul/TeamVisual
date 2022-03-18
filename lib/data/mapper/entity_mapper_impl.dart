import 'package:flutter/foundation.dart';
import 'package:teamvisual/data/mapper/entity_mapper.dart';
import 'package:teamvisual/data/model/sync_response.dart';
import 'package:teamvisual/data/model/user_response.dart';
import 'package:teamvisual/data/model/val_version_response.dart';
import 'package:teamvisual/domain/model/assist_type_entity.dart';
import 'package:teamvisual/domain/model/module_entity.dart';
import 'package:teamvisual/domain/model/user_entity.dart';
import 'package:teamvisual/presentation/utils/string_extension.dart';

class EntityMapperImpl extends EntityMapper{

  @override
  UserEntity toUserEntity(UserResponse? userResponse) {
    return UserEntity(
      idUser: userResponse?.idUser ?? "",
      name: userResponse?.name ?? "",
      docNumber: userResponse?.docNumber ?? "",
      idUserType: userResponse?.idUserType ?? "",
      userType: userResponse?.userType ?? "",
      idAssistType: userResponse?.idAssistType ?? "",
      error: userResponse?.error ?? "",
      loginStatus: userResponse?.loginStatus ?? "",
    );
  }

  @override
  bool toIsValid(ValVersionResponse? valVersionResponse) {
    final valVersion = valVersionResponse?.valVersion ?? "";
    return valVersion.equalsIgnoreCase("true");
  }

  @override
  List<AssistTypeEntity> toAssistTypeEntity(SyncResponse? syncResponse) {
    final List<AssistTypeEntity> list = [];

    try {
      (syncResponse?.assistTypes?.data.forEach((e) =>
          list.add(AssistTypeEntity(
              id: e?.id ?? 0,
              name: e?.name ?? "",
              order: e?.order ?? 0
          ))
      ));
    } catch (e) {
      debugPrint(e.toString());
    }
    return list;
  }

  @override
  List<ModuleEntity> toModuleEntity(SyncResponse? syncResponse) {
    final List<ModuleEntity> list = [];

    try {
      (syncResponse?.modules?.data.forEach((e) =>
          list.add(ModuleEntity(
            id: e?.id ?? 0,
            name: e?.name ?? "",
            required: e?.required ?? 0,
            order: e?.order ?? 0,
          ))
      ));

    } catch (e) {
      debugPrint(e.toString());
    }
    return list;
  }


}