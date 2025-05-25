import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';
import 'package:spell_champ_frontend/presentation/home/pages/exercises.dart';
import 'package:spell_champ_frontend/presentation/home/pages/QuizzesPage.dart';
import 'package:spell_champ_frontend/presentation/home/pages/dashboard.dart';
import 'package:spell_champ_frontend/presentation/home/pages/quiz_results.dart';
import 'package:spell_champ_frontend/providers/progress_provider.dart';

class ExerciseHomePage extends StatefulWidget {
  const ExerciseHomePage({super.key});

  @override
  State<ExerciseHomePage> createState() => _ExerciseHomePageState();
}

class _ExerciseHomePageState extends State<ExerciseHomePage> {
  final secureStorage = const FlutterSecureStorage();
  // String userName = "";
  int grade = 1;
  Map<String, List<Map<String, String>>> allExercises = {};
  Map<String, List<Map<String, dynamic>>> allQuizzes = {};
  Map<String, String> quizTrophies = {};
  List<bool> dailyDrill = List.filled(6, false);

  @override
  void initState() {
    super.initState();
    _retrieveExercises();
    _retrieveQuizExercises();
    _checkDailyLogin();
    _retrieveQuizTrophies();
  }

  Future<void> _retrieveExercises() async {
    final exercises = await secureStorage.read(key: "exercises");

    if (exercises != null) {
      final decoded = jsonDecode(exercises) as Map<String, dynamic>;

      final parsed = decoded.map(
        (key, value) => MapEntry(
          key,
          (value as List).map<Map<String, String>>(
            (item) => Map<String, String>.from(item),
          ).toList(),
        ),
      );

      setState(() {
        allExercises = parsed;
      });
    }
  }

  Future<void> _retrieveQuizExercises() async {
    final quizzes = await secureStorage.read(key: "quizzes");
    if (kDebugMode) {
      print(quizzes);
    }

    if (quizzes != null) {
      final decoded = jsonDecode(quizzes) as Map<String, dynamic>;

      final parsed = decoded.map(
        (key, value) => MapEntry(
          key,
          (value as List).map<Map<String, dynamic>>(
            (item) => Map<String, dynamic>.from(item),
          ).toList(),
        ),
      );

      if (kDebugMode) {
        print(parsed);
      }

      setState(() {
        allQuizzes = parsed;
      });
    }
  }

  void _retrieveQuizTrophies() {
    final trophies = Provider.of<ProgressProvider>(context, listen: false).quizTrophies;
    setState(() {
      quizTrophies = Map<String, String>.from(trophies); // Already a Map
    });
  }


  Future<void> _checkDailyLogin() async {
    final lastLoginDateStr = await secureStorage.read(key: "lastLoginDate");
    final currentDate = DateTime.now();
    final currentWeekday = currentDate.weekday;

    if (lastLoginDateStr != null) {
      final lastLoginDate = DateTime.parse(lastLoginDateStr);
      if (lastLoginDate.day != currentDate.day) {
        setState(() {
          dailyDrill[currentWeekday - 1] = true;
        });
        await secureStorage.write(key: "lastLoginDate", value: currentDate.toIso8601String());
      }
    } else {
      await secureStorage.write(key: "lastLoginDate", value: currentDate.toIso8601String());
      setState(() {
        dailyDrill[currentWeekday - 1] = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final progress = Provider.of<ProgressProvider>(context, listen: true);
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
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                      color: Colors.black54,
                    ),
                  ),
                  Text(
                    progress.userName,
                    style: const TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 40),
                  const Text("Daily Drill", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: List.generate(6, (index) {
                      return Column(
                        children: [
                          CircleAvatar(
                            radius: 25,
                            backgroundImage: dailyDrill[index] ? const AssetImage("assets/images/tick.png") : null,
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
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => ExercisesPage(exercises: allExercises, grade: progress.grade)),
                      );
                    },
                    child: _buildExerciseCard(),
                  ),
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
            _buildTopRightDiamond(progress.diamonds.toString()),
            _buildTopLeftProfile(),
          ],
        ),
      ),
    );
  }

  Widget _buildTopRightDiamond(String diamonds) {
    return Positioned(
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
                  offset: const Offset(0, 2),
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
              child: Text(
                diamonds,
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
    );
  }

  Widget _buildTopLeftProfile() {
    return Positioned(
      top: 7,
      left: 15,
      child: GestureDetector(
        onTap: () async {
          // Navigate to profile/settings
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const ProgressAchievementsScreen()),
          );
        },
        child: Image.asset(
          "assets/images/account.png",
          width: 40,
          height: 40,
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
              style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold, color: Color(0xFF27135E)),
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
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => QuizzesPage(grade: grade.toString(), data: allQuizzes,)),
        );
      },
      child: Stack(
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
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Color(0xFF27135E)),
              ),
            ),
          ),
          Positioned(top: 5, left: 5, child: Image.asset("assets/images/quiz-image1.png", width: 38.6, height: 29.34)),
          Positioned(top: 15, left: 27, child: Image.asset("assets/images/quiz-image2.png", width: 22.35, height: 16.01)),
          Positioned(top: 5, right: 5, child: Image.asset("assets/images/quiz-image3.png", width: 42.51, height: 39.47)),
          Positioned(bottom: -20, left: -20, child: Image.asset("assets/images/quiz-image4.png", width: 62, height: 70)),
          Positioned(bottom: 5, right: 5, child: Image.asset("assets/images/quiz-image5.png", width: 28, height: 28)),
        ],
      ),
    );
  }

  Widget _buildResultCard() {
    return GestureDetector(
      onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => QuizResultsPage()
        )
      );
      },
      child: Stack(
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
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFF27135E)),
              ),
            ),
          ),
          Positioned(left: 5, top: 5, child: Image.asset("assets/images/result-image.png", width: 50.61, height: 51.75)),
          Positioned(right: 0, top: 0, child: Image.asset("assets/images/trophy 1.png", width: 55, height: 54)),
          Positioned(left: 5, bottom: 5, child: Image.asset("assets/images/trophy 2.png", width: 30.94, height: 28.51)),
          Positioned(right: -18, bottom: -35, child: Image.asset("assets/images/trophy 3.png", width: 75, height: 73)),
        ],
      ),
    );
  }
}
