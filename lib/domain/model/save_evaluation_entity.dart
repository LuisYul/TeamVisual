import 'dart:convert';

class SaveEvaluationListEntity {

  final List<SaveEvaluationEntity> evaluations;

  const SaveEvaluationListEntity({
    required this.evaluations,
  });

  Map<String, dynamic> toRequest() => {
    'evaluaciones': jsonEncode(evaluations),
  };

}

class SaveEvaluationEntity {
  final int userCourseId;
  final int questionId;
  final int? alternativeId;
  final int score;

  const SaveEvaluationEntity({
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

