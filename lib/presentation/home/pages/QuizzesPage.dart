import 'package:flutter/material.dart';
import 'package:spell_champ_frontend/core/configs/theme/app_colors.dart';
import 'quiz_slides_page.dart'; 

class QuizzesPage extends StatelessWidget {
  final Map<String, List<Map<String, dynamic>>> data;
  final String grade;

  const QuizzesPage({super.key, required this.data, required this.grade});

  @override
  Widget build(BuildContext context) {
    final quizKeys = data.keys.toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Quizzes',
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        backgroundColor: AppColors.background,
        elevation: 0,
        toolbarHeight: 80,
      ),
      body: ListView.builder(
        itemCount: quizKeys.length,
        itemBuilder: (context, index) {
          final quizKey = quizKeys[index];

          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
            ),
            child: ListTile(
              title: Text(
                'Quiz $quizKey',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.left,
              ),
              onTap: () {
                final quizList = data[quizKey]!;
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => QuizSlidesPage(exerciseNumber: index + 1, grade: grade, quizList: quizList,),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}



