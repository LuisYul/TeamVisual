import 'package:floor/floor.dart';
import 'package:teamvisual/presentation/utils/app_constants.dart';

@Entity(tableName: AppConstants.tableFile)
class FileEntity {

  @primaryKey
  final int id;
  final int userId;
  final int courseId;
  final String path;
  final String name;

  const FileEntity({
    required this.id,
    required this.userId,
    required this.courseId,
    required this.path,
    required this.name,
  });

}