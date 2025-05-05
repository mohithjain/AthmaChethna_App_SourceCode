import 'package:flutter/material.dart';
import 'doodle.dart';
import 'highpriority.dart';
import 'notes.dart';
import 'todolist.dart';
import 'remember.dart';
import 'affirmation.dart';
import 'appointments.dart';

class ToDoScreen extends StatefulWidget {
  @override
  _ToDoScreenState createState() => _ToDoScreenState();
}

class _ToDoScreenState extends State<ToDoScreen> {
  final List<String> titles = [
    "High Priority",
    "Notes",
    "ToDo List",
    "Appointments",
    "Affirmations",
    "Remember"
  ];

  List<bool> glassStates = List.generate(7, (index) => false);
  List<bool> checklistStates = List.generate(5, (index) => false);
  List<String> checklistItems = [
    "Get up early",
    "Meditate",
    "Stay hydrated",
    "Think positive",
    "Brainstorming"
  ];

  @override
 Widget build(BuildContext context) {
  return Scaffold(
    appBar: PreferredSize(
      preferredSize: Size.fromHeight(40), // Reduce height
      child: AppBar(
        backgroundColor: Color(0xFFF2DCBB),
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.brown),
          onPressed: () {
            debugPrint("Back button clicked!");
            Navigator.pop(context);
          },
        ),
        title: Text(
          "ToDo List",
          style: TextStyle(
            fontSize: 20, // Reduce font size
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.italic,
            color: Colors.brown,
          ),
        ),
        centerTitle: true,
      ),
    ),

      body: Stack(
        children: [
          // Background Image
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('images/todo.jpg'),
                fit: BoxFit.fill,
              ),
            ),
          ),

          // Top Bar with Arrow and Title
          

          // Sticky Notes Grid
          Positioned.fill(
            top: 20,
            bottom: 160,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 35),
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1.2,
                ),
                itemCount: titles.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      // Navigate to different pages based on the grid item
                      switch (index) {
                        case 0:
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => HighPriorityPage()),
                          );
                          break;
                        case 1:
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => NotesPage()),
                          );
                          break;
                        case 2:
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => TodoPage()),
                          );
                          break;
                        case 3:
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) =>AppointmentsPage()),
                          );
                          break;
                        
                        case 4:
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => AffirmationsPage()),
                          );
                          break;
                        case 5:
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => RememberPage()),
                          );
                          break;
                      }
                    },
                    child: Container(
                      margin: EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('images/sticker2.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          titles[index],
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16,
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.bold,
                            color: Colors.brown,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),

          // Water Intake Tracker
          Positioned(
            bottom: 320,
            left: 40,
            right: 60,
            child: Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.transparent,
                border: Border.all(color: Colors.brown, width: 2),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: List.generate(7, (index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        glassStates[index] = !glassStates[index];
                      });
                    },
                    child: Icon(
                      Icons.local_drink,
                      size: 30,
                      color: glassStates[index]
                          ? const Color.fromARGB(255, 125, 189, 240)
                          : Colors.white,
                    ),
                  );
                }),
              ),
            ),
          ),

          // Checklist aligned with Doodle Here
          Positioned(
            bottom: 60,
            left: 30,
            child: Container(
              width: 160,
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.brown, width: 2),
                borderRadius: BorderRadius.circular(10),
                color: Colors.white.withOpacity(0.5), // Transparent effect
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Checklist",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.brown,
                    ),
                  ),
                  SizedBox(height: 5),
                  Column(
                    children: List.generate(checklistItems.length, (index) {
                      return Row(
                        children: [
                          Checkbox(
                            value: checklistStates[index],
                            activeColor: Colors.brown,
                            visualDensity: VisualDensity.compact, // Smaller checkbox
                            onChanged: (value) {
                              setState(() {
                                checklistStates[index] = value!;
                              });
                            },
                          ),
                          Text(
                            checklistItems[index],
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: Colors.brown,
                            ),
                          ),
                        ],
                      );
                    }),
                  ),
                ],
              ),
            ),
          ),

          // Doodle Here Section aligned
          Positioned(
            bottom: 60,
            right: 60,
            child: GestureDetector( // Added GestureDetector
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => DoodlePage()),
                );
              },
              child: Container(
                width: 150,
                height: 245,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.brown, width: 2),
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white.withOpacity(0.9),
                ),
                child: Center( // Centered text
                  child: Text(
                    "Doodle Here",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.brown,
                    ),
                  ),
                ),
              ),
            ),
          ),

        ],
      ),
    );
  }
}

// Sample pages for each navigation (you can create actual content for each page as needed)


