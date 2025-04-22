import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spell_champ_frontend/presentation/home/pages/word-slides.dart';
import 'package:spell_champ_frontend/providers/progress_provider.dart';

class ExercisesPage extends StatelessWidget {
  final Map<String, List<Map<String, String>>> exercises;
  final dynamic grade;
  
  const ExercisesPage({super.key, required this.exercises, required this.grade});

  @override
  Widget build(BuildContext context) {
    final progress = Provider.of<ProgressProvider>(context);
    return Scaffold(
      backgroundColor: Colors.purple[100],
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Exercises',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  Stack(
                    children: [
                      Container(
                        width: 50,
                        height: 50,
                        padding: const EdgeInsets.all(4.0),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black26,
                              blurRadius: 12.0,
                              offset: Offset(4, 4),
                            ),
                          ],
                        ),
                        child: Center(
                          child: Image.asset('assets/images/diamond.png'),
                        ),
                      ),
                      Positioned(
                        top: 2,
                        right: 3,
                        child: Container(
                          padding: const EdgeInsets.all(2.0),
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.black,
                          ),
                          child: Text(
                            progress.diamonds.toString(),
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16.0),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                itemCount: exercises.keys.length,
                itemBuilder: (context, index) {
                  final key = exercises.keys.elementAt(index);
                  return GestureDetector(
                    onTap: () async {
                      await precacheImage(
                        AssetImage('assets/images/exercise-image.png'),
                        context,
                      );
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => WordSlides(
                            exerciseNumber: index + 1,
                            data: exercises[key]!,
                            grade: grade,
                          ),
                        ),
                      );
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 8.0),
                      padding: const EdgeInsets.all(16.0),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12.0),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 12.0,
                            offset: Offset(4, 4),
                          ),
                        ],
                      ),
                      child: Text(
                        'Exercise: $key',
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                      ),
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
}
