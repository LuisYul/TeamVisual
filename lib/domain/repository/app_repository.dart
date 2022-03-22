import 'package:teamvisual/domain/model/alternative_entity.dart';
import 'package:teamvisual/domain/model/assist_entity.dart';
import 'package:teamvisual/domain/model/assist_type_entity.dart';
import 'package:teamvisual/domain/model/course_entity.dart';
import 'package:teamvisual/domain/model/evaluation_entity.dart';
import 'package:teamvisual/domain/model/file_entity.dart';
import 'package:teamvisual/domain/model/module_entity.dart';
import 'package:teamvisual/domain/model/question_entity.dart';
import 'package:teamvisual/domain/model/save_evaluation_entity.dart';
import 'package:teamvisual/domain/model/sign_in_entity.dart';
import 'package:teamvisual/domain/model/sync_entity.dart';
import 'package:teamvisual/domain/model/user_entity.dart';
import 'package:teamvisual/domain/model/val_version_entity.dart';
import 'package:teamvisual/domain/model/video_entity.dart';
import 'package:teamvisual/domain/model/assist_list_entity.dart';

abstract class AppRepository {

    Future<UserEntity> signIn(SignInEntity signInEntity);
    Future<bool> valVersion(ValVersionEntity valVersionEntity);
    Future<bool> sync(SyncEntity syncEntity);
    Future<List<ModuleEntity>> getModules();
    Future<List<AssistTypeEntity>> getAssistTypes();
    Future<int> saveAssist(AssistEntity assist);
    Future<bool> sendAssists(AssistListEntity assists);
    Future<void> deleteTables();
    Future<List<CourseEntity>> getCourses();
    Future<List<VideoEntity>> getVideosByCourse(int courseId);
    Future<List<FileEntity>> getFilesByCourse(int courseId);
    Future<List<EvaluationEntity>> getEvaluationsByCourse(int courseId);
    Future<List<QuestionEntity>> getQuestionsByEvaluation(int evaluationId);
    Future<List<AlternativeEntity>> getAlternativesByQuestion(int questionId);
    Future<bool> sendEvaluations(SaveEvaluationListEntity evaluations);

}