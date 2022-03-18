import 'dart:async';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;
import 'package:teamvisual/data/datasource/local/dao/assist_dao.dart';
import 'package:teamvisual/data/datasource/local/dao/assist_type_dao.dart';
import 'package:teamvisual/data/datasource/local/dao/module_dao.dart';
import 'package:teamvisual/domain/model/assist_entity.dart';
import 'package:teamvisual/domain/model/module_entity.dart';
import '../../../domain/model/assist_type_entity.dart';
part 'app_database.g.dart'; // the generated code will be there

@Database(
    version: 1,
    entities: [
      AssistTypeEntity,
      ModuleEntity,
      AssistEntity,
    ],
)
abstract class AppDatabase extends FloorDatabase {
  AssistTypeDao get assistTypeDao;
  ModuleDao get moduleDao;
  AssistDao get assistDao;
}