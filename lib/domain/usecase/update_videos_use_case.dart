import 'package:teamvisual/domain/repository/app_repository.dart';
import 'package:teamvisual/domain/usecase/base_use_case.dart';

class UpdateVideosUseCase implements BaseUseCase<int, dynamic> {

  final AppRepository _repository;

  const UpdateVideosUseCase(this._repository);

  @override
  Future<int> call(params) async {
    return await _repository.updateVideos(params);
  }

}