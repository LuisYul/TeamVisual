import 'package:floor/floor.dart';
import 'package:teamvisual/data/datasource/local/dao/base_dao.dart';
import 'package:teamvisual/domain/model/question_entity.dart';
import 'package:teamvisual/presentation/utils/app_constants.dart';

@dao
abstract class QuestionDao implements BaseDao<QuestionEntity> {

  @Query('SELECT * FROM ${AppConstants.tableQuestion}')
  Future<List<QuestionEntity>> getAll();

  @Query('SELECT * FROM ${AppConstants.tableQuestion} '
      'WHERE evaluationId = :evaluationId')
  Future<List<QuestionEntity>> getByEvaluationId(int evaluationId);

  @Query('DELETE FROM ${AppConstants.tableQuestion}')
  Future<void> deleteAll();

}