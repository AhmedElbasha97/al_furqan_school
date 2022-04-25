// ignore_for_file: file_names
import 'package:al_furqan_school/models/new/requests.dart';
import 'package:dio/dio.dart';

class ContactUsService {
  String baseurl = "https://alforqanschools.sch.qa/site/api/";
  String complainsUrl = "contact.php?";


  sendComplain(String name, String message, String email, String subject,
      String mobile) async {
    Response response;
    response = await Dio().post(
      "$baseurl$complainsUrl?name=$name&email=$email&subject=$subject&message=$message&mobile=$mobile",
    );
    var resData = response.data;
   return Requsts.fromJson(response.data).status;

  }
}
