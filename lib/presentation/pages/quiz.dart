import 'package:flutter/material.dart';
import 'package:spell_champ_frontend/common/widgets/button/diamond_badge.dart';
import 'package:spell_champ_frontend/core/configs/theme/app_theme.dart';

import 'package:spell_champ_frontend/core/diamond_progress_manager.dart';


void main() {
  runApp(
    MaterialApp(
      home: const QuizScreen(),
      theme: AppTheme.lightTheme,
      debugShowCheckedModeBanner: false,
    ),
  );
}

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  final DiamondProgressManager manager = DiamondProgressManager();

  @override
  void initState() {
    super.initState();
    manager.loadSampleData();
    setState(() {});
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          DiamondBadge(
            diamondCount: manager.diamonds,
            top: 50,
            right: 30,
          ),
          Center(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 5),
              padding: const EdgeInsets.all(80),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 10,
                    offset: Offset(4, 4),
                  ),
                ],
              ),
              child: Stack(
                clipBehavior: Clip.none,
                alignment: Alignment.center,
                children: [
                  const Text(
                    'QUIZ',
                    style: TextStyle(
                      fontSize: 80,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF000046),
                    ),
                  ),
                  Positioned(
                    top: -105,
                    left: -110,
                    child: Image.asset(
                      'assets/images/pigy.png',
                      width: 130,
                    ),
                  ),
                  Positioned(
                    bottom: 100,
                    right: 130,
                    child: Image.asset(
                      'assets/images/pigy.png',
                      width: 40,
                    ),
                  ),
                  Positioned(
                    top: -95,
                    right: -110,
                    child: Image.asset(
                      'assets/images/note_pen.png',
                      width: 120,
                    ),
                  ),
                  Positioned(
                    bottom: -120,
                    left: -100,
                    child: Image.asset(
                      'assets/images/quizgirl_2.png',
                      width: 120,
                    ),
                  ),
                  Positioned(
                    bottom: -80,
                    right: -65,
                    child: Image.asset(
                      'assets/images/quizgirl_1.png',
                      width: 60,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
