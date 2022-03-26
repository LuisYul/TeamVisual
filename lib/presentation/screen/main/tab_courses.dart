import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:teamvisual/di/locator.dart';
import 'package:teamvisual/domain/model/course_entity.dart';
import 'package:teamvisual/presentation/base/root_widget.dart';
import 'package:teamvisual/presentation/viewmodel/course_view_model.dart';

class TabCourses extends RootWidget<CourseViewModel> {
  TabCourses() : super(getIt());

  @override
  Widget buildViewModelWidget(BuildContext context, viewModel) {
    return Scaffold(
      backgroundColor: const Color(0xD2EBEBEF),
      body: ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: viewModel.courses.length,
        itemBuilder: (BuildContext context, int index) {
          return AbsorbPointer(
            absorbing: viewModel.courses[index].finished,
            child: Opacity(
              opacity: viewModel.courses[index].finished ? 0.4 : 1.0,
              child: makeCard(viewModel.courses[index], context)
            ),
          );
        },
      ),
    );
  }

  Card makeCard(CourseEntity course, BuildContext context) => Card(
      elevation: 5.0,
      margin: const EdgeInsets.symmetric(
        horizontal: 10.0,
        vertical: 6.0,
      ),
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(25.0),
          ),
        ),
        child: makeListTile(course, context),
      ),
    );

  ListTile makeListTile(CourseEntity course, BuildContext context) => ListTile(
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 20.0,
        vertical: 10.0,
      ),
      title: Row(
        children: [
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  course.course,
                  style: GoogleFonts.montserrat(
                      fontSize: 16,
                      color: Colors.black,
                      fontWeight: FontWeight.w700
                  ),
                ),
                Text(
                  course.resume,
                  style: GoogleFonts.montserrat(
                      fontSize: 15,
                      color: Colors.black,
                      fontWeight: FontWeight.w400
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      subtitle: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Expanded(
            flex: course.advPercent,
            child: LinearProgressIndicator(
                backgroundColor: Colors.black87,
                value: course.advPercent.toDouble(),
                minHeight: 10,
                valueColor: const AlwaysStoppedAnimation(Colors.green),
            ),
          ),
          Expanded(
            flex: 200,
            child: Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Text("${course.advPercent}%",
                  style: GoogleFonts.montserrat(
                      color: Colors.black
                  ),
              ),
            ),
          )
        ],
      ),
      trailing: Wrap(
        spacing: 12,
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "(${course.totalFiles})",
                style: GoogleFonts.montserrat(
                    fontSize: 16,
                    color: Colors.black,
                    fontWeight: FontWeight.w700
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Card(
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                child: SizedBox(
                  width: 35,
                  height: 35,
                  child: IconButton(
                    icon: const Icon(
                      Icons.attach_file_outlined,
                      size: 20.0,
                    ),
                    onPressed: course.totalFiles > 0
                        ? () => viewModel.onClickFiles(course, context)
                        : null,
                    color: Colors.indigoAccent, ),
                ),
              )
            ],
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
            child: Icon(Icons.keyboard_arrow_right,
                color: Colors.black, size: 30.0),
          ),
        ],
      ),
      onTap: () => viewModel.onClickCourse(course)
  );

}
