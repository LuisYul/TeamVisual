import 'package:floor/floor.dart';
import 'package:teamvisual/presentation/utils/app_constants.dart';

@Entity(tableName: AppConstants.tableModules)
class ModuleEntity {
  @primaryKey
  final int id;
  final String name;
  final int required;
  final int order;

  const ModuleEntity({
    required this.id,
    required this.name,
    required this.required,
    required this.order,
  });

  factory ModuleEntity.fromMap(Map<String, dynamic> json) {
    return ModuleEntity(
      id: json['id'],
      name: json['name'],
      required: json['required'],
      order: json['order'],
    );
  }

}