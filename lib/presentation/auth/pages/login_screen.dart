import 'package:flutter/material.dart';
import 'package:spell_champ_frontend/core/configs/theme/app_colors.dart';
import 'package:spell_champ_frontend/presentation/auth/pages/forgot_password.dart';
import 'package:spell_champ_frontend/presentation/auth/pages/grade_selection_screen.dart';
import 'package:spell_champ_frontend/presentation/auth/pages/reset_password.dart';


class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "SPELL CHAMP",
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: AppColors.spellchamp,
              ),
            ),
            const SizedBox(height: 20), // Space below login label

            const Text(
              "Login", // Page title
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 20),

            // Email TextField
            SizedBox(
              width: 300,
              height: 50,
              child: TextField(
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  hintText: "Email Id",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: Colors.black),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),

            // Password TextField
            SizedBox(
              width: 300,
              height: 50,
              child: TextField(
                obscureText: true,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  hintText: "Password",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: Colors.white),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),

            // Forgot Password & Reset Password Row
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const ForgotPasswordPage()),
                        );
                      },
                      child: const Text('Forgot password?'),
                    ),
                  ),
                ),
                Expanded(
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const ResetPasswordPage()),
                        );
                      },
                      child: const Text('Reset password?'),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),

            // Login Button (Navigate to Grade Selection Page)
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) =>  GradeSelectionScreen()),
                );
              },
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: Text('Log in'),
              ),
            ),

            // Divider for Google Login
            Row(
              children: [
                Expanded(
                  child: Divider(color: Colors.black, thickness: 1),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    "also log in with ",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                Expanded(
                  child: Divider(color: Colors.black, thickness: 1),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Google Login Button
            Column(
              children: [
                ElevatedButton(
                  onPressed: () {},
                  child: const Text('Google'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}