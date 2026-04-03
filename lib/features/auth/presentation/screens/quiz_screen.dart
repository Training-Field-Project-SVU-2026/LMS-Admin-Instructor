
import 'package:flutter/material.dart';
import 'package:lms_admin_instructor/features/auth/presentation/screens/quiz_model.dart';

class QuizScreen extends StatefulWidget {
  final Quiz quiz;
  const QuizScreen({super.key, required this.quiz});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int? answer;
  bool checked = false;
  bool checkAns = false;
  String TxtString = 'Please chose Answer';
  @override
  Widget build(BuildContext context) {
    final quiz = widget.quiz;
    return Scaffold(
      appBar: AppBar(
        title: Text('Dart App', style: TextStyle(color: Colors.white)),
        backgroundColor: const Color.fromARGB(255, 26, 26, 26),
      ),

      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Chose the correct answer',
              style: TextStyle(
                color: Colors.blue[400],
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            Text(quiz.question, style: TextStyle(fontSize: 18)),
            Row(
              children: [
                Radio(
                  value: 1,
                  groupValue: answer,
                  onChanged: (value) {
                    setState(() {
                      answer = value;
                    });
                  },
                ),
                Text('1', style: TextStyle(fontSize: 16)),
              ],
            ),
            Row(
              children: [
                Radio(
                  value: 2,
                  groupValue: answer,
                  onChanged: (value) {
                    setState(() {
                      answer = value;
                    });
                  },
                ),
                Text('2', style: TextStyle(fontSize: 16)),
              ],
            ),
            Row(
              children: [
                Radio(
                  value: 3,
                  groupValue: answer,
                  onChanged: (value) {
                    setState(() {
                      answer = value;
                    });
                  },
                ),
                Text('3', style: TextStyle(fontSize: 16)),
              ],
            ),
            Row(
              children: [
                Radio(
                  value: 4,
                  groupValue: answer,
                  onChanged: (value) {
                    setState(() {
                      answer = value;
                    });
                  },
                ),
                Text('4', style: TextStyle(fontSize: 16)),
              ],
            ),

            SizedBox(height: 50),
            Center(child: Text(
              '$TxtString',
              style: TextStyle(
                color: checkAns ? Colors.green : Colors.red
              ),
            )),

            SizedBox(height: 5,),

            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadiusGeometry.circular(8)
                  )
                ),
                onPressed: checked
                    ? null
                    : () {
                        setState(() {
                          checked = true;
                          if (answer == 1 + 1) {
                            checkAns = true;
                            TxtString = 'True Answer';
                          } else {
                            checkAns = false;
                            TxtString = 'Wrong Answer';
                          }
                        });
                      },
                child: Text('Check answer'),
              ),
            ),
            SizedBox(height: 20,),
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadiusGeometry.circular(8)
                  )
                ),
                onPressed: () => setState(() {
                  checked = false;
                }),
                child: Text('Try Again'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}