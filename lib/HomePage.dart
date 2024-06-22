import 'package:buzzchat/Colors.dart';
import 'package:buzzchat/Constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(body: SingleChildScrollView(
      child: Container(
        height: getheight(context),
        width: getwidth(context),
        color: AppColors.primary,
        child: Center(
          child: Text('HomePage'),
        ),
      ),
    ),));
  }
}
