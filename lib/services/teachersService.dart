// ignore_for_file: file_names
import 'package:al_furqan_school/models/teacher/HomeWorkDetails.dart';
import 'package:al_furqan_school/models/teacher/category.dart';
import 'package:al_furqan_school/models/teacher/homeWork.dart';
import 'package:al_furqan_school/models/teacher/messagedetails.dart';
import 'package:al_furqan_school/models/teacher/questionBank.dart';
import 'package:al_furqan_school/models/teacher/reportDetails.dart';
import 'package:al_furqan_school/models/teacher/sentMessages.dart';
import 'package:al_furqan_school/models/teacher/student.dart';
import 'package:al_furqan_school/models/teacher/teacherReport.dart';
import 'package:al_furqan_school/services/api_client.dart';

class TeacherService {
  Future<List<TeacherReport>> getReports({String? id}) async {
    try {
      final response = await ApiClient.instance.dio.get(
        'teacher_reports.php',
        queryParameters: {'teacher_id': id},
      );
      if (response.data != null) {
        return (response.data as List)
            .map((e) => TeacherReport.fromJson(e))
            .toList();
      }
    } on Exception {
      return [];
    }
    return [];
  }

  Future<List<TeacherReportDetails>> getReportDetails({
    String? id,
    String? reportId,
  }) async {
    try {
      final response = await ApiClient.instance.dio.get(
        'teacher_report_view.php',
        queryParameters: {'teacher_id': id, 'report_id': reportId},
      );
      if (response.data != null) {
        return (response.data as List)
            .map((e) => TeacherReportDetails.fromJson(e))
            .toList();
      }
    } on Exception {
      return [];
    }
    return [];
  }

  Future<List<Category>> getCategories() async {
    try {
      final response =
          await ApiClient.instance.dio.get('categories_list.php');
      if (response.data != null) {
        return (response.data as List)
            .map((e) => Category.fromJson(e))
            .toList();
      }
    } on Exception {
      return [];
    }
    return [];
  }

  Future<List<Category>> getLevels({String? id}) async {
    try {
      final response = await ApiClient.instance.dio.get(
        'categories_list.php',
        queryParameters: {'ctg_id': id},
      );
      if (response.data != null) {
        return (response.data as List)
            .map((e) => Category.fromJson(e))
            .toList();
      }
    } on Exception {
      return [];
    }
    return [];
  }

  Future<List<Student>> getStudents({String? id}) async {
    try {
      final response = await ApiClient.instance.dio.get(
        'student_list.php',
        queryParameters: {'class_id': id},
      );
      if (response.data != null) {
        return (response.data as List)
            .map((e) => Student.fromJson(e))
            .toList();
      }
    } on Exception {
      return [];
    }
    return [];
  }

  Future<bool> sendReport({
    String? id,
    String? studentId,
    String? msg,
  }) async {
    try {
      final date = DateTime.now();
      final dateString = '${date.year}-${date.month}-${date.day}';
      final response = await ApiClient.instance.dio.post(
        'teacher_report_add.php',
        queryParameters: {
          'teacher_id': id,
          'student_id': studentId,
          'date': dateString,
          'text': msg,
        },
      );
      return response.data['status'] == 'true';
    } on Exception {
      return false;
    }
  }

  Future<List<HomeWorkTeacher>> getHomeWork({String? id}) async {
    try {
      final response = await ApiClient.instance.dio.get(
        'teacher_homework.php',
        queryParameters: {'teacher_id': id},
      );
      if (response.data != null) {
        return (response.data as List)
            .map((e) => HomeWorkTeacher.fromJson(e))
            .toList();
      }
    } on Exception {
      return [];
    }
    return [];
  }

  Future<List<SentMessagesTeacher>> getSentMessages({String? id}) async {
    try {
      final response = await ApiClient.instance.dio.get(
        'teacher_msg_sent.php',
        queryParameters: {'teacher_id': id},
      );
      if (response.data != null) {
        return (response.data as List)
            .map((e) => SentMessagesTeacher.fromJson(e))
            .toList();
      }
    } on Exception {
      return [];
    }
    return [];
  }

  Future<String?> sendMessages({
    String? id,
    String? type,
    String? studentId,
    String? parentId,
    String? body,
    String? title,
    String? text,
  }) async {
    try {
      final response = await ApiClient.instance.dio.post(
        'teacher_msg_send.php',
        queryParameters: {
          'teacher_id': id,
          'sendto_type': type,
          'to_id': studentId ?? parentId,
          'title': title,
          'text': text,
        },
      );
      return response.data['status']?.toString();
    } on Exception {
      return null;
    }
  }

  Future<List<QuestionBankTeacher>> getQuestionBank({String? id}) async {
    try {
      final response = await ApiClient.instance.dio.get(
        'teacher_quest_bank.php',
        queryParameters: {'teacher_id': id},
      );
      if (response.data != null) {
        return (response.data as List)
            .map((e) => QuestionBankTeacher.fromJson(e))
            .toList();
      }
    } on Exception {
      return [];
    }
    return [];
  }

  Future<List<HomeWorkDetailsTeacherModel>> getHomeworkDetails({
    String? id,
    String? homeworkId,
  }) async {
    try {
      // Fixed: was `"$homeworkDetails??teacher_id=$id"` (double-question-mark bug)
      final response = await ApiClient.instance.dio.get(
        'teacher_homework_view.php',
        queryParameters: {'teacher_id': id, 'homework_id': homeworkId},
      );
      if (response.data != null) {
        return (response.data as List)
            .map((e) => HomeWorkDetailsTeacherModel.fromJson(e))
            .toList();
      }
    } on Exception {
      return [];
    }
    return [];
  }

  Future<List<MessageDetailsTeacherModel>> getsentMessageDetails({
    String? id,
    String? msgId,
  }) async {
    try {
      // Fixed: was `"$sentMessageDetails??teacher_id=$id"` (double-question-mark bug)
      final response = await ApiClient.instance.dio.get(
        'teacher_msg_sent_view.php',
        queryParameters: {'teacher_id': id, 'msg_id': msgId},
      );
      if (response.data != null) {
        return (response.data as List)
            .map((e) => MessageDetailsTeacherModel.fromJson(e))
            .toList();
      }
    } on Exception {
      return [];
    }
    return [];
  }
}
