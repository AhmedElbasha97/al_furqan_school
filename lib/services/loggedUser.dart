// ignore_for_file: file_names
import 'package:al_furqan_school/models/FilesDetails.dart';
import 'package:al_furqan_school/models/Student/AskedQuestion.dart';
import 'package:al_furqan_school/models/Student/AskedQuestionDetails.dart';
import 'package:al_furqan_school/models/Student/book.dart';
import 'package:al_furqan_school/models/Student/scedules_model.dart';
import 'package:al_furqan_school/models/files.dart';
import 'package:al_furqan_school/models/homeWork.dart';
import 'package:al_furqan_school/models/homeWorkDetails.dart';
import 'package:al_furqan_school/models/importantFiles.dart';
import 'package:al_furqan_school/models/question.dart';
import 'package:al_furqan_school/models/questionDetails.dart';
import 'package:al_furqan_school/services/api_client.dart';

class LoggedUser {
  Future<List<Files>> getFiles({String? id}) async {
    try {
      final response = await ApiClient.instance.dio.get(
        'student_download_files.php',
        queryParameters: {'student_id': id},
      );
      if (response.data != null) {
        return (response.data as List)
            .map((e) => Files.fromJson(e))
            .toList();
      }
    } on Exception {
      return [];
    }
    return [];
  }

  Future<List<ImportantFile>> getImportantFiles({String? id}) async {
    try {
      final response = await ApiClient.instance.dio.get(
        'student_prog.php',
        queryParameters: {'student_id': id},
      );
      if (response.data != null) {
        return (response.data as List)
            .map((e) => ImportantFile.fromJson(e))
            .toList();
      }
    } on Exception {
      return [];
    }
    return [];
  }

  Future<List<FileDetails>> getFilesDetails({
    String? id,
    String? fileID,
  }) async {
    try {
      final response = await ApiClient.instance.dio.get(
        'student_download_files_view.php',
        queryParameters: {'student_id': id, 'file_id': fileID},
      );
      if (response.data != null) {
        return (response.data as List)
            .map((e) => FileDetails.fromJson(e))
            .toList();
      }
    } on Exception {
      return [];
    }
    return [];
  }

  Future<List<HomeWork>> getHomeWorks({String? id}) async {
    try {
      final response = await ApiClient.instance.dio.get(
        'student_homework.php',
        queryParameters: {'student_id': id},
      );
      if (response.data != null) {
        return (response.data as List)
            .map((e) => HomeWork.fromJson(e))
            .toList();
      }
    } on Exception {
      return [];
    }
    return [];
  }

  Future<List<HomeWorkDetails>> gethomeWorkDetails({
    String? id,
    String? homeWorkId,
  }) async {
    try {
      final response = await ApiClient.instance.dio.get(
        'student_homework_view.php',
        queryParameters: {'student_id': id, 'homework_id': homeWorkId},
      );
      if (response.data != null) {
        return (response.data as List)
            .map((e) => HomeWorkDetails.fromJson(e))
            .toList();
      }
    } on Exception {
      return [];
    }
    return [];
  }

  Future<List<Question>> getQuestions({String? id}) async {
    try {
      final response = await ApiClient.instance.dio.get(
        'student_quest_bank.php',
        queryParameters: {'student_id': id},
      );
      if (response.data != null) {
        return (response.data as List)
            .map((e) => Question.fromJson(e))
            .toList();
      }
    } on Exception {
      return [];
    }
    return [];
  }

  Future<List<QuestionDetails>> getQuestionsDetails({
    String? id,
    String? qId,
  }) async {
    try {
      final response = await ApiClient.instance.dio.get(
        'student_quest_bank_view.php',
        queryParameters: {'student_id': id, 'file_id': qId},
      );
      if (response.data != null) {
        return (response.data as List)
            .map((e) => QuestionDetails.fromJson(e))
            .toList();
      }
    } on Exception {
      return [];
    }
    return [];
  }

  Future<List<Books>> getBooks({String? id}) async {
    try {
      final response = await ApiClient.instance.dio.get(
        'student_books.php',
        queryParameters: {'student_id': id},
      );
      if (response.data != null) {
        return (response.data as List)
            .map((e) => Books.fromJson(e))
            .toList();
      }
    } on Exception {
      return [];
    }
    return [];
  }

  Future<List<AskedQuestion>> getAskedQuestions({String? id}) async {
    try {
      final response = await ApiClient.instance.dio.get(
        'student_ask_income.php',
        queryParameters: {'student_id': id},
      );
      if (response.data != null) {
        return (response.data as List)
            .map((e) => AskedQuestion.fromJson(e))
            .toList();
      }
    } on Exception {
      return [];
    }
    return [];
  }

  Future<SchedulesModel?> getSchedules({String? classId}) async {
    try {
      final response = await ApiClient.instance.dio.get(
        'sch.php',
        queryParameters: {'class_id': classId},
      );
      if (response.data != null && (response.data as List).isNotEmpty) {
        return SchedulesModel.fromJson(response.data[0]);
      }
    } on Exception {
      return null;
    }
    return null;
  }

  Future<List<AskedQuestionDetails>> getAskedQuestionsDetails({
    String? id,
    String? qid,
  }) async {
    try {
      final response = await ApiClient.instance.dio.get(
        'student_ask_income_view.php',
        // Fixed: was `books + "?student_id=$id&&msg_id=$qid"` (wrong endpoint + && bug)
        queryParameters: {'student_id': id, 'msg_id': qid},
      );
      if (response.data != null) {
        return (response.data as List)
            .map((e) => AskedQuestionDetails.fromJson(e))
            .toList();
      }
    } on Exception {
      return [];
    }
    return [];
  }
}
