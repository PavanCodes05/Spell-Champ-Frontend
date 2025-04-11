import 'package:flutter/material.dart';

void main() {
  runApp(SpellChampApp());
}

class SpellChampApp extends StatelessWidget {
  const SpellChampApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: GradeSelectionScreen(),
    );
  }
}

class GradeSelectionScreen extends StatelessWidget {
  const GradeSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple[100], // Background color
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: "Hello, ",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(
                      text: "Sheetaal",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 8),
              Text(
                "Welcome to Spell Champ!",
                style: TextStyle(fontSize: 18),
              ),
              Text(
                '"Say It Right, Say It Proud!"',
                style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
              ),
              SizedBox(height: 16),

              
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purple[300],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                ),
                onPressed: () {},
                child: Text(
                  "Choose Your Grade",
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
              SizedBox(height: 16),

              
              Expanded(
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                  ),
                  itemCount: 12,
                  itemBuilder: (context, index) {
                    return GradeTile(grade: index + 1);
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

  const GradeTile({super.key, required this.grade});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/images/grade_$grade.png',
      fit: BoxFit.contain,
    );
  }
}