import 'package:teamvisual/domain/repository/app_repository.dart';
import 'package:teamvisual/domain/usecase/base_use_case.dart';

class DeleteTablesUseCase implements BaseUseCase<void, dynamic>{

  final AppRepository _repository;

  const DeleteTablesUseCase(this._repository);

  @override
  Future<void> call(params) async {
    return await  _repository.deleteTables();
  }

}