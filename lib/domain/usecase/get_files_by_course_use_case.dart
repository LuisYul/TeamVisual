import 'package:teamvisual/domain/model/file_entity.dart';
import 'package:teamvisual/domain/repository/app_repository.dart';
import 'package:teamvisual/domain/usecase/base_use_case.dart';

class GetFilesByCourseUseCase implements
    BaseUseCase<List<FileEntity>, dynamic> {

  final AppRepository _repository;

  const GetFilesByCourseUseCase(this._repository);

  @override
  Future<List<FileEntity>> call(params) async{
    return await _repository.getFilesByCourse(params);
  }

}