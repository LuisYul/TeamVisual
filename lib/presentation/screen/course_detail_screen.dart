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
import '../utils/sliver_app_bar_delegate.dart';

class CourseDetailScreen extends RootWidget<CourseDetailViewModel> {
  CourseDetailScreen() : super(getIt(), true);

  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;
  late CourseEntity course;
  late VideoEntity video;

  @override
  void init(BuildContext context) {
    super.init(context);
    final arguments =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    course = arguments['course'];
    video = arguments['video'];
    viewModel.getCourseData(course);

    _controller = VideoPlayerController.network(video.videoFile);
    _initializeVideoPlayerFuture = _controller.initialize();
  }

  @override
  Widget buildViewModelWidget(BuildContext context, viewModel) {
    if (viewModel.isPlayingVideo) {
      _controller.pause();
    } else {
      _controller.play();
    }
    return VisibilityDetector(
      key: const Key("unique key"),
      onVisibilityChanged: (VisibilityInfo info) {
        if(info.visibleFraction == 0){
          _controller.pause();
        }
        else{
          _controller.play();
        }
      },
      child: Scaffold(
        body: SafeArea(
          child: NestedScrollView(
            headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                SliverAppBar(
                  expandedHeight: 200.0,
                  pinned: true,
                  backgroundColor: Colors.white,
                  iconTheme: const IconThemeData(color: Colors.black87),
                  flexibleSpace: FlexibleSpaceBar(
                    centerTitle: true,
                    title: Container(
                      color: Colors.blue,
                      child: Text(
                        innerBoxIsScrolled ? course.course : "",
                        style: GoogleFonts.montserrat(
                          fontSize: 18,
                          color: Colors.black87,
                          fontWeight: FontWeight.w400
                        ),
                      ),
                    ),
                    background: _videoContainer(),
                  ),
                ),
              ];
            },
            body: _listEvaluations(),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          heroTag: "fab_save",
          child: const Icon(Icons.save, color: Colors.white,),
          onPressed: () => viewModel.saveEvaluations(context),
        ),
      ),
    );
  }

  Widget _videoContainer() {
    return FutureBuilder(
      future: _initializeVideoPlayerFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return AspectRatio(
            aspectRatio: _controller.value.aspectRatio,
            child: Stack(children: <Widget>[
              VideoPlayer(_controller),
              Align(
                alignment: Alignment.bottomLeft,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FloatingActionButton.small(
                      heroTag: "fab_video",
                      backgroundColor: Colors.white,
                      child: Icon(
                        _controller.value.isPlaying
                            ? Icons.pause
                            : Icons.play_arrow,
                        color: Colors.black87,
                      ),
                      onPressed: () {
                        viewModel.setIsPlaying(!viewModel.isPlayingVideo);
                      }
                    ),
                  ),
                ),
             ]
            ),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
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
                      fontSize: 14,
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
        minHeight: 30.0,
        maxHeight: 60.0,
        child: Container(
          color: Colors.lightBlue.shade200,
          child: Center(
            child: Text(
              evaluationName,
              style: GoogleFonts.montserrat(
                  fontSize: 18,
                  color: Colors.black87,
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
              fontSize: 13,
              color: Colors.black,
              fontWeight: FontWeight.w200
            ),
          ),
          onChanged: (selected) {
            final AlternativeEntity altSelected = selected as AlternativeEntity;
            viewModel.setAlternativeSelected(question, altSelected);
          },
          selected: viewModel.alternativeSelected[question] == i,
          activeColor: Colors.blueAccent,
        ),
      );
    }
    return widgets;
  }

}

