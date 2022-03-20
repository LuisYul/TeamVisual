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
  final int userCourseId;
  final int courseId;
  final String name;
  final int maxNote;
  final int minNote;

  const Data({
    required this.id,
    required this.userId,
    required this.userCourseId,
    required this.courseId,
    required this.name,
    required this.maxNote,
    required this.minNote,
  });

  factory Data.fromMap(Map<String?, dynamic> json) {
    return Data(
      id: json['idUsuario'],
      userId: json['idEvaluacion'],
      userCourseId: json['idUsuarioCurso'],
      courseId: json['idCurso'],
      name: json['nombre'],
      maxNote: json['notaMax'],
      minNote: json['notaMin'],
    );
  }
}