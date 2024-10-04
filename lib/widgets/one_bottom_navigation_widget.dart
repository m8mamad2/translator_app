import 'package:flutter/material.dart';
import 'package:translator_app/utils/color.dart';
import 'package:translator_app/utils/sized.dart';

Widget oneBottomNavigationBarItem(BuildContext context,IconData icon, String title,VoidCallback onPress,bool isTranslation)=> InkWell(
  onTap: onPress,
  child: Column(
    children: [
      const SizedBox(height: 5,),
      SizedBox(
        height: kHeight(context)*0.03,
        child: Icon(icon, color: isTranslation ? kThired_color : kBG_color,)),
      const SizedBox(height: 1,),
      Text(title, style: const TextStyle(
        color: Colors.white,
        fontSize: 12,
        fontWeight: FontWeight.bold
      ),)
    ],
  ),
);
