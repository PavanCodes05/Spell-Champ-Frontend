

import 'package:spell_champ_frontend/core/diamond_logic.dart';

class DiamondProgressManager {
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

  void loadSampleData() {
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
  }
}
