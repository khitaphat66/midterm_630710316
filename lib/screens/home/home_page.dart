// ignore_for_file: avoid_unnecessary_containers

import 'package:flutter/material.dart';

// TODO: ใส่รหัสนักศึกษาที่ค่าสตริงนี้
const studentId = '630710316';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Question> questions = [
    Question(
      questionText: 'What is the capital of France?',
      answerOptions: ['Berlin', 'Madrid', 'Paris', 'Rome'],
      correctAnswerIndex: 2,
    ),
    // เพิ่มคำถามและคำตอบเพิ่มเติมตามต้องการ
  ];
  int currentQuestionIndex = 0;

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: 20.0,
            vertical: 20.0,
          ),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/bg_colorful.jpg"),
              opacity: 0.6,
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text('Good Morning',
                  textAlign: TextAlign.center, style: textTheme.headlineMedium),
              Text(studentId,
                  textAlign: TextAlign.center,
                  style: textTheme.headlineSmall!.copyWith(
                      fontWeight: FontWeight.bold, color: Colors.black87)),
              Spacer(),
              _buildQuizView(),
              Spacer(),
              _buildButtonPanel(),
              SizedBox(height: 16.0),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildQuizView() {
    Question currentQuestion = questions[currentQuestionIndex];

    return Container(
      child: Column(
        children: [
          Card(
            elevation: 4,
            // ความสูงของกรอบ
            margin: EdgeInsets.all(16.0),
            // ระยะห่างขอบกรอบ
            color: Colors.greenAccent,
            shape: RoundedRectangleBorder(
              borderRadius:
                  BorderRadius.circular(16.0), // กำหนดการโค้งมนของการ์ด
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                width: double.infinity,
                child: Text(
                  currentQuestion.questionText,
                  style: Theme.of(context).textTheme.headlineMedium,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),

          SizedBox(height: 16.0),
          Column(
            children: currentQuestion.answerOptions.map((option) {
              return Container(
                width: double.infinity, // กำหนดความกว้างเท่ากับขอบกรอบ
                margin: EdgeInsets.symmetric(vertical: 6.0), // ระยะห่างขอบกรอบ
                child: ElevatedButton(
                  onPressed: () {
                    // TODO: ตรวจสอบคำตอบถูกหรือไม่
                    bool isCorrect = currentQuestion.correctAnswerIndex ==
                        currentQuestion.answerOptions.indexOf(option);
                    // TODO: ปรับปรุง currentQuestionIndex เพื่อเลื่อนไปยังคำถามถัดไป
                    if (currentQuestionIndex < questions.length - 1) {
                      setState(() {
                        currentQuestionIndex++;
                      });
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.white, // กำหนดสีพื้นหลังของปุ่มเป็นสีขาว
                    onPrimary: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(10.0), // กำหนดการโค้งมนของปุ่ม
                    ), // กำหนดสีของตัวอักษรในปุ่ม
                  ),
                  child: Text(
                    option,
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              );
            }).toList(),
          ),
          SizedBox(height: 16.0),
          // เพิ่ม A, B, C, D หน้าคำตอบ 'Berlin', 'Madrid', 'Paris', 'Rome'
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: ['<', '>'].map((choice) {
                String answer = currentQuestion
                    .answerOptions[currentQuestion.correctAnswerIndex];
                return ElevatedButton(
                  onPressed: () {
                    // TODO: ตรวจสอบคำตอบ A, B, C, D
                    bool isCorrect = choice == answer;
                    // TODO: ปรับปรุง currentQuestionIndex เพื่อเลื่อนไปยังคำถามถัดไป
                    if (currentQuestionIndex < questions.length - 1) {
                      setState(() {
                        currentQuestionIndex++;
                      });
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.white,
                    onPrimary: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    minimumSize: Size(200.0, 40.0),
                  ),
                  child: Text(
                    choice,
                    style: TextStyle(color: Colors.black),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildButtonPanel() {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (currentQuestionIndex > 0)
            ElevatedButton(
              onPressed: () {
                // TODO: เลื่อนไปยังคำถามก่อนหน้า
                if (currentQuestionIndex > 0) {
                  setState(() {
                    currentQuestionIndex--;
                  });
                }
              },
              child: Text('ก่อนหน้า'),
            ),
          if (currentQuestionIndex < questions.length - 1)
            ElevatedButton(
              onPressed: () {
                // TODO: เลื่อนไปยังคำถามถัดไป
                if (currentQuestionIndex < questions.length - 1) {
                  setState(() {
                    currentQuestionIndex++;
                  });
                }
              },
              child: Text('ถัดไป'),
            ),
        ],
      ),
    );
  }

  void _goToPreviousQuestion() {
    if (currentQuestionIndex > 0) {
      setState(() {
        currentQuestionIndex--;
      });
    }
  }

  void _goToNextQuestion() {
    if (currentQuestionIndex < questions.length - 1) {
      setState(() {
        currentQuestionIndex++;
      });
    }
  }
}

class Question {
  final String questionText;
  final List<String> answerOptions;
  final int correctAnswerIndex;

  Question({
    required this.questionText,
    required this.answerOptions,
    required this.correctAnswerIndex,
  });
}
