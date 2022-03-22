import 'package:teamvisual/domain/repository/app_repository.dart';
import 'package:teamvisual/domain/usecase/base_use_case.dart';

class SendEvaluationsUseCase implements BaseUseCase<bool, dynamic> {

  final AppRepository _repository;

  const SendEvaluationsUseCase(this._repository);

  @override
  Future<bool> call(params) {
    return _repository.sendEvaluations(params);
  }

}