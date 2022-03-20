import 'package:teamvisual/data/model/alternative_response.dart';
import 'package:teamvisual/data/model/assist_type_response.dart' ;
import 'package:teamvisual/data/model/evaluation_response.dart';
import 'package:teamvisual/data/model/module_response.dart';
import 'package:teamvisual/data/model/question_response.dart';
import 'package:teamvisual/data/model/video_responde.dart';
import 'course_response.dart';

class SyncResponse {

  String? status;
  AssistTypeResponse? assistTypes;
  ModuleResponse? modules;
  CourseResponse? courses;
  VideoResponse? videos;
  EvaluationResponse? evaluations;
  QuestionResponse? questions;
  AlternativeResponse? alternatives;

  SyncResponse({
    required this.status,
    required this.assistTypes,
    required this.modules,
    required this.courses,
    required this.videos,
    required this.evaluations,
    required this.questions,
    required this.alternatives,
  });

  factory SyncResponse.fromMap(Map<String, dynamic> json) {
    return SyncResponse(
      status: json['estadoSincro'],
      assistTypes: AssistTypeResponse.fromMap(json['tipo_asistencia']),
      modules: ModuleResponse.fromMap(json['modulos']),
      courses: CourseResponse.fromMap(json['lista_curso']),
      videos: VideoResponse.fromMap(json['lista_videos']),
      evaluations: EvaluationResponse.fromMap(json['lista_evaluaciones']),
     // evaluations: null,
      questions: QuestionResponse.fromMap(json['lista_preguntas']),
      alternatives: AlternativeResponse.fromMap(json['lista_alternativas']),
    );
  }

}