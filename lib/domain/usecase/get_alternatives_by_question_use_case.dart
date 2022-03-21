import 'package:teamvisual/domain/model/alternative_entity.dart';
import 'package:teamvisual/domain/repository/app_repository.dart';
import 'package:teamvisual/domain/usecase/base_use_case.dart';

class GetAlternativesByQuestionUseCase implements
    BaseUseCase<List<AlternativeEntity>, dynamic> {

  final AppRepository _repository;

  const GetAlternativesByQuestionUseCase(this._repository);

  @override
  Future<List<AlternativeEntity>> call(params) async{
    return await _repository.getAlternativesByQuestion(params);
  }

}