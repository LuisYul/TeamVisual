import 'package:google_fonts/google_fonts.dart';
import 'package:teamvisual/domain/model/course_entity.dart';
import 'package:teamvisual/domain/model/evaluation_entity.dart';
import 'package:teamvisual/domain/model/question_entity.dart';
import 'package:teamvisual/domain/model/video_entity.dart';
import 'package:teamvisual/presentation/base/root_widget.dart';
import 'package:teamvisual/presentation/viewmodel/course_detail_view_model.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import '../../di/locator.dart';

class CourseDetailScreen extends RootWidget<CourseDetailViewModel> {
  CourseDetailScreen() : super(getIt());

  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;
  late CourseEntity course;
  late VideoEntity video;

  @override
  void init(BuildContext context) {
    super.init(context);
    final arguments = ModalRoute.of(context)!.settings
        .arguments as Map<String, dynamic>;
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
    return Scaffold(
      appBar: AppBar(title: Text(
          course.course,
          textAlign: TextAlign.center,
          style: GoogleFonts.montserrat(
            fontSize: 18,
            color: Colors.black87,
            fontWeight: FontWeight.w400
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black87),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _videoContainer(),
            _listEvaluations(),
          ],
        ),
      ),
   //   body: _listEvaluations(),
    );
  }

  Widget _videoContainer() {
    return FutureBuilder(
      future: _initializeVideoPlayerFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return AspectRatio(
            aspectRatio: _controller.value.aspectRatio,
            child:  Stack(
                children: <Widget>[
                  VideoPlayer(_controller),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: FloatingActionButton.small(
                          backgroundColor: Colors.white,
                          child: Icon(
                            _controller.value.isPlaying
                                ? Icons.pause
                                : Icons.play_arrow,
                            color: Colors.black87,
                          ),
                          onPressed: (){
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
    return PrimaryScrollController(
      controller: ScrollController(),
      child: ListView.separated(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.all(8),
        itemCount: viewModel.evaluations.length,
        itemBuilder: (BuildContext context, int index) {
          return _buildExpandableTile(viewModel.evaluations[index]);
        },
        separatorBuilder: (BuildContext context, int index) => const Divider(),
      ),
    );
  }

  Widget _buildExpandableTile(EvaluationEntity evaluation) {
    return ExpansionTile(
      title: Text(
        evaluation.name,
        style: GoogleFonts.montserrat(
            fontSize: 18,
            color: Colors.black87,
            fontWeight: FontWeight.w400
        ),
      ),
      children: <Widget>[
        ListView.builder(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          primary: true,
          physics:  AlwaysScrollableScrollPhysics(),
          itemCount: viewModel.questions[evaluation.id].length,
          itemBuilder: (BuildContext context, int index) {
            return _buildQuestionTile(viewModel.questions[evaluation.id][index]);
          },
        ),
      ],
    );
  }

  Widget _buildQuestionTile(QuestionEntity question) {
    return ListTile(
        title: Text(
        question.question,
        style: GoogleFonts.montserrat(
        fontSize: 14,
        color: Colors.black,
        fontWeight: FontWeight.w300
         ),
      ),
    );
  }

}