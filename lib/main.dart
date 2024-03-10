import 'package:flutter/material.dart';
import 'package:translateapp/home.dart';
import 'package:translateapp/utils/color.dart';

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
