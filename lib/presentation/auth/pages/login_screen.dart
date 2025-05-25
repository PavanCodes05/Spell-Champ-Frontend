import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spell_champ_frontend/core/configs/theme/app_colors.dart';
import 'package:logger/logger.dart';
import 'package:spell_champ_frontend/presentation/home/pages/home.dart';
import 'package:spell_champ_frontend/providers/progress_provider.dart';

final secureStorage = const FlutterSecureStorage();
final logger = Logger();

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  bool isValidEmail(String email) {
    return RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w]{2,4}$").hasMatch(email);
  }

  bool _isLoading = false;

void _login(BuildContext context) async {
  setState(() => _isLoading = true);

  final email = emailController.text.trim();
  final password = passwordController.text;

  if (email.isEmpty || !isValidEmail(email)) {
    _showSnack("Please enter a valid email");
    setState(() => _isLoading = false);
    return;
  }

  if (password.isEmpty || password.length < 6) {
    _showSnack("Password must be at least 6 characters");
    setState(() => _isLoading = false);
    return;
  }

  try {
    final response = await http.post(
      Uri.parse("https://spell-champ-backend-2.onrender.com/api/v1/auth/login"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"email": email, "password": password}),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      final data = jsonDecode(response.body)["data"];
      final token = data["token"] as String;

      await secureStorage.delete(key: "progress");
      await secureStorage.write(key: "token", value: token);
      await secureStorage.write(key: "user", value: jsonEncode(data));

      final grade = data["currentGrade"];

      // 🧠 Load exercises and quizzes before UI starts
      await _loadExercisesAndQuizzes(grade);

      // ✅ Wait for progress to load
      await context.read<ProgressProvider>().loadFromBackend();
      await Future.delayed(Duration(milliseconds: 100));


      if (!mounted) return;
      if (kDebugMode) debugPrint("Navigating to ExerciseHomePage");
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const ExerciseHomePage()),
      );
    } else {
      _showSnack("Login failed: ${jsonDecode(response.body)["error"]["code"]}");
    }
  } catch (e) {
    _showSnack("An error occurred: $e");
  } finally {
    setState(() => _isLoading = false);
  }
}

void _showSnack(String msg) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
}

Future<void> _loadExercisesAndQuizzes(int grade) async {
  final exRes = await http.get(Uri.parse("https://spell-champ-backend-2.onrender.com/api/v1/grade/$grade/exercises"));
  final quizRes = await http.get(Uri.parse("https://spell-champ-backend-2.onrender.com/api/v1/grade/$grade/quizzes"));

  if (exRes.statusCode == 200) {
    final exercises = jsonDecode(exRes.body)["data"];
    await secureStorage.write(key: "exercises", value: jsonEncode(exercises));
  }

  if (quizRes.statusCode == 200) {
    final quizzes = jsonDecode(quizRes.body)["data"];
    await secureStorage.write(key: "quizzes", value: jsonEncode(quizzes));
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Center(
        child: _isLoading
            ? const CircularProgressIndicator()
            : Column(
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
                  const SizedBox(height: 20),
                  const Text(
                    "Login",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 20),

                  SizedBox(
                    width: 300,
                    height: 50,
                    child: TextField(
                      controller: emailController,
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

                  SizedBox(
                    width: 300,
                    height: 50,
                    child: TextField(
                      controller: passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hintText: "Password",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(color: Colors.black),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 30),

                  SizedBox(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.signupbackground,
                      ),
                      onPressed: () => _login(context),
                      child: const Text('Log in',
                          style: TextStyle(
                            color: Colors.white
                          ),
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}

