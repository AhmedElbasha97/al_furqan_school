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
import 'package:al_furqan_school/services/api_client.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ParentService {
  static const _secureStorage = FlutterSecureStorage(
    aOptions: AndroidOptions(encryptedSharedPreferences: true),
    iOptions: IOSOptions(accessibility: KeychainAccessibility.first_unlock),
  );

  Future<StudentInfoModel?> getStudentInfo({String? id}) async {
    try {
      final response = await ApiClient.instance.dio.get(
        'student_info.php',
        queryParameters: {'student_id': id},
      );
      if (response.data != null && (response.data as List).isNotEmpty) {
        return StudentInfoModel.fromJson(response.data[0]);
      }
    } on Exception {
      return null;
    }
    return null;
  }

  Future<List<Report>> getReports({String? id}) async {
    try {
      final response = await ApiClient.instance.dio.get(
        'parent_report_about.php',
        queryParameters: {'parent_id': id},
      );
      if (response.data != null) {
        return (response.data as List)
            .map((e) => Report.fromJson(e))
            .toList();
      }
    } on Exception {
      return [];
    }
    return [];
  }

  /// Re-authenticates parent using securely stored credentials.
  Future<StudentListModel?> getStudentList() async {
    try {
      final userName = await _secureStorage.read(key: 'usernameParent');
      final passwordUser = await _secureStorage.read(key: 'passwordParent');

      final response = await ApiClient.instance.dio.get(
        'login.php',
        queryParameters: {
          'type': 'PARENTS',
          'username': userName ?? '',
          'password': passwordUser ?? '',
        },
      );
      if (response.data != null) {
        return StudentListModel.fromJson(response.data);
      }
    } on Exception {
      return null;
    }
    return null;
  }

  Future<List<ReportDetails>> getReportDetails({
    String? id,
    String? reportId,
  }) async {
    try {
      final response = await ApiClient.instance.dio.get(
        'parent_report_about_view.php',
        queryParameters: {'parent_id': id, 'report_id': reportId},
      );
      if (response.data != null) {
        return (response.data as List)
            .map((e) => ReportDetails.fromJson(e))
            .toList();
      }
    } on Exception {
      return [];
    }
    return [];
  }

  Future<List<Attendance>> getAttendance({String? id}) async {
    try {
      final response = await ApiClient.instance.dio.get(
        'parent_absence.php',
        queryParameters: {'parent_id': id},
      );
      if (response.data != null) {
        return (response.data as List)
            .map((e) => Attendance.fromJson(e))
            .toList();
      }
    } on Exception {
      return [];
    }
    return [];
  }

  Future<List<Messages>> getMessages({String? id}) async {
    try {
      final response = await ApiClient.instance.dio.get(
        'parent_msg_income.php',
        queryParameters: {'parent_id': id},
      );
      if (response.data != null) {
        return (response.data as List)
            .map((e) => Messages.fromJson(e))
            .toList();
      }
    } on Exception {
      return [];
    }
    return [];
  }

  Future<List<MessageSentStudent>> getSentMessages({String? id}) async {
    try {
      final response = await ApiClient.instance.dio.get(
        'parent_msg_sent.php',
        queryParameters: {'parent_id': id},
      );
      if (response.data != null) {
        return (response.data as List)
            .map((e) => MessageSentStudent.fromJson(e))
            .toList();
      }
    } on Exception {
      return [];
    }
    return [];
  }

  Future<List<MessageDetails>> getMessageDetails({
    String? id,
    String? msgId,
  }) async {
    try {
      final response = await ApiClient.instance.dio.get(
        'parent_msg_income_view.php',
        queryParameters: {'parent_id': id, 'msg_id': msgId},
      );
      if (response.data != null) {
        return (response.data as List)
            .map((e) => MessageDetails.fromJson(e))
            .toList();
      }
    } on Exception {
      return [];
    }
    return [];
  }

  Future<List<MessageDetailsStudent>> getSentMessageDetails({
    String? id,
    String? msgId,
  }) async {
    try {
      final response = await ApiClient.instance.dio.get(
        'parent_msg_sent_view.php',
        queryParameters: {'parent_id': id, 'msg_id': msgId},
      );
      if (response.data != null) {
        return (response.data as List)
            .map((e) => MessageDetailsStudent.fromJson(e))
            .toList();
      }
    } on Exception {
      return [];
    }
    return [];
  }

  Future<String?> sendMessage({
    String? id,
    String? teacherId,
    String? msg,
    String? title,
    String? type,
  }) async {
    try {
      final response = await ApiClient.instance.dio.post(
        'parent_msg_send.php',
        queryParameters: {
          'parent_id': id,
          'sendto_type': type,
          'teacher_id': teacherId,
          'title': title,
          'text': msg,
        },
      );
      return response.data['status']?.toString();
    } on Exception {
      return null;
    }
  }

  Future<List<Teachers>> getTeacher() async {
    try {
      final response = await ApiClient.instance.dio.post('teachers_list.php');
      if (response.data != null) {
        return (response.data as List)
            .map((e) => Teachers.fromJson(e))
            .toList();
      }
    } on Exception {
      return [];
    }
    return [];
  }
}
