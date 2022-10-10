// ignore_for_file: file_names

import 'package:al_furqan_school/globals/CommonSetting.dart';
import 'package:dio/dio.dart';

class JoinApplication {
  String signUpLink = "${baseUrl}application.php";

  Future<String?> sendApplication(
      {String? name,
        String?email,
      String? oldSchool,
      String? mobile,
      String? joinSchoolDate,
      String? idNumber,
      String? birthdate,
      String? gender,
      String? religion,
      String? birthPlace,
      String? nationalty,
      String? city,
      String? province,
      String? regNumber,
      String? address,
      String? zipCode,
      String? phone,
      String? year,
      String? regStatus,
      String? parentName,
      String? relation,
      String? parentJob,
      String? notes}) async {
    Response response;
    response = await Dio().get("$signUpLink?exp_fname=$name&exp_email=$email&exp_preschool=$oldSchool&exp_mob=$mobile&exp_date=$joinSchoolDate&exp_idstudent=$idNumber&exp_birthdate=$birthdate&exp_type=$gender&exp_religion=$religion&exp_birthplace=$birthPlace&exp_nationalty=$nationalty&exp_citybrth=$birthPlace&exp_provincebrth=$province&exp_registnum=$regNumber&exp_address=$address&exp_city=$city&exp_zipcode=$zipCode&exp_tels=$phone&exp_year=$year&exp_registstatus=$regStatus&exp_pname=$parentName&exp_relation=$relation&exp_pjob=$parentJob&exp_notes=$notes",);
    var data = response.data["status"];
    return data;
  }
}
