import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
              height: MediaQuery.of(context).size.height/3,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children:  [
                  const SizedBox(height: 15,),
                  _imgProfilePic(),
                  Text(
                    viewModel.userName,
                    style: GoogleFonts.montserrat(
                        fontSize: 20.sp,
                        color: Colors.white
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(15.sp, 10.sp, 15.sp, 0),
                        child: Column(
                          children: [
                            Text(
                              "0/8",
                              style: GoogleFonts.montserrat(
                                  fontSize: 20.sp,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500
                              ),
                            ),
                            Text(
                              "Progreso",
                              style: GoogleFonts.montserrat(
                                  fontSize: 15.sp,
                                  color: Colors.white
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(15.sp, 10.sp, 15.sp, 0),
                        child: Column(
                          children: [
                            Text(
                              "7",
                              style: GoogleFonts.montserrat(
                                  fontSize: 20.sp,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500
                              ),
                            ),
                            Text(
                              "Encuestas",
                              style: GoogleFonts.montserrat(
                                  fontSize: 15.sp,
                                  color: Colors.white
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(15.sp, 10.sp, 15.sp, 0),
                          child: Column(
                            children: [
                              Text(
                                "2",
                                style: GoogleFonts.montserrat(
                                    fontSize: 20.sp,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500
                                ),
                              ),
                              Text(
                                "Pendientes",
                                style: GoogleFonts.montserrat(
                                    fontSize: 15.sp,
                                    color: Colors.white
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20,),
                ],
              ),
            ),
            Flexible(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(15.h),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            flex: 1,
                            child: CardModule(
                              imageName: 'img_test.png',
                              title: 'Encuestas',
                              color: const Color(0x464C8FEC),
                              onClick: () {},
                            ),
                          ),
                          SizedBox(width: 5.w,),
                          Expanded(
                            flex: 1,
                            child: CardModule(
                              imageName: 'img_camera_green.png',
                              title: 'Asistencia',
                              color: const Color(0x3B39EC6A),
                              onClick: () {
                                viewModel.setCurrentTab(1, "Asistencia");
                              },
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            flex: 1,
                            child: CardModule(
                              imageName: 'img_test.png',
                              title: 'Encuestas',
                              color: const Color(0x464C8FEC),
                              onClick: () {},
                            ),
                          ),
                          SizedBox(width: 5.w,),
                          Expanded(
                            flex: 1,
                            child: CardModule(
                              imageName: 'img_camera_green.png',
                              title: 'Asistencia',
                              color: const Color(0x3B39EC6A),
                              onClick: () {},
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  _imgProfilePic() {
    return CircleAvatar(
      radius: 45.sp,
      backgroundColor: Colors.white,
      child: CircleAvatar(
        backgroundImage: const AssetImage(
          'assets/images/img_profile.png',
        ),
        radius: 40.sp,
      ),
    );
  }

}