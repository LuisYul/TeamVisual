import 'package:floor/floor.dart';
import 'package:teamvisual/data/datasource/local/dao/base_dao.dart';
import 'package:teamvisual/domain/model/alternative_entity.dart';
import 'package:teamvisual/presentation/utils/app_constants.dart';

@dao
abstract class AlternativeDao implements BaseDao<AlternativeEntity> {

  @Query('SELECT * FROM ${AppConstants.tableAlternative}')
  Future<List<AlternativeEntity>> getAll();

  @Query('DELETE FROM ${AppConstants.tableAlternative}')
  Future<void> deleteAll();

}