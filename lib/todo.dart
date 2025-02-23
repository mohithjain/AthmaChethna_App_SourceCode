import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'doodle.dart'; // Import the DoodlePage

void main() {
  // Ensure the app is initialized
  WidgetsFlutterBinding.ensureInitialized();

  // Set the preferred orientations and system UI overlay style
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'To-Do Layout',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Color(0xFFF2EDE5),
      ),
      home: ToDoScreen(),
      debugShowCheckedModeBanner: false, // Remove the debug banner
    );
  }
}

class ToDoScreen extends StatefulWidget {
  @override
  _ToDoScreenState createState() => _ToDoScreenState();
}

class _ToDoScreenState extends State<ToDoScreen> {
  // Store user input for each section
  List<List<String>> textFields = List.generate(8, (_) => List.filled(5, ''));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Color(0xFF6D5B4B)),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Color(0xFFF2EDE5),
        elevation: 0,
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 0),
              Center(
                child: Text(
                  "TODAY'S GOALS",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF6D5B4B),
                  ),
                ),
              ),
              SizedBox(height: 25),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        buildSection('HIGH PRIORITY', 4, sectionIndex: 0),
                        buildSection('TO-DO LIST', 4, sectionIndex: 1),
                        buildSection('SHOPPING', 4, sectionIndex: 2),
                        buildSection('APPOINTMENTS', 4, sectionIndex: 3),
                        buildSection('WORKOUT', 4, sectionIndex: 4),
                        buildChecklistSection(),
                      ],
                    ),
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    flex: 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: Align(
                            alignment: Alignment.topRight,
                            child: TextField(
                              decoration: InputDecoration(
                                labelText: 'Date:',
                                border: OutlineInputBorder(),
                                contentPadding: EdgeInsets.symmetric(horizontal: 6.0),
                              ),
                              textAlign: TextAlign.right,
                            ),
                          ),
                        ),
                        buildSection('NOTES', 4, height: 180, sectionIndex: 5),
                        buildWaterSection('WATER'),
                        buildSection('MEALS', 3, height: 140, sectionIndex: 6),
                        buildSection('REMEMBER', 5, sectionIndex: 7),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => DoodlePage()),
                            );
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: Color(0xFF6D5B4B)),
                            ),
                            height: 450,
                            child: Center(
                              child: Text(
                                'Doodle Here',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF6D5B4B),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 0),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildSection(String title, int itemCount, {double height = 150, required int sectionIndex}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color(0xFF6D5B4B),
          ),
        ),
        SizedBox(height: 4),
        Container(
          height: height,
          decoration: BoxDecoration(
            color: Color(0xFFF6D89E),
            border: Border.all(color: Color(0xFF6D5B4B)),
          ),
          child: CustomPaint(
            painter: NotebookPainter(itemCount: itemCount),
            child: ListView.builder(
              padding: EdgeInsets.all(0),
              itemCount: itemCount,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: TextField(
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(vertical: 12.0),
                    ),
                    style: TextStyle(height: 1.0),
                    onChanged: (value) {
                      setState(() {
                        textFields[sectionIndex][index] = value;
                      });
                    },
                    controller: TextEditingController(text: textFields[sectionIndex][index]),
                  ),
                );
              },
            ),
          ),
        ),
        SizedBox(height: 8),
      ],
    );
  }

  Widget buildWaterSection(String title) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color(0xFF6D5B4B),
          ),
        ),
        SizedBox(height: 4),
        Container(
          height: 80,
          decoration: BoxDecoration(
            color: Color(0xFFF6D89E),
            border: Border.all(color: Color(0xFF6D5B4B)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(4, (index) => _buildWaterCircle()),
          ),
        ),
        SizedBox(height: 8),
      ],
    );
  }

  Widget _buildWaterCircle() {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.brown,
      ),
    );
  }

  Widget buildChecklistSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'CHECKLIST',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color(0xFF6D5B4B),
          ),
        ),
        SizedBox(height: 4),
        Container(
          decoration: BoxDecoration(
            color: Color(0xFFF6D89E),
            border: Border.all(color: Color(0xFF6D5B4B)),
          ),
          child: Column(
            children: [
              buildChecklistItem('GET UP EARLY'),
              buildChecklistItem('MAKE A BED'),
              buildChecklistItem('STAY HYDRATED'),
              buildChecklistItem('WORKOUT'),
              buildChecklistItem('THINK POSITIVE'),
              buildChecklistItem('BRAINSTORMING'),
            ],
          ),
        ),
        SizedBox(height: 8),
      ],
    );
  }

  Widget buildChecklistItem(String text) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Icon(Icons.check_box_outline_blank),
          SizedBox(width: 8.0),
          Text(text),
        ],
      ),
    );
  }
}

class NotebookPainter extends CustomPainter {
  final int itemCount;

  NotebookPainter({required this.itemCount});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.grey
      ..strokeWidth = 1.0;

    double lineHeight = size.height / itemCount;
    for (int i = 0; i < itemCount; i++) {
      double y = (i + 1) * lineHeight;
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}