import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class SecondaryButton extends StatelessWidget {
  const SecondaryButton({
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
        height: 50.h,
        child: OutlinedButton.icon(
            label: icon != null
                ? Icon(icon, color: Colors.red,)
                : const Icon(null),
            icon: Text(
              title,
              style: GoogleFonts.montserrat(
                  fontSize: 18.sp,
                  color: Colors.red,
                  letterSpacing: 0.2,
                  fontWeight: FontWeight.w500
              ),
            ),
            style: OutlinedButton.styleFrom(
              primary: Colors.red,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              side: const BorderSide(
                  width: 1.0,
                  color: Colors.red,
              ),
            ),
            onPressed: () => onClick()
          ),
      ),
    );
  }
}
