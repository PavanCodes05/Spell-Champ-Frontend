import 'package:flutter/material.dart';

class QuizResultsPage extends StatelessWidget {
  final Map<String, String?> quizTrophies;

  QuizResultsPage({required this.quizTrophies});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Text(
                  'Trophies You have gained',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: quizTrophies.length,
                itemBuilder: (context, index) {
                  final quizKey = quizTrophies.keys.elementAt(index);
                  final trophy = quizTrophies[quizKey];

                  return Container(
                    margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                    padding: const EdgeInsets.all(25),
                    decoration: BoxDecoration(
                      color: trophy != null ? Color.fromRGBO(161, 160, 207, 1): Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 10)],
                    ),
                    child: Row(
                      children: [
                        Text(
                          quizKey,
                          style: const TextStyle(fontSize: 24),
                        ),
                        const SizedBox(width: 25),
                        Row(
                          children: [
                            _buildTrophyImage('gold', trophy == 'gold', size: 45),
                            _buildTrophyImage('silver', trophy == 'silver', size: 45),
                            _buildTrophyImage('bronze', trophy == 'bronze', size: 45),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTrophyImage(String type, bool isHighlighted, {required double size}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: isHighlighted ? Colors.white : Colors.transparent,
        ),
        child: Opacity(
          opacity: isHighlighted ? 1.0 : 0.5,
          child: Image.asset(
            'assets/images/${type}_trophy.png',
            width: size,
            height: size,
          ),
        ),
      ),
    );
  }
}

