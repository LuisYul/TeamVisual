import 'package:teamvisual/domain/model/module_entity.dart';
import 'package:teamvisual/domain/repository/app_repository.dart';
import 'package:teamvisual/domain/usecase/base_use_case.dart';

class GetModulesUseCase implements BaseUseCase<List<ModuleEntity>, dynamic> {

  final AppRepository _repository;

  const GetModulesUseCase(this._repository);

  @override
  Future<List<ModuleEntity>> call(params) async{
    return await _repository.getModules();
  }

}