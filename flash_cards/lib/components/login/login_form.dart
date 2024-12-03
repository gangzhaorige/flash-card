import 'package:flash_cards/commons/responsive.dart';
import 'package:flash_cards/components/login/login_desktop.dart';
import 'package:flash_cards/components/login/login_mobile_tablet.dart';
import 'package:flutter/material.dart';


class LoginForm extends StatelessWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    return const ScreenTypeLayout(
      mobile: LoginFormMobileTablet(),
      desktop: LoginFormDesktop(),
    );
  }
}