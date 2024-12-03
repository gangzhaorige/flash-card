import 'package:dio/dio.dart';
import '../api.dart';
import '../locator.dart';

class AuthenticationService {

  static AuthenticationService getInstance() => AuthenticationService._();

  AuthenticationService._();

  Future<dynamic> login(String username, String password) async {
    try {
      var response = locator<Api>().postRequest(path: '/login/', data: {'username': username, 'password' : password});
      return response;
    } on DioException catch (e) {
      return e.response!.data;
    }
  }

  Future<dynamic> register(String username, String password, String email) async {
    try {
      var response = locator<Api>().postRequest(path: '/register/', data: {'username': username, 'password' : password, 'email': email});
      return response;
    } on DioException catch (e) {
      return e.response!.data;
    }
  }

  Future<dynamic> logout() async {
    try {
      return locator<Api>().postRequest(path: '/logout/');
    } on DioException catch (e) {
      return e.response!.data;
    }
  }

  Future<bool> refreshToken() async {
    try {
      final response = await locator<Api>().postRequest(path: '/refresh/');

      if (response.statusCode == 200) {
        // Token refreshed successfully
        return true;
      } else {
        // Token refresh failed
        return false;
      }
    } catch (e) {
      // Handle errors during the token refresh
      print('Error refreshing token: $e');
      return false;
    }
  }
}

