import 'package:teamvisual/domain/repository/app_repository.dart';
import 'package:teamvisual/domain/usecase/base_use_case.dart';

class SendEvaluationsPendingUseCase implements BaseUseCase<bool, dynamic> {

  final AppRepository _repository;

  const SendEvaluationsPendingUseCase(this._repository);

  @override
  Future<bool> call(params) async {
    return await _repository.sendEvaluationsPending();
  }

}