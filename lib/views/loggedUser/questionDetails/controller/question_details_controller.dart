import 'package:al_furqan_school/globals/helpers.dart';
import 'package:al_furqan_school/models/questionDetails.dart';
import 'package:al_furqan_school/services/loggedUser.dart';
import 'package:al_furqan_school/services/notification_services.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class QuestionDetailsController extends GetxController{
  bool isLoading = true;
  bool isOffline = false;
  final BuildContext context;
  QuestionDetailsController(this.context);
  List<QuestionDetails> questions = [];
  var questionID= Get.arguments;

  @override
  Future<void> onInit() async {
    super.onInit();
    isOffline = !await connectivityChecker();
    if(!isOffline){
      await getData();
    }
    NotificationServices.checkNotificationAppInForeground(context);
  update();
  }
  refreshFunction() async {
    isOffline = !await connectivityChecker();
    if(!isOffline){
      await getData();
    }else{
      showTheDialog(context,"لم يتم الاتصال بالشكل الصحيح","قم التصال بشبكة الانترنت و حاول مره اخرى");
    }
  }
  hasFileLink(index){
    return questions[index].fileLink != null;
  }
  hasFileData(index){
    return questions[index].fileDet != null;
  }
  getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? id = prefs.getString("id");
    questions =
    await LoggedUser().getQuestionsDetails(id: id, qId:questionID[0]);
    isLoading = false;
    update();
  }
  launchURL(context, index) async {
    if (await launchUrl(Uri.parse(questions[index].fileLink??""))) {

      showTheDialog(context, "لا يمكن تحميل هذا الملف", "لا يوجد ملف متاح للتحميل لهذا السؤال");
      throw 'Could not launch ${questions[index].fileLink}';

    }
  }
}