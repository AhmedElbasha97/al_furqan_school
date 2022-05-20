import 'package:al_furqan_school/globals/CommonSetting.dart';
import 'package:al_furqan_school/models/new/departmen_detail_model.dart';
import 'package:dio/dio.dart';

class DepartmentServices{
  String departmentURL ="${baseUrl}office_department_app_articles.php?";
  Future<DepartmentDataModel?> getDepartmentData(String? id) async {
    DepartmentDataModel data =DepartmentDataModel();
    Response response;
    response = await Dio().get(
     departmentURL+"dep_id=$id",
    );

    if(response.data!=null){
    data = DepartmentDataModel.fromJson(response.data[0]);}else{
      return null;
    }
    return data;
    }

  }
