import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pilot_quiz/flash_card/reusable_card.dart';
import 'package:pilot_quiz/helpers/fetch_question.dart';
import 'package:pilot_quiz/models/quiz_model.dart';

class HomePage extends StatefulWidget {
  final String aircraftType;
  final String system;
  final String difficultyLevel;
  const HomePage(
      {super.key,
      required this.aircraftType,
      required this.system,
      required this.difficultyLevel});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  GlobalKey<FlipCardState> cardKey = GlobalKey<FlipCardState>();
  FetchQuestions fetchQuestionsInstance = FetchQuestions();
  List<Question> _questions = [];
  int _currentIndexNumber = 0;
  double _initial = 0;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchQuestions();
  }

  Future<void> fetchQuestions() async {
    final QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('questions')
        .where('system', isEqualTo: widget.system)
        .where('aircraftType', isEqualTo: widget.aircraftType)
        .get();

    setState(() {
      List<Question> _questionsData = snapshot.docs.map((doc) {
        final List<String> options = List.from(doc['options'] as List);
        return Question(
            question: doc['question'].toString(),
            option: options,
            correctAnswer: doc['correctAnswer'],
            explanation: doc['explanation'].toString(),
            difficultyLevel: doc['level'].toString(),
            isFlashCard: doc['isFlashCard']);
      }).toList();
      _questions = _questionsData
          .where((q) => q.isFlashCard == true)
          .where((q) => q.difficultyLevel == widget.difficultyLevel)
          .toList();
      isLoading = false;
      _initial = 1 / _questions.length;
    });
  }

  Future<void> _resetCard() async {
    if (cardKey.currentState!.isFront) {
      // Do nothing if already on the front
    } else {
      await cardKey.currentState!.toggleCard(); // Flip to front
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_questions.isNotEmpty) {
      String value = (_currentIndexNumber + 1).toStringAsFixed(0);
      int qustionLeng = _questions.length;
      return Scaffold(
          backgroundColor: Theme.of(context).colorScheme.surface,
          appBar: AppBar(
            iconTheme:
                IconThemeData(color: Theme.of(context).colorScheme.onPrimary),
            title: Center(
              child: Text(
                "FLASH CARDS",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
              ),
            ),
          ),
          body: Center(
              child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
              borderRadius: BorderRadius.all(Radius.circular(50)),
            ),
            margin: const EdgeInsets.only(top: 30),
            padding: const EdgeInsets.all(40),
            alignment: Alignment.center,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text("Question $value of $qustionLeng Completed",
                      style: TextStyle(
                        fontSize: 15,
                        color: Theme.of(context).colorScheme.onPrimary,
                      )),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: LinearProgressIndicator(
                      backgroundColor: Theme.of(context).colorScheme.secondary,
                      valueColor: AlwaysStoppedAnimation(
                          Theme.of(context).colorScheme.onSecondary),
                      minHeight: 5,
                      value: _initial,
                    ),
                  ),
                  const SizedBox(height: 25),
                  SizedBox(
                      width: 300,
                      height: 300,
                      child: FlipCard(
                          key: cardKey,
                          direction: FlipDirection.VERTICAL,
                          front: ReusableCard(
                              text: _questions[_currentIndexNumber].question),
                          back: ReusableCard(
                              text: _questions[_currentIndexNumber].option[
                                  _questions[_currentIndexNumber]
                                      .correctAnswer]))),
                  Text("Tab to see Answer",
                      style: TextStyle(
                          fontSize: 15,
                          color: Theme.of(context).colorScheme.onSecondary)),
                  const SizedBox(height: 20),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        ElevatedButton.icon(
                          onPressed: () {
                            _resetCard();
                            showPreviousCard();
                            updateToPrev();
                          },
                          icon: Icon(
                            FontAwesomeIcons.handPointLeft,
                            size: 30,
                            color: Theme.of(context).colorScheme.onPrimary,
                          ),
                          label: Text(""),
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
                        ElevatedButton.icon(
                          onPressed: () {
                            _resetCard();
                            showNextCard();
                            updateToNext();
                          },
                          icon: Icon(
                            FontAwesomeIcons.handPointRight,
                            size: 30,
                            color: Theme.of(context).colorScheme.onPrimary,
                          ),
                          label: Text(""),
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
                        )
                      ])
                ]),
          )));
    } else {
      if (isLoading) {
        return Scaffold(
          backgroundColor: Theme.of(context).colorScheme.surface,
          body: const Center(
            child: CircularProgressIndicator(),
          ),
        );
      } else {
        return Scaffold(
          body: Center(
            child: Text(
              'Sorry No Question Available',
              style:
                  TextStyle(color: Theme.of(context).colorScheme.onSecondary),
            ),
          ),
        );
      }
    }
  }

  void updateToNext() {
    setState(() {
      _initial = _initial + 1 / _questions.length;
      if (_initial > 1) {
        _initial = 1 / _questions.length;
      }
    });
  }

  void updateToPrev() {
    setState(() {
      _initial = _initial - 1 / _questions.length;
      if (_initial < 1 / _questions.length) {
        _initial = 1;
      }
    });
  }

  void showNextCard() {
    setState(() {
      _currentIndexNumber = (_currentIndexNumber + 1 < _questions.length)
          ? _currentIndexNumber + 1
          : 0;
    });
  }

  void showPreviousCard() {
    setState(() {
      _currentIndexNumber = (_currentIndexNumber - 1 >= 0)
          ? _currentIndexNumber - 1
          : _questions.length - 1;
    });
  }
}
