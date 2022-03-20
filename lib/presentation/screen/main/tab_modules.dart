import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stacked/stacked.dart';
import 'package:teamvisual/presentation/viewmodel/main_view_model.dart';
import 'package:teamvisual/presentation/widgets/card_module.dart';

class TabModules extends StatelessWidget {
  const TabModules({
    Key? key,
    required this.viewModel,
  }) : super(key: key);

  final MainViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<MainViewModel>.reactive(
      viewModelBuilder: () => viewModel,
      builder: (ctx, viewModel, child) {
        return ScreenUtilInit(
          minTextAdapt: true,
          splitScreenMode: true,
          builder: () => Scaffold(
            backgroundColor: const Color(0xD2EBEBEF),
            body: Column(
              children: [
                Container(
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          fit: BoxFit.fill,
                          image: AssetImage(
                            "assets/images/background_modules.png",
                          )
                      )
                  ),
                  height: MediaQuery.of(context).size.height / 3,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const SizedBox(
                        height: 15,
                      ),
                      _imgProfilePic(),
                      _labelName(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          _progressContainer(),
                          _quizContainer(),
                          _pendingContainer(),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
                _gridModules(),
              ],
            ),
          ),
        );
      },
    );

  }

  Widget _imgProfilePic() {
    return CircleAvatar(
      radius: 45.sp,
      backgroundColor: Colors.white,
      child: CircleAvatar(
        backgroundImage: NetworkImage(
          viewModel.userPhoto,
        ),
        radius: 40.sp,
      ),
    );
  }

  Widget _labelName() {
    return Text(
      viewModel.userName,
      style: GoogleFonts.montserrat(
          fontSize: 20.sp,
          color: Colors.white
      ),
    );
  }

  Widget _gridModules() {
    return Flexible(
      child: Padding(
        padding: EdgeInsets.fromLTRB(15.h, 0, 15.h, 0),
        child: GridView.count(
          shrinkWrap: true,
          crossAxisCount: 2,
          crossAxisSpacing: 5.h,
          mainAxisSpacing: 5.h,
          children: [
            if (viewModel.quizModuleOn)
              CardModule(
                imageName: 'img_test.png',
                title: 'Encuestas',
                color: const Color(0x464C8FEC),
                onClick: () {},
              ),
            if (viewModel.assistModuleOn)
              CardModule(
                imageName: 'img_camera_green.png',
                title: 'Asistencia',
                color: const Color(0x3B39EC6A),
                onClick: () {
                  viewModel.setCurrentTab(1, "Asistencia");
                },
              ),
            if (viewModel.thirdModuleOn)
              CardModule(
                imageName: 'img_test.png',
                title: 'Módulo 3',
                color: const Color(0x464C8FEC),
                onClick: () {},
              ),
            if (viewModel.fourthModuleOn)
              CardModule(
                imageName: 'img_camera_green.png',
                title: 'Módulo 4',
                color: const Color(0x3B39EC6A),
                onClick: () {},
              ),
          ],
        ),
      ),
    );
  }

  Widget _progressContainer() {
    return Padding(
      padding: EdgeInsets.fromLTRB(15.sp, 10.sp, 15.sp, 0),
      child: Column(
        children: [
          Text(
            "0/8",
            style: GoogleFonts.montserrat(
                fontSize: 20.sp,
                color: Colors.white,
                fontWeight: FontWeight.w500),
          ),
          Text(
            "Progreso",
            style: GoogleFonts.montserrat(
                fontSize: 15.sp, color: Colors.white),
          ),
        ],
      ),
    );
  }

  Widget _quizContainer() {
    return Padding(
      padding: EdgeInsets.fromLTRB(15.sp, 10.sp, 15.sp, 0),
      child: Column(
        children: [
          Text(
            "7",
            style: GoogleFonts.montserrat(
                fontSize: 20.sp,
                color: Colors.white,
                fontWeight: FontWeight.w500),
          ),
          Text(
            "Encuestas",
            style: GoogleFonts.montserrat(
                fontSize: 15.sp, color: Colors.white),
          ),
        ],
      ),
    );
  }

  Widget _pendingContainer() {
    return Padding(
      padding: EdgeInsets.fromLTRB(15.sp, 10.sp, 15.sp, 0),
      child: Column(
        children: [
          Text(
            "2",
            style: GoogleFonts.montserrat(
                fontSize: 20.sp,
                color: Colors.white,
                fontWeight: FontWeight.w500),
          ),
          Text(
            "Pendientes",
            style: GoogleFonts.montserrat(
                fontSize: 15.sp, color: Colors.white),
          ),
        ],
      ),
    );
  }


}
