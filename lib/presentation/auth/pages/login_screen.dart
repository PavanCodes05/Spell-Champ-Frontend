import 'package:flutter/material.dart';
import 'package:spell_champ_frontend/core/configs/theme/app_colors.dart';
import 'package:spell_champ_frontend/presentation/auth/pages/forgot_password.dart';
import 'package:spell_champ_frontend/presentation/auth/pages/reset_password.dart';

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
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: AppColors.spellchamp
             ),
            ),
            const SizedBox(height: 20), //Space below login label

            const Text("Login",       //page title
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black
          ),
          ),
          const SizedBox(height: 20),

          SizedBox(
            width:300,
            height: 50,

          
        
             child: TextField(decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
                       
                
             
              //const CustomTextField
              hintText: "Email Id",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: Colors.black),
              ),
             ),
           ),
           ), 
        const SizedBox(
              height: 10),
             
            SizedBox(
              width: 300,
              height: 50,
              child: TextField(
                obscureText: true,  
                decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                  
            
            
              hintText:"Password",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: Colors.white),
              ),
              ),
              ),
              ),
            const SizedBox(
              height: 10,
            ),
            Row(mainAxisAlignment: MainAxisAlignment.center,
              children: [
                  Expanded(child: Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(
                        context, 
                        MaterialPageRoute(builder: (context) => const ForgotPasswordPage()),
                      );
                    },
                    
                       //Forgot password logic
                      child: const Text('Forgot password?'
                     
                      ),
                  ),
                  ),
                  ),
              // Forgot password logic
                  Expanded(child: Align(
                    alignment: Alignment.centerLeft,
                    child: TextButton(
                      onPressed: () {
                        Navigator.push(
                          context, 
                          MaterialPageRoute(builder: (context) => const ResetPasswordPage()),
                        );
                      },
                    // Reset password logic
                  child: const Text('Reset password?'
                  ),
             ),
            ),
          ),
        // Reset password logic
          ],
        ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                // Login logic
              },
              child: const Padding(

                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: Text('Log in'),
                ),
            ),
            Row (
          children: [
            Expanded(
            child: Divider(
              color:Colors.black,
              thickness: 1,
            ),
         ),
         Padding(
          padding:EdgeInsets.symmetric(horizontal:10),
          child:Text(
            "also log in with ",
            style: TextStyle(fontSize:18,fontWeight: FontWeight.bold),
          ),
         ),
         Expanded(
          child: Divider(
            color: Colors.black,
            thickness:1
          ),
         ),
          ],
           ),
           SizedBox(height: 20),
           
            Column(
            children: [
              ElevatedButton(onPressed: () {},
               child: Text('Google'))
            ],
           )
          ],
        ),
      )
    ); 
  }
}

 