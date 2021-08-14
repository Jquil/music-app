import 'package:shared_preferences/shared_preferences.dart';

class MySP{

  static MySP instance = MySP._internal();

  factory MySP() => instance;

  SharedPreferences ?_sp;


  MySP._internal(){
    initSP();
  }

  Future<void> initSP() async{
    _sp = await SharedPreferences.getInstance();
  }

  Future<void> setString(String key,String value) async{
    _sp!.setString(key, value);
  }

  String getString(String key){
    String? v = _sp!.getString(key);
    return v == null ? "" : v;
  }
}