import 'dart:async';

import 'package:bmproject/model/session.dart';
import 'package:bmproject/navigation/bottomnavbar.dart';
import 'package:bmproject/screens/intro_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  void checkAuth () {
    Timer(Duration(seconds: 3), () async {
      final result = await SessionSet.instant.getSession("user");
      if(result != null){
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context){
              return BottomNavBar();}
            ), (Route<dynamic> route) => false);
      }else{
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context){
              return IntroScreen();}
            ), (Route<dynamic> route) => false);
      }
    });
  }

  @override
  void initState(){
    super.initState();
    checkAuth();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Container(
        height: 70,
        width: 70,
        child: Lottie.asset("assets/animations/splashscreen.json",
            height: 400),
      ),
    );
  }
}
