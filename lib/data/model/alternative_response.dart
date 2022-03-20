class AlternativeResponse {

  List<Data?> data;
  int? size;
  String? title;

  AlternativeResponse({
    required this.data,
    required this.size,
    required this.title,
  });

  factory AlternativeResponse.fromMap(Map<String, dynamic> json) {
    return AlternativeResponse(
      data: List<Data>.from(json['data'].map((model) => Data.fromMap(model))),
      size: json['size'],
      title: json['title'],
    );
  }

}

class Data {
  final int id;
  final int questionId;
  final String alternative;
  final int correct;
  final int order;

  const Data({
    required this.id,
    required this.questionId,
    required this.alternative,
    required this.correct,
    required this.order,
  });

  factory Data.fromMap(Map<String?, dynamic> json) {
    return Data(
      id: json['idAlternativa'],
      questionId: json['idPregunta'],
      alternative: json['alternativa'],
      correct: json['correcta'],
      order: json['ordenAlternativa'],
    );
  }
}