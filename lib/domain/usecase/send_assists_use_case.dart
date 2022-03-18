import 'package:teamvisual/domain/repository/app_repository.dart';
import 'package:teamvisual/domain/usecase/base_use_case.dart';

class SendAssistsUseCase implements BaseUseCase<bool, dynamic> {

  final AppRepository _repository;

  const SendAssistsUseCase(this._repository);

  @override
  Future<bool> call(params) async{
    return await _repository.sendAssists(params);
  }

}