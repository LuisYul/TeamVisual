import 'package:floor/floor.dart';
import 'package:teamvisual/presentation/utils/app_constants.dart';

@Entity(tableName: AppConstants.tableAlternative)
class AlternativeEntity {

  @primaryKey
  final int id;
  final int questionId;
  final String alternative;
  final int correct;
  final int order;

  const AlternativeEntity({
    required this.id,
    required this.questionId,
    required this.alternative,
    required this.correct,
    required this.order,
  });

}