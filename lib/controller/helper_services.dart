import 'package:shared_preferences/shared_preferences.dart';

class HelperServices {
 static saveServerData(key,value) async {
   SharedPreferences preferences = await SharedPreferences.getInstance();
   preferences.setString(key, value);
  }

  static Future<String> getServerData(key)async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var value =preferences.getString(key)??"";
    return value;
  }
  static setConfiguration(value)async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setBool("isConfigured",value );
  }

 static Future<bool> checkConfiguration()async{
   SharedPreferences preferences = await SharedPreferences.getInstance();
   var value =preferences.getBool("isConfigured")??false;
   return value;
 }

}
