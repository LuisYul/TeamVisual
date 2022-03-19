import 'package:floor/floor.dart';
import 'package:teamvisual/presentation/utils/app_constants.dart';

@Entity(tableName: AppConstants.tableFile)
class FileEntity {

  @primaryKey
  final int id;

  const FileEntity({
    required this.id,
  });

}