import 'package:teamvisual/data/model/generic_response.dart';
import 'package:teamvisual/data/model/sync_response.dart';
import 'package:teamvisual/data/model/user_response.dart';
import 'package:teamvisual/data/model/val_version_response.dart';
import 'package:teamvisual/domain/model/save_evaluation_entity.dart';
import 'package:teamvisual/domain/model/sign_in_entity.dart';
import 'package:teamvisual/domain/model/sync_entity.dart';
import 'package:teamvisual/domain/model/val_version_entity.dart';
import 'package:teamvisual/domain/model/assist_list_entity.dart';

abstract class Remote {

  Future<UserResponse?> signIn(SignInEntity signInEntity);
  Future<ValVersionResponse?> valVersion(ValVersionEntity valVersionEntity);
  Future<SyncResponse?> sync(SyncEntity syncEntity);
  Future<GenericResponse?> sendAssist(AssistListEntity assists);
  Future<GenericResponse?> sendEvaluations(SaveEvaluationListEntity evaluations);

}