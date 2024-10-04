import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:translator_app/utils/color.dart';
import 'package:translator_app/utils/sized.dart';



Widget translateContainer(BuildContext context,TextEditingController text, bool isTranslatorContainer, VoidCallback deleteOnPress,
  [VoidCallback? translationOnPress, Future Function(String text)? startSpeak]){
 
 ScrollController scrollController = ScrollController();
 return Container(
    width: kWidth(context)*0.9,
    height: kHeight(context)*0.3,
    decoration: BoxDecoration(
      gradient: const SweepGradient(
        center: Alignment.topLeft,
        colors: [
          kSecond_color,
          Color(0xFF171718),
          kBG_color
      ]),
      borderRadius: BorderRadius.circular(18)
    ),
    child: Stack(
      children: [ 
        
        Container(
          height: kHeight(context)*0.24,
          width: kWidth(context)*0.9,
          padding: EdgeInsets.only(bottom: kHeight(context)*0.05),
          margin: EdgeInsets.all(kWidth(context)*0.05),
          child: Scrollbar(
            controller: scrollController,
            radius: const Radius.circular(5),
            thumbVisibility: true,
            child: SingleChildScrollView(
              child: TextField(
                minLines: 4,
                maxLines: 20,
                scrollController: scrollController,
                controller: text,
                autocorrect: true,
                onTap: () => text.selection = TextSelection(baseOffset: 0, extentOffset: text.value.text.length),
                keyboardType: TextInputType.multiline,
                style:const TextStyle( color: Colors.white ),
                decoration: const InputDecoration( border: InputBorder.none ),)),
          )),
        
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            height: kHeight(context)*0.04,
            width: kWidth(context)*0.8,
            margin: EdgeInsets.only(bottom: kHeight(context)*0.02),
            decoration: BoxDecoration(
              color: const Color(0xFF2c2c2c),
              borderRadius: BorderRadius.circular(20)
            ),
            child: Row(
              children: [
                IconButton(
                  onPressed: ()=> Clipboard.setData(ClipboardData(text: text.text))
                    .then((value) => ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Copied'))) ), 
                  icon: const Icon(Icons.copy,size: 18,color: kThired_color,)),
                IconButton(onPressed: deleteOnPress, icon: const Icon(Icons.delete,size: 18,color: kThired_color,)),
                isTranslatorContainer ? IconButton(onPressed: ()async => text.text.isNotEmpty ?  await startSpeak!(text.text) : null , icon: const Icon(Icons.volume_up, color: kThired_color,)) : const SizedBox.shrink(),
                isTranslatorContainer ? const Spacer() : const SizedBox.shrink(),
                isTranslatorContainer 
                  ? ElevatedButton.icon(
                      onPressed: translationOnPress, 
                      icon:  const Icon(Icons.arrow_right,color: kThired_color,), 
                      label: const Text('Translate',style: TextStyle(color: kThired_color),),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: kBG_color,

                      ),
                      ) 
                  : const SizedBox.shrink()
              ],
            ),
          ),
        )
      ],
    ),
  );
}
