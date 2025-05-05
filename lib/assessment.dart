import 'package:flutter/material.dart';
import 'resultscreen.dart';

class AssessmentScreen extends StatefulWidget {
  const AssessmentScreen({super.key});

  @override
  _AssessmentScreenState createState() => _AssessmentScreenState();
}

class _AssessmentScreenState extends State<AssessmentScreen> {
  int _currentQuestionIndex = 0;
  List<String> _userAnswers = List.filled(10, ''); // Store answers for 10 questions
  bool _isLoading = false;

  // List of 10 MCQ questions with options
  final List<Map<String, dynamic>> _questions = [
    {'question': 'Do you feel overwhelmed or stressed most of the time?', 'options': ['Yes, frequently', 'Sometimes', 'Rarely', 'Never']},
    {'question': 'Have you been experiencing trouble sleeping or changes in appetite?', 'options': ['Yes, frequently', 'Sometimes', 'Rarely', 'Never']},
    {'question': 'Do you feel sad or hopeless for extended periods?', 'options': ['Yes, frequently', 'Sometimes', 'Rarely', 'Never']},
    {'question': 'Are you finding it difficult to concentrate or make decisions?', 'options': ['Yes, frequently', 'Sometimes', 'Rarely', 'Never']},
    {'question': 'Have you lost interest in activities you once enjoyed?', 'options': ['Yes, frequently', 'Sometimes', 'Rarely', 'Never']},
    {'question': 'Do you feel anxious or panicked in everyday situations?', 'options': ['Yes, frequently', 'Sometimes', 'Rarely', 'Never']},
    {'question': 'Have you been feeling irritable or angry more often?', 'options': ['Yes, frequently', 'Sometimes', 'Rarely', 'Never']},
    {'question': 'Do you feel isolated or have difficulty connecting with others?', 'options': ['Yes, frequently', 'Sometimes', 'Rarely', 'Never']},
    {'question': 'Have you experienced thoughts of self-harm or suicide?', 'options': ['Yes, frequently', 'Sometimes', 'Rarely', 'Never']},
    {'question': 'Do you feel you need help managing your emotions or life challenges?', 'options': ['Yes, frequently', 'Sometimes', 'Rarely', 'Never']},
  ];

  void _selectAnswer(int index, String answer) {
    setState(() {
      _userAnswers[index] = answer;
    });
  }

  void _nextQuestions() {
    if (_currentQuestionIndex + 3 < _questions.length - 1) {
      setState(() {
        _currentQuestionIndex += 3;
      });
    } else {
      setState(() {
        _currentQuestionIndex = 9; // Jump to the last question
      });
    }
  }

  void _submitAssessment() {
    setState(() {
      _isLoading = true;
    });

    int yesFrequentlyCount = _userAnswers.where((answer) => answer == 'Yes, frequently').length;
    bool needsCounselor = yesFrequentlyCount >= 3;

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => ResultScreen(needsCounselor: needsCounselor),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Color(0xFFF2EDE5),
      appBar: AppBar(
        backgroundColor: Colors.brown,
        title: Text(
          'Mental Health Assessment',
          style: TextStyle(color: Colors.white, fontSize: screenWidth * 0.06),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator(color: Colors.brown))
          : Padding(
              padding: EdgeInsets.all(screenWidth * 0.06),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (_currentQuestionIndex == 9) // Only show the last question separately
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Question 10 of 10',
                            style: TextStyle(fontSize: screenWidth * 0.05, fontWeight: FontWeight.bold, color: Colors.brown),
                          ),
                          SizedBox(height: screenHeight * 0.01),
                          Text(
                            _questions[9]['question'] as String,
                            style: TextStyle(fontSize: screenWidth * 0.045, color: Colors.grey[700]),
                          ),
                          ...(_questions[9]['options'] as List<String>).map((option) {
                            return RadioListTile<String>(
                              title: Text(option, style: TextStyle(fontSize: screenWidth * 0.04, color: Colors.grey[700])),
                              value: option,
                              groupValue: _userAnswers[9],
                              onChanged: (value) {
                                _selectAnswer(9, value!);
                              },
                              activeColor: Colors.brown,
                            );
                          }).toList(),
                          SizedBox(height: screenHeight * 0.02),
                          ElevatedButton(
                            onPressed: _userAnswers[9].isEmpty ? null : _submitAssessment,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.brown,
                              padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: Text(
                              'Submit',
                              style: TextStyle(fontSize: screenWidth * 0.04, color: Colors.white),
                            ),
                          ),
                        ],
                      )
                    else // Show three questions per page
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ...List.generate(3, (index) {
                            int questionIndex = _currentQuestionIndex + index;
                            if (questionIndex >= 9) return SizedBox();
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Question ${questionIndex + 1} of 10',
                                  style: TextStyle(fontSize: screenWidth * 0.05, fontWeight: FontWeight.bold, color: Colors.brown),
                                ),
                                SizedBox(height: screenHeight * 0.01),
                                Text(
                                  _questions[questionIndex]['question'] as String,
                                  style: TextStyle(fontSize: screenWidth * 0.045, color: Colors.grey[700]),
                                ),
                                ...(_questions[questionIndex]['options'] as List<String>).map((option) {
                                  return RadioListTile<String>(
                                    title: Text(option, style: TextStyle(fontSize: screenWidth * 0.04, color: Colors.grey[700])),
                                    value: option,
                                    groupValue: _userAnswers[questionIndex],
                                    onChanged: (value) {
                                      _selectAnswer(questionIndex, value!);
                                    },
                                    activeColor: Colors.brown,
                                  );
                                }).toList(),
                                SizedBox(height: screenHeight * 0.02),
                              ],
                            );
                          }),
                          ElevatedButton(
                            onPressed: _userAnswers.sublist(_currentQuestionIndex, _currentQuestionIndex + 3).contains('') ? null : _nextQuestions,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.brown,
                              padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: Text(
                              'Next',
                              style: TextStyle(fontSize: screenWidth * 0.04, color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                  ],
                ),
              ),
            ),
    );
  }
}
