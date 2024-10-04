import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

class SpeackToTextService {
  
  static late SpeechToText speechToText;
  
  SpeackToTextService(){
    speechToText = SpeechToText();
  }

  void initSpeech()async => await speechToText.initialize();

  void startListening(void Function(SpeechRecognitionResult)? onResult) async {
    await speechToText.listen(
      onResult: onResult,
      listenFor: const Duration(seconds: 30),
      localeId: "en_En",
      listenOptions: SpeechListenOptions(
        cancelOnError: false,
        partialResults: false,
        listenMode: ListenMode.confirmation,
      ),
    );
    // setState(() {});
  }

  void stopListening() async {
    await speechToText.stop();
  }

}