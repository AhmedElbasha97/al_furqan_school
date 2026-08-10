// ignore_for_file: file_names
import 'package:al_furqan_school/models/MessageDetailsStudent.dart';
import 'package:al_furqan_school/models/MessageSentStudent.dart';
import 'package:al_furqan_school/models/message.dart';
import 'package:al_furqan_school/models/messageDetails.dart';
import 'package:al_furqan_school/models/teachers.dart';
import 'package:al_furqan_school/services/api_client.dart';

class MessagesService {
  Future<List<Messages>> getMessages({String? id}) async {
    try {
      final response = await ApiClient.instance.dio.get(
        'student_msg_income.php',
        queryParameters: {'student_id': id},
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
        'student_msg_sent.php',
        queryParameters: {'student_id': id},
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
        'student_msg_income_view.php',
        queryParameters: {'student_id': id, 'msg_id': msgId},
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
        'student_msg_sent_view.php',
        queryParameters: {'student_id': id, 'msg_id': msgId},
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
        'student_msg_send.php',
        queryParameters: {
          'student_id': id,
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
