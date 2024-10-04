
import 'dart:io';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';

class TranslatorImageService {
  late TextRecognizer recognizer;

  TranslatorImageService() { 
    recognizer = TextRecognizer(script: TextRecognitionScript.latin); 
  }

  void dispose() => recognizer.close();

  Future<String> processImage(String imgPath) async {
    final image = InputImage.fromFile(File(imgPath));
    final recognized = await recognizer.processImage(image);
    return recognized.text;
  }


}

