import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AffirmationsPage extends StatefulWidget {
  @override
  _AffirmationsPageState createState() => _AffirmationsPageState();
}

class _AffirmationsPageState extends State<AffirmationsPage> {
  final List<String> fixedAffirmations = [
    "• I am strong and capable.",
    "• Every day, I grow and improve.",
    "• I radiate positivity and confidence.",
    "• Challenges help me grow stronger."
  ];
  List<String> userAffirmations = [];
  TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadAffirmations();
  }

  Future<void> _loadAffirmations() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userAffirmations = prefs.getStringList('userAffirmations') ?? [];
    });
  }

  Future<void> _addAffirmation() async {
    if (_controller.text.isNotEmpty) {
      setState(() {
        userAffirmations.add("• " + _controller.text);
      });
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setStringList('userAffirmations', userAffirmations);
      _controller.clear();
    }
  }

  Future<void> _removeAffirmation(int index) async {
    setState(() {
      userAffirmations.removeAt(index);
    });
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList('userAffirmations', userAffirmations);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Affirmations",
          style: TextStyle(color: Color.fromARGB(255, 235, 210, 135)),
        ),
        backgroundColor: Colors.brown,
        iconTheme: IconThemeData(color: Color.fromARGB(255, 235, 210, 135)),
      ),
      body: Container(
        color: Color(0xFFFCE7CC),
        child: Column(
          children: [
            Expanded(
              child: Scrollbar(
                thumbVisibility: true,
                child: ListView.builder(
                  padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0), // Reduced padding
                  itemCount: fixedAffirmations.length + userAffirmations.length,
                  itemBuilder: (context, index) {
                    if (index < fixedAffirmations.length) {
                      return ListTile(
                        contentPadding: EdgeInsets.zero, // Removed extra padding
                        title: Text(
                          fixedAffirmations[index],
                          style: TextStyle(
                            fontStyle: FontStyle.italic,
                            color: Colors.brown,
                          ),
                        ),
                      );
                    } else {
                      int userIndex = index - fixedAffirmations.length;
                      return ListTile(
                        contentPadding: EdgeInsets.zero, // Reduced padding between items
                        title: Text(
                          userAffirmations[userIndex],
                          style: TextStyle(
                            fontStyle: FontStyle.italic,
                            color: Colors.brown,
                          ),
                        ),
                        trailing: IconButton(
                          icon: Icon(Icons.close, color: Colors.brown),
                          onPressed: () => _removeAffirmation(userIndex),
                        ),
                      );
                    }
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 20.0, left: 16.0, right: 16.0), // Reduced bottom padding
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0), // Slightly reduced padding
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.brown),
                  borderRadius: BorderRadius.circular(20.0),
                  color: Colors.transparent,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _controller,
                        decoration: InputDecoration(
                          hintText: "Write your affirmation",
                          hintStyle: TextStyle(color: Colors.brown),
                          border: InputBorder.none,
                        ),
                        style: TextStyle(color: Colors.brown),
                      ),
                    ),
                    SizedBox(width: 5), // Reduced spacing
                    TextButton(
                      onPressed: _addAffirmation,
                      child: Text(
                        "Add",
                        style: TextStyle(color: Colors.brown, fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
