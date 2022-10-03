// ignore_for_file: file_names
import 'package:al_furqan_school/globals/commonStyles.dart';
import 'package:al_furqan_school/globals/widgets/offline_widget.dart';
import 'package:al_furqan_school/views/appData/privacypolicy/privacyPolicyScreen.dart';
import 'package:al_furqan_school/views/appData/term&condition/terms_screen.dart';
import 'package:al_furqan_school/views/loader.dart';
import 'package:al_furqan_school/views/other/joinRequest/controller/join_request_controller.dart';
import 'package:flutter/material.dart';
import 'package:al_furqan_school/I10n/app_localizations.dart';
import 'package:al_furqan_school/globals/widgets/mainButton.dart';
import 'package:al_furqan_school/globals/widgets/textFiled.dart';
import 'package:get/get.dart';
class JoinRequest extends StatelessWidget {
  const JoinRequest({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init:  JoinRequestController(context),
      builder: (JoinRequestController controller) =>   Scaffold(
        key: controller.scaffoldKey,
        backgroundColor: white,
        appBar: AppBar(
          title: Text(
            "${AppLocalizations.of(context)!.translate('joinRequest')}",
          ),
          automaticallyImplyLeading: true,
          iconTheme:  IconThemeData(color: white),
          backgroundColor: mainColor,
        ),
        bottomNavigationBar:controller.isOffline?OfflineWidget(refreshedFunc: (){controller.refreshFunction();},):const SizedBox(width: 0,height: 0,),
        body: controller.isLoading
            ?const Loader()

            : ListView(
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          children: [
            const SizedBox(
              height: 15,
            ),
            InputFiled(
              controller: controller.nameController,
              hintText: "الاسم",
              inputType: TextInputType.text,
            ),
            const SizedBox(
              height: 15,
            ),
            InputFiled(
              controller: controller.birthdateController,
              hintText: "تاريخ الميلاد",
              inputType: TextInputType.datetime,
            ),
            const SizedBox(
              height: 15,
            ),
            InputFiled(
              controller: controller.birthPlaceController,
              hintText:
              "مكان الولادة",
              inputType: TextInputType.streetAddress,
            ),
          const SizedBox(
              height: 15,
            ),
            InputFiled(
              controller: controller.nationaltyController,
              hintText:
              "الجنسية",
              inputType: TextInputType.text,
            ),  const SizedBox(
              height: 15,
            ),
            InputFiled(
              controller: controller.yearController,
              hintText:
              "السنة الدراسية",
              inputType: TextInputType.datetime,
            ),
            const SizedBox(
              height: 15,
            ),
            InputFiled(
              controller: controller.oldSchoolController,
              hintText:
              "المدرسة السابقة",
              inputType: TextInputType.text,
            ),const SizedBox(
              height: 15,
            ),
            InputFiled(
              controller: controller.parentNameController,
              hintText:
              "اسم ولي الامر",
              inputType: TextInputType.text,
            ),
            const SizedBox(
              height: 15,
            ), InputFiled(
              controller: controller.relationController,
              hintText:
              "صلة القرابة",
              inputType: TextInputType.text,
            ),
            const SizedBox(
              height: 15,
            ),
            InputFiled(
              controller: controller.genderController,
              hintText: "جنسية ولى الأمر",
              inputType: TextInputType.text,
            ),
            const SizedBox(
              height: 15,
            ),
            InputFiled(
              controller: controller.parentJobController,
              hintText:
              "وظيفة ولي الامر",
              inputType: TextInputType.text,
            ),
            const SizedBox(
              height: 15,
            ),

            Container(
              decoration: BoxDecoration(
                color: white,
                border: Border.all(width: 1.0,color: mainColor),
                borderRadius: BorderRadius.circular(15),
                boxShadow:  [
                  BoxShadow(
                    color: white,
                    offset: const Offset(
                      5.0,
                      5.0,
                    ),
                    blurRadius: 10.0,
                    spreadRadius: 2.0,
                  ), //BoxShadow
                  const BoxShadow(
                    color: Colors.white,
                    offset: Offset(0.0, 0.0),
                    blurRadius: 0.0,
                    spreadRadius: 0.0,
                  ), //BoxShadow
                ],
              ),
              width: 200,
              height: 60,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: DropdownButton<String>(
                  dropdownColor: white,
                  icon: Container(),
                  value: controller.selectedMaritalStatus,
                  items: <String>[
                    'أختر الحاله الأجتماعية',
                    'متزوج',
                    'أرمل',
                    'مطلق',
                  ].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value,style: TextStyle(color:mainColor,),),
                    );
                  }).toList(),
                  onChanged: (value) {
                     controller.chooseMaritalStatus(value);
                  },
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Container(
              decoration: BoxDecoration(
                color: white,
                border: Border.all(width: 1.0,color: mainColor),
                borderRadius: BorderRadius.circular(15),
                boxShadow:  [
                  BoxShadow(
                    color: white,
                    offset: const Offset(
                      5.0,
                      5.0,
                    ),
                    blurRadius: 10.0,
                    spreadRadius: 2.0,
                  ), //BoxShadow
                  const BoxShadow(
                    color: Colors.white,
                    offset: Offset(0.0, 0.0),
                    blurRadius: 0.0,
                    spreadRadius: 0.0,
                  ), //BoxShadow
                ],
              ),
              width: 200,
              height: 60,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: DropdownButton<String>(
                  dropdownColor: white,
                  icon: Container(),
                  value: controller.selectedMotherWorkingStatus,
                  items: <String>[
                    'أختر  الحالة الوظيفي للأم',
                    ' تعمل',
                    'لا تعمل',

                  ].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value,style: TextStyle(color:mainColor,),),
                    );
                  }).toList(),
                  onChanged: (value) {
                    controller.chooseMotherWorkingStatus(value);
                  },
                ),
              ),
            ),const SizedBox(
              height: 15,
            ),
            InputFiled(
              controller: controller.phoneController1,
              hintText:
              "رقم الهاتف الأول ",
              inputType: TextInputType.phone,
            ),
            const SizedBox(
              height: 15,
            ),
            InputFiled(
              controller: controller.phoneController2,
              hintText:
              "رقم الهاتف الثانى",
              inputType: TextInputType.phone,
            ),
            const SizedBox(
              height: 15,
            ),
            InputFiled(
              controller: controller.emailController,
              hintText:
              "البريد الالكترونى",
              inputType: TextInputType.emailAddress,
            ),
            const SizedBox(
              height: 15,
            ),
            InputFiled(
              controller: controller.zipCodeController,
              hintText:
              "الصندوق البريدي",
              inputType: TextInputType.number,
            ),

            const SizedBox(
              height: 15,
            ),

            InputFiled(
              controller: controller.notesController,
              hintText: "ملاحظات",
              inputType: TextInputType.multiline,
            ),
            const SizedBox(
              height: 15,
            ),
            Container(
              decoration: BoxDecoration(
                color: white,
                border: Border.all(width: 1.0,color: mainColor),
                borderRadius: BorderRadius.circular(15),
                boxShadow:  [
                  BoxShadow(
                    color: white,
                    offset: const Offset(
                      5.0,
                      5.0,
                    ),
                    blurRadius: 10.0,
                    spreadRadius: 2.0,
                  ), //BoxShadow
                  const BoxShadow(
                    color: Colors.white,
                    offset: Offset(0.0, 0.0),
                    blurRadius: 0.0,
                    spreadRadius: 0.0,
                  ), //BoxShadow
                ],
              ),
              width: 200,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Icon(Icons.assignment_late_outlined,color: mainColor,size: 30,),
                     const Padding(
                       padding: EdgeInsets.all(8.0),
                       child: Text("خلال العام الدراسي سيقوم موظفونا بالتالي:   * التقاط صور ثابتة (فوتوغرافية) وعرضها للجمهور عبر الانترنت* التقاط صور متحركة (أفلام/فيديو) وعرضها للجمهور عبر الانترنت* تسجيل صوتي - الاستخدام الرقمي والالكتروني وعرضها للجمهور عبر الانترنت-"),
                     )
                  ],
                ),
              ),
            ),



            const SizedBox(
              height: 30,
            ),
            Row(
              children: [
                Radio(
                  value: 1,
                  fillColor: MaterialStateProperty.all<Color>(teal),

                  groupValue: controller.val,
                  onChanged: (value) {
                    controller.changeValueOfRadioBTN(value);
                  },
                  toggleable: true,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "انا قرأت و اوافق علي ",style: TextStyle(
                    color: mainColor
                ),),
                    Row(
                      children: [
                        InkWell(
                          onTap: (){
                            Get.to(()=>const PrivacyPolicyScreen());
                          },
                          child: Text(
                             "سياسة خاصة",
                            style: TextStyle(
                                color: teal
                            ),
                          ),
                        ),
                        Text(
                            " و ",style: TextStyle(
                          color: mainColor
                        ),),
                        InkWell(
                          onTap: (){
                            Get.to(()=>const TermsScreen());
                          },
                          child: Text(
                             "أحكام وشروط",
                            style: TextStyle(
                                color: teal
                            ),
                          ),
                        ),
                      ],
                    ),

                  ],
                )
              ],
            ),
            const SizedBox(height: 25),
            AppBtn(
                onClick: () {
                  controller.sendRequest(context);
                },
                label: "ارسال",disable: controller.disableBTN,disableAlertTitle: "لا يمكنك تسجيل البينات",disableAlertText: "يجب عليك قراءة والموافقه على شروط واحكام و السياسة الخاصة بالتطبيق",)
          ],
        ),
      ),
    );
  }
}
