// ignore_for_file: file_names

import 'package:al_furqan_school/globals/CommonSetting.dart';
import 'package:al_furqan_school/models/MessageDetailsStudent.dart';
import 'package:al_furqan_school/models/MessageSentStudent.dart';
import 'package:al_furqan_school/models/message.dart';
import 'package:al_furqan_school/models/messageDetails.dart';
import 'package:al_furqan_school/models/new/student_info_model.dart';
import 'package:al_furqan_school/models/new/student_list_model.dart';
import 'package:al_furqan_school/models/parents/attendance.dart';
import 'package:al_furqan_school/models/parents/reportDetails.dart';
import 'package:al_furqan_school/models/parents/reports.dart';
import 'package:al_furqan_school/models/teachers.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';


class ParentService {

  String studentList = "${baseUrl}login.php";
  String reports = "${baseUrl}parent_report_about.php";
  String reportDetails = "${baseUrl}parent_report_about_view.php";
  String attendance = "${baseUrl}parent_absence.php";
  String messages = "${baseUrl}parent_msg_income.php";
  String messageDetails = "${baseUrl}parent_msg_income_view.php";
  String sendMessageLink = "${baseUrl}parent_msg_send.php";
  String sentMessages = "${baseUrl}parent_msg_sent.php";
  String sentMessagesDetails = "${baseUrl}parent_msg_sent_view.php";
  String teachers = "${baseUrl}teachers_list.php";
  String studentInfo ="${baseUrl}student_info.php";
  Future<StudentInfoModel?> getStudentInfo({String? id}) async {
    StudentInfoModel? list ;
    Response response;
    response = await Dio().get(
      "$studentInfo?student_id=$id",
    );
    var data = response.data;
    if (response.data != null) {
    list =StudentInfoModel.fromJson(data[0]);
    }
    return list;
  }
  Future<List<Report>> getReports({String? id}) async {
    List<Report> list = [];
    Response response;
    response = await Dio().get(
      "$reports?parent_id=$id",
    );
    var data = response.data;
    if (response.data != null) {
      data.forEach((element) {
        list.add(Report.fromJson(element));
      });
    }
    return list;
  }

  Future<StudentListModel?> getStudentList(
      ) async {
    StudentListModel? list ;
    Response response;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userName = prefs.getString("usernameParent");
    var passwordUser = prefs.getString("passwordParent");
    response = await Dio().get(
      "$studentList?type=PARENTS&username=$userName&password=$passwordUser",
    );
    var data = response.data;
    if (response.data != null) {

        list =StudentListModel.fromJson(data);

    }
    return list;
  }
  Future<List<ReportDetails>> getReportDetails(
      {String? id, String? reportId}) async {
    List<ReportDetails> list = [];
    Response response;
    response = await Dio().get(
      "$reportDetails?parent_id=$id&report_id=$reportId",
    );
    var data = response.data;
    if (response.data != null) {
      data.forEach((element) {
        list.add(ReportDetails.fromJson(element));
      });
    }
    return list;
  }

  Future<List<Attendance>> getAttendance({String? id}) async {
    List<Attendance> list = [];
    Response response;
    response = await Dio().get(
      "$attendance?parent_id=$id",
    );
    var data = response.data;
    if (response.data != null) {
      data.forEach((element) {
        list.add(Attendance.fromJson(element));
      });
    }
    return list;
  }

  Future<List<Messages>> getMessages({String? id}) async {
    List<Messages> list = [];
    Response response;
    response = await Dio().get(
      "$messages?parent_id=$id",
    );
    var data = response.data;
    if (response.data != null) {
      data.forEach((element) {
        list.add(Messages.fromJson(element));
      });
    }
    return list;
  }

  Future<List<MessageSentStudent>> getSentMessages({String? id}) async {
    List<MessageSentStudent> list = [];
    Response response;
    response = await Dio().get(
      "$sentMessages?parent_id=$id",
    );
    var data = response.data;
    if (response.data != null) {
      data.forEach((element) {
        list.add(MessageSentStudent.fromJson(element));
      });
    }
    return list;
  }

  Future<List<MessageDetails>> getMessageDetails(
      {String? id, String? msgId}) async {
    List<MessageDetails> list = [];
    Response response;
    response = await Dio().get(
      "$messageDetails?parent_id=$id&msg_id=$msgId",
    );
    var data = response.data;
    if (response.data != null) {
      data.forEach((element) {
        list.add(MessageDetails.fromJson(element));
      });
    }
    return list;
  }

  Future<List<MessageDetailsStudent>> getSentMessageDetails(
      {String? id, String? msgId}) async {
    List<MessageDetailsStudent> list = [];
    Response response;
    response = await Dio().get(
      "$sentMessagesDetails?parent_id=$id&msg_id=$msgId",
    );
    var data = response.data;
    if (response.data != null) {
      data.forEach((element) {
        list.add(MessageDetailsStudent.fromJson(element));
      });
    }
    return list;
  }

  Future<String?> sendMessage(
      {String? id,
      String? teacherId,
      String? msg,
      String? title,
      String? type}) async {
    Response response;
    response = await Dio().post(
      "$sendMessageLink?parent_id=$id&sendto_type=$type&teacher_id=$teacherId&title=$title&text=$msg",
    );
    var data = response.data["status"];
    return data;
  }

  Future<List<Teachers>> getTeacher() async {
    List<Teachers> list = [];
    Response response;
    response = await Dio().post(teachers);
    var data = response.data;
    if (response.data != null) {
      data.forEach((element) {
        list.add(Teachers.fromJson(element));
      });
    }
    return list;
  }
}
