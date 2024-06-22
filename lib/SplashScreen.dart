import 'dart:async';

import 'package:buzzchat/AuthScreens/OtpScreen.dart';
import 'package:buzzchat/Colors.dart';
import 'package:buzzchat/Constants.dart';
import 'package:buzzchat/HomePage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'AuthScreens/LoginScreen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}
class _SplashScreenState extends State<SplashScreen> {
  final _auth = FirebaseAuth.instance;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(Duration(seconds: 3), () {
      // if(_auth.currentUser!=null){
      //   Navigator.pushAndRemoveUntil(
      //       context, MaterialPageRoute(builder: (context) => HomePage(
      //   )), (
      //       route) => false);
      // }
      // else {
        Navigator.pushAndRemoveUntil(
            context, MaterialPageRoute(builder: (context) => OtpScreen()), (
            route) => false);
      // }

    });
  }
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          height: getheight(context),
          width: getwidth(context),
          color: AppColors.primary,
            child: Center(
            child: Image.asset('assets/SplashScreen.jpg', height: getheight(context)*0.3,),
        ),
        ),
      ),
    );
  }
}
