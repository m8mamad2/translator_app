import 'package:flutter_tts/flutter_tts.dart';

class SpeackService {

  late FlutterTts flutterTts;

  SpeackService(){
    flutterTts = FlutterTts();
  }

  Future confing()async{
    await flutterTts.setLanguage('en-US');
    await flutterTts.setSpeechRate(1.0);
    await flutterTts.setVolume(1.0);
  }
  
  Future startSpeak(String text) async => await flutterTts.speak(text);
  

}