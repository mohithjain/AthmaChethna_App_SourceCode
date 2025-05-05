import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:sentiment_dart/sentiment_dart.dart';

void main() {
  runApp(MaterialApp(
    home: ReviewPage(),
    debugShowCheckedModeBanner: false,
  ));
}

class ReviewPage extends StatefulWidget {
  @override
  _ReviewPageState createState() => _ReviewPageState();
}

class _ReviewPageState extends State<ReviewPage> {
  TextEditingController reviewController = TextEditingController();
  List<Map<String, dynamic>> reviews = [];
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    loadReviews();
  }

  Future<void> loadReviews() async {
    final prefs = await SharedPreferences.getInstance();
    final String? storedReviews = prefs.getString('reviews');
    if (storedReviews != null) {
      setState(() {
        reviews = List<Map<String, dynamic>>.from(json.decode(storedReviews));
      });
    }
  }

  Future<void> saveReviews() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('reviews', json.encode(reviews));
  }

  double getSentimentRating(String review) {
    final sentimentResult = Sentiment.analysis(review);
    double score = sentimentResult.score;

    List<String> highlyPositiveKeywords = [
      "recovering", "helpful", "benefit", "improving", "better", "progress"
    ];
    List<String> neutralKeywords = [
      "sometimes", "not sure", "okay", "good but", "average"
    ];
    List<String> negativeKeywords = [
      "not satisfied", "bad", "didn't help", "waste", "useless"
    ];

    String lowerReview = review.toLowerCase();

    if (highlyPositiveKeywords.any((word) => lowerReview.contains(word))) {
      return 5.0;
    }
    if (neutralKeywords.any((word) => lowerReview.contains(word))) {
      return 2.5;
    }
    if (negativeKeywords.any((word) => lowerReview.contains(word))) {
      return 1.0;
    }

    if (score > 0) return 4.0;
    if (score == 0) return 3.0;
    return 1.5;
  }

  bool isValidReview(String review) {
    return review.trim().length >= 5;
  }

  void addReview() {
    String text = reviewController.text.trim();
    if (!isValidReview(text)) {
      setState(() {
        errorMessage = "Please enter a valid review (at least 5 characters).";
      });
      return;
    }

    setState(() {
      double rating = getSentimentRating(text);
      reviews.insert(0, {
        'name': 'User',
        'rating': rating,
        'review': text,
        'date': DateTime.now().toString(),
      });
      reviewController.clear();
      errorMessage = null;
    });

    saveReviews();
  }

  void deleteReview(int index) {
    setState(() {
      reviews.removeAt(index);
    });
    saveReviews();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 220, 213, 196),
      appBar: AppBar(
        backgroundColor: Colors.brown, // Changed to brown
        elevation: 0,
        toolbarHeight: 80.0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text("Reviews",
            style: TextStyle(color: Colors.white, fontSize: 26, fontWeight: FontWeight.bold)),
        centerTitle: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("4.5 ★★★★★  8K ratings",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.brown)),
            SizedBox(height: 10),
            Text("Write a Review:",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.brown)),
            TextField(
              controller: reviewController,
              maxLines: 2,
              decoration: InputDecoration(
                hintText: "Type your review here...",
                border: OutlineInputBorder(),
                fillColor: Color.fromARGB(255, 243, 225, 173),
                filled: true,
              ),
            ),
            if (errorMessage != null)
              Padding(
                padding: const EdgeInsets.only(top: 5),
                child: Text(errorMessage!,
                    style: TextStyle(color: Colors.brown, fontSize: 14)),
              ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: addReview,
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.brown,
                  padding: EdgeInsets.symmetric(vertical: 12, horizontal: 30)),
              child: Text("Submit Review",
                  style: TextStyle(color: Colors.white, fontSize: 16)),
            ),
            SizedBox(height: 20),
            Expanded(
              child: reviews.isEmpty
                  ? Center(
                      child: Text(
                      "No reviews yet. Be the first to review!",
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ))
                  : ListView.builder(
                      itemCount: reviews.length,
                      itemBuilder: (context, index) {
                        final review = reviews[index];
                        return Card(
                          shape: RoundedRectangleBorder(
                            side: BorderSide(color: Colors.brown, width: 2),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          color: const Color.fromARGB(255, 168, 148, 137),
                          margin: EdgeInsets.symmetric(vertical: 5),
                          child: Padding(
                            padding: EdgeInsets.all(10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    CircleAvatar(
                                      backgroundColor: Colors.brown,
                                      child: Text("U",
                                          style: TextStyle(color: Colors.white)),
                                    ),
                                    SizedBox(width: 10),
                                    Text("User",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)),
                                    Spacer(),
                                    Row(
                                      children: List.generate(
                                        5,
                                        (starIndex) => Icon(
                                          Icons.star,
                                          color: (review['rating'] > starIndex)
                                              ? Colors.yellow
                                              : Colors.white,
                                        ),
                                      ),
                                    ),
                                    IconButton(
                                      icon: Icon(Icons.delete, color: Colors.brown),
                                      onPressed: () => deleteReview(index),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 5),
                                Text(review['review'],
                                    style: TextStyle(fontSize: 14)),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
