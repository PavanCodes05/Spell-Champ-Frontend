import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spell_champ_frontend/providers/progress_provider.dart';

class QuizResultsPage extends StatelessWidget {
  const QuizResultsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final quizTrophies = context.watch<ProgressProvider>().quizTrophies;
    final grade = context.watch<ProgressProvider>().grade;

    if (kDebugMode) {
      print('QuizTrophies: ${jsonEncode(quizTrophies)}');
    }

    final currentGradeQuizzes = quizTrophies.keys
        .where((key) => key.startsWith('quiz$grade'))
        .toList();

    if (currentGradeQuizzes.isEmpty) {
      return Scaffold(
        body: Center(
          child: Text(
            'No trophies won in the current grade',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      );
    }

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Text(
                  'Trophies You have gained',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: currentGradeQuizzes.length,
                itemBuilder: (context, index) {
                  final quizKey = currentGradeQuizzes[index];
                  final trophy = quizTrophies[quizKey];

                  return Container(
                    margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                    padding: const EdgeInsets.all(25),
                    decoration: BoxDecoration(
                      color: trophy != null
                          ? const Color.fromRGBO(161, 160, 207, 1)
                          : Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [const BoxShadow(color: Colors.grey, blurRadius: 10)],
                    ),
                    child: Row(
                      children: [
                        Text(
                          'Quiz ${index + 1}',
                          style: const TextStyle(fontSize: 24),
                        ),
                        const SizedBox(width: 25),
                        Row(
                          children: [
                            _buildTrophyImage('gold', trophy == 'gold', size: 45),
                            _buildTrophyImage('silver', trophy == 'silver', size: 45),
                            _buildTrophyImage('bronze', trophy == 'bronze', size: 45),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTrophyImage(String type, bool isHighlighted, {required double size}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: isHighlighted ? Colors.white : Colors.transparent,
        ),
        child: Opacity(
          opacity: isHighlighted ? 1.0 : 0.5,
          child: Image.asset(
            'assets/images/${type}_trophy.png',
            width: size,
            height: size,
          ),
        ),
      ),
    );
  }
}

