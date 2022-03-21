import 'package:flutter/material.dart';
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
            return makeCard(viewModel.courses[index]);
          },
        ),
    );
  }

  Card makeCard(CourseEntity course) => Card(
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
      child: makeListTile(course),
    ),
  );

  ListTile makeListTile(CourseEntity course) => ListTile(
    contentPadding: const EdgeInsets.symmetric(
      horizontal: 20.0,
      vertical: 10.0,
    ),
    leading: Container(
      padding: const EdgeInsets.only(right: 12.0),
      child: Image.asset(
        "assets/images/pencil.png",
        height: 50,
      ),
    ),
    title: Text(
      course.course,
      style: const TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.bold,
      ),
    ),
    subtitle: Row(
      children: <Widget>[
        Expanded(
          flex: 1,
          child: LinearProgressIndicator(
            backgroundColor: Colors.grey,
            value: course.advPercent.toDouble(),
            minHeight: 7,
            valueColor: const AlwaysStoppedAnimation(
              Colors.green
            )
          )
        ),
        Expanded(
          flex: 4,
          child: Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: Text("${course.advPercent}%",
                style: const TextStyle(color: Colors.black)
            )
          ),
        )
      ],
    ),
    trailing:
      const Icon(
        Icons.keyboard_arrow_right,
        color: Colors.black, size: 30.0
      ),
    onTap: () => viewModel.onClickCourse(course)
  );
}