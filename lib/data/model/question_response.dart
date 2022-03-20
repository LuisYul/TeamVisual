class QuestionResponse {

  List<Data?> data;
  int? size;
  String? title;

  QuestionResponse({
    required this.data,
    required this.size,
    required this.title,
  });

  factory QuestionResponse.fromMap(Map<String, dynamic> json) {
    return QuestionResponse(
      data: List<Data>.from(json['data'].map((model) => Data.fromMap(model))),
      size: json['size'],
      title: json['title'],
    );
  }

}

class Data {
  final int id;
  final String question;
  final int evaluationId;
  final int note;
  final int questionTypeId;
  final int questionOrder;
  final String type;

  const Data({
    required this.id,
    required this.question,
    required this. evaluationId,
    required this.note,
    required this.questionTypeId,
    required this.questionOrder,
    required this.type,
  });

  factory Data.fromMap(Map<String?, dynamic> json) {
    return Data(
      id: json['idPregunta'],
      question: json['pregunta'],
      evaluationId: json['idEvaluacion'],
      note: json['nota'],
      questionTypeId: json['idTipoPregunta'],
      questionOrder: json['ordenPregunta'],
      type: json['tipo'],
    );
  }
}