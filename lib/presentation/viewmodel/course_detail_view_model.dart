import 'dart:collection';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:teamvisual/domain/model/alternative_entity.dart';
import 'package:teamvisual/domain/model/evaluation_entity.dart';
import 'package:teamvisual/domain/model/question_entity.dart';
import 'package:teamvisual/domain/model/save_evaluation_entity.dart';
import 'package:teamvisual/domain/usecase/save_evaluations_use_case.dart';
import 'package:teamvisual/domain/usecase/send_evaluations_use_case.dart';
import 'package:teamvisual/domain/usecase/update_courses_use_case.dart';
import 'package:teamvisual/presentation/base/root_view_model.dart';
import 'package:teamvisual/presentation/utils/app_constants.dart';
import '../../domain/model/course_entity.dart';
import '../../domain/usecase/get_alternatives_by_question_use_case.dart';
import '../../domain/usecase/get_evaluations_by_course_use_case.dart';
import '../../domain/usecase/get_question_by_evaluation_use_case.dart';
import '../widgets/custom_dialog.dart';

class CourseDetailViewModel extends RootViewModel {

  final GetEvaluationByCourseUseCase _getEvaluationByCourseUseCase;
  final GetQuestionByEvaluationUseCase _getQuestionByEvaluationUseCase;
  final GetAlternativesByQuestionUseCase _getAlternativesByQuestionUseCase;
  final SendEvaluationsUseCase _sendEvaluationsUseCase;
  final SaveEvaluationsUseCase _saveEvaluationsUseCase;
  final UpdateCoursesUseCase _updateCoursesUseCase;

  CourseDetailViewModel(
      this._getEvaluationByCourseUseCase,
      this._getQuestionByEvaluationUseCase,
      this._getAlternativesByQuestionUseCase,
      this._sendEvaluationsUseCase,
      this._saveEvaluationsUseCase,
      this._updateCoursesUseCase,
  );

  late CourseEntity _course;

  bool _isPlayingVideo = false;
  bool get isPlayingVideo => _isPlayingVideo;

  List<EvaluationEntity> _evaluations = [];
  List<EvaluationEntity> get evaluations => _evaluations;

  final LinkedHashMap _questions = LinkedHashMap<int, List<QuestionEntity>>();
  LinkedHashMap get questions => _questions;

  final LinkedHashMap _alternatives =
      LinkedHashMap<int, List<AlternativeEntity>>();
  LinkedHashMap get alternatives => _alternatives;

  final List<int> _questionsId = [];

  final LinkedHashMap alternativeSelected =
      LinkedHashMap<QuestionEntity, AlternativeEntity?>();

  int _current = 0;
  int get current => _current;

  bool _allVideosWatched = false;
  bool get allVideosWatched => _allVideosWatched;

  @override
  initialize() {

  }

  void getCourseData(CourseEntity courseEntity) async {
    _course = courseEntity;
    final result = await runBusyFuture(_getEvaluationByCourseUseCase
        .call(courseEntity.id), busyObject: "error_get_evaluations");
    if(result.isNotEmpty) {
      _evaluations = result;
      _getQuestions();
    }
  }

  void _getQuestions() async {
    for(final i in _evaluations) {
      final result = await runBusyFuture(_getQuestionByEvaluationUseCase
          .call(i.id), busyObject: "error_get_questions");
      _questions[i.id] = result;
      _setQuestionsId(result);
    }
    _getAlternatives();
  }

  void _setQuestionsId(List<QuestionEntity> questions) {
    for(final i in questions) {
      _questionsId.add(i.id);
      alternativeSelected[i] = null;
    }
  }

  void _getAlternatives() async {
    for(final i in _questionsId) {
      final result = await runBusyFuture(_getAlternativesByQuestionUseCase
          .call(i), busyObject: "error_get_alternatives");
      _alternatives[i] = result;
    }
    notify();
  }

  void setAlternativeSelected(QuestionEntity questionEntity,
      AlternativeEntity alternativeEntity) {
    alternativeSelected[questionEntity] = alternativeEntity;
    notify();
  }


  void setIsPlaying(bool isPlaying) {
    _isPlayingVideo = isPlaying;
    notify();
  }

  void setCurrentVideo(int current) {
    _current = current;
    notify();
  }

  void setAllVideosWatched(bool isWatched) {
    _allVideosWatched = isWatched;
  }

  void sendEvaluations(BuildContext context) async {
    showProgress();
    final saveEvaluation = List<SaveEvaluationEntity>.from(alternativeSelected
        .entries.map((e) => SaveEvaluationEntity(id: 0,
        userCourseId: e.key.userCourseId, questionId: e.key.id,
        alternativeId: e.value?.id,
        score: 1 == e.value?.correct ? e.key.note : 0)));

    final saveEvaluations = SaveEvaluationListEntity(evaluations: saveEvaluation);

    final result = await runBusyFuture(_sendEvaluationsUseCase.call(
        saveEvaluations), busyObject: "error_send_evs").catchError((error) {
      _showDialogError(context);
      _saveEvaluations(saveEvaluation);
    });

    _updateCourse();

    if(result) {
      _showDialogSuccess(context);
    } else {
      _showDialogError(context);
      _saveEvaluations(saveEvaluation);
    }
    hideProgress();
  }

  void _saveEvaluations(List<SaveEvaluationEntity> evaluations) async {
    final result = await runBusyFuture(_saveEvaluationsUseCase.call(
        evaluations), busyObject: "error_save_evs");
    pt("id evs saved locally $result");
  }

  void _updateCourse() async {
    _course.finished = true;
    final result = await runBusyFuture(_updateCoursesUseCase
        .call([_course]), busyObject: "error_update_course");
    pt("total courses updated $result");
  }

  void _showDialogError(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) => WillPopScope(
        onWillPop: () async => false,
        child: CustomDialog(
          title: "Atención",
          description: AppConstants.savedInPending,
          firstButtonText: "OK",
          color: Colors.red,
          icon: CupertinoIcons.exclamationmark,
          firstClick: () => {
            navigationService.navigateTo("/main")
          },
        ),
      ),
    );
  }

  void _showDialogSuccess(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) => WillPopScope(
        onWillPop: () async => false,
        child: CustomDialog(
          title: "Atención",
          description: "Se envió la información correctamente",
          firstButtonText: "OK",
          color: Colors.green,
          icon: CupertinoIcons.checkmark_alt,
          firstClick: () => {
            navigationService.navigateTo("/main")
          },
        ),
      ),
    );
  }

}