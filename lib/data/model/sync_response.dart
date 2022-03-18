import 'package:teamvisual/data/model/assist_type_response.dart' ;
import 'package:teamvisual/data/model/module_response.dart';

class SyncResponse {

  String? status;
  AssistTypeResponse? assistTypes;
  ModuleResponse? modules;

  SyncResponse({
    required this.status,
    required this.assistTypes,
    required this.modules,
  });

  factory SyncResponse.fromMap(Map<String, dynamic> json) {
    return SyncResponse(
      status: json['estadoSincro'],
      assistTypes: AssistTypeResponse.fromMap(json['tipo_asistencia']),
      modules: ModuleResponse.fromMap(json['modulos']),
    );
  }

}