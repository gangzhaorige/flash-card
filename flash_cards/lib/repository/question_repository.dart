import 'dart:math';

import 'package:dio/dio.dart';

import '../api.dart';
import '../locator.dart';

class QuestionAnswerRepository {  
  Future<Response?> fetchQuestionAnswers(int topicId) async {
    try {
      Response<dynamic> response = await locator<Api>().getRequest(
        path: '/topics/$topicId/cards/',
      );
      return response;
    } on DioException catch (e) {
      return e.response;
    }
  }
  
  Future<Response?> createQuestionAnswer(int topicId, Object? data) async {
    try {
      Response<dynamic> response = await locator<Api>().postRequest(
        path: '/topics/$topicId/cards/',
        data: data,
      );
      return response;
    } on DioException catch (e) {
      return e.response;
    }
  }

  Future<Response?> deleteQuestionAnswer(int topicId, int questionAnswerId) async {
    try {
      Response<dynamic> response = await locator<Api>().deleteRequest(
        path: '/topics/$topicId/cards/$questionAnswerId/',
      );
      return response;
    } on DioException catch (e) {
      return e.response;
    }
  }

  Future<Response?> updateQuestionAnswer(int topicId, int questionAnswerId, Object? data) async {
    try {
      Response<dynamic> response = await locator<Api>().patchRequest(
        path: '/topics/$topicId/cards/$questionAnswerId/',
        data: data,
      );
      return response;
    } on DioException catch (e) {
      return e.response;
    }
  }

  Future<Response?> explainQuestion(Object? data) async {
    try {
      Response<dynamic> response = await locator<Api>().postRequest(
        path: '/openai-answer-question/',
        data: data,
      );
      return response;
    } on DioException catch (e) {
      return e.response;
    }
  }
  Future<Response?> createQuestionFromPDF(int topicId, Object? data) async {
    try {
      Response<dynamic> response = await locator<Api>().postRequest(path: '/topics/$topicId/upload-pdf/', data: data);
      return response;
    } on DioException catch (e) {
      return e.response;
    }
  }
}