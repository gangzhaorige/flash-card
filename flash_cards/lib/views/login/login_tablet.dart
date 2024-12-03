import 'package:flash_cards/components/login/login_form.dart';
import 'package:flutter/material.dart';

import '../../components/login/footer.dart';

class LoginTableView extends StatelessWidget {
  const LoginTableView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 240, 244, 249),
      body: Center(
        child: FittedBox(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 480,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: Colors.white, // Border color
                    width: 2, // Border width
                  ),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: const LoginForm()
              ),
              const SizedBox(
                width: 480,
                child: Footer()
              ),
            ],
          ),
        ),
      ),
      // backgroundColor: Colors.white,
    );
  }
}