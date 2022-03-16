import 'dart:convert';

import '../../presentation/utils/app_constants.dart';

class SyncEntity {

  final List<TableEntity> tables;
  final ParamsEntity params;

  const SyncEntity({
    required this.tables,
    required this.params,
  });

  Map<String, dynamic> toJson() => {
    'tables': jsonEncode(tables),
    'params': jsonEncode(params),
  };

}

class TableEntity {
  final String name;
  final String show;

  const TableEntity({
    required this.name,
    required this.show,
  });

  Map<String, dynamic> toJson() => {
    'name': name,
    'show': show,
  };

  static List<TableEntity> get tablesSync =>
      [
        const TableEntity(name: AppConstants.tableAssistanceType, show: "true"),
        const TableEntity(name: AppConstants.tableModules, show: "true"),
      ];
}

class ParamsEntity {
  final String idUser;
  final String idApp;
  final String idUserType;

  const ParamsEntity({
    required this.idUser,
    required this.idApp,
    required this.idUserType,
  });

  Map<String, dynamic> toJson() => {
    'idUsuario': idUser,
    'idAplicacion': idApp,
    'idTipoUsuario': idUserType,
  };
}
