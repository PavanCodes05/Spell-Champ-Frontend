import 'package:flutter/material.dart';
import 'package:spell_champ_frontend/core/configs/theme/app_theme.dart';
import 'package:spell_champ_frontend/presentation/auth/pages/signup%20_or_login.dart';
import 'package:spell_champ_frontend/presentation/home/pages/home.dart';
import 'package:spell_champ_frontend/presentation/home/pages/pickImage.dart';
import 'package:spell_champ_frontend/presentation/home/pages/QuizzesPage.dart';
import 'package:spell_champ_frontend/presentation/home/pages/missingWords.dart';

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
      home: const WelcomeScreen()    
  );
  }
}

