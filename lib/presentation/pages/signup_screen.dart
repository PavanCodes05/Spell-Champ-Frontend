import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:spell_champ_frontend/common/widgets/button/basic_app_button.dart';
import 'package:spell_champ_frontend/presentation/pages/gradeselection.dart';

void main() {
  runApp(
    const MaterialApp(
      home: SignupScreen(),
      debugShowCheckedModeBanner: false,
    ),
  );
}

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  SignupScreenState createState() => SignupScreenState();
}

class SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 40),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "SPELL CHAMP",
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "Signup",
                    style: TextStyle(fontSize: 24, color: Colors.black),
                  ),
                  const SizedBox(height: 20),

                  SizedBox(
                    width: 300,
                    height: 55,
                    child: TextFormField(
                      controller: _nameController,
                      keyboardType: TextInputType.name,
                      decoration: _buildInputDecoration("Name", "Enter your Name"),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter your name";
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(height: 10),

                  SizedBox(
                    width: 300,
                    height: 55,
                    child: TextFormField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: _buildInputDecoration("Email", "Enter your Email ID"),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter email";
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(height: 10),

                  SizedBox(
                    width: 300,
                    height: 55,
                    child: TextFormField(
                      controller: _passwordController,
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: true,
                      decoration: _buildInputDecoration("Password", "Enter your Password"),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter your password";
                        } else if (value.length < 6) {
                          return "Password must contain at least 6 characters";
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: 150,
                    child: SignupButton(
                      onPressed: _handleSignup,
                      title: 'Sign Up',
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  InputDecoration _buildInputDecoration(String label, String hint) {
    return InputDecoration(
      labelText: label,
      hintText: hint,
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: Colors.black),
      ),
    );
  }

  void _handleSignup() {
    if (_formKey.currentState!.validate()) {
      Fluttertoast.showToast(msg: 'Signup Successful');
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const GradeSelectionScreen()),
      );
    }
  }
}
