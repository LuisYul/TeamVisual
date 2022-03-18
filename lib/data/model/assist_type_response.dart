class AssistTypeResponse {

  List<Data?> data;
  int? size;
  String? title;

  AssistTypeResponse({
    required this.data,
    required this.size,
    required this.title,
  });

  factory AssistTypeResponse.fromMap(Map<String, dynamic> json) {
    return AssistTypeResponse(
      data: List<Data>.from(json['data'].map((model)=> Data.fromMap(model))),
      size: json['size'],
      title: json['title'],
    );
  }

}

class Data {
  int? id;
  String? name;
  int? order;

  Data({
    required this.id,
    required this.name,
    required this.order,
  });

  factory Data.fromMap(Map<String, dynamic> json) {
    return Data(
      id: json['idTipoAsistencia'],
      name: json['nombre'],
      order: json['orden'],
    );
  }

  Map<String, dynamic> toRequest() => {
    'id': id,
    'name': name,
    'order': order,
  };
}