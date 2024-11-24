import 'package:shared_preferences/shared_preferences.dart';

class CasheHelper {
  static late SharedPreferences sharedPreferences;

  static init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

 static void setUserToken({required String token}) {
    sharedPreferences.setString("token", token);
  }


  static String? getUserToken() {
    print("asdasdasd ${sharedPreferences.getString("token")}");
    return sharedPreferences.getString("token");
  }


  static void clearSharedPreferences() {
    sharedPreferences.clear();
  }
}
