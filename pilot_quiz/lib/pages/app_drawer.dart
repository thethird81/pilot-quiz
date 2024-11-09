import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pilot_quiz/pages/dropdown_home.dart';
import 'package:pilot_quiz/pages/notification_page.dart';
import 'package:pilot_quiz/pages/profile_page.dart';
import 'package:pilot_quiz/pages/settings_page.dart';

class AppDrawer extends StatefulWidget {
  const AppDrawer({super.key});

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  final currentUser = FirebaseAuth.instance.currentUser!;

  void signOut(BuildContext context) {
    FirebaseAuth.instance.signOut();
    Navigator.pop(context);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Logged out!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.primary,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              DrawerHeader(
                  padding: EdgeInsets.all(8),
                  child: Column(
                    children: [
                      Icon(
                        Icons.person,
                        color: Theme.of(context).colorScheme.onPrimary,
                        size: 64,
                      ),
                      Text(
                        currentUser.email!,
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onPrimary,
                        ),
                      ),
                    ],
                  )),
              ListTile(
                leading: Icon(Icons.home,
                    color: Theme.of(context).colorScheme.onPrimary),
                title: Text('Home',
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.onPrimary)),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              DropdownHome())); // Close the drawer
                },
              ),
              ListTile(
                leading: Icon(Icons.settings,
                    color: Theme.of(context).colorScheme.onPrimary),
                title: Text('Profile',
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.onPrimary)),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => ProfilePage()));
                },
              ),
              ListTile(
                leading: Icon(Icons.settings,
                    color: Theme.of(context).colorScheme.onPrimary),
                title: Text('Settings',
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.onPrimary)),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SettingsPage()));
                },
              ),
            ],
          ),
          ListTile(
            leading: Icon(Icons.logout,
                color: Theme.of(context).colorScheme.onPrimary),
            title: Text('Logout',
                style:
                    TextStyle(color: Theme.of(context).colorScheme.onPrimary)),
            onTap: () => signOut(context),
          ),
        ],
      ),
    );
  }
}
