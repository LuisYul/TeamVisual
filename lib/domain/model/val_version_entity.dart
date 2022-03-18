import '../../presentation/utils/app_constants.dart';

class ValVersionEntity {

  final String idApp;
  final String version;

  const ValVersionEntity({
    required this.idApp,
    required this.version,
  });

  Map<String, dynamic> toRequest() => {
    'idAplicacion': idApp,
    'version': version,
  };

  static ValVersionEntity get currentVersion =>
      ValVersionEntity(
        idApp: AppConstants.idApp.toString(),
        version: AppConstants.versionApp,
      );

}