import 'package:flutter/material.dart';
import 'package:translator_app/screen/home_screen.dart';
import 'package:translator_app/screen/splash_scrren.dart';
import 'package:translator_app/utils/color.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) => MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(colorSchemeSeed: kThired_color),
      home: const SplashScreen(),
    );
}
