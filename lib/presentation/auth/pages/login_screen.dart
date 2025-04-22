import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter/material.dart';
import 'package:spell_champ_frontend/core/configs/theme/app_colors.dart';
import 'package:spell_champ_frontend/presentation/home/pages/exercises.dart';
import 'package:logger/logger.dart';

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
    setState(() {
      _isLoading = true;
    });

    final email = emailController.text.trim();
    final password = passwordController.text;

    if (email.isEmpty || !isValidEmail(email)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enter a valid email")),
      );
      setState(() {
        _isLoading = false;
      });
      return;
    }

    if (password.isEmpty || password.length < 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Password must be at least 6 characters")),
      );
      setState(() {
        _isLoading = false;
      });
      return;
    }

    final response = await http.post(Uri.parse("https://spell-champ-backend-2.onrender.com/api/v1/auth/login"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"email": email, "password": password}));

    if (response.statusCode == 200 || response.statusCode == 201) {
      final jsonResponse = jsonDecode(response.body);

      final token = jsonResponse["data"]["token"];
      final user = jsonResponse["data"];

      // Store in secure storage
      await secureStorage.write(key: "token", value: token);
      await secureStorage.write(key: "user", value: jsonEncode(user));

      final userData = await secureStorage.read(key: "user");
      final decodedUser = jsonDecode(userData!);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Login Successful")),
      );

      final grade = decodedUser["currentGrade"];
      final exerciseInfo = await http.get(Uri.parse("https://spell-champ-backend-2.onrender.com/api/v1/grade/$grade/exercises"));

      // logger.i("exerciseInfo: ${exerciseInfo.body}");

      if (exerciseInfo.statusCode == 200 || exerciseInfo.statusCode == 201) {
        final exerciseInfoJson = jsonDecode(exerciseInfo.body);
        final exercises = exerciseInfoJson["data"];
        // logger.i("exercises: $exercises");
        await secureStorage.write(key: "exercises", value: jsonEncode(exercises));
      }

      final exercises = await secureStorage.read(key: "exercises");
      final decodedExercises = jsonDecode(exercises!) as Map<String, dynamic>;

      final properlyTyped = decodedExercises.map((key, value) {
        return MapEntry(
          key,
          (value as List).map<Map<String, String>>((item) => Map<String, String>.from(item)).toList(),
        );
      });

      Navigator.of(context).pushReplacement(
        PageRouteBuilder(
          pageBuilder: (_, __, ___) => ExercisesPage(exercises: properlyTyped, grade: grade,),
          transitionDuration: const Duration(milliseconds: 500),
          transitionsBuilder: (_, Animation<double> animation, __, Widget child) {
            return SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(1, 0),
                end: Offset.zero,
              ).animate(animation),
              child: child,
            );
          },
        ),
      );

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Login Successful")),
      );
      setState(() {
        _isLoading = false;
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: ${jsonDecode(response.body)["error"]["code"]}")),
      );
      setState(() {
        _isLoading = false;
      });
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

