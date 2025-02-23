// ignore_for_file: sort_child_properties_last, use_build_context_synchronously

import 'package:flutter/material.dart';

class AnxietySurveyPage extends StatefulWidget {
  const AnxietySurveyPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _AnxietySurveyPageState createState() => _AnxietySurveyPageState();
}

class _AnxietySurveyPageState extends State<AnxietySurveyPage> {
  final List<String> questions = [
    '1. How often do you feel nervous, anxious, or on edge?',
    '2. Do you find it difficult to control your worries?',
    '3. In the past two weeks, how often have you felt that something terrible might happen?',
    '4. Do you have trouble sleeping due to anxiety or worry?',
    '5. Do you experience panic attacks (sudden, intense fear) that seem to come out of nowhere?',
    '6. Do you experience anxiety in social situations, such as meeting new people or speaking in public?',
    '7. Do you feel overwhelmed by your responsibilities or daily tasks due to anxiety?',
    '8. Do you use alcohol, drugs, or other substances to manage your anxiety?',
    '9. How often do you feel anxious about your health or believe you have a serious illness without medical evidence?',
    '10. Do you experience physical symptoms such as sweating, trembling, or a rapid heartbeat when you are anxious?',
  ];

  final List<double> sliderValues = List<double>.generate(10, (index) => 0);

  void _submitForm(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Submit Successful'),
        duration: Duration(seconds: 2),
        action: SnackBarAction(
          label: 'OK',
          onPressed: () {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
            Navigator.pushNamed(context, '/main');
          },
        ),
      ),
    );

    Future.delayed(Duration(seconds: 1), () {
      Navigator.pushNamed(context, '/main');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text('Anxiety'),
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          Center(
            child: Image.asset('images/anxiety.png', height: 100),
          ),
          SizedBox(height: 16.0),
          ...questions.asMap().entries.map((entry) {
            int idx = entry.key;
            String question = entry.value;
            return buildQuestionCard(question, idx);
          }).toList(),
          SizedBox(height: 16.0),
          ElevatedButton(
            onPressed: () {
              _submitForm(context);
            },
            child: Text(
              'SUBMIT',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.brown,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              padding: EdgeInsets.symmetric(vertical: 16.0),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildQuestionCard(String question, int idx) {
    return Container(
      margin: EdgeInsets.only(bottom: 16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              question,
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            ),
            SliderTheme(
              data: SliderTheme.of(context).copyWith(
                thumbShape: RoundSliderThumbShape(enabledThumbRadius: 12),
                thumbColor: Colors.brown,
                activeTrackColor: Colors.brown,
                inactiveTrackColor: Colors.brown[100],
                overlayShape: RoundSliderOverlayShape(overlayRadius: 20),
                overlayColor: Colors.brown.withOpacity(0.2),
                tickMarkShape: RoundSliderTickMarkShape(tickMarkRadius: 7),
                activeTickMarkColor: Colors.brown,
                inactiveTickMarkColor: Colors.brown,
              ),
              child: Slider(
                value: sliderValues[idx],
                min: 0,
                max: 3,
                divisions: 3,
                onChanged: (value) {
                  setState(() {
                    sliderValues[idx] = value;
                  });
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                buildLabel('Never', idx, 0),
                buildLabel('Rarely', idx, 1),
                buildLabel('Often', idx, 2),
                buildLabel('Always', idx, 3),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildLabel(String label, int questionIdx, int value) {
    return GestureDetector(
      onTap: () {
        setState(() {
          sliderValues[questionIdx] = value.toDouble();
        });
      },
      child: Column(
        children: [
          SizedBox(height: 4),
          Text(label),
        ],
      ),
    );
  }
}