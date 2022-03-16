class AssistanceTypeResponse {

  List<Data?> data;
  int? size;
  String? title;

  AssistanceTypeResponse({
    required this.data,
    required this.size,
    required this.title,
  });

  factory AssistanceTypeResponse.fromMap(Map<String, dynamic> json) {
    return AssistanceTypeResponse(
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

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'order': order,
  };
}