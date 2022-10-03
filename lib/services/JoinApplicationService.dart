// ignore_for_file: file_names

import 'package:al_furqan_school/globals/CommonSetting.dart';
import 'package:dio/dio.dart';

class JoinApplication {
  String signUpLink = "${baseUrl}application.php";

  Future<String?> sendApplication(
      {String? name,
        String?email,
      String? oldSchool,
      String? birthdate,
      String? gender,
      String? birthPlace,
      String? nationalty,
        String? motherWork,
        String? relation,
        String? phone2,
      String? zipCode,
      String? phone1,
      String? year,
      String? parentName,
      String? parentRelation,
      String? parentJob,
      String? notes}) async {
    Response response;
    response = await Dio().get("$signUpLink?exp_fname=$name&exp_email=$email&exp_preschool=$oldSchool&exp_birthdate=$birthdate&exp_type=$gender&exp_birthplace=$birthPlace&exp_citybrth=$birthPlace&exp_zipcode=$zipCode&exp_tels=$phone1&exp_year=$year&exp_pname=$parentName&exp_relation=$relation&exp_pjob=$parentJob&exp_notes=$notes&exp_tels2=$phone2&exp_pnath=$nationalty&exp_mother=$motherWork&exp_pmel=$parentRelation",);
    var data = response.data["status"];
    return data;
  }
}
