// pickImage.dart
import 'package:flutter/material.dart';

class PickImagePage extends StatelessWidget {
  final Map<String, dynamic> data;
  final Function(bool) onNext;

  const PickImagePage({super.key, required this.data, required this.onNext});

  @override
  Widget build(BuildContext context) {
    final options = data['options'] as List<dynamic>;
    final correctAnswer = data['correct_index'] as int;

    return Scaffold(
      backgroundColor: Colors.purple[50],
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const SizedBox(height: 40),
            Text(data['title'], style: const TextStyle(fontSize: 24)),
            const SizedBox(height: 20),
            Text(data['word'], style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            Expanded(
              child: GridView.builder(
                itemCount: options.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      final isCorrect = index == correctAnswer;
                      onNext(isCorrect);
                    },
                    child: Card(
                      elevation: 4,
                      child: Image.network(options[index], fit: BoxFit.cover),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => onNext(false),
              child: const Text('Next'),
            ),
          ],
        ),
      ),
    );
  }
}

