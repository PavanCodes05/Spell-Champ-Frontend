import 'package:flutter/material.dart';

class ExercisesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFD0CDE1),
      body: Padding(
        padding: EdgeInsets.all(10.0),
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  // Moved AppBar content here
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Exercises',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Image.asset(
                            'assets/vectors/diamond.png',
                            width: 50,
                            height: 50,
                          ),
                          Positioned(
                            top: -3,
                            right: 5,
                            child: Image.asset(
                              'assets/vectors/diamond_50.png',
                              width: 12,
                              height: 14,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 10),

                  // Exercise List
                  ...List.generate(10, (index) {
                    return Padding(
                      padding: EdgeInsets.symmetric(vertical: 5.0),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Image.asset(
                            'assets/vectors/exercise-box.png',
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                          Image.asset(
                            'assets/fonts/exercise-${index + 1}.png',
                            height: 40,
                          ),
                        ],
                      ),
                    );
                  }),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: 100, // Slightly bigger bar
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/bar.png'),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: ExercisesPage(),
  ));
}