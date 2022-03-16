import 'dart:developer';

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

  final TextEditingController _userController = TextEditingController(text: '46340447');
  final TextEditingController _passwordController = TextEditingController(text: '1234');

  @override
  Widget buildViewModelWidget(BuildContext context, viewModel) {
    log("login vm loading ${viewModel.loading}");
    return ScreenUtilInit(
      minTextAdapt: true,
      builder: () => SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          body: withProgress(
            body: Column(
              children: <Widget>[
                Column(
                  children: [
                    Image.asset(
                      'assets/images/background_red.jpeg',
                      fit: BoxFit.fitHeight,
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
                        padding: EdgeInsets.all(20.sp),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            _logoTeamVisual(),
                            SizedBox(height: 30.sp),
                            _inputField1(),
                            SizedBox(height: 15.sp),
                            _inputField2(),
                            SizedBox(height: 15.sp),
                            SizedBox(
                              width: double.infinity,
                              child: _loginButton(context)
                            ),
                            SizedBox(height: 15.sp),
                            SizedBox(
                                width: double.infinity,
                                child: _clearDataButton(context)
                            ),
                            SizedBox(height: 25.sp),
                            Center(
                              child: Text(
                                "Versión ${AppConstants.versionApp}",
                                style: GoogleFonts.montserrat(
                                    fontSize: 16.sp,
                                    color: Colors.black54,
                                    letterSpacing: 0.2,
                                    fontWeight: FontWeight.w500
                                ),
                              ),
                            ),
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

  Widget _textAppTitle() {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Team",
              style: GoogleFonts.poppins(
                fontSize: 30.sp,
                color: Colors.blueGrey.shade700,
                fontWeight: FontWeight.w300,
              )
          ),
          Text("Visual",
              style: GoogleFonts.poppins(
                fontSize: 30.sp,
                color: Colors.blueGrey.shade700,
                fontWeight: FontWeight.w500,
              )
          ),
        ],
      ),
    );
  }

  Widget _logoTeamVisual() {
    return Center(
      child: Image.asset(
        'assets/images/img_logo.png',
        fit: BoxFit.fitHeight,
        height: 100.sp,
      ),
    );
  }

  Widget _inputField1() {
    return CustomTextField(
      controller: _userController,
      inputType: TextInputType.number,
      labelText: 'Usuario',
      hintText: 'Ingresa tu usuario',
      icon: Icons.person,
    );
  }

  Widget _inputField2() {
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
      title: "Iniciar sesión",
      icon: CupertinoIcons.arrow_right_circle_fill,
      onClick: () {
        viewModel.submitLogin(
            _userController.text,
            _passwordController.text);
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(builder: (context) => MainScreen()),
        // );
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
          builder: (BuildContext context) => const CustomDialog(
            title: "Success",
            description:
            "USUARIO NO HABILITADO EN EL SISTEMA.",
            firstButtonText: "Okay",
            secondButtonText: "Cancelar",
            color: Colors.red,
            icon: CupertinoIcons.exclamationmark,
          ),
        );
      },
    );
  }

}