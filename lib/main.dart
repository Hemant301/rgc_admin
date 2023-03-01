import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app_badger/flutter_app_badger.dart';
import 'package:path_provider_android/path_provider_android.dart';
import 'package:path_provider_ios/path_provider_ios.dart';
import 'package:rgc_admin/gest_app_detail.dart';
import 'package:rgc_admin/gest_approval.dart';
import 'package:rgc_admin/login.dart';
import 'package:rgc_admin/notify.dart';
import 'package:rgc_admin/splash.dart';
import 'package:rgc_admin/util/storage.dart';
import 'package:rgc_admin/webview.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await StorageUtil.getInstance();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );
  final RemoteMessage? remoteMessage =
      await FirebaseMessaging.instance.getInitialMessage();
  if (remoteMessage != null) {
    if (remoteMessage.data['notification_type'].toString() == "1") {
      Future.delayed(const Duration(seconds: 1), () {
        Navigator.pushReplacementNamed(
            MyApp.navigatorKey.currentState!.context, '/gest_app_detail',
            arguments: {
              'id': remoteMessage.data['user_id'],
              'name': "",
              'phone': ""
            });
      });
    }
  }
  FirebaseMessaging.onMessage.listen((event) async {
    // {HEADER: head, body: body, message: title, intent-type: HOME, type: TEXT, id: inte}

    print('${event.data}----------------------');
    FlutterAppBadger.updateBadgeCount(1);
    FlutterAppBadger.isAppBadgeSupported()
        .then((value) => print("badge $value"));

    showThisNotification(event.data);
  });
  FirebaseMessaging.instance.subscribeToTopic('news');

  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static final navigatorKey = GlobalKey<NavigatorState>();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        navigatorKey: navigatorKey,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: ('/splash'),
        routes: {
          "/splash": (context) => const SplashScreen(),
          "/login": (context) => const Login(),
          "/webview": (context) => const AdminOfRgc(),
          "/gest_approval": (context) => const GuestApprovel(),
          "/gest_app_detail": (context) => const GestAppDetail(),
        });
  }
}

const AndroidNotificationChannel channel = AndroidNotificationChannel(
  'rgc_admin1', // id
  'rgc_admin', // title
  importance: Importance.max,

  playSound: true,
  sound: RawResourceAndroidNotificationSound('notification'),
);

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  if (Platform.isAndroid) PathProviderAndroid.registerWith();
  if (Platform.isIOS) PathProviderIOS.registerWith();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  print('A bg message just showed up :  ${message.messageId}');

  print(message.data);
  await FirebaseMessaging.instance.subscribeToTopic('news');
  FlutterAppBadger.updateBadgeCount(3);

  showThisNotification(message.data);
}
