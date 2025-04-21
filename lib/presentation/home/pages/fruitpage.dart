import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Fruit Picker',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const BananaPage(),
    );
  }
}

class BananaPage extends StatefulWidget {
  const BananaPage({super.key});

  @override
  State<BananaPage> createState() => _BananaPageState();
}

class _BananaPageState extends State<BananaPage> {
  int diamondCount = 50;
  String currentFruit = 'BANANA';
  bool showFlyingBananas = false;
  Offset tappedPosition = Offset.zero;

  List<String> options = [
    'strawberry',
    'orange',
    'apple',
    'banana',
  ];

  void onFruitTap(String fruit, TapDownDetails details) {
    if (fruit.toLowerCase() == currentFruit.toLowerCase()) {
      RenderBox box = context.findRenderObject() as RenderBox;
      final position = box.globalToLocal(details.globalPosition);

      setState(() {
        tappedPosition = position;
        showFlyingBananas = true;
      });

      Future.delayed(const Duration(milliseconds: 800), () {
        setState(() {
          showFlyingBananas = false;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFD2CEF2),
      body: Stack(
        children: [
          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 50), // Top space
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                                         // Left side: number + fruit name
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 24,
                            backgroundColor: Colors.white,
                            backgroundImage: AssetImage('assets/images/number2.png'),
                          ),
                          const SizedBox(width: 12),
                          Text(
                            currentFruit,
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Georgia',
                            ),
                          ),
                        ],
                      ),
                     
                      Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Image.asset(
                            'assets/images/diamond.png',
                            width: 40,
                            height: 40,
                          ),
                          Positioned(
                            top: -5,
                            right: -5,
                            child: Container(
                              padding: const EdgeInsets.all(4),
                              decoration: const BoxDecoration(
                                color: Colors.black,
                                shape: BoxShape.circle,
                              ),
                              child: Text(
                                '$diamondCount',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                Expanded(
                  child: Center(
                    child: GridView.count(
                      shrinkWrap: true,
                      crossAxisCount: 2,
                      padding: const EdgeInsets.all(20),
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 20,
                      children: options.map((fruit) {
                        return GestureDetector(
                          onTapDown: (details) => onFruitTap(fruit, details),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.black26,
                                  blurRadius: 6,
                                  offset: Offset(0, 4),
                                ),
                              ],
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Image.asset('assets/images/$fruit.png'),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ],
            ),
          ),
          if (showFlyingBananas)
            FlyingBanana(origin: tappedPosition),
        ],
      ),
    );
  }
}

class FlyingBanana extends StatefulWidget {
  final Offset origin;

  const FlyingBanana({super.key, required this.origin});

  @override
  State<FlyingBanana> createState() => _FlyingBananaState();
}

class _FlyingBananaState extends State<FlyingBanana>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late List<Offset> directions;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );

    final rand = Random();
    directions = List.generate(10, (_) {
      final angle = rand.nextDouble() * 2 * pi;
      final distance = 50 + rand.nextDouble() * 50;
      return Offset(cos(angle), sin(angle)) * distance;
    });

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: List.generate(directions.length, (index) {
        return AnimatedBuilder(
          animation: _controller,
          builder: (_, __) {
            final dx = widget.origin.dx + directions[index].dx * _controller.value;
            final dy = widget.origin.dy + directions[index].dy * _controller.value;
            return Positioned(
              left: dx,
              top: dy,
              child: Opacity(
                opacity: 1 - _controller.value,
                child: Image.asset(
                  'assets/images/banana.png',
                  width: 50,
                  height: 50,
                ),
              ),
            );
          },
        );
      }),
    );
  }
}

