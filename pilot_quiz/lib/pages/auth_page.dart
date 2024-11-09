import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pilot_quiz/pages/dropdown_home.dart';
import 'package:pilot_quiz/pages/login_page.dart';
import 'package:pilot_quiz/pages/my_home_page.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return const DropdownHome();
          } else {
            return const LoginPage();
          }
        },
      ),
    );
  }
}
