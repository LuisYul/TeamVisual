import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    Key? key,
    required this.title,
    required this.onClick,
    this.icon,
  }) : super(key: key);

  final String title;
  final VoidCallback onClick;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      minTextAdapt: true,
      splitScreenMode: true,
      builder: () => SizedBox(
        height: 48.h,
        child: TextButton.icon(
            label: icon != null
                ? Icon(icon, color: Colors.white,)
                : const Icon(null),
            icon: Text(
              title,
              style: GoogleFonts.montserrat(
                  fontSize: 18.sp,
                  color: Colors.white,
                  letterSpacing: 0.2,
                  fontWeight: FontWeight.w500
              ),
            ),
            style: ElevatedButton.styleFrom(
              primary: Colors.red,
              onPrimary: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
            onPressed: () => onClick()
          ),
      ),
    );
  }
}
