import 'package:floor/floor.dart';
import 'package:teamvisual/data/datasource/local/dao/base_dao.dart';
import 'package:teamvisual/domain/model/assistance_type_entity.dart';
import 'package:teamvisual/presentation/utils/app_constants.dart';

@dao
abstract class AssistanceTypeDao implements BaseDao<AssistanceTypeEntity> {

  @Query('SELECT * FROM ${AppConstants.tableAssistanceType}')
  Future<List<AssistanceTypeEntity>> getAll();

  @Query('DELETE FROM ${AppConstants.tableAssistanceType}')
  Future<void> deleteAll();

}