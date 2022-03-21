import 'dart:collection';
import 'dart:io';

import 'package:teamvisual/domain/model/evaluation_entity.dart';
import 'package:teamvisual/domain/model/question_entity.dart';
import 'package:teamvisual/presentation/base/root_view_model.dart';
import '../../domain/model/course_entity.dart';
import '../../domain/usecase/get_alternatives_by_question_use_case.dart';
import '../../domain/usecase/get_evaluations_by_course_use_case.dart';
import '../../domain/usecase/get_files_by_course_use_case.dart';
import '../../domain/usecase/get_question_by_evaluation_use_case.dart';

class CourseDetailViewModel extends RootViewModel {

  final GetFilesByCourseUseCase _getFilesByCourseUseCase;
  final GetEvaluationByCourseUseCase _getEvaluationByCourseUseCase;
  final GetQuestionByEvaluationUseCase _getQuestionByEvaluationUseCase;
  final GetAlternativesByQuestionUseCase _getAlternativesByQuestionUseCase;

  CourseDetailViewModel(
      this._getFilesByCourseUseCase,
      this._getEvaluationByCourseUseCase,
      this._getQuestionByEvaluationUseCase,
      this._getAlternativesByQuestionUseCase,
    );

  bool _isPlayingVideo = false;
  bool get isPlayingVideo => _isPlayingVideo;

  List<EvaluationEntity> _evaluations = [];
  List<EvaluationEntity> get evaluations => _evaluations;

  final LinkedHashMap _questions = LinkedHashMap<int, List<QuestionEntity>>();
  LinkedHashMap get questions => _questions;

  @override
  initialize() {

  }

  void getCourseData(CourseEntity courseEntity) async {
    //showProgress();
    final result = await runBusyFuture(_getEvaluationByCourseUseCase
        .call(courseEntity.id), busyObject: "error_get_evaluations");
    if(result.isNotEmpty) {
      _evaluations = result;
      notify();
      _getQuestions();
    }
    hideProgress();

  }

  void _getQuestions() async {
   // LinkedHashMap lhmQuestion = LinkedHashMap<int, List<QuestionEntity>>();

    for(final i in _evaluations) {
      final result = await runBusyFuture(_getQuestionByEvaluationUseCase
          .call(i.id), busyObject: "error_get_evaluations");
      _questions[i.id] = result;
    }
    notify();

  }

  void setIsPlaying(bool isPlaying) {
    _isPlayingVideo = isPlaying;
    notify();
  }

  @override
  void dispose() {
    _isPlayingVideo = true;
    super.dispose();
    pt("dispose video");
  }

}