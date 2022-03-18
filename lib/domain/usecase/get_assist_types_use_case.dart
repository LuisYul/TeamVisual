import 'package:teamvisual/domain/model/assist_type_entity.dart';
import 'package:teamvisual/domain/repository/app_repository.dart';
import 'package:teamvisual/domain/usecase/base_use_case.dart';

class GetAssistTypesUseCase implements
    BaseUseCase<List<AssistTypeEntity>, dynamic> {

  final AppRepository _repository;

  const GetAssistTypesUseCase(this._repository);

  @override
  Future<List<AssistTypeEntity>> call(params) async{
    return await _repository.getAssistTypes();
  }

}