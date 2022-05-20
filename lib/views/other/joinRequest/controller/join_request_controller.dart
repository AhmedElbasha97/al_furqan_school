import 'package:al_furqan_school/globals/commonStyles.dart';
import 'package:al_furqan_school/globals/helpers.dart';
import 'package:al_furqan_school/services/JoinApplicationService.dart';
import 'package:al_furqan_school/services/notification_services.dart';
import 'package:al_furqan_school/views/startScreens/choose_state_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class JoinRequestController extends GetxController{
  bool isLoading = false;
  var val = 0;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  bool disableBTN = true;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController oldSchoolController =  TextEditingController();
  final TextEditingController mobileController =  TextEditingController();
  final TextEditingController joinSchoolYearController =  TextEditingController();
  final TextEditingController idNumberController =  TextEditingController();
  final TextEditingController birthdateController =  TextEditingController();
  final TextEditingController genderController =  TextEditingController();
  final TextEditingController religionController =  TextEditingController();
  final TextEditingController birthPlaceController =  TextEditingController();
  final TextEditingController nationaltyController =  TextEditingController();
  final TextEditingController cityController =  TextEditingController();
  final TextEditingController provinceController =  TextEditingController();
  final TextEditingController regNumberController =  TextEditingController();
  final TextEditingController addressController =  TextEditingController();
  final TextEditingController zipCodeController =  TextEditingController();
  final TextEditingController phoneController =  TextEditingController();
  final TextEditingController yearController =  TextEditingController();
  final TextEditingController regStatusController =  TextEditingController();
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
    NotificationServices.checkNotificationAppInForeground(context);
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
    regStatusController.text="";
    religionController.text="";
    regNumberController.text="";
    yearController.text="";
    phoneController.text="";
    zipCodeController.text="";
    addressController.text="";
    provinceController.text="";
    cityController.text="";
    nationaltyController.text="";
    birthPlaceController.text="";
    genderController.text="";
    birthdateController.text="";
    idNumberController.text="";
    oldSchoolController.text="";
    mobileController.text="";
    joinSchoolYearController.text="";
    disableBTN=true;
    update();

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
    isLoading = true;
    update();
    String? result = await JoinApplication().sendApplication(
        name: nameController.text,
        email: emailController.text,
        oldSchool: oldSchoolController.text,
        mobile: mobileController.text,
        joinSchoolDate: joinSchoolYearController.text,
        idNumber: idNumberController.text,
        birthdate: birthdateController.text,
        gender: genderController.text,
        religion: religionController.text,
        birthPlace: birthPlaceController.text,
        nationalty: nationaltyController.text,
        city: cityController.text,
        province: provinceController.text,
        regNumber: regNumberController.text,
        address: addressController.text,
        zipCode: zipCodeController.text,
        phone: phoneController.text,
        year: yearController.text,
        regStatus: regStatusController.text,
        parentName: parentNameController.text,
        relation: relationController.text,
        parentJob: parentJobController.text,
        notes: notesController.text);

    isLoading = false;
    update();
    if (result == "true") {
      doneMassage(context,"تم ارسال البيانات للمراجعه بنجاح", Icon(Icons.check_circle_outline_rounded ,color: mainColor,size: 90,),);
      clearData();
      Future.delayed(const Duration(milliseconds: 500), () {
        pushPageReplacement(context, const ChooseStateScreen());
      });
    } else {
      doneMassage(context,"لم يتم ارسال البيانات للمراجعه حاول مره اخرى لاحقا", Icon(Icons.clear ,color: mainColor,size: 90,),);

    }
  }
}