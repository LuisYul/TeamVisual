import 'package:teamvisual/domain/model/question_entity.dart';
import 'package:teamvisual/domain/repository/app_repository.dart';
import 'package:teamvisual/domain/usecase/base_use_case.dart';

class GetQuestionByEvaluationUseCase implements
    BaseUseCase<List<QuestionEntity>, dynamic> {

  final AppRepository _repository;

  const GetQuestionByEvaluationUseCase(this._repository);

  @override
  Future<List<QuestionEntity>> call(params) async{
    return await _repository.getQuestionsByEvaluation(params);
  }

}