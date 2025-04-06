import 'package:flutter/material.dart';
import 'package:spell_champ_frontend/presentation/intro/pages/welcome_screen.dart';

void main() {
  runApp(SpellChampApp());
}

class SpellChampApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: GradeSelectionScreen(),
    );
  }
}

class GradeSelectionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffC7C6E5), // Background color
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start, // Keep greetings left-aligned
              children: [
                // Greeting Text
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: "Hello, ",
                        style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextSpan(
                        text: "", // Add dynamic name if needed
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
                  style: TextStyle(fontSize: 24),
                ),
                Text(
                  '"Say It Right, Say It Proud!"',
                  style: TextStyle(fontSize: 24, fontStyle: FontStyle.italic),
                ),
                SizedBox(height: 16),

                // Center only the "Choose Your Grade" button
                Center(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor:  const Color.fromARGB(255, 136, 133, 207),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    ),
                    onPressed: () {},
                    child: Text(
                      "Choose Your Grade",
                      
                      style: TextStyle(fontSize: 18, color: Colors.black),
                    ),
                  ),
                ),
                SizedBox(height: 16),

                // Grid of Grades
                GridView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                  ),
                  itemCount: 12,
                  itemBuilder: (context, index) {
                    return GradeTile(grade: index + 1);
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Grade Tile with Navigation
class GradeTile extends StatelessWidget {
  final int grade;

  GradeTile({required this.grade});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ExerciseHomePage(grade: grade), // This should be your correct screen
          ),
        );
      },
      child: Image.asset(
        'assets/images/grade_$grade.png', // Dynamic Image
        fit: BoxFit.contain,
      ),
    );
  }
}