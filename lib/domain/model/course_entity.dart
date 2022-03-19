import 'package:floor/floor.dart';
import 'package:teamvisual/presentation/utils/app_constants.dart';

@Entity(tableName: AppConstants.tableCourse)
class CourseEntity {

  @primaryKey
  final int id;
  final String course;
  final String author;
  final String resume;
  final String userId;
  final String startDate;
  final String endDate;
  final String note;
  final int advPercent;
  final int specAreaId;
  final String specArea;
  final int learningGroupId;
  final String learningGroup;

  const CourseEntity({
    required this.id,
    required this.course,
    required this.author,
    required this.resume,
    required this.userId,
    required this.startDate,
    required this.endDate,
    required this.note,
    required this.advPercent,
    required this.specAreaId,
    required this.specArea,
    required this.learningGroupId,
    required this.learningGroup,
  });

}