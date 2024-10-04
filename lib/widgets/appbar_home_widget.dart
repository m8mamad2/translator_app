import 'package:flutter/material.dart';
import 'package:translator_app/utils/color.dart';
import 'package:translator_app/utils/sized.dart';

class AppbarHomeWidget extends StatelessWidget implements PreferredSizeWidget{
  const AppbarHomeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
        leading: Center(child: Container(margin: EdgeInsets.only(right: kWidth(context)*0.06),child: const Text('Translate',style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold,fontSize: 19),))),
        leadingWidth: kWidth(context)*0.4,
        foregroundColor: kBG_color,
        elevation: 0,
        backgroundColor: kBG_color, );
  }
  
  @override
  Size get preferredSize => const Size(double.infinity, 100);
}