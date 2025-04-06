import 'package:flutter/material.dart';
import 'package:spell_champ_frontend/presentation/home/bloc/exercises.dart';

class ExerciseHomePage extends StatelessWidget {
  const ExerciseHomePage({super.key, required int grade});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFD3CFE3),
      body: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10),

                  // Welcome Text
                  const Text(
                    "Welcome back",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400, color: Colors.black54),
                  ),
                  const Text(
                    "",
                    style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Colors.black),
                  ),
                  const SizedBox(height: 20),

                  // Daily Drill Section
                  const Text("Daily Drill", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 10),

                  // Daily Drill Days Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: List.generate(6, (index) {
                      return Column(
                        children: [
                          CircleAvatar(
                            backgroundColor:  Colors.white,
                            radius: 20,
                          ),
                          const SizedBox(height: 5),
                          Text(["Mon", "Tue", "Wed", "Thu", "Fri", "Sat"][index]),
                        ],
                      );
                    }),
                  ),
                  const SizedBox(height: 20),

                  // EXERCISES Card (Increased Size & Clickable)
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) =>  ExercisesPage()),
                      );
                    },
                    child: _buildLargeCard("assets/vectors/exercise.png"),
                  ),

                  const SizedBox(height: 15),

                  // QUIZ & RESULTS Row with Trophy and Quiz Images
                  Row(
                    children: [
                      Expanded(child: _buildQuizCard("assets/vectors/quiz.png", "assets/fonts/quiz-font.png")),
                      const SizedBox(width: 10),
                      Expanded(child: _buildResultCard("assets/vectors/result.png", "assets/fonts/result-font.png")),
                    ],
                  ),

                  const Spacer(),
                ],
              ),
            ),

            // Diamond Image with 50 Badge on Top Right
            Positioned(
              top: 10,
              right: 10,
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Image.asset("assets/vectors/diamond.png", width: 41, height: 46),
                  Positioned(
                    top: -2,
                    right: 3,
                    child: Image.asset(
                      "assets/vectors/diamond_50.png",
                      width: 12,
                      height: 14,
                    ),
                  ),
                ],
              ),
            ),

            // Bottom Navigation Bar Image
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Image.asset("assets/images/bar.png", fit: BoxFit.cover),
            ),
          ],
        ),
      ),
    );
  }

  // Large Card for EXERCISES (Further Increased Size)
  Widget _buildLargeCard(String imagePath) {
    return Container(
      clipBehavior: Clip.none,
      height: 250, // Increased height for full visibility
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        image: DecorationImage(
          image: AssetImage(imagePath),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  // Small Card for QUIZ with Quiz Images
  Widget _buildQuizCard(String backgroundPath, String fontPath) {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.center,
      children: [
        Container(
          height: 100,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [BoxShadow(color: Colors.grey.shade400, blurRadius: 5)],
          ),
          child: Center(
            child: Image.asset(backgroundPath, width: 60, height: 60, fit: BoxFit.contain),
          ),
        ),
        Positioned(
          child: Image.asset(fontPath, width: 80),
        ),
        Positioned(top: 5, left: 5, child: Image.asset("assets/vectors/quiz-image1.png", width: 38.6, height: 29.34)),
        Positioned(top: 15, left: 27, child: Image.asset("assets/vectors/quiz-image2.png", width: 22.35, height: 16.01)),
        Positioned(top: 5, right: 5, child: Image.asset("assets/vectors/quiz-image3.png", width: 42.51, height: 39.47)),
        Positioned(bottom: -20, left: -20, child: Image.asset("assets/vectors/quiz-image4.png", width: 62, height: 70)),
        Positioned(bottom: 5, right: 5, child: Image.asset("assets/vectors/quiz-image5.png", width: 28, height: 28)),
      ],
    );
  }

  // Small Card for RESULTS with Trophy Images
  Widget _buildResultCard(String backgroundPath, String fontPath) {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.center,
      children: [
        Container(
          height: 100,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [BoxShadow(color: Colors.grey.shade400, blurRadius: 5)],
          ),
          child: Center(
            child: Image.asset(backgroundPath, width: 60, height: 60, fit: BoxFit.contain),
          ),
        ),
        Positioned(
          child: Image.asset(fontPath, width: 80),
        ),
        Positioned(top: 5, left: 5, child: Image.asset("assets/vectors/result-image.png", width: 50.61, height: 51.75)),
        Positioned(top: 5, right: 5, child: Image.asset("assets/vectors/trophy 1.png", width: 55, height: 54)),
        Positioned(bottom: 5, left: 5, child: Image.asset("assets/vectors/trophy 2.png", width: 30.94, height: 28.51)),
        Positioned(bottom: -30, right: -20, child: Image.asset("assets/vectors/trophy 3.png", width: 75, height: 73)),
      ],
    );
  }
}