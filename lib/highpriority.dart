import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HighPriorityPage extends StatefulWidget {
  @override
  _HighPriorityPageState createState() => _HighPriorityPageState();
}

class _HighPriorityPageState extends State<HighPriorityPage> {
  List<String> priorities = List.generate(2, (index) => ''); // Always start with 2 items
  List<bool> isChecked = List.generate(2, (index) => false); // Always start with 2 unchecked items
  List<TextEditingController> controllers = []; // Keep controllers in a list to persist

  @override
  void initState() {
    super.initState();
    _loadData();
    // Initialize the controllers only once
    controllers = List.generate(priorities.length, (index) => TextEditingController(text: priorities[index]));
  }

  // Function to load data from SharedPreferences
  _loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Fetch the priorities and isChecked lists from SharedPreferences
    List<String>? loadedPriorities = prefs.getStringList('priorities');
    List<String>? loadedIsChecked = prefs.getStringList('isChecked');

    setState(() {
      // If loadedPriorities is null, use a default list with 2 empty strings
      priorities = loadedPriorities ?? List.generate(2, (index) => '');

      // If loadedIsChecked is null, use a default list with 2 'false' values
      isChecked = loadedIsChecked != null
          ? loadedIsChecked.map((e) => e == 'true').toList()
          : List.generate(2, (index) => false);

      // Ensure there are always at least 2 items
      if (priorities.length < 2) {
        priorities.addAll(List.generate(2 - priorities.length, (index) => ''));
        isChecked.addAll(List.generate(2 - isChecked.length, (index) => false));
      }

      // Recreate the TextEditingControllers based on the new priorities
      controllers = List.generate(priorities.length, (index) => TextEditingController(text: priorities[index]));
    });
  }

  // Function to save data to SharedPreferences
  _saveData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Save priorities and isChecked lists to SharedPreferences
    await prefs.setStringList('priorities', priorities);
    await prefs.setStringList('isChecked', isChecked.map((e) => e.toString()).toList());
  }

  // Function to delete a priority item
  void deletePriority(int index) {
    setState(() {
      priorities.removeAt(index);
      isChecked.removeAt(index);
      controllers.removeAt(index); // Remove the controller as well

      // Ensure there are always at least 2 items
      if (priorities.length < 2) {
        priorities.add('');
        isChecked.add(false);
        controllers.add(TextEditingController(text: '')); // Add a new controller for the new item
      }
    });
    _saveData(); // Save data after deletion
  }

  // Function to add a new priority item
  void addNewPriority() {
    setState(() {
      priorities.add('');
      isChecked.add(false);
      controllers.add(TextEditingController(text: '')); // Add a new controller for the new item
    });
    _saveData(); // Save data after adding a new priority
  }

  @override
  void dispose() {
    // Dispose all controllers
    for (var controller in controllers) {
      controller.dispose();
    }
    super.dispose();
    _saveData(); // Save data when leaving the page
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(onBackPressed: () {
        Navigator.pop(context); // Custom back button action
      }),
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Image covering the entire screen
          Image.asset(
            "images/highprior.jpg", // Replace with your image
            fit: BoxFit.fill,
          ),
          // Priority list with input fields and checkboxes
          Padding(
            padding: const EdgeInsets.only(top: 50, right: 30), // Adjusted top padding to avoid overlap
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: ListView(
                    children: List.generate(priorities.length, (index) {
                      return Padding(
                        padding: const EdgeInsets.all(6),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 50.0),
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.8,
                            padding: EdgeInsets.all(1),
                            decoration: BoxDecoration(
                              color: Colors.transparent, // Make container fully transparent
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: Colors.brown), // Add a border for clarity
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Checkbox(
                                  value: isChecked[index],
                                  onChanged: (value) {
                                    setState(() {
                                      isChecked[index] = value!;
                                    });
                                    _saveData(); // Save data after checkbox state change
                                  },
                                ),
                                Expanded(
                                  child: TextField(
                                    controller: controllers[index], // Use the controller here
                                    enabled: !isChecked[index],
                                    decoration: InputDecoration(
                                      hintText: "Write your high priority here...",
                                      border: InputBorder.none,
                                      labelStyle: isChecked[index]
                                          ? TextStyle(decoration: TextDecoration.lineThrough)
                                          : null,
                                    ),
                                    onChanged: (text) {
                                      priorities[index] = text;
                                      _saveData(); // Save data after text change
                                    },
                                  ),
                                ),
                                IconButton(
                                  icon: Icon(Icons.delete, color: Colors.brown),
                                  onPressed: () => deletePriority(index),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                ),
              ],
            ),
          ),
          // Plus symbol positioned at the bottom right corner
          Positioned(
            bottom: 20,
            right: 20,
            child: IconButton(
              icon: Icon(
                Icons.add_circle_outline,
                size: 60,
                color: Colors.brown,
              ),
              onPressed: addNewPriority,
            ),
          ),
        ],
      ),
    );
  }
}

// Custom AppBar widget with back button
// Custom AppBar widget with back button
class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback onBackPressed;

  CustomAppBar({required this.onBackPressed});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Color(0xFFFCE7CC), // Set background color to #fce7cc
      elevation: 0,
      leading: IconButton(
        icon: Icon(Icons.arrow_back, color: Colors.brown),
        onPressed: onBackPressed, // Trigger custom back action
      ),
      title: Text(
        "Priority List",
        style: TextStyle(
          fontSize: 36,
          fontWeight: FontWeight.bold,
          fontStyle: FontStyle.italic,
          color: Colors.brown,
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
