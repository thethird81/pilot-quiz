import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pilot_quiz/pages/app_drawer.dart';
import 'package:pilot_quiz/pages/quiz_screen.dart';

import 'flash_card_screen.dart';

class DropdownHome extends StatefulWidget {
  const DropdownHome({super.key});

  @override
  State<DropdownHome> createState() => _DropdownHomeState();
}

class _DropdownHomeState extends State<DropdownHome> {
  @override
  void initState() {
    super.initState();
    fetchAircraftType();
  }

  final currentUser = FirebaseAuth.instance.currentUser!;
  String aircraftTypeValue = 'B777';
  String systemsValue = 'Airplane General';
  String difficultyValue = 'Easy';
  List<String> aircraftType = ['B777', 'B787', 'B737', 'A350', 'B767', 'Q400'];
  final List<String> difficultyLevel = [
    'Easy',
    'Medium',
    'Difficult',
  ];

  final List<String> systems = [
    'Airplane General',
    'Air Systems',
    'Anti-Ice, Rain',
    'Automatic Flight',
    'Communications',
    'Electrical',
    'Engines, APU',
    'Fire Protection',
    'Flight Controls',
    'Flight Instruments, Displays',
    'Flight Management, Navigation',
    'Fuel',
    'Hydraulics',
    'Landing Gear',
    'Warning Systems'
  ];

  Future<void> fetchAircraftType() async {
    try {
      // Replace 'your_collection' and 'your_document_id' with your actual Firestore collection and document ID
      DocumentSnapshot doc = await FirebaseFirestore.instance
          .collection('Users')
          .doc(currentUser.email)
          .get();

      // Extract 'aircraftType' field as a List<String>
      List<dynamic>? aircraftTypes = doc['aircraftType'];
      if (aircraftTypes != null) {
        setState(() {
          aircraftType = List<String>.from(aircraftTypes);
          aircraftTypeValue = aircraftType[0];
        });
      }
    } catch (e) {
      print("Error fetching aircraft types: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        appBar: AppBar(
          iconTheme:
              IconThemeData(color: Theme.of(context).colorScheme.onPrimary),
          title: Center(
              child: Text(
            'HOME',
            style: TextStyle(
              color: Theme.of(context).colorScheme.onPrimary,
            ),
          )),
        ),
        drawer: const AppDrawer(),
        body: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary,
            borderRadius:
                const BorderRadius.only(topLeft: Radius.circular(100)),
          ),
          margin: const EdgeInsets.only(top: 30),
          padding: const EdgeInsets.all(40),
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Select Aircraft Type and System',
                style:
                    TextStyle(color: Theme.of(context).colorScheme.onPrimary),
              ),
              const SizedBox(
                height: 50,
              ),
              DecoratedBox(
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.secondary,
                  border: Border.all(
                      color: Theme.of(context).colorScheme.onPrimary,
                      width: 2), // More visible border
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: DropdownButton(
                    items: aircraftType
                        .map<DropdownMenuItem<String>>(
                          (String aircraftType) => DropdownMenuItem<String>(
                            value: aircraftType,
                            child: Text(aircraftType),
                          ),
                        )
                        .toList(),
                    onChanged: (String? newValue) => setState(
                      () => aircraftTypeValue = newValue!,
                    ),
                    value: aircraftTypeValue,
                    icon: const Padding(
                      padding: EdgeInsets.only(left: 20),
                      child: Icon(Icons.arrow_circle_down_sharp),
                    ),
                    iconEnabledColor: Theme.of(context).colorScheme.onPrimary,
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.onPrimary,
                        fontSize: 20),
                    dropdownColor: Theme.of(context).colorScheme.secondary,
                    underline: Container(),
                    isExpanded: true,
                  ),
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              DecoratedBox(
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.secondary,
                  border: Border.all(
                      color: Theme.of(context).colorScheme.onPrimary,
                      width: 2), // More visible border
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: DropdownButton(
                    items: systems
                        .map<DropdownMenuItem<String>>(
                          (String systems) => DropdownMenuItem<String>(
                            value: systems,
                            child: Text(systems),
                          ),
                        )
                        .toList(),
                    onChanged: (String? newValue) => setState(
                      () => systemsValue = newValue!,
                    ),
                    value: systemsValue,
                    icon: Padding(
                      padding: EdgeInsets.only(left: 20),
                      child: Icon(
                        Icons.arrow_circle_down_sharp,
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                    ),
                    iconEnabledColor: Theme.of(context).colorScheme.onPrimary,
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.onPrimary,
                        fontSize: 20),
                    dropdownColor: Theme.of(context).colorScheme.secondary,
                    underline: Container(),
                    isExpanded: true,
                  ),
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              DecoratedBox(
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.secondary,
                  border: Border.all(
                      color: Theme.of(context).colorScheme.onPrimary,
                      width: 2), // More visible border
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: DropdownButton(
                    items: difficultyLevel
                        .map<DropdownMenuItem<String>>(
                          (String difficulty) => DropdownMenuItem<String>(
                            value: difficulty,
                            child: Text(difficulty),
                          ),
                        )
                        .toList(),
                    onChanged: (String? newValue) => setState(
                      () => difficultyValue = newValue!,
                    ),
                    value: difficultyValue,
                    icon: Padding(
                      padding: EdgeInsets.only(left: 20),
                      child: Icon(
                        Icons.arrow_drop_down_circle,
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                    ),
                    iconEnabledColor: Theme.of(context).colorScheme.onPrimary,
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.onPrimary,
                        fontSize: 20),
                    dropdownColor: Theme.of(context).colorScheme.secondary,
                    underline: Container(),
                    isExpanded: true,
                  ),
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => QuizScreen(
                              aircraftType: aircraftTypeValue,
                              system: systemsValue,
                              difficultyLevel: difficultyValue),
                        ),
                      );
                    },
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
                          borderRadius:
                              BorderRadius.circular(10), // Rounded corners
                        ),
                        minimumSize: const Size(100, 30) // Padding
                        ),
                    child: const Text('QUIZ'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => HomePage(
                              aircraftType: aircraftTypeValue,
                              system: systemsValue,
                              difficultyLevel: difficultyValue),
                        ),
                      );
                    },
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
                          borderRadius:
                              BorderRadius.circular(10), // Rounded corners
                        ),
                        minimumSize: const Size(100, 30) // Padding
                        ),
                    child: const Text('FLASH CARD'),
                  ),
                ],
              ),
            ],
          ),
        ));
  }
}
