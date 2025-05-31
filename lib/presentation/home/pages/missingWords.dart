import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MissingWordsPage extends StatefulWidget {
  final Map<String, dynamic> data;
  final ValueChanged<bool> onNext;

  const MissingWordsPage({
    super.key,
    required this.data,
    required this.onNext,
  });

  @override
  _MissingWordsPageState createState() => _MissingWordsPageState();
}

class _MissingWordsPageState extends State<MissingWordsPage>
    with SingleTickerProviderStateMixin {
  final _controller = TextEditingController();
  late FocusNode _focusNode;

  late final AnimationController _animationController;
  late final Animation<Offset> _offsetAnimation;

  late List<String> givenLetters;
  late List<int> blankIndices;
  String userInput = "";
  bool _keyboardVisible = true;

  @override
  void initState() {
    super.initState();

    _focusNode = FocusNode();

    givenLetters = List<String>.from(widget.data['given_letters']);
    blankIndices = [];

    for (int i = 0; i < givenLetters.length; i++) {
      if (givenLetters[i] == "") {
        blankIndices.add(i);
      }
    }

    _controller.clear();
    _controller.addListener(() {
      final raw = _controller.text.toUpperCase();
      if (raw.length <= blankIndices.length) {
        setState(() => userInput = raw);
      } else {
        _controller.text = userInput;
        _controller.selection = TextSelection.collapsed(offset: userInput.length);
      }
    });

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

    if (_keyboardVisible) {
      _focusNode.requestFocus();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _animationController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _handleSubmit() {
    final answer = List.generate(givenLetters.length, (i) {
      return givenLetters[i] != ""
          ? givenLetters[i].toUpperCase()
          : (blankIndices.indexOf(i) < userInput.length
              ? userInput[blankIndices.indexOf(i)]
              : "");
    }).join("");

    final correct = widget.data['correct_answer'].toUpperCase() == answer;
    widget.onNext(correct);
  }

  void _toggleKeyboard() {
    setState(() {
      _keyboardVisible = !_keyboardVisible;
      if (_keyboardVisible) {
        _focusNode.requestFocus();
      } else {
        _focusNode.unfocus();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple[50],
      body: SafeArea(
        child: SlideTransition(
          position: _offsetAnimation,
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 500),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      widget.data['title'],
                      style: const TextStyle(fontSize: 24),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),

                    // Image
                    Image.network(
                      widget.data['image_url'],
                      height: 150,
                      fit: BoxFit.contain,
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return const CircularProgressIndicator();
                      },
                      errorBuilder: (_, __, ___) => const Text("Image error"),
                    ),

                    const SizedBox(height: 20),

                    // Word boxes
                    Wrap(
                      alignment: WrapAlignment.center,
                      spacing: 6,
                      runSpacing: 10,
                      children: List.generate(givenLetters.length, (i) {
                        final isPreFilled = givenLetters[i] != "";
                        final displayChar = isPreFilled
                            ? givenLetters[i].toUpperCase()
                            : (blankIndices.indexOf(i) < userInput.length
                                ? userInput[blankIndices.indexOf(i)]
                                : "");

                        return Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              displayChar,
                              style: const TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Container(
                              width: 30,
                              height: 6,
                              color: Colors.black54,
                            ),
                          ],
                        );
                      }),
                    ),

                    const SizedBox(height: 20),

                    // Keyboard toggle icon
                    IconButton(
                      onPressed: _toggleKeyboard,
                      icon: Icon(
                        _keyboardVisible ? Icons.keyboard_hide : Icons.keyboard,
                        size: 30,
                      ),
                    ),

                    // Hidden input
                    SizedBox(
                      width: 0,
                      height: 0,
                      child: TextField(
                        controller: _controller,
                        focusNode: _focusNode,
                        autofocus: true,
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(RegExp("[a-zA-Z]")),
                          UpperCaseTextFormatter(),
                        ],
                        onChanged: (val) {
                          setState(() {
                            userInput = val.toUpperCase();
                          });
                        },
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Submit Button
                    ElevatedButton(
                      onPressed: _handleSubmit,
                      child: const Text("Next"),
                    ),
                  ],
                ),
              ),
            ),
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
    return TextEditingValue(
      text: newValue.text.toUpperCase(),
      selection: newValue.selection,
    );
  }
}
