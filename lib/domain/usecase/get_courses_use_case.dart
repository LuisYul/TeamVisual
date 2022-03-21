import 'package:teamvisual/domain/model/course_entity.dart';
import 'package:teamvisual/domain/repository/app_repository.dart';
import 'package:teamvisual/domain/usecase/base_use_case.dart';

class GetCoursesUseCase implements BaseUseCase<List<CourseEntity>, dynamic> {

  final AppRepository _repository;

  const GetCoursesUseCase(this._repository);

  @override
  Future<List<CourseEntity>> call(params) async{
    return await _repository.getCourses();
  }

}