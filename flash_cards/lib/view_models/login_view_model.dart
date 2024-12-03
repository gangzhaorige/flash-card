import 'package:dio/dio.dart';
import 'package:flash_cards/services/authentication_service.dart';
import 'package:flutter/material.dart';


import 'package:get/get.dart' hide Response;

import '../locator.dart';

class LoginViewModel extends ChangeNotifier {

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  String get username => usernameController.text;
  String get password => passwordController.text;

  void updateUsername(String newUsername) {
    usernameController.text = newUsername;
    notifyListeners();
  }

  void updatePassword(String newPassword) {
    passwordController.text = newPassword;
    notifyListeners();
  }

  // Dispose of controllers to free resources
  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<void> login() async {
    Response response = await locator<AuthenticationService>().login(username, password);
    if(response.statusCode == 200) {
      toToMain();
    }
  }

  Future<void> toToMain() async {
    await Get.toNamed('/');
  }
}