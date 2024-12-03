import 'package:flutter/material.dart';

class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      alignment: AlignmentDirectional.centerStart,
      height: 64,
      width: MediaQuery.of(context).size.width,
      child: const Wrap(
        spacing: 40,
        children: [
          Text(
            'Help',
            style: TextStyle(
              fontSize: 16,
            ),
          ),
          Text(
            'Privacy',
            style: TextStyle(
              fontSize: 16,
            ),
          ),
          Text(
            'Terms',
            style: TextStyle(
              fontSize: 16,
            ),
          )
        ],
      ),
    );
  }
}