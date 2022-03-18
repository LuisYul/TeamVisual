import 'package:floor/floor.dart';
import 'package:teamvisual/presentation/utils/app_constants.dart';

@Entity(tableName: AppConstants.tableAssist)
class AssistEntity {
  @PrimaryKey(autoGenerate: true)
  int? id;
  final String? userId;
  final String? userName;
  final String date;
  final String hour;
  final String lat;
  final String lng;
  final String? photoPath;
  final String idAssistType;
  final String obs;
  final String? idUserType;
  final String? userType;
  final String? numDoc;
  String? demo;
  @ignore
  String? photo;

  AssistEntity({
    required this.userId,
    required this.userName,
    required this.date,
    required this.hour,
    required this.lat,
    required this.lng,
    required this.photoPath,
    required this.idAssistType,
    required this.obs,
    required this.idUserType,
    required this.userType,
    required this.numDoc,
    this.demo,
    this.photo,
  });

  Map<String, dynamic> toJson() => {
    'idUsuario': userId,
    'nombreUsuario': userName,
    'fecha': date,
    'hora': hour,
    'latitud': lat,
    'longitud': lng,
    'foto': photo,
    'idTipoAsistencia': idAssistType,
    'observacion': obs,
    'idTipoUsuario': idUserType,
    'tipoUsuario': userType,
    'numDoc': numDoc,
    'demo': demo,
  };

}