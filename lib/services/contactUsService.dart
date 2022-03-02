// ignore_for_file: file_names

import 'package:al_furqan_school/globals/CommonSetting.dart';
import 'package:dio/dio.dart';

class ContactUsService {
  String complainsUrl = "${baseUrl}claim.php";
  String sendUs = "${baseUrl}contact.php";

  sendComplain(String name, String message, String email, String subject,
      String mobile) async {
    Response response;
    response = await Dio().post(
      "$complainsUrl?name=$name&email=$email&subject=$subject&messege=$message&mobile=$mobile",
    );


  }

  contactUs(String name, String message, String email, String subject,
      String mobile) async {
    Response response;
    response = await Dio().post(
      "$sendUs?name=$name&email=$email&subject=$subject&messege=$message&mobile=$mobile",
    );

  }
}
