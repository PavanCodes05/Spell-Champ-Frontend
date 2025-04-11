import 'package:flutter/material.dart';
import 'package:spell_champ_frontend/common/widgets/button/diamond_badge.dart';
import 'package:spell_champ_frontend/core/configs/theme/app_colors.dart';
import 'package:spell_champ_frontend/core/configs/theme/app_theme.dart';
import 'package:spell_champ_frontend/core/diamond_logic.dart';

void main() {
  runApp(
    MaterialApp(
      home: ProgressAchievementsScreen(),
      theme: AppTheme.lightTheme,
      debugShowCheckedModeBanner: false,
    ),
  );
}

class ProgressAchievementsScreen extends StatefulWidget {
  const ProgressAchievementsScreen({super.key});

  @override
  State<ProgressAchievementsScreen> createState() =>
      _ProgressAchievementsScreenState();
}

class _ProgressAchievementsScreenState
    extends State<ProgressAchievementsScreen> {
  static const int totalGrades = 12;
  static const int exercisesPerGrade = 10;
  static const int totalExercises = totalGrades * exercisesPerGrade;

  int goldCount = 0;
  int silverCount = 0;
  int bronzeCount = 0;
  int wordsLearned = 0;
  int diamonds = 0;
  int exercisesCompleted = 0;
  int quizzesCompleted = 0;
  double progressPercent = 0.0;

  @override
  void initState() {
    super.initState();
    loadProgressData();
  }

  void loadProgressData() {
    onWordLearned(75);
    for (int i = 0; i < 8; i++) {
      onExerciseCompleted();
    }
    onQuizCompleted(95); // Gold
    onQuizCompleted(75); // Silver
    onQuizCompleted(60); // Bronze
    onQuizCompleted(85); // Silver
    onQuizCompleted(45); // Bronze
  }

  void onWordLearned(int count) {
    wordsLearned += count;
    diamonds += DiamondUtils.calculateFromWords(count);
    updateProgress();
  }

  void onExerciseCompleted() {
    exercisesCompleted++;
    diamonds += DiamondUtils.calculateFromExercise();
    updateProgress();
  }

  void onQuizCompleted(int score) {
    quizzesCompleted++;
    diamonds += DiamondUtils.calculateFromQuiz();

    if (score >= 90) {
      goldCount++;
    } else if (score >= 70) {
      silverCount++;
    } else {
      bronzeCount++;
    }

    updateProgress();
  }

  void updateProgress() {
    int totalActivities = totalExercises * 2;
    int done = exercisesCompleted + quizzesCompleted;
    progressPercent = (done / totalActivities).clamp(0.0, 1.0);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const SizedBox(height: 75),
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
                          child: Icon(Icons.person,
                              size: 40, color: Colors.deepPurple),
                        ),
                        const SizedBox(width: 30),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              "Sheetaal Gandhi",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  color: Colors.white),
                            ),
                            Text(
                              "Grade - 7",
                              style:
                                  TextStyle(fontSize: 16, color: Colors.white),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  DiamondBadge(diamondCount: diamonds),
                ],
              ),
              const SizedBox(height: 40),
              Column(
                children: [
                  Text(
                    "${(progressPercent * 100).toInt()}%",
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
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
                  _buildTrophyStat(
                      "assets/images/gold_trophy.png", "$goldCount Gold"),
                  _buildTrophyStat("assets/images/silver_trophy.png",
                      "$silverCount Silver"),
                  _buildTrophyStat("assets/images/bronze_trophy.png",
                      "$bronzeCount Bronze"),
                ],
              ),
              const SizedBox(height: 50),
              Wrap(
                alignment: WrapAlignment.center,
                spacing: 16,
                runSpacing: 16,
                children: [
                  _buildStatCard("assets/images/book.png",
                      "$wordsLearned\nNo of words learnt"),
                  _buildStatCard("assets/images/dimond.png",
                      "$diamonds\nTotal diamonds"),
                  _buildStatCard("assets/images/exercise.png",
                      "$exercisesCompleted\nExercises complete"),
                  _buildStatCard("assets/images/quiz_image.png",
                      "$quizzesCompleted\nCompleted quiz"),
                ],
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
              BoxShadow(
                  color: Colors.black26, blurRadius: 4, offset: Offset(1, 2))
            ],
          ),
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildStatCard(String imagePath, String label) {
    return Container(
      width: 150,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.black, width: 1),
        boxShadow: const [
          BoxShadow(
              color: Colors.black26, blurRadius: 6, offset: Offset(2, 4))
        ],
      ),
      child: Column(
        children: [
          Image.asset(imagePath, width: 40, height: 40),
          const SizedBox(height: 8),
          Text(label,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 14)),
        ],
      ),
    );
  }
}
