import 'package:teamvisual/domain/model/assistance_type_entity.dart';
import 'package:teamvisual/domain/repository/app_repository.dart';
import 'package:teamvisual/domain/usecase/base_use_case.dart';

class GetAssistanceTypesUseCase implements
    BaseUseCase<List<AssistanceTypeEntity>, dynamic> {

  final AppRepository _repository;

  GetAssistanceTypesUseCase(this._repository);

  @override
  Future<List<AssistanceTypeEntity>> call(params) async{
    return await _repository.getAssistanceTypes();
  }

}