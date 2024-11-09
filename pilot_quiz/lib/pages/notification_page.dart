import 'package:flutter/material.dart';
import 'package:pilot_quiz/helpers/notification_helper.dart';

final GlobalKey<_NotiHomePageState> homePageKey =
    GlobalKey<_NotiHomePageState>();

class NotiHomePage extends StatefulWidget {
  NotiHomePage({Key? key}) : super(key: homePageKey);

  @override
  State<NotiHomePage> createState() => _NotiHomePageState();
}

class _NotiHomePageState extends State<NotiHomePage> {
  @override
  void initState() {
    super.initState();
    //listenToNotifications();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Flutter Local Notifications")),
      body: SizedBox(
        height: double.infinity,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // ElevatedButton.icon(
              //   icon: const Icon(Icons.notifications_outlined),
              //   onPressed: () {
              //     LocalNotifications.showSimpleNotification(
              //         title: "Simple Notification",
              //         body: "This is a simple notification",
              //         payload: "This is simple data");
              //   },
              //   label: const Text("Simple Notification"),
              // ),
              // ElevatedButton.icon(
              //   icon: const Icon(Icons.timer_outlined),
              //   onPressed: () {
              //     LocalNotifications.showPeriodicNotifications(
              //         title: "Periodic Notification",
              //         body: "This is a Periodic Notification",
              //         payload: "This is periodic data");
              //   },
              //   label: const Text("Periodic Notifications"),
              // ),
              ElevatedButton.icon(
                icon: const Icon(Icons.timer_outlined),
                onPressed: () {
                  LocalNotifications.showScheduleNotification(
                      title: "Schedule Notification",
                      body: "QUIZ OF THE DAY!!",
                      payload: "I am so happy !!! This is schedule data",
                      timeDuration: 5);
                },
                label: const Text("Schedule Notifications"),
              ),
              // to close periodic notifications
              // ElevatedButton.icon(
              //     icon: const Icon(Icons.delete_outline),
              //     onPressed: () {
              //       LocalNotifications.cancel(1);
              //     },
              //     label: const Text("Close Periodic Notifcations")),
              ElevatedButton.icon(
                  icon: const Icon(Icons.delete_forever_outlined),
                  onPressed: () {
                    LocalNotifications.cancelAll();
                  },
                  label: const Text("Cancel All Notifcations"))
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
