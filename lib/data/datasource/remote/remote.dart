import 'package:teamvisual/data/model/sync_response.dart';
import 'package:teamvisual/data/model/user_response.dart';
import 'package:teamvisual/data/model/val_version_response.dart';
import 'package:teamvisual/domain/model/sign_in_entity.dart';
import 'package:teamvisual/domain/model/sync_entity.dart';
import 'package:teamvisual/domain/model/val_version_entity.dart';

abstract class Remote {

  Future<UserResponse?> signIn(SignInEntity signInEntity);
  Future<ValVersionResponse?> valVersion(ValVersionEntity valVersionEntity);
  Future<SyncResponse?> sync(SyncEntity syncEntity);

}