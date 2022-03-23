import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:teamvisual/domain/model/course_entity.dart';
import 'package:teamvisual/domain/model/evaluation_entity.dart';
import 'package:teamvisual/domain/usecase/download_file_use_case.dart';
import 'package:teamvisual/domain/usecase/get_courses_use_case.dart';
import 'package:teamvisual/presentation/base/root_view_model.dart';
import 'package:teamvisual/presentation/utils/app_constants.dart';
import '../../domain/model/file_entity.dart';
import '../../domain/usecase/get_evaluations_by_course_use_case.dart';
import '../../domain/usecase/get_files_by_course_use_case.dart';
import '../../domain/usecase/get_videos_by_course_use_case.dart';
import '../widgets/custom_dialog.dart';

class CourseViewModel extends RootViewModel {

  final GetCoursesUseCase _getCoursesUseCase;
  final GetEvaluationByCourseUseCase _getEvaluationByCourseUseCase;
  final GetVideosByCourseUseCase _getVideosByCourseUseCase;
  final GetFilesByCourseUseCase _getFilesByCourseUseCase;
  final DownloadFileUseCase _downloadFileUseCase;

  CourseViewModel(
      this._getEvaluationByCourseUseCase,
      this._getCoursesUseCase,
      this._getVideosByCourseUseCase,
      this._getFilesByCourseUseCase,
      this._downloadFileUseCase,
  );

  final LinkedHashMap _evaluations =
      LinkedHashMap<int, List<EvaluationEntity>>();
  LinkedHashMap get evaluations => _evaluations;

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
      _getEvaluations();
    }
    hideProgress();
  }

  void _getEvaluations() async {
    for(final i in _courses) {
      final result = await runBusyFuture(_getEvaluationByCourseUseCase
          .call(i.id), busyObject: "error_get_evaluations");
      _evaluations[i.id] = result;
    }
  }

  void onClickCourse(CourseEntity course) async {
    final result = await runBusyFuture(_getVideosByCourseUseCase
        .call(course.id), busyObject: "error_get_videos");
    navigationService.navigateTo('/course_detail',
        arguments: {'course': course, 'video': result.first});
  }

  void onClickFiles(CourseEntity course, BuildContext context) async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.storage,
    ].request();

    pt(statuses[Permission.storage].toString());

    if (await Permission.storage.isGranted) {
      final result = await runBusyFuture(_getFilesByCourseUseCase
          .call(course.id), busyObject: "error_get_files");
      if(result.isNotEmpty) {
        _downloadFiles(result, context);
      }
    }
  }

  void _downloadFiles(List<FileEntity> files, BuildContext context) async {
    showProgress();
    final finalFiles = files.takeWhile((e) => e.name.isNotEmpty);
    for(final i in finalFiles) {
      final result = await runBusyFuture(_downloadFileUseCase.call([i.path,
        i.name, AppConstants.downloadPath]), busyObject: "error_download_file");

      i.success = result.isNotEmpty;
    }

    String fileNames = "";
    for(final i in finalFiles) {
      if(true == i.success) {
        fileNames += "\n- ${i.name}";
      }
    }
    hideProgress();

    if(fileNames.isEmpty) {
      setErrorMsg("No se descargó ningun documento.");
    }

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) => CustomDialog(
        title: "Atención",
        description: 'Se descargaron los siguientes archivos en la '
            'carpeta "Documentos" de tu móvil:\n $fileNames',
        firstButtonText: "OK",
        color: Colors.green,
        icon: CupertinoIcons.checkmark_alt,
      ),
    );
  }

}