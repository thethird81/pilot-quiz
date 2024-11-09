import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pilot_quiz/components/text_box.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final currentUser = FirebaseAuth.instance.currentUser!;

  Future<void> editField(String field) async {}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        appBar: AppBar(
          iconTheme:
              IconThemeData(color: Theme.of(context).colorScheme.onPrimary),
          title: Text("Profile Page",
              style: TextStyle(color: Theme.of(context).colorScheme.onPrimary)),
          backgroundColor: Theme.of(context).colorScheme.surface,
        ),
        body: StreamBuilder<DocumentSnapshot>(
          stream: FirebaseFirestore.instance
              .collection('Users')
              .doc(currentUser.email)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final userDate = snapshot.data!.data() as Map<String, dynamic>;
              List<dynamic> aircraftTypeList = userDate['aircraftType'];
              return ListView(
                children: [
                  const SizedBox(
                    height: 50,
                  ),
                  Icon(
                    Icons.person,
                    size: 72,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(currentUser.email!,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onPrimary,
                      )),
                  const SizedBox(
                    height: 50,
                  ),
                  Padding(
                      padding: const EdgeInsets.only(left: 25),
                      child: Text(
                        'My Details',
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.onPrimary),
                      )),
                  MyTextBox(
                    text: userDate['username'],
                    sectionName: "username",
                    onPressed: () => editField('username'),
                  ),
                  MyTextBox(
                    text: aircraftTypeList.join(','),
                    sectionName: "Aircraft Type",
                    onPressed: () => editField('B777'),
                  )
                ],
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text('Error ${snapshot.error}'),
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ));
  }
}
