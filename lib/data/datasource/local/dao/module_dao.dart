import 'package:floor/floor.dart';
import 'package:teamvisual/data/datasource/local/dao/base_dao.dart';
import 'package:teamvisual/domain/model/module_entity.dart';
import 'package:teamvisual/presentation/utils/app_constants.dart';

@dao
abstract class ModuleDao implements BaseDao<ModuleEntity> {

  @Query('SELECT * FROM ${AppConstants.tableModule}')
  Future<List<ModuleEntity>> getAll();

  @Query('DELETE FROM ${AppConstants.tableModule}')
  Future<void> deleteAll();

}