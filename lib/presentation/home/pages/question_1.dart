import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:spell_champ_frontend/core/configs/theme/app_colors.dart';
import 'package:spell_champ_frontend/core/configs/theme/app_theme.dart';


void main() {
  runApp(
    MaterialApp(
      home: const Question1Screen(),
      theme: AppTheme.lightTheme,
      debugShowCheckedModeBanner: false,
    ),
  );
}

class Question1Screen extends StatefulWidget {
  const Question1Screen({super.key});

  @override
  State<Question1Screen> createState() => _Question1ScreenState();
}

class _Question1ScreenState extends State<Question1Screen> {

  final TextEditingController c1 = TextEditingController();
  final TextEditingController c2 = TextEditingController();
  final TextEditingController c3 = TextEditingController();

  final FocusNode f1 = FocusNode();
  final FocusNode f2 = FocusNode();
  final FocusNode f3 = FocusNode();

  bool navigated = false;

  @override
  void initState() {
    super.initState();

    c1.addListener(checkAnswer);
    c2.addListener(checkAnswer);
    c3.addListener(checkAnswer);
  }

  void checkAnswer() {
    if (navigated) return;
    final guess = '${c1.text}${c2.text}${c3.text}'.toUpperCase();
    if (guess == 'APL') {
      navigated = true;
      Future.delayed(const Duration(milliseconds: 200), () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const NextQuestionScreen()),
        );
      });
    }
  }

  @override
  void dispose() {
    c1.dispose();
    c2.dispose();
    c3.dispose();
    f1.dispose();
    f2.dispose();
    f3.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: 70,
            left: 30,
            child: Container(
              padding: const EdgeInsets.all(15),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
              ),
              child: Container(
                padding: const EdgeInsets.all(9),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.black,
                ),
                child: const Text(
                  '1',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/apple.png',
                  width: 210,
                  height: 210,
                ),
                const SizedBox(height: 40),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InputLetterBox(
                      controller: c1,
                      focusNode: f1,
                      nextFocus: f2,
                      prevFocus: null,
                    ),
                    const LetterBox(letter: 'P'),
                    InputLetterBox(
                      controller: c2,
                      focusNode: f2,
                      nextFocus: f3,
                      prevFocus: f1,
                    ),
                    InputLetterBox(
                      controller: c3,
                      focusNode: f3,
                      prevFocus: f2,
                    ),
                    const LetterBox(letter: 'E'),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class LetterBox extends StatelessWidget {
  final String letter;

  const LetterBox({required this.letter, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5),
      width: 40,
      height: 50,
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(width: 10, color: Colors.black26),
        ),
      ),
      alignment: Alignment.bottomCenter,
      child: Text(
        letter,
        style: const TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class InputLetterBox extends StatefulWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final FocusNode? nextFocus;
  final FocusNode? prevFocus;

  const InputLetterBox({
    required this.controller,
    required this.focusNode,
    this.nextFocus,
    this.prevFocus,
    super.key,
  });

  @override
  State<InputLetterBox> createState() => _InputLetterBoxState();
}

class _InputLetterBoxState extends State<InputLetterBox> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5),
      width: 40,
      height: 50,
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(width: 10, color: Colors.black26),
        ),
      ),
      child: Align(
        alignment: Alignment.bottomCenter,
        child: SizedBox(
          height: 30, 
          child: TextField(
            controller: widget.controller,
            focusNode: widget.focusNode,
            textAlign: TextAlign.center,
            maxLength: 1,
            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              height: 1.1,
            ),
            inputFormatters: [UpperCaseTextFormatter()],
            decoration: const InputDecoration(
              counterText: '',
              fillColor: AppColors.background,
              isCollapsed: true,
              contentPadding: EdgeInsets.only(bottom: 2),
              border: InputBorder.none,
            ),
            onChanged: (val) {
              if (val.isNotEmpty && widget.nextFocus != null) {
                FocusScope.of(context).requestFocus(widget.nextFocus);
              } else if (val.isEmpty && widget.prevFocus != null) {
                FocusScope.of(context).requestFocus(widget.prevFocus);
              }
            },
          ),
        ),
      ),
    );
  }
}



class UpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    return newValue.copyWith(
      text: newValue.text.toUpperCase(),
      selection: newValue.selection,
    );
  }
}

class NextQuestionScreen extends StatelessWidget {
  const NextQuestionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      
    );
  }
}
