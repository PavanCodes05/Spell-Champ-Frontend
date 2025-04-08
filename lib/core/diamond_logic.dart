class DiamondUtils {
  static int calculateFromWords(int wordCount) {
    return wordCount ~/ 5;
  }

  static int calculateFromExercise() {
    return 5;
  }

  static int calculateFromQuiz() {
    return 10;
  }
}
