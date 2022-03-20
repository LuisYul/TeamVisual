import 'package:floor/floor.dart';
import 'package:teamvisual/presentation/utils/app_constants.dart';

@Entity(tableName: AppConstants.tableAssistType)
class AssistTypeEntity {

  @primaryKey
  final int id;
  final String name;
  final int order;
  @ignore
  bool? current;
  @ignore
  int? index;

  AssistTypeEntity({
    required this.id,
    required this.name,
    required this.order,
    this.current,
    this.index,
  });

  factory AssistTypeEntity.fromMap(Map<String, dynamic> json) {
    return AssistTypeEntity(
      id: json['id'],
      name: json['name'],
      order: json['order'],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'order': order,
    'current': current,
    'index': index,
  };

}