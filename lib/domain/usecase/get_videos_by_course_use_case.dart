import 'package:teamvisual/domain/model/video_entity.dart';
import 'package:teamvisual/domain/repository/app_repository.dart';
import 'package:teamvisual/domain/usecase/base_use_case.dart';

class GetVideosByCourseUseCase implements BaseUseCase<List<VideoEntity>, dynamic> {

  final AppRepository _repository;

  const GetVideosByCourseUseCase(this._repository);

  @override
  Future<List<VideoEntity>> call(params) async{
    return await _repository.getVideosByCourse(params);
  }

}