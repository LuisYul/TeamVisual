import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:teamvisual/presentation/utils/app_constants.dart';
import 'package:teamvisual/presentation/viewmodel/login_view_model.dart';
import 'package:teamvisual/presentation/widgets/custom_text_field.dart';
import 'package:teamvisual/presentation/widgets/primary_button.dart';
import '../../di/locator.dart';
import '../base/root_widget.dart';
import '../widgets/custom_dialog.dart';
import '../widgets/secondary_button.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginScreen extends RootWidget<LoginViewModel> {
  LoginScreen() : super(getIt());

  final TextEditingController _userController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget buildViewModelWidget(BuildContext context, viewModel) {
    return ScreenUtilInit(
      minTextAdapt: true,
      builder: () => SafeArea(
        child: GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: Scaffold(
            resizeToAvoidBottomInset: true,
            body: Column(
              children: <Widget>[
                Column(
                  children: [
                    Image.asset(
                      'assets/images/background_red.jpeg',
                      fit: BoxFit.fitHeight,
                      height: 180.h,
                    ),
                  ],
                ),
                Expanded(
                  child: Container(
                    width: double.infinity,
                    height: double.infinity,
                    decoration: const BoxDecoration(
                      color: Colors.white12,
                      boxShadow: [
                        BoxShadow(color: Colors.white24, spreadRadius: 3),
                      ],
                    ),
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: EdgeInsets.all(20.h),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            _logoTeamVisual(),
                            SizedBox(height: 30.h),
                            _userField(),
                            SizedBox(height: 15.h),
                            _passwordField(),
                            SizedBox(height: 15.h),
                            SizedBox(
                              width: double.infinity,
                              child: _loginButton(context)
                            ),
                            SizedBox(height: 15.h),
                            SizedBox(
                                width: double.infinity,
                                child: _clearDataButton(context)
                            ),
                            SizedBox(height: 20.h),
                            _versionLabel(),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Widget _textAppTitle() {
  //   return Center(
  //     child: Row(
  //       mainAxisAlignment: MainAxisAlignment.center,
  //       children: [
  //         Text("Team",
  //             style: GoogleFonts.poppins(
  //               fontSize: 30.sp,
  //               color: Colors.blueGrey.shade700,
  //               fontWeight: FontWeight.w300,
  //             )
  //         ),
  //         Text("Visual",
  //             style: GoogleFonts.poppins(
  //               fontSize: 30.sp,
  //               color: Colors.blueGrey.shade700,
  //               fontWeight: FontWeight.w500,
  //             )
  //         ),
  //       ],
  //     ),
  //   );
  // }

  Widget _logoTeamVisual() {
    return Center(
      child: Image.asset(
        'assets/images/img_logo.png',
        fit: BoxFit.fitHeight,
        height: 100.sp,
      ),
    );
  }

  Widget _userField() {
    return CustomTextField(
      controller: _userController,
      inputType: TextInputType.number,
      labelText: 'Usuario',
      hintText: 'Ingresa tu usuario',
      icon: Icons.person,
    );
  }

  Widget _passwordField() {
    return CustomTextField(
      controller: _passwordController,
      inputType: TextInputType.visiblePassword,
      labelText: 'Clave',
      hintText: 'Ingresa tu clave',
      icon: Icons.lock,
    );
  }

  Widget _loginButton(BuildContext context) {
    return PrimaryButton(
      title: "Iniciar sesi??n",
      icon: CupertinoIcons.arrow_right_circle_fill,
      onClick: () {
        FocusScope.of(context).unfocus();
        viewModel.submitLogin(
            _userController.text,
            _passwordController.text,
        );
      },
    );
  }

  Widget _clearDataButton(BuildContext context) {
    return SecondaryButton(
      title: "Borrar datos",
      icon: CupertinoIcons.trash,
      onClick: () {
        showDialog(
          context: context,
          builder: (BuildContext context) => CustomDialog(
            title: "Atenci??n",
            description: "??Desea borrar los datos del sistema?",
            firstButtonText: "No",
            secondButtonText: "Si",
            secondClick: () => viewModel.submitClearData(),
          ),
        );
      },
    );
  }

  Widget _versionLabel() {
    return Center(
      child: Text(
        "Versi??n ${AppConstants.versionApp}",
        style: GoogleFonts.montserrat(
            fontSize: 16.sp,
            color: Colors.black54,
            letterSpacing: 0.2,
            fontWeight: FontWeight.w500
        ),
      ),
    );
  }

}