import 'dart:io';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:teamvisual/domain/model/course_entity.dart';
import 'package:teamvisual/domain/model/evaluation_entity.dart';
import 'package:teamvisual/domain/model/question_entity.dart';
import 'package:teamvisual/domain/model/video_entity.dart';
import 'package:teamvisual/presentation/base/root_widget.dart';
import 'package:teamvisual/presentation/viewmodel/course_detail_view_model.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:visibility_detector/visibility_detector.dart';
import '../../di/locator.dart';
import '../../domain/model/alternative_entity.dart';
import '../utils/app_constants.dart';
import '../utils/sliver_app_bar_delegate.dart';
import 'package:collection/collection.dart';
import '../widgets/custom_dialog.dart';

class CourseDetailScreen extends RootWidget<CourseDetailViewModel> {
  CourseDetailScreen() : super(getIt(), true);

  late CourseEntity course;
  late List<VideoEntity> video;
  final List<VideoPlayerController> _controllers = [];

  @override
  void init(BuildContext context) {
    super.init(context);
    final arguments =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    course = arguments['course'];
    video = arguments['video'];
    viewModel.getCourseData(course);

    if(video.isEmpty) {
      viewModel.setAllVideosWatched(true);
    }
    video.forEachIndexed((index, element) {
      print("local path video ${element.localPath}");
      final file = File(element.localPath);
      _controllers.add(VideoPlayerController.file(file));
      _controllers[index].initialize();
    });
    _controllers.add(VideoPlayerController.file(File("nothing")));
  }

  @override
  Widget buildViewModelWidget(BuildContext context, viewModel) {
    if(!viewModel.allVideosWatched) {
      _controllers[viewModel.current].addListener(() {
        if( _controllers[viewModel.current].value.isInitialized &&
            _controllers[viewModel.current].value.position
                == _controllers[viewModel.current].value.duration) {
          if(viewModel.current == video.length -1) {
            viewModel.setAllVideosWatched(true);
          }
          viewModel.setCurrentVideo(viewModel.current +1);
          return;
        }
      });

      if (viewModel.isPlayingVideo) {
        _controllers[viewModel.current].pause();
      } else {
        _controllers[viewModel.current].play();
      }
    }

    return VisibilityDetector(
      key: const Key("unique key"),
      onVisibilityChanged: (VisibilityInfo info) {
        if(info.visibleFraction == 0){
          _controllers[viewModel.current].pause();
        }
        else{
          _controllers[viewModel.current].play();
        }
      },
      child: ScreenUtilInit(
        minTextAdapt: true,
        builder: () => Scaffold(
          body: SafeArea(
            child: NestedScrollView(
              headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
                return <Widget>[
                  SliverAppBar(
                    expandedHeight: 200.h,
                    pinned: true,
                    backgroundColor: Colors.white,
                    iconTheme: const IconThemeData(color: Colors.black87),
                    flexibleSpace: FlexibleSpaceBar(
                      centerTitle: true,
                      title: Text(
                        innerBoxIsScrolled ? course.course : "",
                        style: GoogleFonts.montserrat(
                          fontSize: 18.sp,
                          color: Colors.black87,
                          fontWeight: FontWeight.w400
                        ),
                      ),
                      background: _videoContainer(),
                    ),
                  ),
                ];
              },
              body: AbsorbPointer(
                absorbing: !viewModel.allVideosWatched,
                child: Opacity(
                  opacity: viewModel.allVideosWatched ? 1.0: 0.4,
                    child: _listEvaluations()
                ),
              ),
            ),
          ),
          floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.redAccent,
            heroTag: "fab_save",
            child: const Icon(Icons.save, color: Colors.white,),
            onPressed: () => viewModel.allVideosWatched
                ?  _showDialogConfirm(context)
                : viewModel.setErrorMsg(AppConstants.needWatchAllVideos),
          ),
        ),
      ),
    );
  }

  Widget _videoContainer() {
    return AspectRatio(
      aspectRatio: _controllers[viewModel.current].value.aspectRatio,
      child: Stack(children: <Widget>[
        VideoPlayer(_controllers[viewModel.current]),
        if(!viewModel.allVideosWatched)
        Align(
          alignment: Alignment.bottomLeft,
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: FloatingActionButton.small(
                heroTag: "fab_video",
                backgroundColor: Colors.white,
                child: Icon(
                  _controllers[viewModel.current].value.isPlaying
                      ? Icons.pause
                      : Icons.play_arrow,
                  color: Colors.black87,
                ),
                onPressed: () {
                  if(!viewModel.allVideosWatched) {
                    viewModel.setIsPlaying(!viewModel.isPlayingVideo);
                  }
                }
              ),
            ),
          ),
       ]
      ),
    );
  }

  Widget _listEvaluations() {
    return CustomScrollView(
      slivers: <Widget>[for (final i in viewModel.evaluations) ...sections(i)],
    );
  }

  List<Widget> sections(EvaluationEntity evaluation) {
    return [
      makeEvaluationHeader(evaluation.name),
      SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) => Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(8,0,0,0),
                child: ListTile(
                  title: Text(
                    viewModel.questions[evaluation.id][index].question,
                    style: GoogleFonts.montserrat(
                      fontSize: 14.sp,
                      color: Colors.black,
                      fontWeight: FontWeight.w300,
                      textBaseline: TextBaseline.alphabetic
                    ),
                  ),
                ),
              ),
              ...createRadioListUsers(viewModel.questions[evaluation.id][index]),
            ],
          ),
          childCount: viewModel.questions[evaluation.id]?.length ?? 0,
        ),
      ),
    ];
  }

  SliverPersistentHeader makeEvaluationHeader(String evaluationName) {
    return SliverPersistentHeader(
      pinned: true,
      delegate: SliverAppBarDelegate(
        minHeight: 30.h,
        maxHeight: 60.h,
        child: Container(
          color: Colors.black54,
          child: Center(
            child: Text(
              evaluationName,
              style: GoogleFonts.montserrat(
                  fontSize: 18.sp,
                  color: Colors.white,
                  fontWeight: FontWeight.w400),
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> createRadioListUsers(QuestionEntity question) {
    List<AlternativeEntity> alternatives =
        viewModel.alternatives[question.id] ?? [];
    List<Widget> widgets = [];
    for (final i in alternatives) {
      widgets.add(
        RadioListTile(
          visualDensity: const VisualDensity(
            horizontal: VisualDensity.minimumDensity,
            vertical: VisualDensity.minimumDensity,
          ),
          value: i,
          groupValue: viewModel.alternativeSelected[question],
          title: Text(
            i.alternative,
            style: GoogleFonts.montserrat(
              fontSize: 13.sp,
              color: Colors.black,
              fontWeight: FontWeight.w200
            ),
          ),
          onChanged: (selected) {
            final AlternativeEntity altSelected = selected as AlternativeEntity;
            viewModel.setAlternativeSelected(question, altSelected);
          },
          selected: viewModel.alternativeSelected[question] == i,
          activeColor: Colors.red,
        ),
      );
    }
    return widgets;
  }

  void _showDialogConfirm(BuildContext buildContext) {
    showDialog(
      context: buildContext,
      builder: (BuildContext context) => CustomDialog(
        title: "Atención",
        description: "¿Desea enviar las respuestas?",
        firstButtonText: "No",
        secondButtonText: "Si",
        secondClick: () => viewModel.sendEvaluations(buildContext),
      ),
    );
  }
}

