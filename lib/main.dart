import 'package:flutter/material.dart';
import 'package:translator_app/home.dart';
import 'package:translator_app/utils/color.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) => MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(colorSchemeSeed: kThired_color),
      home: const MyHomePage(),
    );
}
