import 'package:colorful_safe_area/colorful_safe_area.dart';
import 'package:flash_cards/views/login/login_desktop.dart';
import 'package:flutter/material.dart';

import '../../commons/responsive.dart';
import 'login_mobile.dart';
import 'login_tablet.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return const ColorfulSafeArea(
      color: Colors.white,
      child: Center(
        child: ScreenTypeLayout(
          mobile: LoginMobileView(),
          tablet: LoginTableView(),
          desktop: LoginViewDesktop(),
        ),
      ),
    );
  }
}

