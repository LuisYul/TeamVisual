import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class CardModule extends StatelessWidget {

  final String imageName;
  final String title;
  final Color color;
  final VoidCallback onClick;

  const CardModule({
    Key? key,
    required this.imageName,
    required this.title,
    required this.color,
    required this.onClick,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      minTextAdapt: true,
      builder: () => SizedBox(
        height: 160.h,
        child: GestureDetector(
          onTap: () => onClick(),
          child: Card(
            color: Colors.white,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CircleAvatar(
                    backgroundColor: color,
                    radius: 45.h,
                    child: Image(
                      image: AssetImage('assets/images/$imageName'),
                      height: 50.h,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Text(
                    title,
                    style: GoogleFonts.montserrat(
                        fontSize: 17.sp,
                        color: Colors.black87,
                        fontWeight: FontWeight.w500
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
