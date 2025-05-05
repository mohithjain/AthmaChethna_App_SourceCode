import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';
// ignore: unused_import
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:async';
import 'services/storage_service.dart';
import 'dart:convert';

// Mapping of emojis to scores (0 to 10)
const Map<String, int> emojiScores = {
  '😄': 10,
  '😎': 9,
  '😊': 8,
  '😋': 7,
  '😷': 6,
  '😲': 5,
  '😴': 4,
  '😔': 3,
  '😟': 2,
  '😢': 1,
  '😠': 0,
};

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _selectedEmoji = '😊';
  Map<String, double> _emojiProgress = {};
  Map<String, int> _emojiClickCount = {};
  double _soulScore = 0.0;
  int _totalClicks = 0;
  int _daysTracked = 0;
  List<Map<String, int>> _weeklyMoodData = [];

  @override
  void initState() {
    super.initState();
    _loadSavedEmojiAndProgress();
    _loadSavedData();
  }

  Future<void> _loadSavedData() async {
    final prefs = await SharedPreferences.getInstance();
    final String todayDate = DateTime.now().toIso8601String().split('T')[0];
    final String? lastSavedDate = prefs.getString('lastSavedDate');
    final String? firstMoodDateStr = prefs.getString('firstMoodDate');

    // Check if it's a new day for emoji click reset
    if (lastSavedDate == null || lastSavedDate != todayDate) {
      _emojiClickCount.clear();
      for (var emoji in emojiScores.keys) {
        _emojiClickCount[emoji] = 0;
      }
      await prefs.setString('lastSavedDate', todayDate);
    } else {
      for (var emoji in emojiScores.keys) {
        _emojiClickCount[emoji] = prefs.getInt('clickCount_$emoji') ?? 0;
      }
    }

    bool shouldReset = false;

    if (firstMoodDateStr != null) {
      DateTime firstMoodDate = DateTime.parse(firstMoodDateStr);
      DateTime today = DateTime.now();
      if (today.difference(firstMoodDate).inDays >= 7) {
        shouldReset = true;
        await prefs.setString('firstMoodDate', todayDate); // start new cycle
      }
    } else {
      await prefs.setString('firstMoodDate', todayDate); // first time user
    }

    setState(() {
      _soulScore = prefs.getDouble('soulScore') ?? 0.0;
      _daysTracked = shouldReset ? 0 : prefs.getInt('daysTracked') ?? 0;
      _totalClicks = shouldReset ? 0 : prefs.getInt('totalClicks') ?? 0;
      _weeklyMoodData =
          shouldReset
              ? []
              : List<Map<String, int>>.from(
                (prefs.getStringList('weeklyMoodData') ?? []).map(
                  (json) => Map<String, int>.from(jsonDecode(json)),
                ),
              );
    });
  }

  // Save SoulScore to SharedPreferences
  Future<void> _saveData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('soulScore', _soulScore);
    await prefs.setInt('daysTracked', _daysTracked);
    await prefs.setInt('totalClicks', _totalClicks);
    _emojiClickCount.forEach((emoji, count) async {
      await prefs.setInt('clickCount_$emoji', count);
    });
    await prefs.setStringList(
      'weeklyMoodData',
      _weeklyMoodData.map((data) => jsonEncode(data)).toList(),
    );
  }

  // Calculate the weekly SoulScore as an average of emoji clicks
  // Calculate SoulScore as a weighted average of emoji scores over the past 7 days
  void _calculateSoulScore() async {
    final prefs = await SharedPreferences.getInstance();

    // Get today's date and stored first mood date
    final today = DateTime.now();
    String todayDate = today.toIso8601String().split('T')[0];
    String? firstMoodDateStr = prefs.getString('firstMoodDate');

    if (firstMoodDateStr != null) {
      DateTime firstMoodDate = DateTime.parse(firstMoodDateStr);
      if (today.difference(firstMoodDate).inDays >= 7) {
        // 7-day period completed: reset mood data
        _weeklyMoodData.clear();
        await prefs.setString('firstMoodDate', todayDate);
        print("Auto-reset weekly mood data after 7 days.");
      }
    } else {
      // If no start date, set it now
      await prefs.setString('firstMoodDate', todayDate);
    }

    // Trim to max 7 days (if user clicks a lot in short time)
    while (_weeklyMoodData.length > 7) {
      _weeklyMoodData.removeAt(0);
    }

    int totalMoodScore = 0;
    int totalMoodClicks = 0;

    for (var dailyData in _weeklyMoodData) {
      for (var emoji in dailyData.keys) {
        int count = dailyData[emoji] ?? 0;
        int score = emojiScores[emoji] ?? 0;
        totalMoodScore += count * score;
        totalMoodClicks += count;
      }
    }

    int newSoulScore =
        totalMoodClicks > 0
            ? ((totalMoodScore / totalMoodClicks) * 10).toInt()
            : 0;

    print("Total Mood Score: $totalMoodScore");
    print("Total Mood Clicks: $totalMoodClicks");
    print("Updated SoulScore: $newSoulScore");

    setState(() {
      _soulScore = newSoulScore.toDouble();
    });

    _saveData();
  }

  // Handle emoji selection and update click count
  void _onEmojiSelected(String emoji) {
    setState(() {
      _selectedEmoji = emoji;
      _emojiClickCount[emoji] = (_emojiClickCount[emoji] ?? 0) + 1;
      _totalClicks++;
    });
    _updateDailyMoodData(emoji);
  }

  void _updateDailyMoodData(String emoji) {
    if (_weeklyMoodData.length >= 7) {
      _weeklyMoodData.removeAt(0);
    }
    if (_weeklyMoodData.isEmpty || _weeklyMoodData.last[emoji] == null) {
      _weeklyMoodData.add({emoji: 1});
    } else {
      _weeklyMoodData.last[emoji] = (_weeklyMoodData.last[emoji] ?? 0) + 1;
    }
    _calculateSoulScore();
  }

  @override
  void dispose() {
    super.dispose();
  }

  // Load saved emoji and progress from SharedPreferences
  Future<void> _loadSavedEmojiAndProgress() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _selectedEmoji = prefs.getString('selectedEmoji') ?? '😊';
      _emojiProgress = {
        '😄': prefs.getDouble('😄') ?? 0.0,
        '😎': prefs.getDouble('😎') ?? 0.0,
        '😊': prefs.getDouble('😊') ?? 0.0,
        '😋': prefs.getDouble('😋') ?? 0.0,
        '😷': prefs.getDouble('😷') ?? 0.0,
        '😲': prefs.getDouble('😲') ?? 0.0,
        '😴': prefs.getDouble('😴') ?? 0.0,
        '😔': prefs.getDouble('😔') ?? 0.0,
        '😟': prefs.getDouble('😟') ?? 0.0,
        '😢': prefs.getDouble('😢') ?? 0.0,
        '😠': prefs.getDouble('😠') ?? 0.0,
      };
    });
  }

  // Save emoji and progress to SharedPreferences
  // ignore: unused_element
  Future<void> _saveEmojiAndProgress() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('selectedEmoji', _selectedEmoji);
    for (var entry in _emojiProgress.entries) {
      await prefs.setDouble(entry.key, entry.value);
    }
  }

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
            SizedBox(height: screenHeight * 0.02),
            Padding(
              padding: EdgeInsets.all(screenWidth * 0.08),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  HowAreYouToday(onEmojiSelected: _onEmojiSelected),
                  SizedBox(height: screenHeight * 0.02),
                  HealthMetrics(
                    selectedEmoji: _selectedEmoji,
                    moodProgress:
                        _emojiClickCount[_selectedEmoji]?.toDouble() ?? 0.0,
                    soulScore: _soulScore / 100,
                    emojiClickCount: _emojiClickCount,
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  ChatbotSection(),
                  SizedBox(height: screenHeight * 0.02),
                  CounselorSection(),
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

// Updated UserHeader to retrieve username from Flutter Secure Storage

class UserHeader extends StatefulWidget {
  @override
  _UserHeaderState createState() => _UserHeaderState();
}

class _UserHeaderState extends State<UserHeader> {
  String? username;
  final StorageService _storageService = StorageService(); // ✅ Instance created

  @override
  void initState() {
    super.initState();
    _loadUsername();
  }

  Future<void> _loadUsername() async {
    String? storedUsername =
        await _storageService.getUsername(); // ✅ Retrieve stored username
    setState(() {
      username = storedUsername ?? "User"; // Default to "User" if not found
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Container(
      decoration: BoxDecoration(
        color: Colors.brown,
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
        padding: EdgeInsets.symmetric(
          horizontal: screenWidth * 0.04,
          vertical: screenWidth * 0.12,
        ),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/userprofile');
                  },
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: screenWidth * 0.08,
                        backgroundColor: Colors.white,
                        child: Text(
                          username != null && username!.isNotEmpty
                              ? username![0].toUpperCase()
                              : "U",
                          style: TextStyle(
                            fontSize: screenWidth * 0.08,
                            fontWeight: FontWeight.bold,
                            color: Colors.brown,
                          ),
                        ),
                      ),
                      SizedBox(width: screenWidth * 0.04),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Hi! Welcome $username',
                            style: TextStyle(
                              fontSize: screenWidth * 0.06,
                              fontWeight: FontWeight.bold,
                              color: const Color.fromARGB(255, 244, 214, 159),
                            ),
                          ),
                          Row(
                            children: [
                              SizedBox(width: screenWidth * 0.01),
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
            Positioned(
              top: 0,
              right: 7,
              child: GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/notification');
                },
                child: Icon(
                  Icons.notifications,
                  color: const Color.fromARGB(255, 244, 214, 159),
                  size: screenWidth * 0.1,
                ),
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
      child: Text(label, style: TextStyle(fontSize: 14, color: Colors.black)),
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
              style: TextStyle(color: const Color(0xFFFCEBCB).withOpacity(0.8)),
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
  final Function(String) onEmojiSelected;

  HowAreYouToday({required this.onEmojiSelected});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: screenWidth * 0.02),
          child: Text(
            'How Are You Today ?',
            style: TextStyle(
              fontSize: screenWidth * 0.07,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(height: screenWidth * 0.04),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              EmojiButton(
                emoji: '😄',
                size: screenWidth * 0.1,
                onTap: () => onEmojiSelected('😄'),
              ),
              EmojiButton(
                emoji: '😎',
                size: screenWidth * 0.1,
                onTap: () => onEmojiSelected('😎'),
              ),
              EmojiButton(
                emoji: '😊',
                size: screenWidth * 0.1,
                onTap: () => onEmojiSelected('😊'),
              ),
              EmojiButton(
                emoji: '😋',
                size: screenWidth * 0.1,
                onTap: () => onEmojiSelected('😋'),
              ),
              EmojiButton(
                emoji: '😷',
                size: screenWidth * 0.1,
                onTap: () => onEmojiSelected('😷'),
              ),
              EmojiButton(
                emoji: '😲',
                size: screenWidth * 0.1,
                onTap: () => onEmojiSelected('😲'),
              ),
              EmojiButton(
                emoji: '😴',
                size: screenWidth * 0.1,
                onTap: () => onEmojiSelected('😴'),
              ),
              EmojiButton(
                emoji: '😔',
                size: screenWidth * 0.1,
                onTap: () => onEmojiSelected('😔'),
              ),
              EmojiButton(
                emoji: '😟',
                size: screenWidth * 0.1,
                onTap: () => onEmojiSelected('😟'),
              ),
              EmojiButton(
                emoji: '😢',
                size: screenWidth * 0.1,
                onTap: () => onEmojiSelected('😢'),
              ),
              EmojiButton(
                emoji: '😠',
                size: screenWidth * 0.1,
                onTap: () => onEmojiSelected('😠'),
              ),
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
  final VoidCallback onTap;

  EmojiButton({required this.emoji, this.size = 32, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4.0),
        child: Text(emoji, style: TextStyle(fontSize: size)),
      ),
    );
  }
}

class HealthMetrics extends StatefulWidget {
  final String selectedEmoji;
  final double moodProgress;
  final double soulScore;
  final Map<String, int> emojiClickCount;

  const HealthMetrics({
    required this.selectedEmoji,
    required this.moodProgress,
    required this.soulScore,
    required this.emojiClickCount,
  });

  @override
  _HealthMetricsState createState() => _HealthMetricsState();
}

class _HealthMetricsState extends State<HealthMetrics> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: screenWidth * 0.02),
          child: Text(
            'Health Metrics',
            style: TextStyle(
              fontSize: screenWidth * 0.07,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(height: screenWidth * 0.02),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              SizedBox(width: screenWidth * 0.02),
              MetricCard(
                title: 'Soul Score',
                value: '${widget.soulScore.toInt()}%',
                color: const Color.fromARGB(255, 158, 112, 95),
                baseColor: Color(0xFFF6D89E),
                progressColor: Colors.brown,
                icon: Icons.favorite,
                progressValue: (widget.soulScore / 100).clamp(0.0, 1.0),
              ),
              SizedBox(width: screenWidth * 0.02),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/mood');
                },
                child: MetricCard(
                  title: '${widget.selectedEmoji} Mood',
                  value: '${widget.emojiClickCount[widget.selectedEmoji] ?? 0}',
                  color: const Color.fromARGB(255, 158, 112, 95),
                  baseColor: Color(0xFFF6D89E),
                  progressColor: Colors.brown,
                  progressValue: widget.moodProgress.clamp(0.0, 1.0),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class MetricCard extends StatelessWidget {
  final String title;
  final String value;
  final Color color;
  final Color? baseColor;
  final Color? progressColor;
  final IconData? icon;
  final Widget? child;
  final double? progressValue;

  MetricCard({
    required this.title,
    required this.value,
    required this.color,
    this.baseColor,
    this.progressColor,
    this.icon,
    this.child,
    this.progressValue,
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
                if (icon != null) Icon(icon, color: Colors.red, size: 28),
                SizedBox(width: 8.0),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
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
            percent: (progressValue ?? 0.0).clamp(0.0, 1.0),
            center: Text(
              value,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20.0,
                color: Colors.white,
              ),
            ),
            circularStrokeCap: CircularStrokeCap.round,
            progressColor: progressColor ?? Colors.white,
            backgroundColor: baseColor ?? Colors.white.withOpacity(0.3),
          ),
        ],
      ),
    );
  }
}

//Chatbot section
class ChatbotSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(
            left: screenWidth * 0.02,
            top: screenWidth * 0.06,
          ),
          child: Text(
            'Chat with AI',
            style: TextStyle(
              fontSize: screenWidth * 0.08,
              fontWeight: FontWeight.bold,
              color: Colors.brown,
            ),
          ),
        ),
        SizedBox(height: screenWidth * 0.04),
        GestureDetector(
          onTap: () {
            Navigator.pushNamed(
              context,
              '/chatbot',
            ); // Navigate to chatbot.dart
          },
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.0), // Rounded corners
              boxShadow: [
                BoxShadow(
                  color: Colors.brown.withOpacity(0.8), // Brown shadow
                  spreadRadius: 2,
                  blurRadius: 4,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(
                18.0,
              ), // Apply same rounded corners
              child: Image.asset('images/bot.png', fit: BoxFit.cover),
            ),
          ),
        ),
      ],
    );
  }
}

class CounselorSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight =
        MediaQuery.of(context).size.height; // Get screenHeight directly

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(
            left: screenWidth * 0.02,
            top: screenWidth * 0.04,
          ),
          child: Text(
            'Meet Our Counselor',
            style: TextStyle(
              fontSize: screenWidth * 0.07,
              fontWeight: FontWeight.bold,
              color: Colors.brown,
            ),
          ),
        ),
        SizedBox(height: screenHeight * 0.02),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Counselor Photo on the left, sized dynamically
            Container(
              width:
                  screenWidth *
                  0.35, // Adjusted width to match picture size proportionally
              height:
                  screenWidth *
                  0.45, // Adjusted height to maintain aspect ratio
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.0),
                image: DecorationImage(
                  image: AssetImage(
                    'images/breakSigma.jpg',
                  ), // Use the counselor image
                  fit: BoxFit.cover,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 1,
                    blurRadius: 2,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
            ),
            SizedBox(width: screenWidth * 0.04),
            // Counselor Details on the right, aligned with the picture height
            Expanded(
              child: Container(
                height:
                    screenWidth *
                    0.45, // Match the height of the picture for parallel alignment
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment:
                      MainAxisAlignment
                          .center, // Center vertically for alignment
                  children: [
                    Text(
                      'Ms.Sneha H ',
                      style: TextStyle(
                        fontSize: screenWidth * 0.06,
                        fontWeight: FontWeight.bold,
                        color: Colors.brown,
                      ),
                    ),
                    SizedBox(height: screenWidth * 0.03),
                    Text(
                      '4th floor , pg-Block , BMS College of Engineering',
                      style: TextStyle(
                        fontSize: screenWidth * 0.04,
                        color: Colors.grey[700],
                      ),
                    ),
                    SizedBox(height: screenWidth * 0.01),
                    Text(
                      '- counseling@bmsce.ac.in',
                      style: TextStyle(
                        fontSize: screenWidth * 0.035,
                        color: Colors.grey[700],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: screenHeight * 0.05),
        // Question and answer in italics with extra padding from left and right
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: screenWidth * 0.038,
          ), // Extra padding from left and right
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Know your Counsellor - ',
                style: TextStyle(
                  fontSize: screenWidth * 0.06,
                  fontWeight: FontWeight.bold,
                  color: Colors.brown,
                  fontStyle: FontStyle.italic, // Italics for the question
                ),
              ),
              SizedBox(height: screenWidth * 0.04),
              Text(
                'Ms . Sneha H is an experienced clinical psychologist with an MSc in Clinical Psychology. She has six years of experience working at BMS and has been practicing for six years in the field of counsling and therapy Her expertise lies in Cognitive Behavioral Therapy (CBT) and Rational Emotive BehaviorTherapy (REBT). Previously, she worked at St. John\'s and has extensive experience in studentcounseling.Her commitment to student well-being and psychological support makes her an invaluable resource, especially in addressing issues like trauma, anxiety, and the long-term impact of harassment.',
                style: TextStyle(
                  fontSize: screenWidth * 0.04,
                  color: Colors.grey[700],
                  fontStyle: FontStyle.italic, // Italics for the answer
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: screenHeight * 0.0),
        // Book Appointment Button
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: screenWidth * 0.1,
            vertical: screenWidth * 0.1,
          ), // Align button with the padded text above
          child: ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(
                context,
                '/counselling',
              ); // Navigate to appointment booking page
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.brown,
              padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: Text(
              'Book Appointment',
              style: TextStyle(
                fontSize: screenWidth * 0.04,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class GuidedTipsSection extends StatelessWidget {
  final List<Map<String, String>> tips = [
    {
      "title": "Benefits Of Meditation",
      "image": "images/meditation.png",
      "route": "/article1",
    },
    {
      "title": "Finding joy in Everyday Moments",
      "image": "images/joy.jpg",
      "route": "/article2",
    },
    {
      "title": "Tips For Boosting Immunity",
      "image": "images/imm.jpg",
      "route": "/article3",
    },
    {
      "title": "Mantra Of Success",
      "image": "images/success.jpg",
      "route": "/article4",
    },
    {
      "title": "Setting And Achieving Personal Goals",
      "image": "images/goals.jpg",
      "route": "/article5",
    },
    {
      "title": "How Exercise Improve the Outlook of Your Life",
      "image": "images/exerc.jpg",
      "route": "/article6",
    },
    {
      "title": "How Helping Others Enrich Your Life",
      "image": "images/helping.jpg",
      "route": "/article7",
    },
    {
      "title": "How Spending Time Outdoors Can Boost Your Mood",
      "image": "images/article8.jpg",
      "route": "/article8",
    },
    {
      "title": "Joy Of Learning New Habbits & Interest",
      "image": "images/art9A.jpg",
      "route": "/article9",
    },
    {
      "title": "Tips for Connecting with Friends and Family",
      "image": "images/art10.jpg",
      "route": "/article10",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Guided Tips',
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: Colors.brown,
          ),
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
                    Navigator.pushNamed(
                      context,
                      tips[index]['route']!,
                    ); // Navigate to the article screen
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
      Navigator.pushNamed(context, '/journal');
    } else if (index == 3) {
      Navigator.pushNamed(context, '/todo');
    } else if (index == 2) {
      Navigator.pushNamed(context, '/blog_review');
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: _currentIndex,
      onTap: _onTap,
      type: BottomNavigationBarType.fixed,
      backgroundColor: Color.fromARGB(255, 227, 210, 175),
      selectedItemColor:
          Colors.brown, // <--- this highlights the selected item in brown
      unselectedItemColor:
          Colors.black54, // <--- this sets unselected items to another color
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home, size: 38, color: Colors.brown),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.menu_book, size: 38, color: Colors.brown),
          label: 'Journal',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.create, size: 38, color: Colors.brown),
          label: 'Blogs & Review',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.schedule, size: 38, color: Colors.brown),
          label: 'Task',
        ),
      ],
    );
  }
}
