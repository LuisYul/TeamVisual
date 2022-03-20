import 'package:floor/floor.dart';
import 'package:teamvisual/presentation/utils/app_constants.dart';

@Entity(tableName: AppConstants.tableEvaluation)
class EvaluationEntity {

  @primaryKey
  final int id;
  final int userId;
  final int userCourseId;
  final int courseId;
  final String name;
  final int maxNote;
  final int minNote;

  const EvaluationEntity({
    required this.id,
    required this.userId,
    required this.userCourseId,
    required this.courseId,
    required this.name,
    required this.maxNote,
    required this.minNote,
  });

}