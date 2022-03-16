import 'package:floor/floor.dart';
import 'package:teamvisual/presentation/utils/app_constants.dart';

@Entity(tableName: AppConstants.tableAssistanceType)
class AssistanceTypeEntity {
  @primaryKey
  final int id;
  final String name;
  final int order;

  const AssistanceTypeEntity({
    required this.id,
    required this.name,
    required this.order,
  });

  factory AssistanceTypeEntity.fromMap(Map<String, dynamic> json) {
    return AssistanceTypeEntity(
      id: json['id'],
      name: json['name'],
      order: json['order'],
    );
  }

}