import 'package:flutter/material.dart';
import 'package:spell_champ_frontend/common/widgets/button/diamond_badge.dart';
import 'package:spell_champ_frontend/core/configs/theme/app_colors.dart';
import 'package:spell_champ_frontend/core/configs/theme/app_theme.dart';
import 'package:spell_champ_frontend/core/diamond_progress_manager.dart';


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

class _ProgressAchievementsScreenState extends State<ProgressAchievementsScreen> {
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
                  DiamondBadge(diamondCount: manager.diamonds),
                ],
              ),
              const SizedBox(height: 40),
              Column(
                children: [
                  Text(
                    "${(manager.progressPercent * 100).toInt()}%",
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Slider(
                    value: manager.progressPercent,
                    onChanged: (_) {},
                    max: 1,
                    divisions: 100,
                    label: "${(manager.progressPercent * 100).toInt()}%",
                    activeColor: AppColors.primary,
                  ),
                ],
              ),
              const SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildTrophyStat("assets/images/gold_trophy.png", "${manager.goldCount} Gold"),
                  _buildTrophyStat("assets/images/silver_trophy.png", "${manager.silverCount} Silver"),
                  _buildTrophyStat("assets/images/bronze_trophy.png", "${manager.bronzeCount} Bronze"),
                ],
              ),
              const SizedBox(height: 50),
              Wrap(
                alignment: WrapAlignment.center,
                spacing: 16,
                runSpacing: 16,
                children: [
                  _buildStatCard("assets/images/book.png", "${manager.wordsLearned}\nNo of words learnt"),
                  _buildStatCard("assets/images/dimond.png", "${manager.diamonds}\nTotal diamonds"),
                  _buildStatCard("assets/images/exercise.png", "${manager.exercisesCompleted}\nExercises complete"),
                  _buildStatCard("assets/images/quiz_image.png", "${manager.quizzesCompleted}\nCompleted quiz"),
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
              BoxShadow(color: Colors.black26, blurRadius: 4, offset: Offset(1, 2))
            ],
          ),
          child: Text(
            label,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
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
          BoxShadow(color: Colors.black26, blurRadius: 6, offset: Offset(2, 4))
        ],
      ),
      child: Column(
        children: [
          Image.asset(imagePath, width: 40, height: 40),
          const SizedBox(height: 8),
          Text(label, textAlign: TextAlign.center, style: const TextStyle(fontSize: 14)),
        ],
      ),
    );
  }
}
