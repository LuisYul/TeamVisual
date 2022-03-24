import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:teamvisual/di/locator.dart';
import 'package:teamvisual/presentation/base/root_widget.dart';
import 'package:teamvisual/presentation/viewmodel/main_view_model.dart';
import 'package:teamvisual/presentation/viewmodel/module_view_model.dart';
import 'package:teamvisual/presentation/widgets/card_module.dart';

class TabModules extends RootWidget<ModuleViewModel> {
   TabModules({
     required this.mainViewModel,
   }) : super(getIt());

  final MainViewModel mainViewModel;

  @override
  Widget buildViewModelWidget(BuildContext context, viewModel) {
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
                  SizedBox(height: 15.h,),
                  _imgProfilePic(),
                  SizedBox(height: 5.h),
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
  }

  Widget _imgProfilePic() {
    return CircleAvatar(
      radius: 45.sp,
      backgroundColor: Colors.white,
      child: CircleAvatar(
        backgroundImage: viewModel.userPhoto == ""
            ? const AssetImage('assets/images/img_profile.png') as ImageProvider
            : CachedNetworkImageProvider(viewModel.userPhoto,),
        radius: 40.sp,
      ),
    );
  }

  Widget _labelName() {
    return Text(
      viewModel.userName,
      style: GoogleFonts.montserrat(
          fontSize: 17.sp,
          color: Colors.white
      ),
      textAlign: TextAlign.center,
      maxLines: 1,
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
            if (viewModel.assistModuleOn)
              CardModule(
                imageName: 'img_camera_green.png',
                title: 'Asistencia',
                color: const Color(0x3B39EC6A),
                onClick: () {
                  mainViewModel.setCurrentTab(1, "Asistencia");
                },
              ),
            if (viewModel.quizModuleOn)
              CardModule(
                imageName: 'img_test.png',
                title: 'Cursos',
                color: const Color(0x464C8FEC),
                onClick: () {
                  mainViewModel.setCurrentTab(2, "Cursos");
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
                fontSize: 18.sp,
                color: Colors.white,
                fontWeight: FontWeight.w500),
          ),
          Text(
            "Progreso",
            style: GoogleFonts.montserrat(
                fontSize: 14.sp, color: Colors.white),
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
                fontSize: 18.sp,
                color: Colors.white,
                fontWeight: FontWeight.w500),
          ),
          Text(
            "Encuestas",
            style: GoogleFonts.montserrat(
                fontSize: 14.sp, color: Colors.white),
          ),
        ],
      ),
    );
  }

  Widget _pendingContainer() {
    return Padding(
      padding: EdgeInsets.fromLTRB(18.sp, 10.sp, 15.sp, 0),
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
                fontSize: 14.sp, color: Colors.white),
          ),
        ],
      ),
    );
  }

}
