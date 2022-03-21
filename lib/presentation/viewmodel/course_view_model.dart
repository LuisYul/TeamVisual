import 'package:teamvisual/domain/model/course_entity.dart';
import 'package:teamvisual/domain/usecase/get_courses_use_case.dart';
import 'package:teamvisual/presentation/base/root_view_model.dart';
import '../../domain/usecase/get_videos_by_course_use_case.dart';

class CourseViewModel extends RootViewModel {

  final GetCoursesUseCase _getCoursesUseCase;
  final GetVideosByCourseUseCase _getVideosByCourseUseCase;

  CourseViewModel(
      this._getCoursesUseCase,
      this._getVideosByCourseUseCase,
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

  void _getVideos(CourseEntity course) async {
    final result = await runBusyFuture(_getVideosByCourseUseCase
        .call(course.id), busyObject: "error_get_videos");
    navigationService.navigateTo('/course_detail',
        arguments: {'course': course, 'video': result.first});
  }

  void onClickCourse(CourseEntity course) {
    _getVideos(course);
  }

}