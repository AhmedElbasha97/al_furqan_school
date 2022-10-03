import 'package:al_furqan_school/globals/commonStyles.dart';
import 'package:al_furqan_school/globals/helpers.dart';
import 'package:al_furqan_school/services/JoinApplicationService.dart';
import 'package:al_furqan_school/services/notification_services.dart';
import 'package:al_furqan_school/views/startScreens/choose_state_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class JoinRequestController extends GetxController{
  bool isLoading = false;
  bool isOffline = false;
  String selectedMaritalStatus = "أختر الحاله الأجتماعية";
  String maritalStatus = "" ;
  String selectedMotherWorkingStatus = "أختر  الحالة الوظيفي للأم";
  String motherWorkingStatus = "";
  var val = 0;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  bool disableBTN = true;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController oldSchoolController =  TextEditingController();
  final TextEditingController birthdateController =  TextEditingController();
  final TextEditingController genderController =  TextEditingController();
  final TextEditingController birthPlaceController =  TextEditingController();
  final TextEditingController nationaltyController =  TextEditingController();
  final TextEditingController zipCodeController =  TextEditingController();
  final TextEditingController phoneController1 =  TextEditingController();
  final TextEditingController phoneController2 =  TextEditingController();
  final TextEditingController yearController =  TextEditingController();
  final TextEditingController parentNameController =  TextEditingController();
  final TextEditingController relationController =  TextEditingController();
  final TextEditingController parentJobController =  TextEditingController();
  final TextEditingController notesController =  TextEditingController();
  final TextEditingController emailController =  TextEditingController();
  final BuildContext context;
  JoinRequestController(this.context);
  @override
  Future<void> onInit() async {
    super.onInit();
    isOffline = !await connectivityChecker();
    NotificationServices.checkNotificationAppInForeground(context);
  update();
  }
  refreshFunction() async {
    isOffline = !await connectivityChecker();
    if(!isOffline){
    }else{
      showTheDialog(context,"لم يتم الاتصال بالشكل الصحيح","قم التصال بشبكة الانترنت و حاول مره اخرى");
    }
  }
  chooseMaritalStatus(value){
    maritalStatus = value;
    selectedMaritalStatus = value;
    update();
  }
  chooseMotherWorkingStatus(value){
    motherWorkingStatus = value;
    selectedMotherWorkingStatus = value;
    update();
  }
  Future<void> doneMassage(context,String title, Icon icon) async {
    return showDialog<void>(

      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return StatefulBuilder(builder: (context, StateSetter setState) {
              return Dialog(
                child: Container(
                    color: white,
                    width: MediaQuery.of(context).size.width*0.1,
                    height: MediaQuery.of(context).size.height * 0.2,
                    child:  Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          icon,
                          Text(title,style: TextStyle(color: mainColor,fontWeight: FontWeight.bold,fontSize: 15),textAlign: TextAlign.center,),
                        ],
                      ),
                    )
                ),
              );
            });
          },
        );
      },
    );
  }
  clearData(){
    nameController.text= "";
    emailController.text= "";
    notesController.text= "";
    parentJobController.text="";
    relationController.text="";
    yearController.text="";
    zipCodeController.text="";
    selectedMaritalStatus = "أختر الحاله الأجتماعية";
     selectedMotherWorkingStatus = "أختر  الحالة الوظيفي للأم";
    nationaltyController.text="";
    birthPlaceController.text="";
    genderController.text="";
    birthdateController.text="";
    oldSchoolController.text="";
    disableBTN=true;
    update();

  }
  validationOfText(){
    if(nameController.text!=""||nameController.text.trim().isNotEmpty){
      if(birthdateController.text!=""||birthPlaceController.text.trim().isNotEmpty){
        if(birthPlaceController.text!=""||birthPlaceController.text.trim().isNotEmpty){
          if(nationaltyController.text!=""||nationaltyController.text.trim().isNotEmpty){
            if(yearController.text!=""||yearController.text.trim().isNotEmpty){
              if(oldSchoolController.text!=""||oldSchoolController.text.trim().isNotEmpty){
                if(parentNameController.text!=""||parentNameController.text.trim().isNotEmpty){
                  if(relationController.text!=""||relationController.text.trim().isNotEmpty){
                    if(genderController.text!=""||genderController.text.trim().isNotEmpty){
                      if(parentJobController.text!=""||parentJobController.text.trim().isNotEmpty){
                        if(selectedMaritalStatus != "أختر الحاله الأجتماعية"){
                          if(selectedMotherWorkingStatus != "أختر  الحالة الوظيفي للأم"){
                            if(phoneController1.text!=""||phoneController1.text.trim().isNotEmpty){
                              return true;
                            }else{
                              showTheDialog(context,"لا يمكن المتابعه","لابد من ادخال رقم هاتف واحد على الأقل");
                              return false;
                            }
                          }else{
                            showTheDialog(context,"لا يمكن المتابعه","لا بد من اختيار هل الأم تعمل أم لا");
                            return false;
                          }
                        }else{
                          showTheDialog(context,"لا يمكن المتابعه","لابد من إختيار الحاله الاجتماعية لولى الامر");
                          return false;
                        }
                      }else{
                        showTheDialog(context,"لا يمكن المتابعه","لابد من كتابه وظيفه ولى الامر");
                        return false;
                      }
                    }else{
                      showTheDialog(context,"لا يمكن المتابعه","لا بد من كتابه جنسيه ولى الامر");
                      return false;
                    }
                  }else{
                    showTheDialog(context,"لا يمكن المتابعه","لابد من كتابه صله القرابه بين الطالب و ولى الأمر");
                    return false;
                  }
                }else{
                  showTheDialog(context,"لا يمكن المتابعه","لا بد من ادخال اسم ولى الامر");
                  return false;
                }
              }else{
                showTheDialog(context,"لا يمكن المتابعه","لا بد من كتابه اسم المدرسة القديمه للطالب");
                return false;
              }
            }else{
              showTheDialog(context,"لا يمكن المتابعه","لا بد من ادخال الصف الذى تريد الطالب ان ينضم اليه");
              return false;
            }
          }else{
            showTheDialog(context,"لا يمكن المتابعه","لابد من كتابه جنسيه الطالب");
            return false;
          }
        }else{
          showTheDialog(context,"لا يمكن المتابعه","لا بد من ادخال مكان ميلاد الطالب");
          return false;
        }
      }else{
        showTheDialog(context,"لا يمكن المتابعه","لا بد من ادخال تاريخ ميلاد الطالب");
        return false;
      }
    }else{
      showTheDialog(context,"لا يمكن المتابعه","لا بد من كتابه اسم الطالب كاملا");
      return false;
    }
  }
  changeValueOfRadioBTN(value){
   if(value==null){
     val=0;
   }else{
     val=value;
   }
    if(val==1){
      disableBTN=false;
    }else{
      disableBTN =true;
      val==0;
    }
    update();
  }
  sendRequest(context) async {
    if(!isOffline) {
      isLoading = true;
      update();
      String? result;
      if(validationOfText()) {
        String? result = await JoinApplication().sendApplication(
            name: nameController.text,
            email: emailController.text,
            oldSchool: oldSchoolController.text,
            motherWork: motherWorkingStatus,
            parentRelation: maritalStatus,
            birthdate: birthdateController.text,
            gender: genderController.text,
            birthPlace: birthPlaceController.text,
            nationalty: nationaltyController.text,
            phone1: phoneController1.text,
            phone2: phoneController2.text,
            zipCode: zipCodeController.text,
            year: yearController.text,
            parentName: parentNameController.text,
            relation: relationController.text,
            parentJob: parentJobController.text,
            notes: notesController.text);
      }
      isLoading = false;
      update();
      if (result == "true") {
        doneMassage(context, "تم ارسال البيانات للمراجعه بنجاح", Icon(
          Icons.check_circle_outline_rounded, color: mainColor, size: 90,),);
        clearData();
        Future.delayed(const Duration(milliseconds: 500), () {
          pushPageReplacement(context, const ChooseStateScreen());
        });
      } else {
        doneMassage(
          context, "لم يتم ارسال البيانات للمراجعه حاول مره اخرى لاحقا",
          Icon(Icons.clear, color: mainColor, size: 90,),);
      }
    }else{
      showTheDialog(context,"لم يتم الاتصال بالشكل الصحيح","قم التصال بشبكة الانترنت و حاول مره اخرى");

    }
  }
}