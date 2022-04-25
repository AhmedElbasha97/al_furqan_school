import 'package:al_furqan_school/models/homeWorkDetails.dart';
import 'package:al_furqan_school/services/loggedUser.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeWorkDetailsController extends GetxController{
  bool isLoading = true;
  List<HomeWorkDetails> homework = [];
  var homeWorkId= Get.arguments;
  bool hasNoData = false;
  @override
  Future<void> onInit() async {
    super.onInit();
    //Change value to name2
    await getData();
  }
  getData() async {
    isLoading=true;
    update();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? id = prefs.getString("id");
    homework =
    await LoggedUser().gethomeWorkDetails(id: id, homeWorkId: homeWorkId);
    if(homework.isEmpty){
      hasNoData=true;
    }else{
      hasNoData=false;
    }
    isLoading = false;
    update();
  }
}