import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


class RememberPage extends StatefulWidget {
  @override
  _RememberPageState createState() => _RememberPageState();
}

class _RememberPageState extends State<RememberPage> {
  TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadSavedText();
  }

  void _loadSavedText() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _controller.text = prefs.getString('saved_note') ?? '';
    });
  }

  void _saveText(String text) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('saved_note', text);
  }

  void _clearText() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('saved_note');
    setState(() {
      _controller.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFCE7CC),
      appBar: AppBar(
        backgroundColor: Color(0xFFFCE7CC),
        elevation: 0,
        title: Text("Remember", style: TextStyle(color: Colors.brown, fontWeight: FontWeight.bold)),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.brown),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.delete, color: Colors.brown),
            onPressed: _clearText,
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black, width: 3),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: EdgeInsets.all(10),
            child: TextField(
              controller: _controller,
              onChanged: _saveText,
              maxLines: null,
              keyboardType: TextInputType.multiline,
              textAlign: TextAlign.start,
              style: TextStyle(fontSize: 16, color: Colors.black),
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.all(10),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
