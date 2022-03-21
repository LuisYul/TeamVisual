import 'package:floor/floor.dart';
import 'package:teamvisual/data/datasource/local/dao/base_dao.dart';
import 'package:teamvisual/domain/model/file_entity.dart';
import 'package:teamvisual/presentation/utils/app_constants.dart';

@dao
abstract class FileDao implements BaseDao<FileEntity> {

  @Query('SELECT * FROM ${AppConstants.tableFile}')
  Future<List<FileEntity>> getAll();

  @Query('SELECT * FROM ${AppConstants.tableFile} WHERE courseId = :courseId')
  Future<List<FileEntity>> getByCourseId(int courseId);

  @Query('DELETE FROM ${AppConstants.tableFile}')
  Future<void> deleteAll();

}