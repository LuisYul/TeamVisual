class ModuleResponse {

  List<Data?> data;
  int? size;
  String? title;

  ModuleResponse({
    required this.data,
    required this.size,
    required this.title,
  });

  factory ModuleResponse.fromMap(Map<String, dynamic> json) {
    return ModuleResponse(
      data: List<Data>.from(json['data'].map((model) => Data.fromMap(model))),
      size: json['size'],
      title: json['title'],
    );
  }

}

class Data {
  int? id;
  String? name;
  int? required;
  int? order;

  Data({
    required this.id,
    required this.name,
    required this.required,
    required this.order,
  });

  factory Data.fromMap(Map<String, dynamic> json) {
    return Data(
      id: json['idModulo'],
      name: json['nombre'],
      required: json['obligatorio'],
      order: json['orden'],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'required': required,
    'order': order,
  };
}