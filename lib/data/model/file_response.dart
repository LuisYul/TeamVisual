class FileResponse {

  List<Data?> data;
  int? size;
  String? title;

  FileResponse({
    required this.data,
    required this.size,
    required this.title,
  });

  factory FileResponse.fromMap(Map<String, dynamic> json) {
    return FileResponse(
      data: List<Data>.from(json['data'].map((model) => Data.fromMap(model))),
      size: json['size'],
      title: json['title'],
    );
  }

}

class Data {

  final int? id;
  final int? userId;
  final int? courseId;
  final String? path;
  final String? name;

  const Data({
    required this.id,
    required this.userId,
    required this.courseId,
    required this.path,
    required this.name,
  });

  factory Data.fromMap(Map<String?, dynamic> json) {
    return Data(
      id: json['idMaterial'],
      userId: json['idUsuario'],
      courseId: json['idCurso'],
      path: json['archivoRuta'],
      name: json['nombre'],
    );
  }
}