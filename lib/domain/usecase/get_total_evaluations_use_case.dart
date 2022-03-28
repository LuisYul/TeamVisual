import 'package:teamvisual/domain/repository/app_repository.dart';
import 'package:teamvisual/domain/usecase/base_use_case.dart';

class GetTotalEvaluationsUseCase implements BaseUseCase<int, dynamic> {

  final AppRepository _repository;

  const GetTotalEvaluationsUseCase(this._repository);

  @override
  Future<int> call(params) async{
    return await _repository.getTotalEvaluations();
  }

}