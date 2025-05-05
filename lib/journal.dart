import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class JournalScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white), // Arrow color: b18752
          onPressed: () {
            Navigator.pop(context); // Navigate back to the previous screen
          },
        ),
        backgroundColor: Color(0xFFB09C83), // AppBar color: b09c83
        elevation: 0,
        
      ),
      body: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => TextFieldPage()),
          );
        },
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('images/journal.png'), // Change to your image
              fit: BoxFit.cover, // Ensures full coverage
            ),
          ),
        ),
      ),
    );
  }
}

class TextFieldPage extends StatefulWidget {
  @override
  _TextFieldPageState createState() => _TextFieldPageState();
}

class _TextFieldPageState extends State<TextFieldPage> {
  TextEditingController _controller = TextEditingController();
  FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _loadSavedText();

    // Ensure cursor appears by requesting focus
    Future.delayed(Duration(milliseconds: 300), () {
      setState(() {
        _focusNode.requestFocus();
      });
    });
  }

  void _loadSavedText() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _controller.text = prefs.getString('diaryText') ?? '';
    });
  }

  void _saveText() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('diaryText', _controller.text);
  }

  void _deleteText() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('diaryText');
    setState(() {
      _controller.clear();
    });
  }

  @override
  void dispose() {
    _saveText();
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false, // Prevents floating issues
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent, // Brown-colored AppBar
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: const Color.fromARGB(255, 110, 75, 62)), // Back arrow in brown color
          onPressed: () {
            Navigator.pop(context);
          },
        ),
  
        actions: [
          IconButton(
            icon: Icon(Icons.delete, color: Colors.brown),
            padding: EdgeInsets.only(right: 50),
            onPressed: _deleteText,
          ),
        ],
      ),
      body: Stack(
        children: [
          // Background Image (Ensures it fills screen below AppBar)
          Positioned.fill(
            child: Image.asset(
              'images/journal1.png', // Change to your image
              fit: BoxFit.fill,
            ),
          ),

          // Transparent TextField Positioned Over Background
          Padding(
            padding: EdgeInsets.only(top: kToolbarHeight + 70), // Start cursor 60 pixels below AppBar
            child: SingleChildScrollView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              child: Container(
                height: MediaQuery.of(context).size.height - kToolbarHeight - 30,
                padding: EdgeInsets.only(left: 50, right:50 , bottom: 120), // Add left padding for the cursor
                child: TextField(
                  controller: _controller,
                  focusNode: _focusNode,
                  maxLines: null,
                  autofocus: true, // Ensure cursor is always visible
                  showCursor: true, // Ensure cursor is always visible
                  cursorWidth: 1.5, // Reduce cursor size (default is 2.0)
                  textAlignVertical: TextAlignVertical.center,
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.brown,
                    height: 2.4, // Adjust based on image line spacing
                  ),
                  cursorColor: Colors.brown,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.zero,
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