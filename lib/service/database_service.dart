import 'package:shared_preferences/shared_preferences.dart';
import 'package:translator_app/utils/translate_enums.dart';



class DatabaseService {
  
  static late SharedPreferences sharedPreferences;
  
  static Future init()async{
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static setFromValue(TranslateEnums value)async => await sharedPreferences.setString('from', value.name);
  static setToValue(TranslateEnums value)async => await sharedPreferences.setString('to', value.name);
  
  static getFromValue()=> sharedPreferences.getString('from') ?? 'en';
  static getToValue()=>   sharedPreferences.getString('to') ?? 'fa';

  
}