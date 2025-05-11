import 'package:flutter/material.dart';
import 'missingWords.dart';
import 'pickImage.dart';

class QuizSlidesPage extends StatefulWidget {
  final List<Map<String, dynamic>> quizList;

  const QuizSlidesPage({super.key, required this.quizList});

  @override
  State<QuizSlidesPage> createState() => _QuizSlidesPageState();
}

class _QuizSlidesPageState extends State<QuizSlidesPage> {
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
            return Center(
              child: Text(
                'Correct answers: $_correctAnswers/${widget.quizList.length}',
                style: const TextStyle(fontSize: 32),
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

          return Stack(
            children: [
              child,
              Positioned(
                top: 16,
                left: 16,
                child: CircleAvatar(
                  backgroundColor: Colors.black,
                  child: Text(
                    '${index + 1}',
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ),
              Positioned(
                top: 22,
                left: 22,
                child: Text(
                  '${index + 1}',
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          );
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
      Navigator.pop(context); // Quiz done
    }
  }
}


