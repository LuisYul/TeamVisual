import 'package:floor/floor.dart';
import 'package:teamvisual/data/datasource/local/dao/base_dao.dart';
import 'package:teamvisual/domain/model/assist_type_entity.dart';
import 'package:teamvisual/presentation/utils/app_constants.dart';

@dao
abstract class AssistTypeDao implements BaseDao<AssistTypeEntity> {

  @Query('SELECT * FROM ${AppConstants.tableAssistType}')
  Future<List<AssistTypeEntity>> getAll();

  @Query('DELETE FROM ${AppConstants.tableAssistType}')
  Future<void> deleteAll();

}