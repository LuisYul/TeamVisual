import 'package:teamvisual/domain/repository/app_repository.dart';
import 'package:teamvisual/domain/usecase/base_use_case.dart';

class SendAssistsPendingUseCase implements BaseUseCase<bool, dynamic> {

  final AppRepository _repository;

  const SendAssistsPendingUseCase(this._repository);

  @override
  Future<bool> call(params) async {
    return await _repository.sendAssistsPending();
  }

}