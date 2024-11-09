import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pilot_quiz/constants/notam_contractions.dart';

class MyNotamHomePage extends StatefulWidget {
  const MyNotamHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyNotamHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyNotamHomePage> {
  List<Map<String, dynamic>> _foundContractions = [];
  @override
  void initState() {
    _foundContractions = allContractions;
    super.initState();
  }

  void _runFilter(String enteredKeyword) {
    List<Map<String, dynamic>> result = [];
    if (enteredKeyword.isEmpty) {
      result = allContractions;
    } else {
      result = allContractions
          .where((notam) => (notam['contraction']
              .toLowerCase()
              .contains(enteredKeyword.toLowerCase())))
          .toList();
    }

    setState(() {
      _foundContractions = result;
    });
  }

  void signOut() {
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(widget.title),
          actions: [
            IconButton(onPressed: signOut, icon: const Icon(Icons.logout))
          ],
        ),
        body: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            TextField(
              onChanged: (value) => _runFilter(value),
              decoration: const InputDecoration(
                  labelText: 'Search', suffixIcon: Icon(Icons.search)),
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: _foundContractions.length,
                  itemBuilder: (context, index) => Card(
                        key: ValueKey(_foundContractions[index]['id']),
                        color: const Color.fromARGB(255, 4, 100, 243),
                        elevation: 4,
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        child: ListTile(
                          leading: Text(
                            _foundContractions[index]['id'].toString(),
                            style: const TextStyle(
                                fontSize: 24, color: Colors.white),
                          ),
                          title: Text(
                            _foundContractions[index]['contraction'].toString(),
                            style: const TextStyle(
                                fontSize: 24, color: Colors.white),
                          ),
                          subtitle: Text(
                            _foundContractions[index]['decode'].toString(),
                            style: const TextStyle(
                                fontSize: 24, color: Colors.white),
                          ),
                        ),
                      )),
            ),
          ],
        ));
  }
}
