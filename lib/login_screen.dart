import 'package:flutter/material.dart';
import 'package:spell_champ_frontend/common/widgets/botton/basic_app_bottonn.dart';
import 'package:spell_champ_frontend/core/configs/theme/app_colors.dart';
import 'package:spell_champ_frontend/core/configs/theme/custom_text_field.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    
      body:Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            

            const Text(
              "SPELL CHAMP",
              style: TextStyle(
                fontSize: 34,
                fontWeight: FontWeight.bold,
                color: AppColors.spellchamp
             ),
            ),
            
            const SizedBox(
              height: 20,
              width: 150,
            ),
            const CustomTextField(hintText: "Email Id"),
            const SizedBox(
              height: 10,
              width: 150,
            ),
            const CustomTextField(hintText:"Password",isPassword: true,),
            const SizedBox(
              height: 10,
              width: 150,
            ),
            SizedBox(
              width: 150,
              child: BasicAppBotton(
                onPressed: () {},
                title: 'Log in',
              ),
            )
          ],
        ),
      )
    );
  }
}

