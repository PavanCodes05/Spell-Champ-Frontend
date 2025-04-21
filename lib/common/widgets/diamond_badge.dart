import 'package:flutter/material.dart';

class DiamondBadge extends StatelessWidget {
  final int diamondCount;
  final double top;
  final double right;

  const DiamondBadge({
    super.key,
    required this.diamondCount,
    this.top = 16,
    this.right = 16,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: top,
      right: right,
      child: Stack(
        alignment: Alignment.center,
        children: [
          const CircleAvatar(
            backgroundColor: Colors.white,
            radius: 24,
            child: Image(
              image: AssetImage("assets/images/diamond.png"),
              width: 60,
              height: 60,
            ),
          ),
          Positioned(
            top: 2,
            right: 0,
            child: Container(
              padding: const EdgeInsets.all(3),
              decoration: const BoxDecoration(
                color: Colors.black,
                shape: BoxShape.circle,
              ),
              child: Text(
                "$diamondCount",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
