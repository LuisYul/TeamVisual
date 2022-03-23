class CourseResponse {

  List<Data?> data;
  int? size;
  String? title;

  CourseResponse({
    required this.data,
    required this.size,
    required this.title,
  });

  factory CourseResponse.fromMap(Map<String, dynamic> json) {
    return CourseResponse(
      data: List<Data>.from(json['data'].map((model) => Data.fromMap(model))),
      size: json['size'],
      title: json['title'],
    );
  }

}

class Data {
  final int? userId;
  final String? startDate;
  final String? endDate;
  final int? note;
  final int? advPercent;
  final int? specAreaId;
  final String? specArea;
  final int? learningGroupId;
  final String? learningGroup;
  final int? courseId;
  final String? course;
  final String? author;
  final String? resume;
  final int? totalFiles;

  const Data({
    required this.userId,
    required this.startDate,
    required this.endDate,
    required this.note,
    required this.advPercent,
    required this.specAreaId,
    required this.specArea,
    required this.learningGroupId,
    required this.learningGroup,
    required this.courseId,
    required this.course,
    required this.author,
    required this.resume,
    required this.totalFiles,
  });

  factory Data.fromMap(Map<String?, dynamic> json) {
    return Data(
      userId: json['idUsuario'],
      startDate: json['fecInicio'],
      endDate: json['fecFin'],
      note: json['nota'],
      advPercent: json['porcentajeAvance'],
      specAreaId: json['idAreaEspecializacion '],
      specArea: json['areaEspecializacion'],
      learningGroupId: json['idGrupoAprendizaje'],
      learningGroup: json['grupoAprendizaje'],
      courseId: json['idCurso'],
      course: json['curso'],
      author: json['autor'],
      resume: json['resumen'],
      totalFiles: json['cantidadArchivos'],
    );
  }
}