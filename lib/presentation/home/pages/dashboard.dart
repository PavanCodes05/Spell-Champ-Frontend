import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';
import 'package:spell_champ_frontend/common/widgets/diamond_badge.dart';
import 'package:spell_champ_frontend/core/configs/theme/app_colors.dart';
import 'package:spell_champ_frontend/presentation/auth/pages/signup%20_or_login.dart';
import 'package:spell_champ_frontend/presentation/auth/pages/gradeselection.dart';
import 'package:spell_champ_frontend/providers/progress_provider.dart';

class ProgressAchievementsScreen extends StatefulWidget {
  const ProgressAchievementsScreen({super.key});

  @override
  State<ProgressAchievementsScreen> createState() => _ProgressAchievementsScreenState();
}

class _ProgressAchievementsScreenState extends State<ProgressAchievementsScreen> {
  final secureStorage = const FlutterSecureStorage();

  late ProgressProvider progress;
  bool _initialized = false;

  String userName = "User";
  int grade = 1;
  int diamondCount = 0;
  int goldCount = 0;
  int silverCount = 0;
  int bronzeCount = 0;
  int exercisesCompleted = 0;
  int quizzesCompleted = 0;
  double progressPercent = 0.0;

  @override
  void initState() {
    super.initState();
    _retrieveUserInfo();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_initialized) {
      progress = Provider.of<ProgressProvider>(context, listen: false);
      _loadProgressValues();
      _initialized = true;
    }
  }

  void _loadProgressValues() {
    setState(() {
      diamondCount = progress.diamonds;
      goldCount = progress.gold;
      silverCount = progress.silver;
      bronzeCount = progress.bronze;
      exercisesCompleted = progress.exercisesCompleted;
      quizzesCompleted = progress.quizzesCompleted;
      progressPercent = ((exercisesCompleted + quizzesCompleted) / 20).clamp(0, 1).toDouble();
    });
  }

  Future<void> _retrieveUserInfo() async {
    try {
      final userJson = await secureStorage.read(key: "user");
      if (userJson != null) {
        final userData = jsonDecode(userJson);
        setState(() {
          userName = userData["data"]["name"] ?? "User";
          grade = userData["data"]["currentGrade"] ?? 1;
        });
      }
    } catch (_) {
      setState(() {
        userName = "User";
        grade = 1;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Progress & Achievements",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          TextButton(
            onPressed: () async {
              await secureStorage.deleteAll();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const WelcomeScreen()),
              );
            },
            child: const Text("Logout", style: TextStyle(color: Colors.black)),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    padding: const EdgeInsets.all(30),
                    decoration: BoxDecoration(
                      color: AppColors.spellchamp,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Row(
                      children: [
                        const CircleAvatar(
                          radius: 30,
                          backgroundColor: Colors.white,
                          child: Icon(Icons.person, size: 40, color: Colors.deepPurple),
                        ),
                        const SizedBox(width: 30),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              userName,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              "Grade $grade",
                              style: const TextStyle(fontSize: 16, color: Colors.white),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  DiamondBadge(diamondCount: diamondCount),
                ],
              ),
              const SizedBox(height: 40),
              Column(
                children: [
                  Text(
                    "${(progressPercent * 100).toInt()}%",
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Slider(
                    value: progressPercent,
                    onChanged: (_) {},
                    max: 1,
                    divisions: 100,
                    label: "${(progressPercent * 100).toInt()}%",
                    activeColor: AppColors.primary,
                  ),
                ],
              ),
              const SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildTrophyStat("assets/images/gold_trophy.png", "$goldCount Gold"),
                  _buildTrophyStat("assets/images/silver_trophy.png", "$silverCount Silver"),
                  _buildTrophyStat("assets/images/bronze_trophy.png", "$bronzeCount Bronze"),
                ],
              ),
              const SizedBox(height: 50),
              Center(
                child: Wrap(
                  alignment: WrapAlignment.center,
                  spacing: 16,
                  runSpacing: 16,
                  children: [
                    _buildStatCard("assets/images/exercises.png", "$exercisesCompleted\nExercises Completed"),
                    _buildStatCard("assets/images/quiz_image.png", "$quizzesCompleted\nCompleted Quizzes"),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.purple[300],
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => GradeSelectionScreen(userName: userName),
                      ),
                    );
                  },
                  child: const Text(
                    "Change Grade",
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTrophyStat(String imagePath, String label) {
    return Column(
      children: [
        Image.asset(imagePath, width: 100, height: 100),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: const [
              BoxShadow(color: Colors.black26, blurRadius: 4, offset: Offset(1, 2)),
            ],
          ),
          child: Text(label, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
        ),
      ],
    );
  }

  Widget _buildStatCard(String imagePath, String label) {
    return Container(
      width: 250,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.black, width: 1),
        boxShadow: const [
          BoxShadow(color: Colors.black26, blurRadius: 6, offset: Offset(2, 4)),
        ],
      ),
      child: Column(
        children: [
          Image.asset(imagePath, width: 60, height: 60),
          const SizedBox(height: 8),
          Text(label, textAlign: TextAlign.center, style: const TextStyle(fontSize: 18)),
        ],
      ),
    );
  }
}
