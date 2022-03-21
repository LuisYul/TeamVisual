import 'package:floor/floor.dart';
import 'package:teamvisual/data/datasource/local/dao/base_dao.dart';
import 'package:teamvisual/domain/model/course_entity.dart';
import 'package:teamvisual/presentation/utils/app_constants.dart';

@dao
abstract class CourseDao implements BaseDao<CourseEntity> {

  @Query('SELECT * FROM ${AppConstants.tableCourse}')
  Future<List<CourseEntity>> getAll();

  @Query('SELECT * FROM ${AppConstants.tableCourse} WHERE userId = :userId')
  Future<List<CourseEntity>> getByUserId(int userId);

  @Query('DELETE FROM ${AppConstants.tableCourse}')
  Future<void> deleteAll();

}