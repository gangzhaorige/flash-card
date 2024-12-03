import 'package:flash_cards/components/login/login_desktop.dart';
import 'package:flash_cards/components/login/login_form.dart';
import 'package:flash_cards/components/signup/signup_desktop.dart';
import 'package:flutter/material.dart';

import '../../components/login/footer.dart';

class SignUpViewDesktop extends StatelessWidget {
  const SignUpViewDesktop({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 240, 244, 249),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 450,
              width: 1040,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: Colors.white, // Border color
                  width: 2, // Border width
                ),
              ),
              margin: const EdgeInsets.symmetric(horizontal: 108),
              child: const SignUpFormDesktop()
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 108),
              child: SizedBox(
                width: 1040,
                child: Footer()
              ),
            ),
          ],
        ),
      ),
      // backgroundColor: Colors.white,
    );
  }
}