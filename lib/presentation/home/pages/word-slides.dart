import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:provider/provider.dart';
import 'package:spell_champ_frontend/providers/progress_provider.dart';

class WordSlides extends StatefulWidget {
  final int exerciseNumber;
  final List<Map<String, String>> data;
  final int grade;

  const WordSlides({
    super.key,
    required this.exerciseNumber,
    required this.data,
    required this.grade,
  });

  @override
  State<WordSlides> createState() => _WordSlidesState();
}

class _WordSlidesState extends State<WordSlides> with SingleTickerProviderStateMixin {
  late int _currentIndex;
  late FlutterTts _flutterTts;
  late TextEditingController _controller;
  late AnimationController _animationController;
  late Animation<Offset> _offsetAnimation;
  late Animation<double> _opacityAnimation;
  late Animation<double> _shakeAnimation;
  late Animation<double> _hyphenAnimation;
  late FocusNode _focusNode;

  bool _isImageReady = false;
  bool _keyboardVisible = false;

  @override
  void initState() {
    super.initState();
    _currentIndex = 0;
    _flutterTts = FlutterTts();
    _controller = TextEditingController();
    _focusNode = FocusNode();

    _animationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    _offsetAnimation = Tween<Offset>(
      begin: const Offset(1, 0),
      end: Offset.zero,
    ).animate(_animationController);

    _opacityAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: const Interval(0.5, 1.0, curve: Curves.easeInOut),
    ));

    _shakeAnimation = Tween<double>(
      begin: 0.0,
      end: 10.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: const Interval(0.0, 0.2, curve: Curves.elasticInOut),
    ));

    _hyphenAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: const Interval(0.2, 0.5, curve: Curves.easeInOut),
    ));

    _animationController.forward(from: 0.0);
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _controller.dispose();
    _animationController.dispose();
    _flutterTts.stop();
    super.dispose();
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

  void _nextSlide() {
    String currentWord = widget.data[_currentIndex]['word']!.toUpperCase();

    if (_controller.text.toUpperCase() == currentWord) {
      if (_currentIndex < widget.data.length - 1) {
        if (_isImageReady) {
          setState(() {
            _currentIndex++;
            _controller.clear();
            _animationController.forward(from: 0.0);
          });
        }
      } else {
        Provider.of<ProgressProvider>(context, listen: false)
            .markExerciseCompleted("exercise${widget.grade}${widget.exerciseNumber}");
        Navigator.pop(context);
      }
    } else {
      _shakeAnimation = Tween<double>(
        begin: 0.0,
        end: 3.0,
      ).animate(CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.0, 0.2, curve: Curves.elasticInOut),
      ));
      _animationController.forward(from: 0.0);
    }
  }

  void _speakWord() async {
    await _flutterTts.setLanguage("en-GB");
    await _flutterTts.setPitch(0.8);
    await _flutterTts.setSpeechRate(0.5);
    await _flutterTts.speak(widget.data[_currentIndex]['word']!.toUpperCase());
  }

  @override
  Widget build(BuildContext context) {
    String currentWord = widget.data[_currentIndex]['word']!.toUpperCase();
    String userInput = _controller.text.toUpperCase();
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          child: Center(
            child: Column(
              children: [
                Text(
                  'Exercise-${widget.exerciseNumber}',
                  style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                widget.data[_currentIndex]['picture'] != null
                    ? FadeTransition(
                        opacity: _opacityAnimation,
                        child: SlideTransition(
                          position: _offsetAnimation,
                          child: Transform.translate(
                            offset: Offset(_shakeAnimation.value, 0),
                            child: Image.network(
                              widget.data[_currentIndex]['picture']!,
                              width: screenWidth * 0.6,
                              height: screenWidth * 0.6,
                              fit: BoxFit.contain,
                              loadingBuilder: (context, child, loadingProgress) {
                                if (loadingProgress == null) {
                                  _isImageReady = true;
                                  return child;
                                } else {
                                  _isImageReady = false;
                                  return const CircularProgressIndicator();
                                }
                              },
                              errorBuilder: (context, error, stackTrace) {
                                _isImageReady = false;
                                return const Text('Image not available');
                              },
                            ),
                          ),
                        ),
                      )
                    : const SizedBox.shrink(),
                const SizedBox(height: 20),
                FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    currentWord,
                    style: const TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 30),

                /// Hyphen + visible keyboard toggle
                Column(
                  children: [
                    GestureDetector(
                      onTap: _toggleKeyboard,
                      child: Wrap(
                        alignment: WrapAlignment.center,
                        spacing: 6,
                        children: List.generate(currentWord.length, (index) {
                          return Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                index < userInput.length ? userInput[index] : '',
                                style: const TextStyle(
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              const SizedBox(height: 4),
                              ScaleTransition(
                                scale: _hyphenAnimation,
                                child: Container(
                                  width: 30,
                                  height: 6,
                                  color: Colors.black54,
                                ),
                              ),
                            ],
                          );
                        }),
                      ),
                    ),

                    const SizedBox(height: 12),

                    // 🔘 Icon toggle for keyboard
                    IconButton(
                      onPressed: _toggleKeyboard,
                      icon: Icon(
                        _keyboardVisible ? Icons.keyboard_hide : Icons.keyboard,
                        color: Colors.black54,
                      ),
                      iconSize: 28,
                      tooltip: _keyboardVisible ? 'Hide Keyboard' : 'Show Keyboard',
                    ),


                    // 🔤 Hidden Input
                    SizedBox(
                      width: 0,
                      height: 0,
                      child: TextField(
                        focusNode: _focusNode,
                        controller: _controller,
                        maxLength: currentWord.length,
                        keyboardType: TextInputType.text,
                        style: const TextStyle(color: Colors.transparent),
                        cursorColor: Colors.transparent,
                        showCursor: false,
                        decoration: const InputDecoration.collapsed(hintText: ""),
                        onChanged: (value) {
                          setState(() {
                            _controller.value = _controller.value.copyWith(
                              text: value.toUpperCase(),
                              selection: TextSelection.collapsed(offset: value.length),
                            );
                          });
                        },
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 40),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: _speakWord,
                      child: Container(
                        width: 70,
                        height: 70,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: Image.asset('assets/images/volume.png'),
                      ),
                    ),
                    const SizedBox(width: 20),
                    GestureDetector(
                      onTap: _nextSlide,
                      child: Container(
                        width: 70,
                        height: 70,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: Image.asset('assets/images/next.png'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
