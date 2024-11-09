import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  final List<String> practiceType = ['QUIZ', 'FLASH CARD'];
  Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('HOME'),
          backgroundColor: Colors.blueAccent,
        ),
        body: Container(
          padding: const EdgeInsets.all(100),
          alignment: Alignment.center,
          child: GridView.count(
            crossAxisSpacing: 12,
            mainAxisSpacing: 30,
            crossAxisCount: 1,
            children: [
              for (var i in practiceType)
                InkWell(
                  onTap: () {
                    // Provider.of<DataProvider>(context, listen: false)
                    //     .updateIsQuiz(true);
                    // if (i == 'QUIZ')
                    //   Navigator.of(context).push(
                    //     MaterialPageRoute(
                    //       builder: (context) => TopicsScreen(),
                    //     ),
                    //   );
                    // else {
                    //   Provider.of<DataProvider>(context, listen: false)
                    //       .updateIsQuiz(false);
                    //   Navigator.of(context).push(
                    //     MaterialPageRoute(
                    //       builder: (context) => TopicsScreen(),
                    //     ),
                    //   );
                    // }
                  },
                  child: Container(
                      padding: const EdgeInsets.all(40),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: const Color.fromARGB(255, 163, 189, 233)),
                      child: Text(
                        i,
                        style: const TextStyle(
                            fontSize: 32, fontWeight: FontWeight.bold),
                      )),
                )
            ],
          ),
        ));
  }
}
