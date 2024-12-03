import 'package:flash_cards/components/login/footer.dart';
import 'package:flash_cards/components/login/login_form.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class LoginMobileView extends StatelessWidget {
  const LoginMobileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          height: !kIsWeb ? MediaQuery.of(context).size.height - 100 : MediaQuery.of(context).size.height,
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              LoginForm(),
              Footer(),
            ],
          ),
        ),
      ),
      backgroundColor: Colors.white,
    );
  }
}