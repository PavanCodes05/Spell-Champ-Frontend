import 'package:flutter/material.dart';
import 'package:spell_champ_frontend/core/configs/theme/app_theme.dart';
import 'package:spell_champ_frontend/presentation/pages/signup%20_or_login.dart';


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
      home: const WelcomeScreen(),
    );
  }
}

