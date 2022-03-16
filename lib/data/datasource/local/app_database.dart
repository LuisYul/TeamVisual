import 'dart:async';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;
import 'package:teamvisual/data/datasource/local/dao/assistance_type_dao.dart';
import 'package:teamvisual/data/datasource/local/dao/module_dao.dart';
import 'package:teamvisual/domain/model/module_entity.dart';
import '../../../domain/model/assistance_type_entity.dart';
part 'app_database.g.dart'; // the generated code will be there

@Database(
    version: 1,
    entities: [
      AssistanceTypeEntity,
      ModuleEntity,
    ],
)
abstract class AppDatabase extends FloorDatabase {
  AssistanceTypeDao get assistanceTypeDao;
  ModuleDao get moduleDao;
}