// ignore_for_file: deprecated_member_use, duplicate_ignore

import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Color(0xFFF2EDE5),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              color: Theme.of(context).scaffoldBackgroundColor,
              child: UserHeader(),
            ),
            SizedBox(height: screenHeight * 0.02), // Responsive spacing
            Padding(
              padding: EdgeInsets.all(screenWidth * 0.08), // Responsive padding
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  HowAreYouToday(),
                  SizedBox(height: screenHeight * 0.02),
                  HealthMetrics(),
                  SizedBox(height: screenHeight * 0.02),
                  QuizAssessment(),
                  SizedBox(height: screenHeight * 0.02),
                  GuidedTipsSection(),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigation(),
    );
  }
}

class UserHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Container(
      decoration: BoxDecoration(
        color:  Colors.brown,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 2,
            offset: Offset(0, 0),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04, vertical: screenWidth * 0.12),
        child: Stack(
          children: [
            // Main Content (Profile Photo, Welcome Text, Thought of the Day)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/profile');
                  },
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: screenWidth * 0.1, // Responsive avatar size
                        backgroundImage: AssetImage('images/david.jpg'),
                      ),
                      SizedBox(width: screenWidth * 0.04),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Hi! Welcome Ravi',
                            style: TextStyle(fontSize: screenWidth * 0.06, fontWeight: FontWeight.bold , color: const Color.fromARGB(255, 244, 214, 159)),
                          ),
                          Row(
                            children: [
                              StyledChip(label: 'User'),
                              SizedBox(width: screenWidth * 0.04),
                              StyledChip(label: '😊Happy'),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: screenWidth * 0.04),
                ThoughtOfTheDay(),
              ],
            ),

            // Notification Bell (Positioned at the top-right)
            Positioned(
              top: 20, // Align to the top
              right: 7, // Align to the right
              child: GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/notify');
                },
                child: Icon(Icons.notifications, color: const Color.fromARGB(255, 244, 214, 159), size: screenWidth * 0.1),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
class StyledChip extends StatelessWidget {
  final String label;

  StyledChip({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 1.0),
      decoration: BoxDecoration(
        color: const Color(0xFFFCEBCB).withOpacity(0.5),
        borderRadius: BorderRadius.circular(30.0),
      ),
      child: Text(
        label,
        style: TextStyle(fontSize: 14, color: Colors.black),
      ),
    );
  }
} 


class ThoughtOfTheDay extends StatefulWidget {
  @override
  _ThoughtOfTheDayState createState() => _ThoughtOfTheDayState();
}

class _ThoughtOfTheDayState extends State<ThoughtOfTheDay> {
  final TextEditingController _controller = TextEditingController();
  int _charCount = 0;

  @override
  void initState() {
    super.initState();
    _loadSavedThought();
  }

  Future<void> _loadSavedThought() async {
    final prefs = await SharedPreferences.getInstance();
    final savedThought = prefs.getString('thoughtOfTheDay') ?? '';
    setState(() {
      _controller.text = savedThought;
      _charCount = savedThought.length;
    });
  }

  Future<void> _saveThought() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('thoughtOfTheDay', _controller.text);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.transparent,
        border: Border.all(
          color: const Color(0xFFFCEBCB).withOpacity(0.8),
          width: 2,
        ),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFFCEBCB).withOpacity(0.2),
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: StatefulBuilder(
          builder: (context, setState) {
            return TextField(
              controller: _controller,
              onChanged: (text) {
                setState(() {
                  _charCount = text.length;
                });
                _saveThought();
              },
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Enter your thought of the day...',
                hintStyle: TextStyle(
                  color: const Color(0xFFFCEBCB).withOpacity(0.8),
                  fontSize: 16,
                  fontStyle: FontStyle.italic,
                ),
                counterText: '$_charCount/100',
                contentPadding: EdgeInsets.only(top: 10),
              ),
              style: TextStyle(color: const Color(0xFFFCEBCB).withOpacity(0.8),),
              maxLength: 100,
              maxLines: 2,
              textAlignVertical: TextAlignVertical.center,
            );
          },
        ),
      ),
    );
  }
}

class HowAreYouToday extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: screenWidth * 0.02),
          child: Text('How Are You Today ?', style: TextStyle(fontSize: screenWidth * 0.07, fontWeight: FontWeight.bold)),
        ),
        SizedBox(height: screenWidth * 0.04),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              EmojiButton(emoji: '😄', size: screenWidth * 0.1),
              EmojiButton(emoji: '😟', size: screenWidth * 0.1),
              EmojiButton(emoji: '😊', size: screenWidth * 0.1),
              EmojiButton(emoji: '😔', size: screenWidth * 0.1),
              EmojiButton(emoji: '😲', size: screenWidth * 0.1),
              EmojiButton(emoji: '😢', size: screenWidth * 0.1),
              EmojiButton(emoji: '😠', size: screenWidth * 0.1),
              EmojiButton(emoji: '😴', size: screenWidth * 0.1),
              EmojiButton(emoji: '😋', size: screenWidth * 0.1),
              EmojiButton(emoji: '😎', size: screenWidth * 0.1),
              EmojiButton(emoji: '😷', size: screenWidth * 0.1),
            ],
          ),
        ),
      ],
    );
  }
}

class EmojiButton extends StatelessWidget {
  final String emoji;
  final double size;

  EmojiButton({required this.emoji, this.size = 32});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: Text(
        emoji,
        style: TextStyle(fontSize: size),
      ),
    );
  }
}

class HealthMetrics extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: screenWidth * 0.02),
          child: Text('Health Metrics', style: TextStyle(fontSize: screenWidth * 0.07, fontWeight: FontWeight.bold)),
        ),
        SizedBox(height: screenWidth * 0.02),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              SizedBox(width: screenWidth * 0.02),
              MetricCard(
                title: 'Soul Score',
                value: '60%',
                color: const Color.fromARGB(255, 158, 112, 95),
                baseColor: Color(0xFFF6D89E),
                progressColor: Colors.brown,
                icon: Icons.favorite,
              ),
              SizedBox(width: screenWidth * 0.02),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/mood');
                },
                child: MetricCard(
                  title: '😊 Mood',
                  value: '50%',
                  color: const Color.fromARGB(255, 158, 112, 95),
                  baseColor: Color(0xFFF6D89E),
                  progressColor: Colors.brown,
                ),
              ),
              SizedBox(width: screenWidth * 0.0),
            ],
          ),
        ),
      ],
    );
  }
}

// Continue updating other widgets similarly...
class MetricCard extends StatelessWidget {
  final String title;
  final String value;
  final Color color;
  final Color? baseColor;
  final Color? progressColor;
  final IconData? icon;
  final Widget? child;

  MetricCard({
    required this.title,
    required this.value,
    required this.color,
    this.baseColor,
    this.progressColor,
    this.icon,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160,
      padding: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(16.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 2,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (child == null)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (icon != null)
                  Icon(
                    icon,
                    color: Colors.red,
                    size: 28,
                  ),
                SizedBox(width: 8.0),
                Text(
                  title,
                  style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ],
            )
          else
            child!,
          SizedBox(height: 10),
          CircularPercentIndicator(
            radius: 60.0,
            lineWidth: 8.0,
            animation: true,
            percent: double.parse(value.replaceAll('%', '')) / 100.0,
            center: Text(
              value,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0, color: Colors.white),
            ),
            circularStrokeCap: CircularStrokeCap.round,
            progressColor: progressColor ?? Colors.white,
            // ignore: deprecated_member_use
            backgroundColor: baseColor ?? Colors.white.withOpacity(0.3),
          ),
        ],
      ),
    );
  }
}




class QuizAssessment extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Image.asset('images/test.png', width: 100, height: 100), // Add the image here
            SizedBox(width: 0),
            Text('QUIZ ASSESSMENT', style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold , color: Colors.brown)),
          ],
        ),
        SizedBox(height: 20),
        Text(
          'Embark on a transformative journey. Discover yourself through our engaging quiz. Start now to unlock valuable insights and self-awareness.',
          style: TextStyle(fontSize: 16 ,  ),
        ),
        SizedBox(height: 30), // Add space between paragraphs
        Text(
          'How Quiz will help you?', // New text
          style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.brown), // Bold and brown color
        ),
        SizedBox(height: 30),
        GridView.count(
          shrinkWrap: true,
          crossAxisCount: 2,
          crossAxisSpacing: 20.0,
          mainAxisSpacing: 20.0,
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          children: [
            InfoCard(title: 'Self-Awareness', icon: Icons.self_improvement),
            InfoCard(title: 'Separate Myths from Facts', icon: Icons.fact_check),
            InfoCard(title: 'Take charge of your well-being', icon: Icons.health_and_safety),
          ],
        ),
        SizedBox(height: 40),
        Text(
          'Choose Your Test',
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.brown), // Bold and brown color
        ),
        SizedBox(height: 40),
        GridView.count(
          shrinkWrap: true,
          crossAxisCount: 2,
          crossAxisSpacing: 16.0,
          mainAxisSpacing: 20.0,
          padding: EdgeInsets.symmetric(horizontal: 12.0),
          children: [
            TestCard(
              title: 'Anxiety',
              image: AssetImage('images/anxiety.png'),
              onTap: () {
                Navigator.pushNamed(context, '/anxiety_quiz'); // Navigate to AnxietyScreen
              },
            ),
            TestCard(
              title: 'Depression',
              image: AssetImage('images/depression.jpg'),
              onTap: () {
                Navigator.pushNamed(context, '/depression'); // Handle tap event
              },
            ),
            TestCard(
              title: 'Stress',
              image: AssetImage('images/stress.png'),
              onTap: () {
                Navigator.pushNamed(context, '/stress');// Handle tap event
              },
            ),
            TestCard(
              title: 'Eating Habits',
              image: AssetImage('images/eat.png'),
              onTap: () {
                Navigator.pushNamed(context, '/eating');// Handle tap event
              },
            ),
            TestCard(
              title: 'Communication',
              image: AssetImage('images/comm.jpg'),
              onTap: () {
                Navigator.pushNamed(context, '/communication');// Handle tap event
              },
            ),
            TestCard(
              title: 'Sleep Hygiene',
              image: AssetImage('images/sleep.png'),
              onTap: () {
                Navigator.pushNamed(context, '/sleep');// Handle tap event
              },
            ),
          ],
        ),
      ],
    );
  }
}



class InfoCard extends StatelessWidget {
  final String title;
  final IconData icon;

  InfoCard({required this.title, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.0),
        boxShadow: [
          BoxShadow(
            // ignore: duplicate_ignore
            // ignore: deprecated_member_use
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 2,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 50, color: Colors.brown),
          SizedBox(height: 10),
          Text(title, style: TextStyle(fontSize: 16), textAlign: TextAlign.center),
        ],
      ),
    );
  }
}

class TestCard extends StatelessWidget {
  final String title;
  final ImageProvider image;
  final VoidCallback onTap;

  TestCard({required this.title, required this.image, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 160,  // Adjust width to match the image
        height: 500, // Increase height to fit all content
        padding: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: Color(0xFFF2EDE5),
          borderRadius: BorderRadius.circular(16.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 2,
              offset: Offset(0, 1),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(image: image, width: 80, height: 60, fit: BoxFit.contain), // Adjusted image size
            SizedBox(height: 1), // Adjust spacing
            Text(
              title,
              style: TextStyle(fontSize: 14),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 2), // Adjust spacing
            Spacer(),
            ElevatedButton(
              onPressed: onTap,
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Color(0xFFF6D89E)),
              ),
              child: Container(
                alignment: Alignment.center,
                width: double.infinity,
                child: Text(
                  'Take Test ->',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.brown),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}



class GuidedTipsSection extends StatelessWidget {
  final List<Map<String, String>> tips = [
    {"title": "Benefits Of Meditation", "image": "images/meditation.png", "route": "/article1"},
    {"title": "Finding joy in Everyday Moments", "image": "images/joy.jpg", "route": "/article2"},
    {"title": "Tips For Boosting Immunity", "image": "images/imm.jpg", "route": "/article3"},
    {"title": "Mantra Of Success", "image": "images/success.jpg", "route": "/article4"},
    {"title": "Setting And Achieving Personal Goals", "image": "images/goals.jpg", "route": "/article5"},
    {"title": "How Exercise Improve the Outlook of Your Life", "image": "images/exerc.jpg", "route": "/article6"},
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Guided Tips',
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.brown),
        ),
        SizedBox(height: 10),
        SizedBox(
          height: 400,
          child: ListView.builder(
            itemCount: tips.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(4.0),
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, tips[index]['route']!); // Navigate to the article screen
                  },
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    color: Colors.amber.shade100,
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundImage: AssetImage(tips[index]['image']!),
                        radius: 30,
                      ),
                      title: Text(tips[index]['title']!),
                      trailing: IconButton(
                        icon: Icon(Icons.more_vert),
                        onPressed: () {
// Add action here
                        },
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}



class BottomNavigation extends StatefulWidget {
  @override
  _BottomNavigationState createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int _currentIndex = 0;

  void _onTap(int index) {
    setState(() {
      _currentIndex = index;
    });
    if (index == 1) {
      Navigator.pushNamed(context, '/chat');
    }else  if (index == 3) {
      Navigator.pushNamed(context, '/todo');
    }else  if (index == 2) {
      Navigator.pushNamed(context, '/review');
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: _currentIndex,
      onTap: _onTap,
       type: BottomNavigationBarType.fixed,
      backgroundColor: Color.fromARGB(255, 227, 210, 175),
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home, size: 38, color: Colors.brown),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.message_rounded, size: 38, color: Colors.brown),
          label: 'Chat',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.create, size: 38, color: Colors.brown),
          label: 'Reviews',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.schedule, size: 38, color: Colors.brown),
          label: 'Todo List',
        ),
      ],
    );
  }
}
