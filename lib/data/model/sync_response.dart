import 'package:teamvisual/data/model/assist_type_response.dart' ;
import 'package:teamvisual/data/model/evaluation_response.dart';
import 'package:teamvisual/data/model/module_response.dart';
import 'package:teamvisual/data/model/video_responde.dart';

import 'course_response.dart';

class SyncResponse {

  String? status;
  AssistTypeResponse? assistTypes;
  ModuleResponse? modules;
  CourseResponse? courses;
  VideoResponse? videos;
  EvaluationResponse? evaluations;

  SyncResponse({
    required this.status,
    required this.assistTypes,
    required this.modules,
    required this.courses,
    required this.videos,
    required this.evaluations,
  });

  factory SyncResponse.fromMap(Map<String, dynamic> json) {
    return SyncResponse(
      status: json['estadoSincro'],
      assistTypes: AssistTypeResponse.fromMap(json['tipo_asistencia']),
      modules: ModuleResponse.fromMap(json['modulos']),
      courses: CourseResponse.fromMap(json['lista_curso']),
      videos: VideoResponse.fromMap(json['lista_videos']),
      evaluations: EvaluationResponse.fromMap(json['lista_evaluaciones']),
    );
  }

}