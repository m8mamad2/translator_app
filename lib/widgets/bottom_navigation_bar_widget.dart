
import 'package:flutter/material.dart';
// import 'package:flutter_tesseract_ocr/android_ios.dart';
import 'package:translator_app/utils/color.dart';
import 'package:translator_app/utils/sized.dart';
import 'package:translator_app/widgets/one_bottom_navigation_widget.dart';


Widget bottomNaviationBarWidget(BuildContext context,bool isNotSpeching,VoidCallback startListening,VoidCallback stopListening,[VoidCallback? imageTranslateOnPress, ])=> Padding(
  padding: EdgeInsets.only(right: kWidth(context)*0.05,left: kWidth(context)*0.05,bottom: kWidth(context)*0.05),
  child: Stack(
    alignment: Alignment.topCenter,
    children: [

      //* Bottom Navigation Item
      Container(
        height: kHeight(context)*0.13,
        padding: EdgeInsets.only(top: kHeight(context)*0.045),
        child: Container(
          height: kHeight(context)*0.08,
          padding: EdgeInsets.only(
            right: kWidth(context)*0.08,
            left: kWidth(context)*0.08,
            top: kHeight(context)*0.01
            ),
          decoration: BoxDecoration(color: const Color(0xFF2c2c2c),borderRadius: BorderRadius.circular(20), ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              oneBottomNavigationBarItem(context,Icons.transcribe,'Translation',(){},true),
              oneBottomNavigationBarItem(context,Icons.image,'Image',imageTranslateOnPress!,true),
            ],
          ),
        ),
      ),

      //* Voice Floating Action Button
      ElevatedButton(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: kBG_color,
          minimumSize: Size(kWidth(context)*0.19, kWidth(context)*0.19),
          shape: const CircleBorder()
        ),
        child: const SizedBox.shrink(),
        onPressed: (){},
      ),
      ElevatedButton(
        style: ElevatedButton.styleFrom(
          elevation: 10,
          backgroundColor: kThired_color,
          minimumSize: Size(kWidth(context)*0.18, kWidth(context)*0.18),
          shape: const CircleBorder()
        ),
        onPressed: isNotSpeching ? startListening : stopListening,
        child: Icon(isNotSpeching  ? Icons.mic_off : Icons.mic,color: kBG_color,),
      ),
    ],
  ),
);


