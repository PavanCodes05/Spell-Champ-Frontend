import 'package:flutter/material.dart';
import 'package:spell_champ_frontend/core/configs/theme/app_colors.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final bool isPassword;
  final double width;
  
  const CustomTextField({
    required this.hintText,
    this.isPassword = false,
    this.width=300,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
      return SizedBox(
      width: width, 
      child: TextField(
        obscureText: isPassword,
        decoration: InputDecoration(
          hintText: hintText,
          filled: true,
          fillColor: AppColors.inputBackground,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: AppColors.inputBorder),
          ),
        ),
      ),
    );
  }
}
