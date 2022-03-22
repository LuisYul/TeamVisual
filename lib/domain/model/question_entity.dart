import 'package:floor/floor.dart';
import 'package:teamvisual/presentation/utils/app_constants.dart';

@Entity(tableName: AppConstants.tableQuestion)
class QuestionEntity {

  @primaryKey
  final int id;
  final String question;
  final int evaluationId;
  final int userCourseId;
  final int note;
  final int questionTypeId;
  final int questionOrder;
  final String type;

  const QuestionEntity({
    required this.id,
    required this.question,
    required this.evaluationId,
    required this.userCourseId,
    required this.note,
    required this.questionTypeId,
    required this.questionOrder,
    required this.type,
  });

}