// ignore_for_file: file_names
import 'package:al_furqan_school/globals/CommonSetting.dart';
import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {

  String loginLink = "${baseUrl}login.php";
  String signUpLink = "${baseUrl}application.php";

  Future<String?> login({String? userName, String? type, String? password}) async {
    String message = "";
    Response? response  ;
    await FirebaseMessaging.instance.getToken().then((token) async {
      response = await Dio().get(
        "$loginLink?type=$type&username=$userName&password=$password&token=$token",
      );
    });

if (response?.data["status"] == "true") {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString("id", response?.data["info"]["id"]);
  prefs.setString("name", response?.data["info"]["name"]);
  if (type == "PARENTS") {
    prefs.setString("usernameParent", "$userName");
    prefs.setString("passwordParent", "$password");
  }
  prefs.setString("type", "$type");
if(type=="STUDENT"){
  prefs.setString("class", response?.data["info"]["class"]);
}
      message = "done";
      return message;
    } else {
      message = response?.data["msg"];
      return message;
    }
  }

}
