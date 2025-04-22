// lib/presentation/auth/pages/signup_screen.dart

import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:spell_champ_frontend/common/widgets/button/basic_app_button.dart';
import 'package:spell_champ_frontend/providers/progress_provider.dart';
import 'package:spell_champ_frontend/presentation/auth/pages/gradeselection.dart';

final _secureStorage = FlutterSecureStorage();

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController     = TextEditingController();
  final _emailController    = TextEditingController();
  final _passwordController = TextEditingController();

  bool _isLoading = false;

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
        child: _isLoading
          ? const CircularProgressIndicator()
          : SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 48),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      "SPELL CHAMP",
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.deepPurple,
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      "Sign Up",
                      style: TextStyle(fontSize: 24, color: Colors.black87),
                    ),
                    const SizedBox(height: 24),
                    TextFormField(
                      controller: _nameController,
                      decoration: _buildInputDecoration("Name", "Enter your name"),
                      validator: (v) => (v == null || v.isEmpty) ? "Please enter your name" : null,
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _emailController,
                      decoration: _buildInputDecoration("Email", "Enter your email"),
                      keyboardType: TextInputType.emailAddress,
                      validator: (v) => (v == null || v.isEmpty) ? "Please enter your email" : null,
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _passwordController,
                      decoration: _buildInputDecoration("Password", "Enter your password"),
                      obscureText: true,
                      validator: (v) {
                        if (v == null || v.isEmpty) return "Please enter a password";
                        if (v.length < 6) return "Password must be at least 6 characters";
                        return null;
                      },
                    ),
                    const SizedBox(height: 24),
                    BasicAppBotton(
                      title: "Sign Up",
                      onPressed: _submitSignup,
                    ),
                  ],
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
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
      ),
    );
  }

  Future<void> _submitSignup() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      final response = await http.post(
        Uri.parse("https://spell-champ-backend-2.onrender.com/api/v1/auth/signup"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "name":     _nameController.text.trim(),
          "email":    _emailController.text.trim(),
          "password": _passwordController.text,
        }),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = jsonDecode(response.body)["data"];
        final token = data["token"] as String;

        // 1️⃣ Clear any old progress for a clean start:
        await _secureStorage.delete(key: "progress");

        // 2️⃣ Store token & user
        await _secureStorage.write(key: "token", value: token);
        await _secureStorage.write(key: "user",  value: jsonEncode(data));

        // 3️⃣ Load fresh progress from backend
        await context.read<ProgressProvider>().loadFromBackend();

        Fluttertoast.showToast(msg: "Signup successful!");

        // 4️⃣ Navigate to grade selection
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (_) => GradeSelectionScreen(userName: data["name"] as String),
          ),
        );
      } else {
        Fluttertoast.showToast(msg: "Signup failed: ${response.body}");
      }
    } catch (e) {
      Fluttertoast.showToast(msg: "Error: $e");
      if (kDebugMode) debugPrint("Signup error: $e");
    } finally {
      setState(() => _isLoading = false);
    }
  }
}
