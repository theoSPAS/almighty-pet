import 'package:flutter/material.dart';
import '../consts/const_file.dart';

class CustomButton extends StatelessWidget {
  var onPressed;
  String label;

  CustomButton({required this.onPressed, required this.label});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: 55,
        padding: const EdgeInsets.symmetric(horizontal: 30),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: primaryGreen,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: primaryGreen.withOpacity(0.6),
              blurRadius: 30,
              offset: const Offset(0, 10),
            ),
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 30,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Text(
          label,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}