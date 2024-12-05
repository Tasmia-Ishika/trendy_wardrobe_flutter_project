import 'dart:convert';
import 'package:final_flutter_project/users/model/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RememberUserPrefs
{
  //save user info
  static Future<void> saveRememberUser(User userInfo) async
  {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String userJsonData = jsonEncode(userInfo.toJson());
    await preferences.setString("currentUser", userJsonData);

  }
}