import 'package:teamvisual/domain/repository/app_repository.dart';
import 'package:teamvisual/domain/usecase/base_use_case.dart';

class SaveEvaluationsUseCase implements BaseUseCase<List<int>, dynamic> {

  final AppRepository _repository;

  const SaveEvaluationsUseCase(this._repository);

  @override
  Future<List<int>> call(params) {
   return _repository.saveEvaluations(params);
  }

}