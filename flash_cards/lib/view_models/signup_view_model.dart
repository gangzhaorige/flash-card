import 'package:dio/dio.dart';
import 'package:flash_cards/services/authentication_service.dart';
import 'package:flutter/material.dart';


import 'package:get/get.dart' hide Response;

import '../locator.dart';

class SignUpViewModel extends ChangeNotifier {

  // TextEditingControllers for each field
  final TextEditingController emailController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // Getters for the text
  String get email => emailController.text;
  String get username => usernameController.text;
  String get password => passwordController.text;

  // Methods to update the text and notify listeners
  void updateEmail(String newEmail) {
    emailController.text = newEmail;
    notifyListeners();
  }

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
    emailController.dispose();
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<void> signUp() async {
    Response response = await locator<AuthenticationService>().register(username, password, email);
    if(response.statusCode == 201) {
      toLogin();
    }
  }

  Future<void> toLogin() async {
    await Get.toNamed('/login');
  }
}