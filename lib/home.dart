import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:translateapp/service/translator_service.dart';
import 'package:translateapp/utils/color.dart';
import 'package:translateapp/utils/sized.dart';
import 'package:translateapp/widgets/bottom_navigation_bar_widget.dart';
import 'package:translateapp/widgets/translate_contaienr_widget.dart';
import 'package:translator/translator.dart';


class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}
class _MyHomePageState extends State<MyHomePage> {

  //* Translation 
  final translator = GoogleTranslator();
  TextEditingController? translateRes = TextEditingController();
  
  //* Image Translation
  late TranslatorServiceAbs _recognizer;
  TextEditingController? data = TextEditingController();

  //* Voice
  final SpeechToText _speechToText = SpeechToText();
  final bool _speechEnabled = false;

  //* For Speck
  FlutterTts flutterTts = FlutterTts();

  @override
  void initState() {
    super.initState();
    if(!_speechEnabled) _initSpeech();
    _recognizer = TranslatorService();
    confing();
  }

  @override
  void dispose() {
    super.dispose();
    if(_recognizer is TranslatorService) (_recognizer as TranslatorService).dispose();
  }

  //* For Image‍
  void processImage() async {

    final XFile? image = await ImagePicker().pickImage(source: ImageSource.gallery);

    if(image?.path != null) {
      final recognizedText = await _recognizer.processImage(image!.path);
      setState(() => data!.text = recognizedText );
    }
}

  //* For Translation 
  void translation()async{
    if(data != null){
      Translation res = await translator.translate(data!.text,to: 'fa');
      setState(() => translateRes!.text = res.text );
    }
  }

  //* For Wipe Data
  void deleteData(TextEditingController data)=> data.clear();

  //* For Voice Recording
  void _initSpeech()async => await _speechToText.initialize();
  void _startListening() async {
    await _speechToText.listen(
      onResult: (result) => setState(()=> data!.text = result.recognizedWords ),
      listenFor: const Duration(seconds: 30),
      localeId: "en_En",
      cancelOnError: false,
      partialResults: false,
      listenMode: ListenMode.confirmation,
    );
    setState(() {});
  }
  void _stopListening() async {
    await _speechToText.stop();
    setState(() {});
  }

  //* For Speck 
  Future confing()async{
    await flutterTts.setLanguage('en-US');
    await flutterTts.setSpeechRate(1.0);
    await flutterTts.setVolume(1.0);
  }
  Future startSpeak(String text) async => await flutterTts.speak(text);
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBG_color,
      appBar: AppBar(
        leading: Center(child: Container(margin: EdgeInsets.only(right: kWidth(context)*0.06),child: const Text('Translate',style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold,fontSize: 19),))),
        leadingWidth: kWidth(context)*0.4,
        foregroundColor: kBG_color,
        elevation: 0,
        backgroundColor: kBG_color, ),
      bottomNavigationBar: bottomNaviationBarWidget( context,  _speechToText.isNotListening , _startListening, _stopListening, processImage),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              
              translateContainer(context, data! ,true,()=>deleteData(data!),translation,startSpeak),
              SizedBox(height: kHeight(context)*0.01,),
              translateContainer(context, translateRes! ,false,()=>deleteData(translateRes!)),

            ],
          ),
        ),
      )
    );
  }
}


