import 'package:floor/floor.dart';
import 'package:teamvisual/data/datasource/local/dao/base_dao.dart';
import 'package:teamvisual/domain/model/assist_entity.dart';
import 'package:teamvisual/presentation/utils/app_constants.dart';

@dao
abstract class AssistDao implements BaseDao<AssistEntity> {

  @Query('SELECT * FROM ${AppConstants.tableAssist}')
  Future<List<AssistEntity>> getAll();

  @Query('DELETE FROM ${AppConstants.tableAssist}')
  Future<void> deleteAll();

  @Query('SELECT COUNT(*) FROM ${AppConstants.tableAssist}')
  Future<int?> getTotalRows();

}