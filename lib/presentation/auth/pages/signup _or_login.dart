import 'package:flutter/material.dart';
import 'package:spell_champ_frontend/common/widgets/button/basic_app_button.dart';
import 'package:spell_champ_frontend/core/configs/theme/app_colors.dart';
import 'package:spell_champ_frontend/presentation/auth/pages/login_screen.dart';
import 'package:spell_champ_frontend/presentation/auth/pages/signup_screen.dart';



class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 100,
              width: 100,
              decoration: const BoxDecoration(
                color: AppColors.white,
                shape: BoxShape.circle,
              ),
              child: const Center(
                child: Text("Logo",
                 style: TextStyle(
                  fontSize: 18,
                   fontWeight: FontWeight.bold
                   )
                   ),
              ),
            ),
            const SizedBox(height: 20),
            const Text("SPELL CHAMP", 
            style: TextStyle(
              fontSize: 34,
               fontWeight: FontWeight.bold,
                color: Colors.black
                )
                ),
             const SizedBox(height: 20),
               
            const Text("Master every word, be a ",
             style: TextStyle(
              fontSize: 20,
               fontWeight: FontWeight.bold, 
               color: AppColors.lightblack
               )
               ),
               const Text(" SPELL CHAMP",
             style: TextStyle(
              fontSize: 20,
               fontWeight: FontWeight.bold, 
               color: AppColors.lightblack
               )
               ),
            const SizedBox(height: 40,),
            SizedBox(
              width: 150,
              child: BasicAppBotton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginScreen()));
                },
                title: 'Log in',
                
              ),
            ),

            const SizedBox(height: 10,),
            SizedBox(
              width: 150,
              child: SignupButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const SignupScreen()));
                },
                title: 'Sign up',
                
              ),
            ),
          ],
        ),
      ),
    );
  }
}



