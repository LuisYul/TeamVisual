import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:teamvisual/presentation/base/root_widget.dart';
import 'package:teamvisual/presentation/viewmodel/assist_view_model.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../di/locator.dart';

class TabModules extends RootWidget<AssistViewModel> {
  TabModules() : super(getIt());

  @override
  Widget buildViewModelWidget(BuildContext context, viewModel) {
    return ScreenUtilInit(
      minTextAdapt: true,
      splitScreenMode: true,
      builder: () => Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
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
                   CircleAvatar(
                    radius: 45.sp,
                    backgroundColor: Colors.white,
                    child: CircleAvatar(
                      backgroundImage: const AssetImage(
                          'assets/images/img_profile.png',
                      ),
                      radius: 40.sp,
                    ),
                  ),
                  Text(
                    "Juan Lopez",
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
                      Center(
                        child: Padding(
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
                  const SizedBox(height: 15,),
                ],
              ),
            )

          ],
        ),
      ),
    );
  }

}