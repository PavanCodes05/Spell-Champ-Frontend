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

class _MissingWordsPageState extends State<MissingWordsPage> with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final _answerControllers = <TextEditingController>[];
  late final AnimationController _animationController;
  late final Animation<Offset> _offsetAnimation;

  @override
  void initState() {
    super.initState();
    for (var i = 0; i < widget.data['given_letters'].length; i++) {
      _answerControllers.add(TextEditingController());
    }
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _offsetAnimation = Tween<Offset>(
      begin: const Offset(0.0, 1.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
    _animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple[50],
      body: Center(
        child: SlideTransition(
          position: _offsetAnimation,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(widget.data['title'], style: const TextStyle(fontSize: 24)),
              const SizedBox(height: 20),
              Image.network(
                widget.data['image_url'],
                height: 150,
                fit: BoxFit.cover,
                loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Center(
                    child: CircularProgressIndicator(
                      value: loadingProgress.expectedTotalBytes != null
                          ? loadingProgress.cumulativeBytesLoaded / (loadingProgress.expectedTotalBytes ?? 1)
                          : null,
                    ),
                  );
                },
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: Form(
                  key: _formKey,
                  child: Wrap(
                    spacing: 8,
                    runSpacing: 0,
                    alignment: WrapAlignment.center,
                    runAlignment: WrapAlignment.center,
                    children: List.generate(widget.data['given_letters'].length, (i) {
                      final letter = widget.data['given_letters'][i];
                      return Container(
                        constraints: const BoxConstraints(minWidth: 48, maxWidth: 48),
                        height: 48,
                        decoration: BoxDecoration(
                          border: Border.all(width: 2, color: Colors.black),
                        ),
                        child: Center(
                          child: letter != ""
                              ? Text(
                                  letter.toUpperCase(),
                                  style: const TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )
                              : TextFormField(
                                  controller: _answerControllers[i],
                                  decoration: const InputDecoration(
                                    border: InputBorder.none,
                                  ),
                                  style: const TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textAlign: TextAlign.center,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.allow(RegExp("[a-zA-Z]")),
                                    UpperCaseTextFormatter(),
                                  ],
                                ),
                        ),
                      );
                    }),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    final answer = List.generate(widget.data['given_letters'].length, (i) {
                      return widget.data['given_letters'][i] != ""
                          ? widget.data['given_letters'][i].toUpperCase()
                          : _answerControllers[i].text.toUpperCase();
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
      ),
    );
  }

  @override
  void dispose() {
    for (final controller in _answerControllers) {
      controller.dispose();
    }
    _animationController.dispose();
    super.dispose();
  }
}

class UpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    return TextEditingValue(
      text: newValue.text.toUpperCase(),
      selection: newValue.selection,
    );
  }
}

