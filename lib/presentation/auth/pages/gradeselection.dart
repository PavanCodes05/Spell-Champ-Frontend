import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:convert';
import 'package:spell_champ_frontend/presentation/home/pages/exercises.dart';
import 'package:logger/logger.dart';

final logger = Logger();

void main() {
  runApp(const SpellChampApp());
}

class SpellChampApp extends StatelessWidget {
  const SpellChampApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const GradeSelectionScreen(userName: "Guest"),
    );
  }
}

class GradeSelectionScreen extends StatefulWidget {
  final String userName;

  const GradeSelectionScreen({super.key, required this.userName});

  @override
  State<GradeSelectionScreen> createState() => _GradeSelectionScreenState();
}

class _GradeSelectionScreenState extends State<GradeSelectionScreen> with TickerProviderStateMixin {
  bool _isAnimating = false;
  int? _selectedGrade;
  late final AnimationController _imageAnimationController;
  late final AnimationController _textAnimationController;
  late final Animation<double> _imageScaleAnimation;
  late final Animation<double> _textScaleAnimation;

  @override
  void initState() {
    super.initState();
    _imageAnimationController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );

    _textAnimationController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    )..repeat(reverse: true);

    _imageScaleAnimation = Tween<double>(begin: 0.5, end: 2.0).animate(
      CurvedAnimation(
        parent: _imageAnimationController,
        curve: Curves.easeInOut,
      ),
    );

    _textScaleAnimation = Tween<double>(begin: 1.0, end: 1.2).animate(
      CurvedAnimation(
        parent: _textAnimationController,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void dispose() {
    _imageAnimationController.dispose();
    _textAnimationController.dispose();
    super.dispose();
  }

  Future<void> _handleGradeSelection(int grade) async {
    setState(() {
      _isAnimating = true;
      _selectedGrade = grade;
    });

    _imageAnimationController.forward();

    await Future.delayed(const Duration(seconds: 2));

    final secureStorage = const FlutterSecureStorage();
    final token = await secureStorage.read(key: "token");

    if (token == null) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Please login first")),
        );
      }
      return;
    }

    try {
      final response = await http.put(
        Uri.parse("https://spell-champ-backend-2.onrender.com/api/v1/grade/update-grade"),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token"
        },
        body: jsonEncode({"grade": grade}),
      );

      if (response.statusCode == 200) {
        await secureStorage.write(key: 'user', value: response.body);

        final exerciseInfo = await http.get(
          Uri.parse("https://spell-champ-backend-2.onrender.com/api/v1/grade/$grade/exercises"),
        );

        if (exerciseInfo.statusCode == 200 || exerciseInfo.statusCode == 201) {
          final exercisesJson = jsonDecode(exerciseInfo.body);
          final exercises = exercisesJson["data"];
          await secureStorage.write(key: "exercises", value: jsonEncode(exercises));

          final storedExercises = await secureStorage.read(key: "exercises");
          final decodedExercises = jsonDecode(storedExercises!) as Map<String, dynamic>;

          final properlyTyped = decodedExercises.map((key, value) {
            return MapEntry(
              key,
              (value as List).map<Map<String, String>>((item) => Map<String, String>.from(item)).toList(),
            );
          });

          if (context.mounted) {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (_) => ExercisesPage(exercises: properlyTyped),
              ),
            );
          }
        }
      } else {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Error: ${response.body}")),
          );
        }
      }
    } catch (e) {
      logger.e("Error during grade update: $e");
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("An error occurred.")),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isAnimating
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ScaleTransition(
                    scale: _textScaleAnimation,
                    child: Text(
                      _selectedGrade == null ? "Select a grade" : "You chose grade $_selectedGrade!",
                      style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(height: 16),
                  ScaleTransition(
                    scale: _imageScaleAnimation,
                    child: _selectedGrade == null
                        ? const SizedBox()
                        : Image.asset(
                            'assets/images/grade_$_selectedGrade.png',
                            fit: BoxFit.contain,
                          ),
                  ),
                ],
              ),
            )
          : SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Hello, ${widget.userName}",
                      style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    const Text("Welcome to Spell Champ!", style: TextStyle(fontSize: 24)),
                    const Text('"Say It Right, Say It Proud!"', style: TextStyle(fontSize: 20, fontStyle: FontStyle.italic)),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.purple[300],
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                      ),
                      onPressed: () {},
                      child: const Text("Choose Your Grade", style: TextStyle(fontSize: 18, color: Colors.white)),
                    ),
                    const SizedBox(height: 16),
                    Expanded(
                      child: GridView.builder(
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 12,
                          mainAxisSpacing: 12,
                        ),
                        itemCount: 12,
                        itemBuilder: (context, index) {
                          return GradeTile(
                            grade: index + 1,
                            onTap: () => _handleGradeSelection(index + 1),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}

class GradeTile extends StatelessWidget {
  final int grade;
  final VoidCallback onTap;

  const GradeTile({super.key, required this.grade, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Image.asset(
        'assets/images/grade_$grade.png',
        fit: BoxFit.contain,
      ),
    );
  }
}
