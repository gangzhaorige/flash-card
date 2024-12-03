
import 'package:flutter/material.dart';

class FlashButton extends StatelessWidget {
  const FlashButton({
    super.key,
    required this.onPressed,
    required this.text,
  });

  final VoidCallback onPressed;
  final String text;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      width: MediaQuery.of(context).size.width,
      child: OutlinedButton(
        onPressed: () => onPressed(),
        style: OutlinedButton.styleFrom(
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
          side: const BorderSide(
            color: Colors.grey,
          ),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0))
        ),
        child : Text(
          text,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 20
          ),
        ),
      ),
    );
  }
}