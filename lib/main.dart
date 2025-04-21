import 'package:flutter/material.dart';
import 'package:spell_champ_frontend/core/configs/theme/app_theme.dart';
import 'package:spell_champ_frontend/presentation/auth/pages/signup%20_or_login.dart';
import 'package:spell_champ_frontend/presentation/home/pages/pickImage.dart';
import 'package:spell_champ_frontend/presentation/home/pages/QuizzesPage.dart';
import 'package:spell_champ_frontend/presentation/home/pages/missingWords.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppTheme.lightTheme,
      debugShowCheckedModeBanner: false,
      home: QuizzesPage(data: {
        "1": [
            {
                "given_letters": [
                    "A",
                    "",
                    "P",
                    "L",
                    "E"
                ],
                "title": "Complete the Word",
                "correct_answer": "APPLE",
                "type": "fill-in",
                "image_url": "https://res.cloudinary.com/dui1qqiue/image/upload/f_auto,q_auto/Apple"
            },
            {
                "type": "fill-in",
                "correct_answer": "BANANA",
                "given_letters": [
                    "",
                    "A",
                    "N",
                    "A",
                    "N",
                    "A"
                ],
                "image_url": "https://res.cloudinary.com/dui1qqiue/image/upload/f_auto,q_auto/Apple",
                "title": "Complete the Word"
            },
            {
                "type": "fill-in",
                "correct_answer": "ELEPHANT",
                "image_url": "https://res.cloudinary.com/dui1qqiue/image/upload/f_auto,q_auto/Apple",
                "title": "Complete the Word",
                "given_letters": [
                    "E",
                    "L",
                    "",
                    "P",
                    "H",
                    "A",
                    "N",
                    "T"
                ]
            },
            {
                "given_letters": [
                    "P",
                    "",
                    "N",
                    "C",
                    "I",
                    "L"
                ],
                "type": "fill-in",
                "image_url": "https://res.cloudinary.com/dui1qqiue/image/upload/f_auto,q_auto/Apple",
                "title": "Complete the Word",
                "correct_answer": "PENCIL"
            },
            {
                "title": "Complete the Word",
                "correct_answer": "TIGER",
                "image_url": "https://res.cloudinary.com/dui1qqiue/image/upload/f_auto,q_auto/Apple",
                "type": "fill-in",
                "given_letters": [
                    "T",
                    "I",
                    "G",
                    "",
                    "R"
                ]
            },
            {
                "type": "image-choice",
                "options": [
                    "https://res.cloudinary.com/dui1qqiue/image/upload/f_auto,q_auto/Apple",
                    "https://res.cloudinary.com/dui1qqiue/image/upload/f_auto,q_auto/Apple",
                    "https://res.cloudinary.com/dui1qqiue/image/upload/f_auto,q_auto/Apple",
                    "https://res.cloudinary.com/dui1qqiue/image/upload/f_auto,q_auto/Apple"
                ],
                "title": "Pick the Right Image",
                "correct_index": 0,
                "word": "Car"
            },
            {
                "options": [
                    "https://res.cloudinary.com/dui1qqiue/image/upload/f_auto,q_auto/Apple",
                    "https://res.cloudinary.com/dui1qqiue/image/upload/f_auto,q_auto/Apple",                    "https://res.cloudinary.com/dui1qqiue/image/upload/f_auto,q_auto/Apple",                  "https://res.cloudinary.com/dui1qqiue/image/upload/f_auto,q_auto/Apple"
                  ],
                "title": "Pick the Right Image",
                "type": "image-choice",
                "word": "Dog",
                "correct_index": 2
            },
            {
                "type": "image-choice",
                "title": "Pick the Right Image",
                "word": "Book",
                "options": [
                    "https://res.cloudinary.com/dui1qqiue/image/upload/f_auto,q_auto/Apple",                "https://res.cloudinary.com/dui1qqiue/image/upload/f_auto,q_auto/Apple",
                    "https://res.cloudinary.com/dui1qqiue/image/upload/f_auto,q_auto/Apple",
                    "https://res.cloudinary.com/dui1qqiue/image/upload/f_auto,q_auto/Apple"
                ],
                "correct_index": 2
            },
            {
                "correct_index": 1,
                "word": "Tree",
                "title": "Pick the Right Image",
                "type": "image-choice",
                "options": [
                    "https://res.cloudinary.com/dui1qqiue/image/upload/f_auto,q_auto/Apple",
                    "https://res.cloudinary.com/dui1qqiue/image/upload/f_auto,q_auto/Apple",
                    "https://res.cloudinary.com/dui1qqiue/image/upload/f_auto,q_auto/Apple",
                    "https://res.cloudinary.com/dui1qqiue/image/upload/f_auto,q_auto/Apple"
                ]
            },
            {
                "options": [
                    "https://res.cloudinary.com/dui1qqiue/image/upload/f_auto,q_auto/Apple",                   "https://res.cloudinary.com/dui1qqiue/image/upload/f_auto,q_auto/Apple",
                    "https://res.cloudinary.com/dui1qqiue/image/upload/f_auto,q_auto/Apple",
                    "https://res.cloudinary.com/dui1qqiue/image/upload/f_auto,q_auto/Apple",
                    ],
                "type": "image-choice",
                "correct_index": 1,
                "word": "Shoe",
                "title": "Pick the Right Image"
            }
        ],
         "2": [
            {
                "given_letters": [
                    "A",
                    "",
                    "P",
                    "L",
                    "E"
                ],
                "title": "Complete the Word",
                "correct_answer": "APPLE",
                "type": "fill-in",
                "image_url": "https://example.com/apple.png"
            },
            {
                "type": "fill-in",
                "correct_answer": "BANANA",
                "given_letters": [
                    "",
                    "A",
                    "N",
                    "A",
                    "N",
                    "A"
                ],
                "image_url": "https://example.com/banana.png",
                "title": "Complete the Word"
            },
            {
                "type": "fill-in",
                "correct_answer": "ELEPHANT",
                "image_url": "https://example.com/elephant.png",
                "title": "Complete the Word",
                "given_letters": [
                    "E",
                    "L",
                    "",
                    "P",
                    "H",
                    "A",
                    "N",
                    "T"
                ]
            },
            {
                "given_letters": [
                    "P",
                    "",
                    "N",
                    "C",
                    "I",
                    "L"
                ],
                "type": "fill-in",
                "image_url": "https://example.com/pencil.png",
                "title": "Complete the Word",
                "correct_answer": "PENCIL"
            },
            {
                "title": "Complete the Word",
                "correct_answer": "TIGER",
                "image_url": "https://example.com/tiger.png",
                "type": "fill-in",
                "given_letters": [
                    "T",
                    "I",
                    "G",
                    "",
                    "R"
                ]
            },
            {
                "type": "image-choice",
                "options": [
                    "https://example.com/car.png",
                    "https://example.com/bike.png",
                    "https://example.com/bus.png",
                    "https://example.com/train.png"
                ],
                "title": "Pick the Right Image",
                "correct_index": 0,
                "word": "Car"
            },
            {
                "options": [
                    "https://example.com/cat.png",
                    "https://example.com/fox.png",
                    "https://example.com/dog.png",
                    "https://example.com/lion.png"
                ],
                "title": "Pick the Right Image",
                "type": "image-choice",
                "word": "Dog",
                "correct_index": 2
            },
            {
                "type": "image-choice",
                "title": "Pick the Right Image",
                "word": "Book",
                "options": [
                    "https://example.com/pen.png",
                    "https://example.com/notebook.png",
                    "https://example.com/book.png",
                    "https://example.com/laptop.png"
                ],
                "correct_index": 2
            },
            {
                "correct_index": 1,
                "word": "Tree",
                "title": "Pick the Right Image",
                "type": "image-choice",
                "options": [
                    "https://example.com/flower.png",
                    "https://example.com/tree.png",
                    "https://example.com/grass.png",
                    "https://example.com/shrub.png"
                ]
            },
            {
                "options": [
                    "https://example.com/hat.png",
                    "https://example.com/shoe.png",
                    "https://example.com/socks.png",
                    "https://example.com/belt.png"
                ],
                "type": "image-choice",
                "correct_index": 1,
                "word": "Shoe",
                "title": "Pick the Right Image"
            }
        ]

      }),
    );
  }
}

