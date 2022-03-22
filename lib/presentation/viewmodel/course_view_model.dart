import 'package:teamvisual/domain/model/course_entity.dart';
import 'package:teamvisual/domain/usecase/get_courses_use_case.dart';
import 'package:teamvisual/presentation/base/root_view_model.dart';
import '../../domain/usecase/get_files_by_course_use_case.dart';
import '../../domain/usecase/get_videos_by_course_use_case.dart';

class CourseViewModel extends RootViewModel {

  final GetCoursesUseCase _getCoursesUseCase;
  final GetVideosByCourseUseCase _getVideosByCourseUseCase;
  final GetFilesByCourseUseCase _getFilesByCourseUseCase;

  CourseViewModel(
      this._getCoursesUseCase,
      this._getVideosByCourseUseCase,
      this._getFilesByCourseUseCase,
  );

  List<CourseEntity> _courses = [];
  List<CourseEntity> get courses => _courses;

  @override
  initialize() {
    _getCourses();
  }

  void _getCourses() async{
    showProgress();
    final result = await runBusyFuture(_getCoursesUseCase.call(""),
        busyObject: "error_get_courses");
    if(result.isNotEmpty) {
      _courses = result;
      notify();
    }
    hideProgress();
  }

  void onClickFiles(CourseEntity course) async {
    final result = await runBusyFuture(_getFilesByCourseUseCase
        .call(course.id), busyObject: "error_get_files");
    if(result.isNotEmpty) {
      pt("files $result");
    //  notify();
    }
  }

  void onClickCourse(CourseEntity course) async {
    final result = await runBusyFuture(_getVideosByCourseUseCase
        .call(course.id), busyObject: "error_get_videos");
    navigationService.navigateTo('/course_detail',
        arguments: {'course': course, 'video': result.first});
  }

}