import 'package:teamvisual/domain/repository/app_repository.dart';
import 'package:teamvisual/domain/usecase/base_use_case.dart';

class SaveAssistUseCase implements BaseUseCase<int, dynamic> {

  final AppRepository _repository;

  const SaveAssistUseCase(this._repository);

  @override
  Future<int> call(params) {
    return _repository.saveAssist(params);
  }

}