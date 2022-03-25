import 'dart:collection';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:teamvisual/domain/model/course_entity.dart';
import 'package:teamvisual/domain/model/evaluation_entity.dart';
import 'package:teamvisual/domain/model/video_entity.dart';
import 'package:teamvisual/domain/usecase/download_file_use_case.dart';
import 'package:teamvisual/domain/usecase/get_courses_use_case.dart';
import 'package:teamvisual/domain/usecase/update_videos_use_case.dart';
import 'package:teamvisual/presentation/base/root_view_model.dart';
import 'package:teamvisual/presentation/utils/app_constants.dart';
import 'package:teamvisual/domain/model/file_entity.dart';
import 'package:teamvisual/domain/usecase/get_files_by_course_use_case.dart';
import 'package:teamvisual/domain/usecase/get_videos_by_course_use_case.dart';
import '../widgets/custom_dialog.dart';

class CourseViewModel extends RootViewModel {

  final GetCoursesUseCase _getCoursesUseCase;
  final GetVideosByCourseUseCase _getVideosByCourseUseCase;
  final GetFilesByCourseUseCase _getFilesByCourseUseCase;
  final DownloadFileUseCase _downloadFileUseCase;
  final UpdateVideosUseCase _updateVideosUseCase;

  CourseViewModel(
      this._getCoursesUseCase,
      this._getVideosByCourseUseCase,
      this._getFilesByCourseUseCase,
      this._downloadFileUseCase,
      this._updateVideosUseCase,
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
    }
    hideProgress();
  }

  void onClickCourse(CourseEntity course) async {
    _checkStoragePermission();
    if (await Permission.storage.isGranted) {
      final result = await runBusyFuture(_getVideosByCourseUseCase
          .call(course.id), busyObject: "error_get_videos");

      if (result.isNotEmpty) {
        _downloadVideos(course, result);
      }
    }

    // navigationService.navigateTo('/course_detail',
    //     arguments: {'course': course, 'video': result});
  }

  void onClickFiles(CourseEntity course, BuildContext context) async {
    _checkStoragePermission();
    if (await Permission.storage.isGranted) {
      final result = await runBusyFuture(_getFilesByCourseUseCase
          .call(course.id), busyObject: "error_get_files");
      if(result.isNotEmpty) {
        _downloadFiles(result, context);
      }
    }
  }

  void _downloadVideos(CourseEntity course, List<VideoEntity> videos) async {
    showProgress();
    final finalVideos = videos.takeWhile((e) => e.name.isNotEmpty);

    for (final i in finalVideos) {
      if(i.localPath.isEmpty) {
        final result = await runBusyFuture(_downloadFileUseCase
            .call([i.videoFile, i.name, AppConstants.downloadPath]),
            busyObject: "error_download_video");
        pt("local path $result");
        i.localPath = result;
      }
    }

    final successVideos = List<VideoEntity>.from(finalVideos
        .takeWhile((e) => e.localPath.isNotEmpty));

    final result = await runBusyFuture(_updateVideosUseCase
        .call(successVideos), busyObject: "error_update_videos");
    pt("total video updated $result");
    hideProgress();

    navigationService.navigateTo('/course_detail',
        arguments: {'course': course, 'video': successVideos});
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

  void _checkStoragePermission() async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.storage,
    ].request();

    pt(statuses[Permission.storage].toString());
  }

}