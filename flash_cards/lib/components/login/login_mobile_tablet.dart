import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../view_models/login_view_model.dart';
import '../button.dart';
import '../text_field.dart';

class LoginFormMobileTablet extends StatelessWidget {
  const LoginFormMobileTablet({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 24, right: 24, top: 24, bottom: 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Icon(
            Icons.bolt_sharp,
            size: 48,
            color: Colors.blue,
          ),
          Container(
            margin: const EdgeInsets.only(top: 24),
            width: MediaQuery.of(context).size.width,
            child: const Text(
              'Flash Card',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 16, bottom: 32),
            width: MediaQuery.of(context).size.width,
            child: const Text(
              'Please enter your credentials.',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
          ),
          FlashTextField(
            controller: Provider.of<LoginViewModel>(context,listen: false).usernameController,
            text: 'Username',
          ),
          const SizedBox(
            height: 25,
          ),
          FlashTextField(
            controller: Provider.of<LoginViewModel>(context,listen: false).passwordController,
            text: 'Password',
            obscureText: true,
          ),
          const SizedBox(
            height: 25,
          ),
          FlashButton(
            text: 'Login', onPressed: () async {
              await Provider.of<LoginViewModel>(context, listen: false).login();
            },
          ),
          const SizedBox(
            height: 25,
          ),
          Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            alignment: WrapAlignment.center,
            children: [
              const Text(
                'Don\'t have an account?',
                style: TextStyle(
                  fontSize: 18,
                ),
                textAlign: TextAlign.center,
              ),
              TextButton(
                style: ButtonStyle(
                  overlayColor: WidgetStateProperty.all(Colors.transparent),
                  foregroundColor: WidgetStateProperty.all(Colors.blue),
                ),
                onPressed: () async {
                  Get.toNamed('/signup');
                },
                child: const Text(
                  'Sign Up',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 25,
          ),
        ],
      ),
    );
  }
}