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
  int _diamondCount = 50;
  int _currentIndex = 1;

    
  final List<Map<String, String>> wordsList = [
    {"word": "Apple", "icon": "assets/images/apple.png"},
    {"word": "Banana", "icon": "assets/images/banana.png"},
    {"word": "Orange", "icon": "assets/images/orange.png"},
    {"word": "Strawberry", "icon": "assets/images/strawberry.png"},
    {"word": "Pineapple", "icon": "assets/images/pineapple.png"},
    {"word": "Jackfruit", "icon": "assets/images/jackfruit.png"},
    {"word": "Watermelon", "icon": "assets/images/watermelon.png"},
  ];

  final List<Widget> pages = [
    Center(child: Text("Home Page")),
    Center(child: Text("Words Page")),
    Center(child: Text("Notifications Page")),
    Center(child: Text("Profile Page")),
  ];

  void increaseDiamond() {
    setState(() {
      _diamondCount++;
    });
  }

  void increaseNotification() {
    setState(() {
    });
  }
   void onTabTapped (int index) {
    setState(() {
      _currentIndex =index ;
    });
   }
  
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
                        child: Image.asset(
                          wordsList[index]['icon']!,
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
       Positioned(
            top: 40,
            right: 20,
            child: Stack(
              alignment: Alignment.topRight,
              children: [
                Container(
                  padding: EdgeInsets.all(2),
                 
                  child: Image.asset(
                    'assets/vectors/diamond.png',
                    width: 41,
                    height: 46,
                  ),
                ),
                Positioned(
                  top: 0,
                  right: 0,
                  child: CircleAvatar(
                    radius: 10,
                    backgroundColor: Colors.black,
                    child: Text(
                      "$_diamondCount",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
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