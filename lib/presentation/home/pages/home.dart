import 'package:flutter/material.dart';


class ExerciseHomePage extends StatefulWidget {
  const ExerciseHomePage({super.key, required this.grade});
  final int grade;

  @override
  State<ExerciseHomePage> createState() => _ExerciseHomePageState();
}

class _ExerciseHomePageState extends State<ExerciseHomePage> {
  final List<bool> taskCompleted = [true, true, false, true, false, false];

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
                  const Text(
                    "Welcome back",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400, color: Colors.black54),
                  ),
                  const Text(
                    "Sheetaal Gandhi",
                    style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Colors.black),
                  ),
                  const SizedBox(height: 20),
                  const Text("Daily Drill", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: List.generate(6, (index) {
                      return Column(
                        children: [
                          Stack(
                            alignment: Alignment.center,
                            children: [
                              const CircleAvatar(
                                backgroundColor: Colors.white,
                                radius: 20,
                              ),
                              if (taskCompleted[index])
                                Image.asset(
                                  "assets/images/tick.png",
                                  width: 40,  // Updated size
                                  height: 40, // Updated size
                                ),
                            ],
                          ),
                          const SizedBox(height: 5),
                          Text(["Mon", "Tue", "Wed", "Thu", "Fri", "Sat"][index]),
                        ],
                      );
                    }),
                  ),
                  GestureDetector(
                    
                    child: _buildLargeCard("assets/images/exercise.png"),
                  ),
                  const SizedBox(height: 15),
                  Row(
                    children: [
                      Expanded(child: _buildQuizCard("assets/images/quiz.png", "assets/images/quiz-font.png")),
                      const SizedBox(width: 10),
                      Expanded(child: _buildResultCard("assets/images/result.png", "assets/images/result-font.png")),
                    ],
                  ),
                  const Spacer(),
                ],
              ),
            ),
            Positioned(
              top: 10,
              right: 10,
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 2,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Center(
                      child: Image.asset("assets/images/diamond.png", width: 35, height: 30),
                    ),
                  ),
                  Positioned(
                    top: -7,
                    right: -2,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 1),
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Text(
                        "50",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 20,
              left: 20,
              right: 20,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 79, 17, 150),
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    )
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset("assets/images/home.png", width: 73, height: 29),
                    Image.asset("assets/images/clipboard.png", width: 28, height: 29),
                    Image.asset("assets/images/notification.png", width: 33, height: 33),
                    Image.asset("assets/images/Test Account.png", width: 25, height: 25),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLargeCard(String imagePath) {
    return Container(
      clipBehavior: Clip.none,
      height: 250,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        image: DecorationImage(
          image: AssetImage(imagePath),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

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
        Positioned(top: 5, left: 5, child: Image.asset("assets/images/quiz-image1.png", width: 38.6, height: 29.34)),
        Positioned(top: 15, left: 27, child: Image.asset("assets/images/quiz-image2.png", width: 22.35, height: 16.01)),
        Positioned(top: 5, right: 5, child: Image.asset("assets/images/quiz-image3.png", width: 42.51, height: 39.47)),
        Positioned(bottom: -20, left: -20, child: Image.asset("assets/images/quiz-image4.png", width: 62, height: 70)),
        Positioned(bottom: 5, right: 5, child: Image.asset("assets/images/quiz-image5.png", width: 28, height: 28)),
      ],
    );
  }

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
        Positioned(top: 5, left: 5, child: Image.asset("assets/images/result-image.png", width: 50.61, height: 51.75)),
        Positioned(top: 5, right: 5, child: Image.asset("assets/images/trophy 1.png", width: 55, height: 54)),
        Positioned(bottom: 5, left: 5, child: Image.asset("assets/images/trophy 2.png", width: 30.94, height: 28.51)),
        Positioned(bottom: -30, right: -20, child: Image.asset("assets/images/trophy 3.png", width: 75, height: 73)),
      ],
    );
  }
}