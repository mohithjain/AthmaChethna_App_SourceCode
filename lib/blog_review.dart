import 'package:flutter/material.dart';

class BlogPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Add an AppBar with a transparent background
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        // Left arrow to navigate back to the home screen
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pushNamed(context, '/homescreen'); // Change route as needed
          },
        ),
      ),
      // Extend the background image behind the AppBar
      extendBodyBehindAppBar: true,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/blogcover.jpg'), // Make sure your asset is added in pubspec.yaml
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              blogCard(context),
              SizedBox(height: 40), // Space between the two cards
              reviewCard(context),
            ],
          ),
        ),
      ),
    );
  }

  // Blog card becomes clickable with GestureDetector
  Widget blogCard(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/blog');
      },
      child: Container(
        width: 350,
        padding: EdgeInsets.all(26),
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.6),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min, // To prevent the Column from expanding
          children: [
            Text(
              '"Share your voice, inspire others, and turn your passion into powerful stories that leave a lasting impact."',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10), // Add some spacing
            Text(
              'Add yours',
              style: TextStyle(
                color: Colors.white,
                fontSize: 14, // Smaller font size
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Review card becomes clickable with GestureDetector
  Widget reviewCard(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/review');
      },
      child: Container(
        width: 350,
        padding: EdgeInsets.all(26),
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.6),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min, // To prevent the Column from expanding
          children: [
            Text(
              '"Discover genuine experiences and insightful opinions through authentic reviews from our community."',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10), // Add some spacing
            Text(
              'Add yours',
              style: TextStyle(
                color: Colors.white,
                fontSize: 14, // Smaller font size
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
        ),
      ),
    );
  }
}