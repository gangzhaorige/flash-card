

import 'package:flash_cards/components/signup/signup_desktop.dart';
import 'package:flash_cards/components/signup/signup_mobile_tablet.dart';
import 'package:flutter/material.dart';

import '../../commons/responsive.dart';

class SignUpForm extends StatelessWidget {
  const SignUpForm({super.key});

  @override
  Widget build(BuildContext context) {
    return const ScreenTypeLayout(
      mobile: SignUpFormMobileTablet(),
      desktop: SignUpFormDesktop(),
    );
  }
}