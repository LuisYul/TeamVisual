import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomDialog extends StatelessWidget {
   const CustomDialog({
    Key? key,
    required this.title,
    required this.description,
    required this.firstButtonText,
    this.secondButtonText,
    this.color,
    this.icon,
    this.firstClick,
    this.secondClick,
  }) : super(key: key);

  final String title;
  final String description;
  final String firstButtonText;
  final String? secondButtonText;
  final Color? color;
  final IconData? icon;
  final VoidCallback? firstClick, secondClick;

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      minTextAdapt: true,
      builder: () => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        child: dialogContent(context),
      ),
    );
  }

  dialogContent(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(
            top: 70.h,
            bottom: 16.h,
            left: 16.h,
            right: 16.h,
          ),
          margin: EdgeInsets.only(top: 50.h),
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(16.h),
            boxShadow: const [
              BoxShadow(
                color: Colors.white,
                blurRadius: 1.0,
                offset:  Offset(0.0, 0.0),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                title,
                style: GoogleFonts.montserrat(
                  fontSize: 26.sp,
                  color: Colors.black87,
                  letterSpacing: 0.2,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 36.h),
              Text(
                description,
                textAlign: TextAlign.center,
                style: GoogleFonts.montserrat(
                  fontSize: 16.sp,
                  color: Colors.black87,
                  letterSpacing: 0.2,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(height: 36.h),
              Align(
                alignment: Alignment.bottomRight,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    _firstButton(context),
                    secondButtonText != null
                        ? _secondButton(context)
                        : Container(),
                  ],
                ),
              ),
            ],
          ),
        ),
        Positioned(
          left: 16.0,
          right: 16.0,
          child: CircleAvatar(
            backgroundColor: color ?? Colors.green.shade600,
            radius: 50.h,
            child: Icon(
              icon ?? CupertinoIcons.checkmark_alt,
              color: Colors.white,
              size: 40.h,
            ),
          ),
        ),
      ],
    );
  }

  Widget _firstButton(BuildContext context) {
    return TextButton(
      onPressed: () {
        Navigator.of(context).pop();
        firstClick != null ? firstClick!() : null;
      },
      child: Text(
        firstButtonText,
        style: GoogleFonts.montserrat(
          fontSize: 20.sp,
          color: Colors.indigo.shade800,
          letterSpacing: 0.2,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _secondButton(BuildContext context) {
    return TextButton(
      onPressed: () {
        Navigator.of(context).pop();
        secondClick != null ? secondClick!() : null;
      },
      child: Text(
        secondButtonText ?? "Cancel",
        style: GoogleFonts.montserrat(
          fontSize: 20.sp,
          color: Colors.indigo.shade800,
          letterSpacing: 0.2,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}