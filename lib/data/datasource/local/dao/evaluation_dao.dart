import 'package:floor/floor.dart';
import 'package:teamvisual/data/datasource/local/dao/base_dao.dart';
import 'package:teamvisual/domain/model/evaluation_entity.dart';
import 'package:teamvisual/presentation/utils/app_constants.dart';

@dao
abstract class EvaluationDao implements BaseDao<EvaluationEntity> {

  @Query('SELECT * FROM ${AppConstants.tableEvaluation}')
  Future<List<EvaluationEntity>> getAll();

  @Query('SELECT * FROM ${AppConstants.tableEvaluation} WHERE courseId = :courseId')
  Future<List<EvaluationEntity>> getByCourseId(int courseId);

  @Query('DELETE FROM ${AppConstants.tableEvaluation}')
  Future<void> deleteAll();

  @Query('SELECT COUNT(*) FROM ${AppConstants.tableEvaluation}')
  Future<int?> getTotalRows();

}