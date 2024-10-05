import 'dart:io';
import 'package:flutter/material.dart';
import 'package:translator_app/screen/home_screen.dart';
import 'package:translator_app/utils/color.dart';
import 'package:translator_app/utils/sized.dart';

  
class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: FutureBuilder(
        future: internetAndAuthChecker(context),
        builder:(context, snapshot) => Column(
          children: [
            Expanded(
             flex: 6,
             child: Image.asset("assets/logo.png")),
          ],
        ),
      ),
    );


  }

  Future internetAndAuthChecker(BuildContext context)async{
      await Future.delayed(
        const Duration(seconds: 4),
        ()=> Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const MyHomePage())));
  }

}