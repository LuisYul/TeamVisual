import 'package:teamvisual/domain/model/evaluation_entity.dart';
import 'package:teamvisual/domain/repository/app_repository.dart';
import 'package:teamvisual/domain/usecase/base_use_case.dart';

class GetEvaluationByCourseUseCase implements
    BaseUseCase<List<EvaluationEntity>, dynamic> {

  final AppRepository _repository;

  const GetEvaluationByCourseUseCase(this._repository);

  @override
  Future<List<EvaluationEntity>> call(params) async{
    return await _repository.getEvaluationsByCourse(params);
  }

}