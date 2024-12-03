import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:flash_cards/locator.dart';
import 'package:flash_cards/services/authentication_service.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:flutter/foundation.dart';

class Api {
  final Dio api;
  final cookieJar = CookieJar();
  
  Api(): api = Dio(
  BaseOptions(
    baseUrl: 'http://localhost:8000/api',
    connectTimeout: const Duration(seconds: 60), // Increased connection timeout
    receiveTimeout: const Duration(seconds: 60), // Increased receive timeout
    headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    },
  ),
)..options.extra = {
  'withCredentials': true, // Include cookies in requests
} {
  api.interceptors.add(
    InterceptorsWrapper(
      onError: (DioException error, ErrorInterceptorHandler handler) async {
        // Skip handling errors for refresh token requests to avoid infinite loop
        if (error.requestOptions.extra['isRefreshToken'] == true) {
          Get.offAllNamed('/login');
          handler.next(error); // Pass the error without further processing
          return;
        }

        // Handle 401 Unauthorized errors for other requests
        if (error.response?.statusCode == 401) {
          // Check if the request has already been retried
          bool hasRetried = error.requestOptions.extra['hasRetried'] ?? false;

          if (!hasRetried) {
            try {
              // Attempt to refresh the token
              final refreshed = await locator<AuthenticationService>().refreshToken();

              if (refreshed) {
                // Retry the original request with the new token
                final retryOptions = error.requestOptions
                  ..extra['hasRetried'] = true; // Mark the request as retried
                final response = await api.fetch(retryOptions);
                handler.resolve(response); // Resolve the request
                return; // Stop further error processing
              }
            } catch (e) {
              return;
            }
          }
          Get.offAllNamed('/login'); // Clear navigation stack and go to login
          handler.next(error); // Pass the error to the next handler
          return;
        }

        // For other errors, pass the error to the next handler
        handler.next(error);
      },
    ),
  );
    if (!kIsWeb) {
      api.interceptors.add(CookieManager(cookieJar));
    }
  }



  Future<Response<dynamic>> postRequest({required String path, Object? data}) async {
    return api.post(
      path,
      data: data,
      options: path == '/refresh/' ? Options(
        extra: {'isRefreshToken': true}, // Skip interceptor for this request
      ) : null,
    );
  }

  Future<Response<dynamic>> getRequest({required String path, Object? data}) async {
    return api.get(
      path,
      data: data,
    );
  }

  Future<Response<dynamic>> putRequest({required String path, Object? data}) async {
    return api.put(
      path,
      data: data,
    );
  }

  Future<Response<dynamic>> patchRequest({required String path, Object? data}) async {
    return api.patch(
      path,
      data: data,
    );
  }

  Future<Response<dynamic>> deleteRequest({required String path, Object? data}) async {
    return api.delete(
      path,
      data: data,
    );
  }
}