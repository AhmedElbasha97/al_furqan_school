// ignore_for_file: file_names

import 'package:al_furqan_school/globals/CommonSetting.dart';
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
import 'package:dio/dio.dart';

class LoggedUser {
  String filesLink = "${baseUrl}student_download_files.php";
  String fileDetails = "${baseUrl}student_download_files_view.php";
  String homeWorks = "${baseUrl}student_homework.php";
  String homeWorkDetails = "${baseUrl}student_homework_view.php";
  String questionBank = "${baseUrl}student_quest_bank.php";
  String questionDetails = "${baseUrl}student_quest_bank_view.php";
  String importantFile = "${baseUrl}student_prog.php";
  String books = "${baseUrl}student_books.php";
  String askedQuestions = "${baseUrl}student_ask_income.php";
  String askedQuestionsDetails = "${baseUrl}student_ask_income_view.php";
  String schedulesLink = "${baseUrl}sch.php";
  Future<List<Files>> getFiles({String? id}) async {
    List<Files> list = [];
    Response response;
    response = await Dio().get(
      "$filesLink?student_id=$id",
    );
    var data = response.data;
    if (response.data != null) {
      data.forEach((element) {
        list.add(Files.fromJson(element));
      });
    }
    return list;
  }

  Future<List<ImportantFile>> getImportantFiles({String? id}) async {
    List<ImportantFile> list = [];
    Response response;
    response = await Dio().get(
     "$importantFile?student_id=$id",
    );
    var data = response.data;
    if (response.data != null) {
      data.forEach((element) {
        list.add(ImportantFile.fromJson(element));
      });
    }
    return list;
  }

  Future<List<FileDetails>> getFilesDetails({String? id, String? fileID}) async {
    List<FileDetails> list = [];
    Response response;
    response = await Dio().get(
      "$fileDetails?student_id=$id&file_id=$fileID",
    );
    var data = response.data;
    if (response.data != null) {
      data.forEach((element) {
        list.add(FileDetails.fromJson(element));
      });
    }
    return list;
  }

  Future<List<HomeWork>> getHomeWorks({String? id}) async {
    List<HomeWork> list = [];
    Response response;
    response = await Dio().get(
      "$homeWorks?student_id=$id",
    );
    if (response.data != null) {
      var data = response.data;
      data.forEach((element) {
        list.add(HomeWork.fromJson(element));
      });
    }
    return list;
  }

  Future<List<HomeWorkDetails>> gethomeWorkDetails(
      {String? id, String? homeWorkId}) async {
    List<HomeWorkDetails> list = [];
    Response response;
    response = await Dio().get(
      "$homeWorkDetails?student_id=$id&homework_id=$homeWorkId",
    );
    var data = response.data;
    if (response.data != null) {
      data.forEach((element) {
        list.add(HomeWorkDetails.fromJson(element));
      });
    }
    return list;
  }

  Future<List<Question>> getQuestions({String? id}) async {
    List<Question> list = [];
    Response response;
    response = await Dio().get(
       "$questionBank?student_id=$id",
    );
    var data = response.data;
    if (response.data != null) {
      data.forEach((element) {
        list.add(Question.fromJson(element));
      });
    }
    return list;
  }

  Future<List<QuestionDetails>> getQuestionsDetails(
      {String? id, String? qId}) async {
    List<QuestionDetails> list = [];
    Response response;
    response = await Dio().get(
     "$questionBank?student_id=$id&file_id=$qId",
    );
    var data = response.data;
    if (response.data != null) {
      data.forEach((element) {
        list.add(QuestionDetails.fromJson(element));
      });
    }
    return list;
  }

  Future<List<Books>> getBooks({String? id}) async {
    List<Books> list = [];
    Response response;
    response = await Dio().get(
      "$books?student_id=$id",
    );
    var data = response.data;
    if (response.data != null) {
      data.forEach((element) {
        list.add(Books.fromJson(element));
      });
    }
    return list;
  }

  Future<List<AskedQuestion>> getAskedQuestions({String? id}) async {
    List<AskedQuestion> list = [];
    Response response;
    response = await Dio().get(
      "$books?student_id=$id",
    );
    var data = response.data;
    if (response.data != null) {
      data.forEach((element) {
        list.add(AskedQuestion.fromJson(element));
      });
    }
    return list;
  }
  Future<SchedulesModel?> getSchedules({String? classId}) async {
    SchedulesModel? list ;
    Response response;

    response = await Dio().get(
      "$schedulesLink?class_id=$classId",
    );
    var data = response.data;
     list=SchedulesModel.fromJson(data[0]);
    return list;
  }

  Future<List<AskedQuestionDetails>> getAskedQuestionsDetails(
      {String? id, String? qid}) async {
    List<AskedQuestionDetails> list = [];
    Response response;
    response = await Dio().get(
      "$books?student_id=$id&&msg_id=$qid",
    );
    var data = response.data;
    if (response.data != null) {
      data.forEach((element) {
        list.add(AskedQuestionDetails.fromJson(element));
      });
    }
    return list;
  }
}
