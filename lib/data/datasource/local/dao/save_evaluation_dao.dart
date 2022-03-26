import 'package:floor/floor.dart';
import 'package:teamvisual/data/datasource/local/dao/base_dao.dart';
import 'package:teamvisual/presentation/utils/app_constants.dart';
import '../../../../domain/model/save_evaluation_entity.dart';

@dao
abstract class SaveEvaluationDao implements BaseDao<SaveEvaluationEntity> {

  @Query('SELECT * FROM ${AppConstants.tableSaveEvaluation}')
  Future<List<SaveEvaluationEntity>> getAll();

  @Query('DELETE FROM ${AppConstants.tableSaveEvaluation}')
  Future<void> deleteAll();

  @Query('SELECT COUNT(*) FROM ${AppConstants.tableSaveEvaluation}')
  Future<int?> getTotalRows();

}