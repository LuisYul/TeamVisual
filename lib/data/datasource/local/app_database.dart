import 'dart:async';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;
import 'package:teamvisual/data/datasource/local/dao/alternative_dao.dart';
import 'package:teamvisual/data/datasource/local/dao/assist_dao.dart';
import 'package:teamvisual/data/datasource/local/dao/assist_type_dao.dart';
import 'package:teamvisual/data/datasource/local/dao/course_dao.dart';
import 'package:teamvisual/data/datasource/local/dao/file_dao.dart';
import 'package:teamvisual/data/datasource/local/dao/module_dao.dart';
import 'package:teamvisual/data/datasource/local/dao/question_dao.dart';
import 'package:teamvisual/data/datasource/local/dao/save_evaluation_dao.dart';
import 'package:teamvisual/data/datasource/local/dao/video_dao.dart';
import 'package:teamvisual/domain/model/alternative_entity.dart';
import 'package:teamvisual/domain/model/assist_entity.dart';
import 'package:teamvisual/domain/model/evaluation_entity.dart';
import 'package:teamvisual/domain/model/file_entity.dart';
import 'package:teamvisual/domain/model/module_entity.dart';
import 'package:teamvisual/domain/model/question_entity.dart';
import 'package:teamvisual/domain/model/save_evaluation_entity.dart';
import 'package:teamvisual/domain/model/video_entity.dart';
import '../../../domain/model/assist_type_entity.dart';
import '../../../domain/model/course_entity.dart';
import 'dao/evaluation_dao.dart';
part 'app_database.g.dart'; // the generated code will be there

@Database(
    version: 1,
    entities: [
      AssistTypeEntity,
      ModuleEntity,
      AssistEntity,
      CourseEntity,
      EvaluationEntity,
      VideoEntity,
      FileEntity,
      QuestionEntity,
      AlternativeEntity,
      SaveEvaluationEntity,
    ],
)
abstract class AppDatabase extends FloorDatabase {
  AssistTypeDao get assistTypeDao;
  ModuleDao get moduleDao;
  AssistDao get assistDao;
  CourseDao get courseDao;
  EvaluationDao get evaluationDao;
  VideoDao get videoDao;
  FileDao get fileDao;
  QuestionDao get questionDao;
  AlternativeDao get alternativeDao;
  SaveEvaluationDao get saveEvaluationDao;
}