class EvaluationResponse {

  List<Data?> data;
  int? size;
  String? title;

  EvaluationResponse({
    required this.data,
    required this.size,
    required this.title,
  });

  factory EvaluationResponse.fromMap(Map<String, dynamic> json) {
    return EvaluationResponse(
      data: List<Data>.from(json['data'].map((model) => Data.fromMap(model))),
      size: json['size'],
      title: json['title'],
    );
  }

}

class Data {
  final int id;
  final int userId;
  final int courseId;
  final String name;
  final int maxNote;
  final int minNote;
  final int questionId;
  final String question;
  final int note;
  final int questionTypeId;
  final int questionOrder;
  final String type;
  final int alternativeId;
  final String alternative;
  final int correct;
  final int alternativeOrder;

  const Data({
    required this.id,
    required this.userId,
    required this.courseId,
    required this.name,
    required this.maxNote,
    required this.minNote,
    required this.questionId,
    required this.question,
    required this.note,
    required this.questionTypeId,
    required this.questionOrder,
    required this.type,
    required this.alternativeId,
    required this.alternative,
    required this.correct,
    required this.alternativeOrder,
  });

  factory Data.fromMap(Map<String?, dynamic> json) {
    return Data(
      id: json['idUsuario'],
      userId: json['idEvaluacion'],
      courseId: json['idCurso'],
      name: json['nombre'],
      maxNote: json['notaMax'],
      minNote: json['notaMin'],
      questionId: json['idPregunta'],
      question: json['pregunta'],
      note: json['nota'],
      questionTypeId: json['idTipoPregunta'],
      questionOrder: json['ordenPregunta'],
      type: json['tipo'],
      alternativeId: json['idAlternativa'],
      alternative: json['alternativa'],
      correct: json['correcta'],
      alternativeOrder: json['ordenAlternativa'],
    );
  }
}