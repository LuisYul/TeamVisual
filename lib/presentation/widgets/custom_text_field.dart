import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    Key? key,
    required this.labelText,
    required this.controller,
    this.hintText,
    this.icon,
    this.inputType,
  }) : super(key: key);

  final String labelText;
  final TextEditingController controller;
  final IconData? icon;
  final String? hintText;
  final TextInputType? inputType;

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      minTextAdapt: true,
      splitScreenMode: true,
        builder: () => TextField(
          controller: controller,
          keyboardType: inputType,
          obscureText: inputType == TextInputType.visiblePassword,
          style: GoogleFonts.montserrat(
              fontSize: 15.sp,
              color: Colors.black,
              letterSpacing: 0.24,
              fontWeight: FontWeight.w500
          ),
          decoration: InputDecoration(
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                  color: Colors.black54,
                  width: 2.0
              ),
            ),
            border: const OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.black,
              ),
            ),
            hintText: hintText ?? labelText,
            labelText: labelText,
            prefixIcon: icon != null
                ? Icon(icon, color: Colors.black54,)
                : null,
            prefixText: ' ',
            focusColor: Colors.black54,
            labelStyle: const TextStyle(
                color: Colors.black54
            ),
            suffixStyle: const TextStyle(
                color: Colors.redAccent
            ),
          ),
        ),
    );
  }
}
