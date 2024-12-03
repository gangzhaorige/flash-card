import 'package:colorful_safe_area/colorful_safe_area.dart';
import 'package:flash_cards/views/signup/signup_desktop.dart';
import 'package:flutter/material.dart';

import '../../commons/responsive.dart';
import 'signup_mobile.dart';
import 'signup_tablet.dart';

class SignUpView extends StatelessWidget {
  const SignUpView({super.key});

  @override
  Widget build(BuildContext context) {
    return const ColorfulSafeArea(
      color: Colors.white,
      child: Center(
        child: ScreenTypeLayout(
          mobile: SignUpMobileView(),
          tablet: SignUpTableView(),
          desktop: SignUpViewDesktop(),
        ),
      ),
    );
  }
}

