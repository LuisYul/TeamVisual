import 'package:floor/floor.dart';
import 'package:teamvisual/data/datasource/local/dao/base_dao.dart';
import 'package:teamvisual/domain/model/video_entity.dart';
import 'package:teamvisual/presentation/utils/app_constants.dart';

@dao
abstract class VideoDao implements BaseDao<VideoEntity> {

  @Query('SELECT * FROM ${AppConstants.tableVideo}')
  Future<List<VideoEntity>> getAll();

  @Query('DELETE FROM ${AppConstants.tableVideo}')
  Future<void> deleteAll();

}