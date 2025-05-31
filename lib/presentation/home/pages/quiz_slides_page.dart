import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'missingWords.dart';
import 'pickImage.dart';
import 'package:provider/provider.dart';
import 'package:spell_champ_frontend/providers/progress_provider.dart';

class QuizSlidesPage extends StatefulWidget {
  final List<Map<String, dynamic>> quizList;
  final int exerciseNumber;

  const QuizSlidesPage({
    super.key,
    required this.quizList,
    required this.exerciseNumber,
  });

  @override
  State<QuizSlidesPage> createState() => _QuizSlidesPageState();
}

class _QuizSlidesPageState extends State<QuizSlidesPage> {
  final progress = ProgressProvider();
  final PageController _pageController = PageController();
  int _correctAnswers = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: widget.quizList.length + 1,
        itemBuilder: (context, index) {
          if (index == widget.quizList.length) {
            Provider.of<ProgressProvider>(context, listen: false).markQuizCompleted(
              _correctAnswers,
              "quiz${progress.grade}${widget.exerciseNumber}",
            );

            if (kDebugMode) {
              debugPrint("Done!");
            }

            return _buildSlideWrapper(
              index: index,
              child: Center(
                child: Text(
                  'Correct answers: $_correctAnswers/${widget.quizList.length}',
                  style: const TextStyle(fontSize: 32),
                ),
              ),
            );
          }

          final quiz = widget.quizList[index];
          final type = quiz['type'];

          late Widget child;

          switch (type) {
            case 'fill-in':
              child = MissingWordsPage(
                data: quiz,
                onNext: (isCorrect) {
                  if (isCorrect) {
                    setState(() {
                      _correctAnswers++;
                    });
                  }
                  _nextPage();
                },
              );
              break;
            case 'image-choice':
              child = PickImagePage(
                data: quiz,
                onNext: (isCorrect) {
                  if (isCorrect) {
                    setState(() {
                      _correctAnswers++;
                    });
                  }
                  _nextPage();
                },
              );
              break;
            default:
              child = const Center(child: Text("Unsupported quiz type"));
          }

          return _buildSlideWrapper(index: index, child: child);
        },
      ),
    );
  }

  void _nextPage() {
    if (_pageController.page!.toInt() < widget.quizList.length) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOutCubic,
      );
    } else {
      Provider.of<ProgressProvider>(context, listen: false).markQuizCompleted(
        _correctAnswers,
        "quiz${progress.grade}${widget.exerciseNumber}",
      );
      if (kDebugMode) {
        debugPrint("Quiz done");
      }
    }
  }

  Widget _buildSlideWrapper({required Widget child, required int index}) {
    return Column(
      children: [
        const SizedBox(height: 24),
        Row(
          children: [
            const SizedBox(width: 16),
            Stack(
              alignment: Alignment.center,
              children: [
                const CircleAvatar(
                  radius: 18,
                  backgroundColor: Colors.black,
                ),
                Text(
                  '${index + 1}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 8),
        Expanded(
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 600),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: child,
              ),
            ),
          ),
        ),
      ],
    );
  }
}