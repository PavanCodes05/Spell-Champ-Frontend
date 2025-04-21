import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// missingWords.dart
class MissingWordsPage extends StatefulWidget {
  final Map<String, dynamic> data;
  final ValueChanged<bool> onNext;

  const MissingWordsPage({super.key, required this.data, required this.onNext});

  @override
  _MissingWordsPageState createState() => _MissingWordsPageState();
}

class _MissingWordsPageState extends State<MissingWordsPage> {
  final _formKey = GlobalKey<FormState>();
  final _answerControllers = <TextEditingController>[];

  @override
  void initState() {
    super.initState();
    for (var i = 0; i < widget.data['given_letters'].length; i++) {
      _answerControllers.add(TextEditingController());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple[50],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(widget.data['title'], style: const TextStyle(fontSize: 24)),
            const SizedBox(height: 20),
            Image.network(widget.data['image_url'], height: 150),
            const SizedBox(height: 20),
            Form(
              key: _formKey,
              child: Wrap(
                spacing: 8,
                runSpacing: 0,
                children: List.generate(widget.data['given_letters'].length, (i) {
                  final letter = widget.data['given_letters'][i];
                  return Container(
                    width: 40,
                    height: 40,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: TextFormField(
                      controller: _answerControllers[i],
                      decoration: InputDecoration(
                        hintText: letter != "" ? letter : "_",
                        border: InputBorder.none,
                      ),
                      inputFormatters: [LengthLimitingTextInputFormatter(1)],
                      textCapitalization: TextCapitalization.characters,
                    ),
                  );
                }),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  final answer = List.generate(widget.data['given_letters'].length, (i) {
                    return widget.data['given_letters'][i] != ""
                        ? widget.data['given_letters'][i]
                        : _answerControllers[i].text;
                  }).join("");
                  final correct = widget.data['correct_answer'] == answer;
                  widget.onNext(correct);
                }
              },
              child: const Text("Next"),
            )
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    for (final controller in _answerControllers) {
      controller.dispose();
    }
    super.dispose();
  }
}

