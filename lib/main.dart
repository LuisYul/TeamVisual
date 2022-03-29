import 'dart:io';
import 'package:teamvisual/di/locator.dart';
import 'package:flutter/material.dart';
import 'package:teamvisual/presentation/screen/course_detail_screen.dart';
import 'package:teamvisual/presentation/screen/login_screen.dart';
import 'package:teamvisual/presentation/screen/main_screen.dart';
import 'package:teamvisual/presentation/utils/navigation_service.dart';

final hideMainAppBar = ValueNotifier<bool>(true);

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDI();
  HttpOverrides.global = MyHttpOverrides();
  runApp(const MyApp());
}

class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext? context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert,
          String host, int port) => true;
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: getIt<NavigationService>().navigatorKey,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => LoginScreen(),
       '/main': (context) => MainScreen(),
        '/course_detail': (context) => CourseDetailScreen(),
       // '/': (context) => MainScreen(),
      },
    );
  }
}
