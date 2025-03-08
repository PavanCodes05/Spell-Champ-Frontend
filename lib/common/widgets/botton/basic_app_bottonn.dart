import 'package:flutter/material.dart';
import 'package:spell_champ_frontend/core/configs/theme/app_colors.dart';



class BasicAppBotton extends StatelessWidget{
  final VoidCallback onPressed;
  final String title; 
  final Color? color;

  const BasicAppBotton({
    required this.onPressed,
    required this.title,
    this.color,
    
   
    super.key, 
    });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed:onPressed,
      style: ElevatedButton.styleFrom(
       backgroundColor: color ?? AppColors.white,
        
      ),
    
      child: Text(
        title,
      style: const TextStyle(color: AppColors.loginletter),
      )
    );
  }
}

class SignupButton extends StatelessWidget{
  final VoidCallback onPressed;
  final String title; 
  final Color? color;

  const SignupButton({
    required this.onPressed,
    required this.title,
    this.color,
    
   
    super.key, 
    });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed:onPressed,
      style: ElevatedButton.styleFrom(
       backgroundColor: color ?? AppColors.signupbackground
       
        
      ),
    
      child: Text(
        title,
      style: const TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
      )
    );
  }
}