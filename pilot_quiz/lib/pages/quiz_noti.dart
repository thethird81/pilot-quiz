import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pilot_quiz/helpers/notification_helper.dart';
import 'package:pilot_quiz/models/quiz_model.dart';

class QuizNoti extends StatefulWidget {
  const QuizNoti({
    super.key,
  });
  @override
  _QuizNotiState createState() => _QuizNotiState();
}

class _QuizNotiState extends State<QuizNoti> {
  List<Question> _questions = [];
  int _currentQuestionIndex = 0;
  int _score = 0;
  List<int?> _selectedAnswers = [];

  @override
  void initState() {
    super.initState();

    fetchQuestions();
    //listenToNotifications();
  }

  Future<void> fetchQuestions() async {
    final QuerySnapshot snapshot =
        await FirebaseFirestore.instance.collection('questions').limit(5).get();

    setState(() {
      _questions = snapshot.docs.map((doc) {
        final List<String> options = List.from(doc['options'] as List);
        return Question(
            question: doc['question'].toString(),
            option: options,
            correctAnswer: doc['correctAnswer'],
            explanation: doc['explanation'].toString(),
            difficultyLevel: doc['level'].toString(),
            isFlashCard: doc['isFlashCard']);
      }).toList();
      _selectedAnswers = List<int?>.filled(_questions.length, null);
    });
  }

  void _nextQuestion() {
    setState(() {
      if (_currentQuestionIndex < _questions.length - 1) {
        _currentQuestionIndex++;
      }
    });
  }

  void _prevQuestion() {
    setState(() {
      if (_currentQuestionIndex > 0) {
        _currentQuestionIndex--;
      }
    });
  }

  void _submitQuiz() {
    List<int> unansweredQuestions = [];
    for (int i = 0; i < _questions.length; i++) {
      if (_selectedAnswers[i] == null) {
        unansweredQuestions.add(i + 1); // Adding 1 to make it 1-based index
      }
    }

    if (unansweredQuestions.isNotEmpty) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text('Unanswered Questions',
              style: TextStyle(color: Theme.of(context).colorScheme.onPrimary)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Please answer the following questions:',
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.onPrimary)),
              Text(unansweredQuestions.join(', '),
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.onPrimary)),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(ctx).pop();
                _goToFirstUnansweredQuestion(unansweredQuestions);
              },
              child: Text('Go to First Unanswered',
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.onPrimary)),
            ),
          ],
        ),
      );
    } else {
      int score = 0;
      for (int i = 0; i < _questions.length; i++) {
        if (_selectedAnswers[i] == _questions[i].correctAnswer) {
          score++;
        }
      }
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text('Quiz Completed',
              style: TextStyle(color: Theme.of(context).colorScheme.onPrimary)),
          content: Text('Your score is $score/${_questions.length}',
              style: TextStyle(color: Theme.of(context).colorScheme.onPrimary)),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(ctx).pop();
              },
              child: Text('OK',
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.onPrimary)),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(ctx).pop();
                _resetQuiz();
              },
              child: Text(
                'Reset Quiz',
                style:
                    TextStyle(color: Theme.of(context).colorScheme.onPrimary),
              ),
            ),
          ],
        ),
      );
    }
  }

  void _goToFirstUnansweredQuestion(List<int> unansweredQuestions) {
    setState(() {
      _currentQuestionIndex = unansweredQuestions.first -
          1; // Subtracting 1 to make it 0-based index
    });
  }

  void _resetQuiz() {
    setState(() {
      _currentQuestionIndex = 0;
      _score = 0;
      _selectedAnswers = List<int?>.filled(_questions.length, null);
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_questions.isNotEmpty) {
      final question = _questions[_currentQuestionIndex];
      return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        appBar: AppBar(
          iconTheme:
              IconThemeData(color: Theme.of(context).colorScheme.onPrimary),
          title: Center(
              child: Text(
            'Questions',
            style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
          )),
        ),
        body: Container(
          color: Theme.of(context).colorScheme.secondary,
          padding: EdgeInsets.only(left: 20, right: 20, bottom: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${_currentQuestionIndex + 1}/${_questions.length}',
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.onPrimary,
                        fontWeight: FontWeight.w400,
                        fontSize: 20),
                  ),
                  Container(
                    child: Text(
                      question.question,
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 20,
                          color: Theme.of(context).colorScheme.onPrimary),
                    ),
                  ),
                  ...question.option.asMap().entries.map((entry) {
                    int idx = entry.key;
                    String val = entry.value;
                    return ListTile(
                      selectedColor: Theme.of(context).colorScheme.onPrimary,
                      iconColor: Theme.of(context).colorScheme.onPrimary,
                      title: GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedAnswers[_currentQuestionIndex] = idx;
                            });
                          },
                          child: Text(
                            val,
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: Theme.of(context).colorScheme.onPrimary),
                          )),
                      leading: Radio<int>(
                        activeColor: Theme.of(context).colorScheme.onPrimary,
                        value: idx,
                        groupValue: _selectedAnswers[_currentQuestionIndex],
                        onChanged: (value) {
                          setState(() {
                            _selectedAnswers[_currentQuestionIndex] = value;
                          });
                        },
                      ),
                    );
                  }).toList(),
                ],
              ),
              Container(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(
                          onPressed: _prevQuestion,
                          child: Text(
                            'Previous',
                            style: TextStyle(
                                color: Theme.of(context).colorScheme.onPrimary),
                          ),
                          style: ElevatedButton.styleFrom(
                              foregroundColor:
                                  Theme.of(context).colorScheme.onPrimary,
                              backgroundColor: Theme.of(context)
                                  .colorScheme
                                  .secondary, // Text color
                              shadowColor: Theme.of(context)
                                  .colorScheme
                                  .onPrimary, // Shadow color
                              elevation: 2, // Elevation
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    10), // Rounded corners
                              ),
                              minimumSize: const Size(100, 30) // Padding
                              ),
                        ),
                        ElevatedButton(
                          onPressed:
                              _currentQuestionIndex == _questions.length - 1
                                  ? _submitQuiz
                                  : _nextQuestion,
                          child: Text(
                            _currentQuestionIndex == _questions.length - 1
                                ? 'Submit'
                                : 'Next',
                            style: TextStyle(
                                color: Theme.of(context).colorScheme.onPrimary),
                          ),
                          style: ElevatedButton.styleFrom(
                              foregroundColor:
                                  Theme.of(context).colorScheme.onPrimary,
                              backgroundColor: Theme.of(context)
                                  .colorScheme
                                  .secondary, // Text color
                              shadowColor: Theme.of(context)
                                  .colorScheme
                                  .onPrimary, // Shadow color
                              elevation: 2, // Elevation
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    10), // Rounded corners
                              ),
                              minimumSize: const Size(100, 30) // Padding
                              ),
                        ),
                      ],
                    ),
                    ExpansionTile(
                      title: Text(
                        'Explanation',
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.onPrimary),
                      ),
                      children: [
                        Text(
                          question.explanation,
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.onPrimary),
                        )
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          title: Text('Quiz App'),
        ),
        body: const Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
  }
}
