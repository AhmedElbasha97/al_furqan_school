import 'package:al_furqan_school/models/homeWork.dart';
import 'package:al_furqan_school/services/loggedUser.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeWorkController extends GetxController{
  bool isLoading = true;
  bool hasNoData= false;
  List<HomeWork> homeworks = [];
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

    homeworks = await LoggedUser().getHomeWorks(id: id);
    if(homeworks.isEmpty){
      hasNoData = true;
    }else{
      hasNoData = false;
    }
    isLoading = false;
  update();
  }
}