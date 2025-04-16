import 'package:flutter/material.dart';


void main() {
  runApp(MaterialApp(
    home: NotificationPage(),
    debugShowCheckedModeBanner: false,
  ));
}
class NotificationPage extends StatefulWidget {
   const NotificationPage ({super.key});
  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  int diamondCount = 50; 
  int? expandedIndex;

  final List<String> notificationTitles = [
    'Notification 1',
    'Notification 2',
    'Notification 3',
    'Notification 4',
    'Notification 5',
    'Notification 6',
    'Notification 7',
    'Notification 8',
    'Notification 9',
    'Notification 10',
  ];

  final List<String> notificationMessages = [
    '''Congratulations Pavan ,

you have successfully completed Grade 1
and now stepping into Grade 2...

You have gained 10+ more diamonds''',
    'Keep going! You’re doing amazing.',
    'Your activity streak is on fire!',
    'New challenge available, check it out!',
    'You unlocked a new badge!',
    'Daily reward claimed!',
    'Reminder: Complete today’s quiz.',
    'Feedback requested for recent lesson.',
    'You’re close to a new milestone!',
    'Your profile was viewed 10 times today.'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFCBC3E3),
       appBar: AppBar(
        backgroundColor: const Color(0xFFCBC3E3),
        elevation: 0,
        title: Padding(
  padding: const EdgeInsets.only(top: 5),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Image.asset('assets/vectors/person.png', width: 50, height: 50),
                const SizedBox(width: 10),
                const Text(
                  'Sheetaal Gandhi',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
            
              ],
            ),
            Stack(
              alignment: Alignment.topRight,
              children: [
                Image.asset('assets/vectors/diamond.png', width: 41, height: 46),
                Positioned(
                  right: 0,
                  top: 0,
                  child: Container(
                    padding: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.black, width: 1),
                      color: Colors.black,
                    ),
                    child: Text(
                      '$diamondCount',
                      style: const TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
       ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: ListView.builder(
          itemCount: notificationTitles.length,
          itemBuilder: (context, index) {
            bool isExpanded = expandedIndex == index;

            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                elevation: 4,
                color: const Color(0xFFD7D3E8),
                child: InkWell(
                  onTap: () {
                    setState(() {
                      expandedIndex = isExpanded ? null : index;
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 12, horizontal: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              notificationTitles[index],
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            Icon(
                              isExpanded
                                  ? Icons.keyboard_arrow_up
                                  : Icons.keyboard_arrow_down,
                            )
                          ],
                        ),
                        if (isExpanded) ...[
                          const SizedBox(height: 10),
                          Text(
                            notificationMessages[index],
                            style: const TextStyle(fontSize: 14),
                          )
                        ]
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
       );
    
  }
}

