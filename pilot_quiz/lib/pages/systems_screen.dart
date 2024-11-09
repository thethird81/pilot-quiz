import 'package:flutter/material.dart';

class SystemsScreen extends StatelessWidget {
  final String aircraftType;
  final List<String> systems = [
    'Engine',
    'Oxygen',
    'Warning system',
    'Lighting',
    'Landing Gear',
    'Pneumatics',
    'Aircraft General',
    'Anti Ice, Rain Protection',
    'Hydraulics',
    'Fuel System',
    'Flight Controls',
    'Fire Protection',
    'Electrical',
    'Avionics',
    'APU',
  ];
  SystemsScreen({super.key, required this.aircraftType});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Topics'),
          backgroundColor: Colors.blueAccent,
        ),
        body: Container(
          padding: const EdgeInsets.all(32),
          alignment: Alignment.center,
          child: GridView.count(
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            crossAxisCount: 2,
            children: [
              for (var i in systems)
                InkWell(
                  onTap: () {
                    // final isQuiz = Provider.of<DataProvider>(context).isQuiz;
                    // debugPrint(isQuiz.toString());
                    //if (isQuiz) {
                    // Navigator.of(context).push(
                    //   MaterialPageRoute(
                    //     builder: (context) =>
                    //         QuizScreen(aircraftType: aircraftType, system: i),
                    //   ),
                    // );
                    //} else {
                    // Navigator.of(context).push(
                    //   MaterialPageRoute(
                    //     builder: (context) =>
                    //         HomePage(aircraftType: aircraftType, system: i),
                    //   ),
                    // );
                    // }
                  },
                  child: Container(
                      padding: const EdgeInsets.all(12),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: const Color.fromARGB(255, 163, 189, 233)),
                      child: Text(
                        i,
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      )),
                )
            ],
          ),
        ));
  }
}
