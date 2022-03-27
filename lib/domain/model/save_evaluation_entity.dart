import 'dart:convert';

import 'package:floor/floor.dart';
import 'package:teamvisual/presentation/utils/app_constants.dart';

class SaveEvaluationListEntity {

  final List<SaveEvaluationEntity> evaluations;

  const SaveEvaluationListEntity({
    required this.evaluations,
  });

  Map<String, dynamic> toRequest() => {
    'evaluaciones': jsonEncode(evaluations),
  };

}

@Entity(tableName: AppConstants.tableSaveEvaluation)
class SaveEvaluationEntity {
  @PrimaryKey(autoGenerate: true)
  int? id;
  final int userCourseId;
  final int questionId;
  final int? alternativeId;
  final int score;

  SaveEvaluationEntity({
    required this.userCourseId,
    required this.questionId,
    required this.alternativeId,
    required this.score,
  });

  Map<String, dynamic> toJson() => {
    'idUsuarioCurso': userCourseId,
    'idPregunta': questionId,
    'idAlternativa': alternativeId,
    'puntaje': score,
  };
}

