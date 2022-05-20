// ignore_for_file: file_names
import 'package:al_furqan_school/globals/CommonSetting.dart';
import 'package:al_furqan_school/models/new/requests.dart';
import 'package:dio/dio.dart';

class ContactUsService {
  String complainsUrl = "${baseUrl}contact.php";



  sendComplain(String name, String message, String email, String subject,
      String mobile) async {
    Response response;
    response = await Dio().post(
      "$complainsUrl?name=$name&email=$email&subject=$subject&message=$message&mobile=$mobile",
    );
   return Requsts.fromJson(response.data).status;

  }
}
