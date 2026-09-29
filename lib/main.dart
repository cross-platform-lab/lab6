import 'package:flutter/material.dart';

import 'quiz_brain.dart';

// Lab 6: Quizzler
// Trò chơi câu đố Đúng/Sai với danh sách biểu tượng kết quả (scoreKeeper).
void main() {
  runApp(const QuizzlerApp());
}

class QuizzlerApp extends StatelessWidget {
  const QuizzlerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quizzler',
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.grey.shade900,
        body: const SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: QuizPage(),
          ),
        ),
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  const QuizPage({super.key});

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  final QuizBrain quizBrain = QuizBrain();
  final List<Icon> scoreKeeper = [];
  int correctCount = 0;

  void checkAnswer(bool userPickedAnswer) {
    final bool correctAnswer = quizBrain.getCorrectAnswer();

    setState(() {
      if (userPickedAnswer == correctAnswer) {
        correctCount++;
        scoreKeeper.add(const Icon(Icons.check, color: Colors.green));
      } else {
        scoreKeeper.add(const Icon(Icons.close, color: Colors.red));
      }
    });

    if (quizBrain.isFinished()) {
      showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (context) => AlertDialog(
          title: const Text('Hoàn thành!'),
          content: Text(
            'Bạn đã trả lời đúng $correctCount/${quizBrain.totalQuestions} câu.\n'
            'Trò chơi sẽ bắt đầu lại từ câu đầu tiên.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Chơi lại'),
            ),
          ],
        ),
      ).then((_) {
        setState(() {
          quizBrain.reset();
          scoreKeeper.clear();
          correctCount = 0;
        });
      });
    } else {
      setState(quizBrain.nextQuestion);
    }
  }

  Widget answerButton({required String label, required Color color, required bool value}) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: TextButton(
          style: TextButton.styleFrom(
            backgroundColor: color,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
          onPressed: () => checkAnswer(value),
          child: Text(label, style: const TextStyle(fontSize: 20)),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 16),
          child: Text(
            'Câu ${quizBrain.questionNumber}/${quizBrain.totalQuestions}',
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.white54, fontSize: 16),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: LinearProgressIndicator(
            value: scoreKeeper.length / quizBrain.totalQuestions,
            color: Colors.lightBlueAccent,
            backgroundColor: Colors.white12,
          ),
        ),
        Expanded(
          flex: 5,
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Center(
              child: Text(
                quizBrain.getQuestionText(),
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 25, color: Colors.white),
              ),
            ),
          ),
        ),
        answerButton(label: 'Đúng', color: Colors.green, value: true),
        answerButton(label: 'Sai', color: Colors.red, value: false),
        SizedBox(
          height: 40,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(children: scoreKeeper),
          ),
        ),
      ],
    );
  }
}
