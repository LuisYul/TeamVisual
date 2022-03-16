import 'package:teamvisual/data/model/assistance_type_response.dart' ;
import 'package:teamvisual/data/model/module_response.dart';

class SyncResponse {

  String? status;
  AssistanceTypeResponse? assistanceTypes;
  ModuleResponse? modules;

  SyncResponse({
    required this.status,
    required this.assistanceTypes,
    required this.modules,
  });

  factory SyncResponse.fromMap(Map<String, dynamic> json) {
    return SyncResponse(
      status: json['estadoSincro'],
      assistanceTypes: AssistanceTypeResponse.fromMap(json['tipo_asistencia']),
      modules: ModuleResponse.fromMap(json['modulos']),
    );
  }

}