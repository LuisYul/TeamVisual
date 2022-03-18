import 'dart:convert';

import 'package:teamvisual/domain/model/assist_entity.dart';

class AssistListEntity {

  final List<AssistEntity> assists;

  const AssistListEntity({
    required this.assists,
  });

  Map<String, dynamic> toRequest() => {
    'asistencia': jsonEncode(assists),
  };

}