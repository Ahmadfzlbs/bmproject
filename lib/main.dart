import 'package:bmproject/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,

  ]);
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));
    return MaterialApp(
      title: 'Real-Estate App',
      debugShowCheckedModeBanner: false,
      theme:
      ThemeData(fontFamily: 'Inter', primaryColor: const Color(0xFFFFFFFF)),
      home: Scaffold(
        backgroundColor: Colors.deepPurpleAccent,
        body: SplashScreen(),
      ),
    );
  }
}
