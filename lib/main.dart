import 'package:flutter/material.dart';

void main() {
  runApp(const QuizApp());
}

class QuizApp extends StatelessWidget {
  const QuizApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: QuizScreen(),
    );
  }
}

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});


  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int currentQuestionIndex = 0;
  int score = 0;

static const List<Map<String, Object>> questions = [
  {
    'question': 'Qual a capital dos Estados Unidos?',
    'options': ['Paris', 'Londres', 'Washington', 'Orlando'],
    'answer': 'Washington',
  },
  {
    'question': 'Quem criou o Flutter?',
    'options': ['Facebook', 'Google', 'Microsoft', 'Apple'],
    'answer': 'Google',
  },
  {
    'question': 'Qual a maior empresa do mundo em 2024?',
    'options': ['Apple', 'Microsoft', 'Tesla', 'Google'],
    'answer': 'Microsoft',
  },
];

void checkAnswer(String selectedAnswer) {
  if (selectedAnswer == questions[currentQuestionIndex]['answer']) {
    score++;
  }

  setState(() {
    currentQuestionIndex++;
  });
}

@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: const Text('Quiz App'),
      centerTitle: true
    ),
    body: currentQuestionIndex < questions.length
    ? buildQuestion()
    : buildResult(),
  );
}

Widget buildQuestion() {
  return Padding(
    padding: const EdgeInsets.all(16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Questão ${currentQuestionIndex + 1}/${questions.length}',
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 20),
        Text(
          questions[currentQuestionIndex]['question'] as String,
          style: const TextStyle(fontSize: 18),
        ),
        const SizedBox(height: 20),
        ...(questions[currentQuestionIndex]['options'] as List<String>)
          .map((option) => ElevatedButton(
            onPressed: () => checkAnswer(option),
            child: Text(option),
          ))
        .toList(),
      ],
    ),
  );
}

Widget buildResult() {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Quiz Completado!',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 20),
        Text(
          'Seu score: $score/${questions.length}',
          style: const TextStyle(fontSize: 20),
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: () {
            setState(() {
              currentQuestionIndex = 0;
              score = 0;
            });
          },
          child: const Text('Restart Quiz'),
        ),
      ],
    ),
  );
}
}