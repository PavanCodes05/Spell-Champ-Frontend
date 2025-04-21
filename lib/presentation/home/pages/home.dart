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
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 35),
                  const Text(
                    "Welcome back",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400, color: Colors.black54),
                  ),
                  const Text(
                    "Sheetaal Gandhi",
                    style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Colors.black),
                  ),
                  const SizedBox(height: 40),
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
                                  width: 40,
                                  height: 40,
                                ),
                            ],
                          ),
                          const SizedBox(height: 5),
                          Text(
                            ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat"][index],
                            style: const TextStyle(
                              color: Colors.white,
                              shadows: [BoxShadow(color: Colors.grey, blurRadius: 10)],
                            ),
                          ),
                        ],
                      );
                    }),
                  ),
                  const SizedBox(height: 30),
                  _buildExerciseCard(),
                  const SizedBox(height: 50),
                  Row(
                    children: [
                      Expanded(child: _buildQuizCard()),
                      const SizedBox(width: 10),
                      Expanded(child: _buildResultCard()),
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
                          color: Colors.grey,
                          blurRadius: 10,
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
                          shadows: [BoxShadow(color: Colors.grey, blurRadius: 10)],
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
              top: 7,
              left: 15,
              child: GestureDetector(
                onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Scaffold(
                    appBar: AppBar(title: Text('Account Page')),
                    body: Center(child: Text('Account Page Placeholder')),
                  )),
                );

                },
                child: Image.asset(
                  "assets/images/account.png",
                  width: 40,
                  height: 40,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildExerciseCard() {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          height: 158,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Colors.white,
            boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 10)],
          ),
          child: const Center(
            child: Text(
              "EXERCISES",
              style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold, color: Color.fromARGB(255, 39, 19, 94)),
            ),
          ),
        ),
        Positioned(top: 0, left: 10, child: Image.asset("assets/images/exercise-image1.png", width: 60.44, height: 59.25)),
        Positioned(top: 5, right: 30, child: Image.asset("assets/images/exercise-image2.png", width: 30.12, height: 29.73)),
        Positioned(bottom: 10, left: 10, child: Image.asset("assets/images/exercise-image3.png", width: 30, height: 30)),
        Positioned(bottom: -35, right: -30, child: Image.asset("assets/images/exercise-image4.png", width: 137, height: 116.53)),
      ],
    );
  }

  Widget _buildQuizCard() {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          height: 159,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Colors.white,
            boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 10)],
          ),
          child: const Center(
            child: Text(
              "QUIZ",
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Color.fromARGB(255, 39, 19, 94)),
            ),
          ),
        ),
        Positioned(top: 5, left: 5, child: Image.asset("assets/images/quiz-image1.png", width: 38.6, height: 29.34)),
        Positioned(top: 15, left: 27, child: Image.asset("assets/images/quiz-image2.png", width: 22.35, height: 16.01)),
        Positioned(top: 5, right: 5, child: Image.asset("assets/images/quiz-image3.png", width: 42.51, height: 39.47)),
        Positioned(bottom: -20, left: -20, child: Image.asset("assets/images/quiz-image4.png", width: 62, height: 70)),
        Positioned(bottom: 5, right: 5, child: Image.asset("assets/images/quiz-image5.png", width: 28, height: 28)),
      ],
    );
  }

  Widget _buildResultCard() {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          height: 159,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Colors.white,
            boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 10)],
          ),
          child: const Center(
            child: Text(
              "RESULTS",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color.fromARGB(255, 39, 19, 94)),
            ),
          ),
        ),
        Positioned(left: 5, top: 5, child: Image.asset("assets/images/result-image.png", width: 50.61, height: 51.75)),
        Positioned(right: 0, top: 0, child: Image.asset("assets/images/trophy 1.png", width: 55, height: 54)),
        Positioned(left: 5, bottom: 5, child: Image.asset("assets/images/trophy 2.png", width: 30.94, height: 28.51)),
        Positioned(right: -18, bottom: -35, child: Image.asset("assets/images/trophy 3.png", width: 75, height: 73)),
      ],
    );
  }
}
