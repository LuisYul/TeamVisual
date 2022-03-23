import 'package:teamvisual/domain/usecase/base_use_case.dart';

import '../repository/app_repository.dart';

class GetAllPendingUseCase implements BaseUseCase<List<int>, dynamic> {

  final AppRepository _repository;

  const GetAllPendingUseCase(this._repository);

  @override
  Future<List<int>> call(params) async {
    return await _repository.getAllPending();
  }

}