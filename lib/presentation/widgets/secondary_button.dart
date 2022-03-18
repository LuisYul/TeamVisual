import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class SecondaryButton extends StatelessWidget {
  const SecondaryButton({
    Key? key,
    required this.title,
    required this.onClick,
    this.icon,
    this.disabled,
  }) : super(key: key);

  final String title;
  final VoidCallback onClick;
  final IconData? icon;
  final bool? disabled;

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      minTextAdapt: true,
      splitScreenMode: true,
      builder: () => SizedBox(
        height: 45.h,
        child: OutlinedButton.icon(
            label: icon != null
                ? Icon(icon, color: true == disabled ? Colors.grey :Colors.red)
                : const Icon(null),
            icon: Text(
              title,
              style: GoogleFonts.montserrat(
                  fontSize: 18.sp,
                  color: true == disabled ? Colors.grey :Colors.red,
                  letterSpacing: 0.2,
                  fontWeight: FontWeight.w500
              ),
            ),
            style: OutlinedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              side: BorderSide(
                  width: 1.0,
                  color: true == disabled ? Colors.grey :Colors.red,
              ),
            ),
            onPressed: true == disabled ? null : () => onClick()
          ),
      ),
    );
  }
}
