import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Wordspage(),
    debugShowCheckedModeBanner: false,
  ));
}


    
class Wordspage extends StatefulWidget {
  const Wordspage ({super.key});
  @override
 
  _WordspageState createState() => _WordspageState();
}

class _WordspageState extends State<Wordspage> {

  final List<Map<String, String>> wordsList = [
        { "word": "Apple", "picture": "https://res.cloudinary.com/dui1qqiue/image/upload/f_auto,q_auto/Apple" },
        { "word": "Banana", "picture": "https://res.cloudinary.com/dui1qqiue/image/upload/f_auto,q_auto/ni0r3okslghmpmotsjh4" },
        { "word": "Cat", "picture": "https://res.cloudinary.com/dui1qqiue/image/upload/f_auto,q_auto/ru8svekcaclh4j9dbjpd" },
        { "word": "Dog", "picture": "https://res.cloudinary.com/dui1qqiue/image/upload/f_auto,q_auto/enxlxjpyukkgmf56p6dw" },
        { "word": "Elephant", "picture": "https://res.cloudinary.com/dui1qqiue/image/upload/f_auto,q_auto/l252jor08wom4icgyfiu" },
        { "word": "Fish", "picture": "https://res.cloudinary.com/dui1qqiue/image/upload/f_auto,q_auto/nuufegazvolob7o5jhov" },
        { "word": "Grapes", "picture": "https://res.cloudinary.com/dui1qqiue/image/upload/f_auto,q_auto/oxz6veggr0m4qzxkl4d9" },
        { "word": "House", "picture": "https://res.cloudinary.com/dui1qqiue/image/upload/f_auto,q_auto/syi3qjy03j6sujatzeok" },
        { "word": "Ice", "picture": "https://res.cloudinary.com/dui1qqiue/image/upload/f_auto,q_auto/szqeg4una1xc0cjzu6uy" },
        { "word": "Jug", "picture": "https://res.cloudinary.com/dui1qqiue/image/upload/f_auto,q_auto/l3vigddv7oaomwmzov4c" }
  ];

  final List<Widget> pages = [
    Center(child: Text("Home Page")),
    Center(child: Text("Words Page")),
    Center(child: Text("Notifications Page")),
    Center(child: Text("Profile Page")),
  ];

  
  
 @override
  Widget build(BuildContext context) {
    return Scaffold(
    backgroundColor: Color(0xFFD5D4F3), 
      // Light purple background
    body: Stack(
      children:[Padding(
        padding: const EdgeInsets.only(top: 50.0, left: 20, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
             SizedBox(height:40 ),  //space for diamond
          Text(
              "Words you have\ncompleted learning",
              style: TextStyle(fontSize:24,fontWeight: FontWeight.bold,
            ),
             ),
             SizedBox(height: 16),
            Expanded(   //space btw title and list
             child: ListView.builder(
                itemCount: wordsList.length,
                itemBuilder: (context, index) {
                  final word = wordsList[index]['word']!;
                  return Container(
                    margin: EdgeInsets.symmetric(vertical: 6),
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [BoxShadow(color: Colors.white, blurRadius: 4)],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(padding: const EdgeInsets.only(left: 8.0),
                        child: Text(
                           word,
              style: TextStyle(fontSize: 18),
                        ),
                        ),
                        Padding(padding:const EdgeInsets.only(left: 8.0),
                        child: Image.network(
                          wordsList[index]['picture']!,
                       height: 40,),
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
      ],
    ),
     );
  }
}

