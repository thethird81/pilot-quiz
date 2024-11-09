import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:pilot_quiz/firebase_options.dart';
import 'package:pilot_quiz/helpers/notification_helper.dart';
import 'package:pilot_quiz/pages/auth_page.dart';
import 'package:pilot_quiz/pages/flash_card_noti.dart';
import 'package:pilot_quiz/pages/quiz_noti.dart';
import 'package:pilot_quiz/themes/dark_theme.dart';
import 'package:pilot_quiz/themes/light_theme.dart';
import 'package:flutter/services.dart';

final navigatorKey = GlobalKey<NavigatorState>();
FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await LocalNotifications.init();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

//  handle in terminated state

  var initialNotification =
      await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();

  if (initialNotification?.didNotificationLaunchApp == true) {
    // LocalNotifications.onClickNotification.stream.listen((event) {
    Future.delayed(const Duration(seconds: 1), () {
      // print(event);
      navigatorKey.currentState!.pushNamed('/flash_card_noti',
          arguments: initialNotification?.notificationResponse?.payload);
      LocalNotifications.showScheduleNotification(
          title: "title",
          body: "checkAppLaunch",
          payload: "payload",
          timeDuration: 5);
    });
  }
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((_) => {runApp(const MyApp())});
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  //  to listen to any notification clicked or not
  listenToNotifications() {
    print("Listening to notification");
    LocalNotifications.onClickNotification.stream.listen((event) {
      print(event);
      navigatorKey.currentState!.pushNamed('/quiz_noti', arguments: event);
      LocalNotifications.showScheduleNotification(
          title: "title", body: event, payload: event, timeDuration: 5);
    });
  }

  @override
  void initState() {
    super.initState();
    listenToNotifications();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: navigatorKey,
      title: 'Flutter Demo',
      theme: lightTheme,
      darkTheme: darkTheme,
      routes: {
        '/': (context) => const AuthPage(),
        '/quiz_noti': (context) => const QuizNoti(),
        '/flash_card_noti': (context) => const FlashCardNoti(),
      },
    );
  }
}
