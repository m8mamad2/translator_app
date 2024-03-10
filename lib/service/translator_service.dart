
import 'dart:io';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';

abstract class TranslatorServiceAbs { Future<String> processImage(String imgPath);  }
class TranslatorService extends TranslatorServiceAbs {
  late TextRecognizer recognizer;

  TranslatorService() { recognizer = TextRecognizer(); }

  void dispose() => recognizer.close();

  @override
  Future<String> processImage(String imgPath) async {
    // final image = InputImage.fromFile(File(imgPath));
    final image = InputImage.fromFile(File(imgPath));
    final recognized = await recognizer.processImage(image);
    return recognized.text;
  }
//   Future<void> processImageInBlocks(InputImage image) async {
//   final recognized = await recognizer.processImage(image);
//   final blocks = recognized.blocks;
//   for (int i = 0; i < blocks.length; i++) {
//     final e = blocks[i];
//     print(e.text);
//   }
// }

}

