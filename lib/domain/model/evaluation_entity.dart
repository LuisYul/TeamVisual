import 'package:floor/floor.dart';
import 'package:teamvisual/presentation/utils/app_constants.dart';

@Entity(tableName: AppConstants.tableEvaluation)
class EvaluationEntity {

  @primaryKey
  final int id;
  final int userId;
  final int courseId;
  final String name;
  final int maxNote;
  final int minNote;
  final int questionId;
  final String question;
  final int note;
  final int questionTypeId;
  final int questionOrder;
  final String type;
  final int alternativeId;
  final String alternative;
  final int correct;
  final int alternativeOrder;

  const EvaluationEntity({
    required this.id,
    required this.userId,
    required this.courseId,
    required this.name,
    required this.maxNote,
    required this.minNote,
    required this.questionId,
    required this.question,
    required this.note,
    required this.questionTypeId,
    required this.questionOrder,
    required this.type,
    required this.alternativeId,
    required this.alternative,
    required this.correct,
    required this.alternativeOrder,
  });

}