import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:convert';

void main() {
  runApp(const SpellChampApp());
}

class SpellChampApp extends StatelessWidget {
  const SpellChampApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: GradeSelectionScreen(userName: "Guest"),
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
  late final AnimationController _textAnimationController;
  // ignore: unused_field
  late final Animation<double> _textScaleAnimation;

  @override
  void initState() {
    super.initState();
    _textAnimationController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    )..repeat(reverse: true);
    _textScaleAnimation = Tween<double>(begin: 1.0, end: 1.2).animate(CurvedAnimation(
      parent: _textAnimationController,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _textAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isAnimating
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    _selectedGrade == null ? "Select a grade" : "You chose grade $_selectedGrade!",
                    style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  ScaleTransition(
                    scale: Tween<double>(begin: 0.5, end: 2.0).animate(
                      CurvedAnimation(
                        parent: AnimationController(
                          duration: const Duration(milliseconds: 2000),
                          vsync: this,
                        )..forward(),
                        curve: Curves.easeInOut,
                      ),
                    ),
                    child: _selectedGrade == null
                        ? const Text("Select a grade")
                        : Image.asset(
                            'assets/images/grade_$_selectedGrade.png', // Dynamic Image
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
                          return GradeTile(grade: index + 1, onTap: () async {
                            setState(() {
                              _isAnimating = true;
                              _selectedGrade = index + 1;
                            });

                            await Future.delayed(const Duration(milliseconds: 2000));

                            setState(() {
                              _isAnimating = false;
                            });

                            final storage = const FlutterSecureStorage();
                            final token = await storage.read(key: "token");

                            if (token == null) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text("Please login first")),
                              );
                              return;
                            }

                            final response = await http.put(
                              Uri.parse("https://spell-champ-backend-2.onrender.com/api/v1/grade/update-grade"),
                              headers: {
                                "Content-Type": "application/json",
                                "Authorization": "Bearer $token"
                              },
                              body: jsonEncode({
                                "grade": index + 1,
                              }),
                            );

                            if (response.statusCode == 200) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text("Grade updated successfully")),
                              );
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text("Error: ${response.body}")),
                              );
                            }
                          });
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
        'assets/images/grade_$grade.png', // Dynamic Image
        fit: BoxFit.contain,
      ),
    );
  }
}

