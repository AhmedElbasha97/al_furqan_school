// ignore_for_file: file_names

import 'package:al_furqan_school/globals/commonStyles.dart';
import 'package:flutter/material.dart';
import 'package:al_furqan_school/I10n/app_localizations.dart';
import 'package:al_furqan_school/globals/helpers.dart';
import 'package:al_furqan_school/globals/widgets/mainButton.dart';
import 'package:al_furqan_school/globals/widgets/textFiled.dart';
import 'package:al_furqan_school/services/JoinApplicationService.dart';
import 'package:al_furqan_school/views/homeScreen.dart';

class JoinRequest extends StatefulWidget {
  const JoinRequest({Key? key}) : super(key: key);

  @override
  _JoinRequestState createState() => _JoinRequestState();
}

class _JoinRequestState extends State<JoinRequest> {
  bool isLoading = false;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _oldSchoolController =  TextEditingController();
  final TextEditingController _mobileController =  TextEditingController();
  final TextEditingController _joinSchoolYearController =  TextEditingController();
  final TextEditingController _idNumberController =  TextEditingController();
  final TextEditingController _birthdateController =  TextEditingController();
  final TextEditingController _genderController =  TextEditingController();
  final TextEditingController _religionController =  TextEditingController();
  final TextEditingController _birthPlaceController =  TextEditingController();
  final TextEditingController _nationaltyController =  TextEditingController();
  final TextEditingController _cityController =  TextEditingController();
  final TextEditingController _provinceController =  TextEditingController();
  final TextEditingController _regNumberController =  TextEditingController();
  final TextEditingController _addressController =  TextEditingController();
  final TextEditingController _zipCodeController =  TextEditingController();
  final TextEditingController _phoneController =  TextEditingController();
  final TextEditingController _yearController =  TextEditingController();
  final TextEditingController _regStatusController =  TextEditingController();
  final TextEditingController _parentNameController =  TextEditingController();
  final TextEditingController _relationController =  TextEditingController();
  final TextEditingController _parentJobController =  TextEditingController();
  final TextEditingController _notesController =  TextEditingController();
  final TextEditingController _emailController =  TextEditingController();

  sendRequest() async {
    isLoading = true;
    setState(() {});
    String? result = await JoinApplication().sendApplication(
        name: _nameController.text,
        oldSchool: _oldSchoolController.text,
        mobile: _mobileController.text,
        joinSchoolDate: _joinSchoolYearController.text,
        idNumber: _idNumberController.text,
        birthdate: _birthdateController.text,
        gender: _genderController.text,
        religion: _religionController.text,
        birthPlace: _birthPlaceController.text,
        nationalty: _nationaltyController.text,
        city: _cityController.text,
        province: _provinceController.text,
        regNumber: _regNumberController.text,
        address: _addressController.text,
        zipCode: _zipCodeController.text,
        phone: _phoneController.text,
        year: _yearController.text,
        regStatus: _regStatusController.text,
        parentName: _parentNameController.text,
        relation: _relationController.text,
        parentJob: _parentJobController.text,
        notes: _notesController.text);

    isLoading = false;
    setState(() {});
    if (result == "true") {
      pushPageReplacement(context, const HomeScreen());
    } else {
      const snackBar = SnackBar(content: Text("حدث خطأ"));
      scaffoldKey.currentState!.showSnackBar(snackBar);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: white,
      appBar: AppBar(
        title: Text(
          "${AppLocalizations.of(context)!.translate('joinRequest')}",
        ),
        automaticallyImplyLeading: true,
        iconTheme:  IconThemeData(color: white),
        backgroundColor: mainColor,
      ),
      body: isLoading
          ?  Center(
              child: CircularProgressIndicator(
                color: mainColor,
                backgroundColor: white,
              ),
            )
          : ListView(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              children: [
                const SizedBox(
                  height: 15,
                ),
                InputFiled(
                  controller: _nameController,
                  hintText: "${AppLocalizations.of(context)!.translate('name')}",
                ),
                const SizedBox(
                  height: 15,
                ),
                InputFiled(
                  controller: _genderController,
                  hintText:
                      "${AppLocalizations.of(context)!.translate('gender')}",
                ),
                const SizedBox(
                  height: 15,
                ),
                InputFiled(
                  controller: _birthdateController,
                  hintText:
                      "${AppLocalizations.of(context)!.translate('birthday')}",
                ),
                const SizedBox(
                  height: 15,
                ),
                InputFiled(
                  controller: _addressController,
                  hintText:
                      "${AppLocalizations.of(context)!.translate('address')}",
                ),
                const SizedBox(
                  height: 15,
                ),
                InputFiled(
                  controller: _notesController,
                  hintText:
                      "${AppLocalizations.of(context)!.translate('notes')}",
                ),
                const SizedBox(
                  height: 15,
                ),
                InputFiled(
                  controller: _emailController,
                  hintText:
                      "${AppLocalizations.of(context)!.translate('email')}",
                ),
                const SizedBox(
                  height: 15,
                ),
                InputFiled(
                  controller: _mobileController,
                  hintText:
                      "${AppLocalizations.of(context)!.translate('mobile')}",
                ),
                const SizedBox(
                  height: 15,
                ),
                InputFiled(
                  controller: _phoneController,
                  hintText:
                      "${AppLocalizations.of(context)!.translate('phone')}",
                ),
                const SizedBox(
                  height: 15,
                ),
                InputFiled(
                  controller: _oldSchoolController,
                  hintText:
                      "${AppLocalizations.of(context)!.translate('oldSchool')}",
                ),
                const SizedBox(
                  height: 15,
                ),
                InputFiled(
                  controller: _joinSchoolYearController,
                  hintText:
                      "${AppLocalizations.of(context)!.translate('joinDate')}",
                ),
                const SizedBox(
                  height: 15,
                ),
                InputFiled(
                  controller: _provinceController,
                  hintText:
                      "${AppLocalizations.of(context)!.translate('province')}",
                ),
                const SizedBox(
                  height: 15,
                ),
                InputFiled(
                  controller: _regNumberController,
                  hintText:
                      "${AppLocalizations.of(context)!.translate('regNum')}",
                ),
                const SizedBox(
                  height: 30,
                ),
                const SizedBox(
                  height: 15,
                ),
                InputFiled(
                  controller: _regStatusController,
                  hintText:
                      "${AppLocalizations.of(context)!.translate('regStatus')}",
                ),
                                const SizedBox(
                  height: 15,
                ),
                InputFiled(
                  controller: _cityController,
                  hintText: "${AppLocalizations.of(context)!.translate('city')}",
                ),
                const SizedBox(
                  height: 30,
                ),
                InputFiled(
                  controller: _religionController,
                  hintText:
                      "${AppLocalizations.of(context)!.translate('religion')}",
                ),
                const SizedBox(
                  height: 30,
                ),
                InputFiled(
                  controller: _idNumberController,
                  hintText:
                      "${AppLocalizations.of(context)!.translate('DocNo')}",
                ),
                const SizedBox(
                  height: 30,
                ),
                InputFiled(
                  controller: _yearController,
                  hintText:
                      "${AppLocalizations.of(context)!.translate('studyYear')}",
                ),
                const SizedBox(
                  height: 30,
                ),
                InputFiled(
                  controller: _parentNameController,
                  hintText:
                      "${AppLocalizations.of(context)!.translate('parentName')}",
                ),
                const SizedBox(
                  height: 30,
                ),
                InputFiled(
                  controller: _parentJobController,
                  hintText:
                      "${AppLocalizations.of(context)!.translate('parentJob')}",
                ),
                const SizedBox(
                  height: 30,
                ),
                InputFiled(
                  controller: _nationaltyController,
                  hintText:
                      "${AppLocalizations.of(context)!.translate('Nationality')}",
                ),
                const SizedBox(
                  height: 30,
                ),
                InputFiled(
                  controller: _relationController,
                  hintText:
                      "${AppLocalizations.of(context)!.translate('relation')}",
                ),
                const SizedBox(
                  height: 30,
                ),
                InputFiled(
                  controller: _birthPlaceController,
                  hintText:
                      "${AppLocalizations.of(context)!.translate('bornPlace')}",
                ),
                const SizedBox(
                  height: 30,
                ),
                InputFiled(
                  controller: _zipCodeController,
                  hintText:
                      "${AppLocalizations.of(context)!.translate('PostalBox')}",
                ),
                const SizedBox(
                  height: 30,
                ),
                AppBtn(
                    onClick: () {
                      sendRequest();
                    },
                    label: "${AppLocalizations.of(context)!.translate('send')}")
              ],
            ),
    );
  }
}
