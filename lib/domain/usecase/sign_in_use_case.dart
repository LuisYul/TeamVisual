import 'package:teamvisual/domain/model/user_entity.dart';
import 'package:teamvisual/domain/repository/app_repository.dart';
import 'package:teamvisual/domain/usecase/base_use_case.dart';

class SignInUseCase implements BaseUseCase<UserEntity, dynamic> {

  final AppRepository _repository;

  const SignInUseCase(this._repository);

  @override
  Future<UserEntity> call(params) async {
    return await _repository.signIn(params);
  }

}