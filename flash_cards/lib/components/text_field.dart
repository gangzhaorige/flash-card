import 'package:flutter/material.dart';

class FlashTextField extends StatelessWidget {
  const FlashTextField({
    super.key,
    required this.controller,
    required this.text,
    this.obscureText = false,
    this.enableSuggestions = false,
    this.autocorrect = false,
  });

  final TextEditingController controller;
  final String text;
  final bool obscureText;
  final bool enableSuggestions;
  final bool autocorrect;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 54,
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        enableSuggestions: enableSuggestions,
        autocorrect: autocorrect,
        decoration: InputDecoration(
          floatingLabelBehavior: FloatingLabelBehavior.never,
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blue, width: 2.0),
            borderRadius: BorderRadius.all(
              Radius.circular(
                12,
              ),
            ),
          ),
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(8),
            ),
          ),
          labelText: text,
        ),
        style: const TextStyle(fontSize: 18),
      ),
    );
  }
}