import 'package:floor/floor.dart';
import 'package:teamvisual/presentation/utils/app_constants.dart';

@Entity(tableName: AppConstants.tableVideo)
class VideoEntity {

  @primaryKey
  final int id;
  final int userId;
  final int courseId;
  final String videoFile;
  final String name;

  const VideoEntity({
    required this.id,
    required this.userId,
    required this.courseId,
    required this.videoFile,
    required this.name,
  });

}