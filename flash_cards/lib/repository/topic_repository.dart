
import 'package:dio/dio.dart';
import 'package:flash_cards/api.dart';
import 'package:flash_cards/locator.dart';

class TopicRepository {  
  Future<Response?> fetchTopics() async {
    try {
      Response<dynamic> response = await locator<Api>().getRequest(
        path: '/topics/',
      );
      return response;
    } on DioException catch (e) {
      return e.response;
    }
  }
  Future<Response?> createTopic(Object? data) async {
    try {
      Response<dynamic> response = await locator<Api>().postRequest(
        path: '/topics/',
        data: data,
      );
      return response;
    } on DioException catch (e) {
      return e.response;
    }
  }

  Future<Response?> deleteTopic(int topicId) async {
    try {
      Response<dynamic> response = await locator<Api>().deleteRequest(
        path: '/topics/$topicId/',
      );
      return response;
    } on DioException catch (e) {
      return e.response;
    }
  }

  Future<Response?> updateTopic(int topicId, Object? data) async {
    try {
      Response<dynamic> response = await locator<Api>().patchRequest(
        path: '/topics/$topicId/',
        data: data,
      );
      return response;
    } on DioException catch (e) {
      return e.response;
    }
  }
}