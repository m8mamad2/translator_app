import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:translator/translator.dart';
import 'package:translator_app/service/database_service.dart';
import 'package:translator_app/service/speack_service.dart';
import 'package:translator_app/service/speack_to_text_service.dart';
import 'package:translator_app/service/translator_service.dart';
import 'package:translator_app/utils/color.dart';
import 'package:translator_app/utils/sized.dart';
import 'package:translator_app/widgets/bottom_navigation_bar_widget.dart';
import 'package:translator_app/widgets/translate_contaienr_widget.dart';


class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}
class _MyHomePageState extends State<MyHomePage> {

  final translator = GoogleTranslator();
  final SpeackService speackService = SpeackService();
  final SpeackToTextService speackToTextService = SpeackToTextService();
  final TranslatorImageService _recognizer = TranslatorImageService();
  final SpeechToText _speechToText = SpeechToText();
  
  TextEditingController? translateRes = TextEditingController();
  TextEditingController? inputController = TextEditingController();
  

  @override
  void initState() {
    super.initState();
    _initSpeech();
    speackService.confing();
    DatabaseService.init();
  }

  @override
  void dispose() {
    super.dispose();
    _recognizer.dispose();
  }

  //* For Image‍
  void processImage() async {

    final XFile? image = await ImagePicker().pickImage(source: ImageSource.gallery);

    if(image?.path != null) {
      final recognizedText = await _recognizer.processImage(image!.path);
      setState(() => inputController!.text = recognizedText );
    }
}

  //* For Translation 
  void translation()async{
    if(inputController != null){
      Translation res = await translator.translate(inputController!.text,from: DatabaseService.getFromValue(),to: DatabaseService.getToValue());
      setState(() => translateRes!.text = res.text );
    }
  }

  //* For Wipe Data
  void deleteData(TextEditingController data)=> data.clear();

  //* For Voice Recording
  void _initSpeech()async => await _speechToText.initialize();
  void _startListening() async {
    await _speechToText.listen(
      onResult: (result) => setState(()=> inputController!.text = result.recognizedWords ),
      listenFor: const Duration(seconds: 30),
      listenOptions: SpeechListenOptions(
        cancelOnError: false,
        partialResults: false,
        listenMode: ListenMode.confirmation,
      ),
    );
    setState(() {});
  }
  void _stopListening() async {
    await _speechToText.stop();
    setState(() {});
  }

  
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
              
              translateContainer(context, inputController! ,true,()=>deleteData(inputController!), translation, speackService.startSpeak),
              SizedBox(height: kHeight(context)*0.01,),
              translateContainer(context, translateRes! ,false,()=>deleteData(translateRes!)),

            ],
          ),
        ),
      )
      
    );
  }

}


