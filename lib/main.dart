import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:spell_champ_frontend/core/configs/theme/app_theme.dart';
import 'package:spell_champ_frontend/presentation/auth/pages/signup%20_or_login.dart';
import 'package:spell_champ_frontend/presentation/home/pages/home.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppTheme.lightTheme,
      debugShowCheckedModeBanner: false,
      home: FutureBuilder(
        future: const FlutterSecureStorage().read(key: 'user'),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return const ExerciseHomePage();
          } else {
            return const WelcomeScreen();
          }
        },
      ),
    );
  }
}

