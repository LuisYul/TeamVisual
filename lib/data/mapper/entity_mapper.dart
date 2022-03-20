import 'package:teamvisual/data/model/sync_response.dart';
import 'package:teamvisual/data/model/user_response.dart';
import 'package:teamvisual/data/model/val_version_response.dart';
import 'package:teamvisual/domain/model/assist_type_entity.dart';
import 'package:teamvisual/domain/model/course_entity.dart';
import 'package:teamvisual/domain/model/evaluation_entity.dart';
import 'package:teamvisual/domain/model/file_entity.dart';
import 'package:teamvisual/domain/model/module_entity.dart';
import 'package:teamvisual/domain/model/question_entity.dart';
import 'package:teamvisual/domain/model/user_entity.dart';
import 'package:teamvisual/domain/model/video_entity.dart';

import '../../domain/model/alternative_entity.dart';

abstract class EntityMapper {
  UserEntity toUserEntity(UserResponse? userResponse);
  bool toIsValid(ValVersionResponse? valVersionResponse);
  List<AssistTypeEntity> toAssistTypeEntity(SyncResponse? syncResponse);
  List<ModuleEntity> toModuleEntity(SyncResponse? syncResponse);
  List<CourseEntity> toCourseEntity(SyncResponse? syncResponse);
  List<VideoEntity> toVideoEntity(SyncResponse? syncResponse);
  List<FileEntity> toFileEntity(SyncResponse? syncResponse);
  List<EvaluationEntity> toEvaluationEntity(SyncResponse? syncResponse);
  List<QuestionEntity> toQuestionEntity(SyncResponse? syncResponse);
  List<AlternativeEntity> toAlternativeEntity(SyncResponse? syncResponse);
}