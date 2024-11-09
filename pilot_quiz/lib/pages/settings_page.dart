import 'package:flutter/material.dart';
import 'package:pilot_quiz/helpers/notification_helper.dart';

final GlobalKey<_SettingsPageState> homePageKey =
    GlobalKey<_SettingsPageState>();

class SettingsPage extends StatefulWidget {
  SettingsPage({Key? key}) : super(key: homePageKey);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final List<int> durations = [1, 2, 6, 12, 24];
  int? selectedDuration;
  int? _selectedDuration; // Default to null
  bool _isButtonActive = false; // Track button state

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme:
            IconThemeData(color: Theme.of(context).colorScheme.onPrimary),
        title: const Text("Flutter Local Notifications"),
      ),
      body: SizedBox(
        height: double.infinity,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  DropdownButton<int>(
                    value: _selectedDuration,
                    items: [1, 2, 6, 12, 24].map((int value) {
                      return DropdownMenuItem<int>(
                        value: value,
                        child: Text(
                          '$value hour${value > 1 ? 's' : ''}',
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.onPrimary),
                        ),
                      );
                    }).toList(),
                    onChanged: (newValue) {
                      setState(() {
                        _selectedDuration = newValue;
                        _isButtonActive = newValue !=
                            null; // Activate button when duration is selected
                      });
                    },
                    hint: Text(
                      "Select Duration",
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.onPrimary),
                    ),
                  ),
                  ElevatedButton.icon(
                    icon: Icon(Icons.timer_outlined,
                        color: Theme.of(context).colorScheme.onPrimary),
                    onPressed: _isButtonActive
                        ? () {
                            LocalNotifications.showScheduleNotification(
                              title: "Schedule Notification",
                              body: "QUIZ OF THE DAY!!",
                              payload:
                                  "I am so happy !!! This is schedule data",
                              timeDuration: _selectedDuration!,
                            );
                          }
                        : null,
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
                    label: Text(
                      "Schedule Notifications",
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.onPrimary),
                    ),
                  ),
                ],
              ),
              ElevatedButton.icon(
                  icon: Icon(
                    Icons.delete_forever_outlined,
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
                  onPressed: () {
                    LocalNotifications.cancelAll();
                  },
                  style: ElevatedButton.styleFrom(
                      foregroundColor: Theme.of(context).colorScheme.onPrimary,
                      backgroundColor:
                          Theme.of(context).colorScheme.secondary, // Text color
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
                  label: Text(
                    "Cancel All Notifications",
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.onPrimary),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}

class NotiListner extends StatefulWidget {
  const NotiListner({super.key});

  @override
  State<NotiListner> createState() => _NotiListnerState();
}

class _NotiListnerState extends State<NotiListner> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
