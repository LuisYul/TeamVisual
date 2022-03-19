class VideoResponse {

  List<Data?> data;
  int? size;
  String? title;

  VideoResponse({
    required this.data,
    required this.size,
    required this.title,
  });

  factory VideoResponse.fromMap(Map<String, dynamic> json) {
    return VideoResponse(
      data: List<Data>.from(json['data'].map((model) => Data.fromMap(model))),
      size: json['size'],
      title: json['title'],
    );
  }

}

class Data {

  final int? userId;
  final int? videoId;
  final int? courseId;
  final String? videoFile;
  final String? name;

  const Data({
    required this.userId,
    required this.videoId,
    required this.courseId,
    required this.videoFile,
    required this.name,
  });

  factory Data.fromMap(Map<String?, dynamic> json) {
    return Data(
      userId: json['idUsuario'],
      videoId: json['idVideo'],
      courseId: json['idCurso'],
      videoFile: json['archivoVideo'],
      name: json['nombre'],
    );
  }
}