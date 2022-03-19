import 'package:teamvisual/di/locator.dart';
import 'package:flutter/material.dart';
import 'package:teamvisual/presentation/screen/login_screen.dart';
import 'package:teamvisual/presentation/screen/main_screen.dart';
import 'package:teamvisual/presentation/utils/navigation_service.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDI();
  runApp(const MyApp());
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
        // '/': (context) => MainScreen(),
      },
    );
  }
}
