// ignore_for_file: require_trailing_commas

import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:rgc_admin/util/userCred.dart';

import '../main.dart';

/// Manages & returns the users FCM token.
///
/// Also monitors token refreshes and updates state.
class TokenMonitor extends StatefulWidget {
  // ignore: public_member_api_docs

  @override
  State<StatefulWidget> createState() => _TokenMonitor();
}

class _TokenMonitor extends State<TokenMonitor> {
  final String _token = ' ';
  Stream<String>? _tokenStream;

  void setToken(String token) {
    print('FCM Token: $token');
    setTokenApi(token);
  }

  Future<dynamic> setTokenApi(String tokenkey) async {
    var client = http.Client();
    try {
      final body = {"user_id": userCred.getUserId(), "token": tokenkey};
      log(body.toString());
      final response = await client.post(
          Uri.parse(
              "https://cms.cybertize.in/notificationServiceHandler/panel/register-token-api.php"),
          // Uri.parse(
          //     "https://cms.cybertize.in/notificationServiceHandler/register-token.php"),

          body: (body));
      if (response.statusCode == 200) {
        print(response.body);
        return jsonDecode(response.body);
      } else {
        print('Request failed with status: ${response.statusCode}.');
      }
    } catch (e) {
      print(e);
    } finally {
      client.close();
    }
  }

  @override
  void initState() {
    super.initState();
    print('FCM============================================================');
    FirebaseMessaging.instance
        .getToken(
            vapidKey:
                'BJCOx9vfEVwIz17omHSAIzBvJmsxibVAABC3PY72ErPbt9wJNA631kb5T4arpfpbKm1o9QZcT_uPw-b6G_z65kM')
        .then((token) {
      setToken(token ?? ' ');
    });
    // _tokenStream = FirebaseMessaging.instance.onTokenRefresh;
    // _tokenStream.listen(setToken);
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

Future<String> _downloadAndSaveFile(String url, String fileName) async {
  final Directory directory = await getApplicationDocumentsDirectory();
  final String filePath = '${directory.path}/$fileName';
  final http.Response response = await http.get(Uri.parse(url));
  final File file = File(filePath);
  await file.writeAsBytes(response.bodyBytes);
  return filePath;
}

// Future<void> _showNotification({String body = '', String title = ''}) async {
//   const AndroidInitializationSettings initializationSettingsAndroid =
//       AndroidInitializationSettings('@mipmap/ic_launcher');

//   /// Note: permissions aren't requested here just to demonstrate that can be
//   /// done later
//   final IOSInitializationSettings initializationSettingsIOS =
//       IOSInitializationSettings(
//           requestAlertPermission: true,
//           requestBadgePermission: true,
//           requestSoundPermission: true,
//           onDidReceiveLocalNotification: (
//             int id,
//             String? title,
//             String? body,
//             String? payload,
//           ) async {
//             // didReceiveLocalNotificationSubject.add(
//             //   ReceivedNotification(
//             //     id: id,
//             //     title: title,
//             //     body: body,
//             //     payload: payload,
//             //   ),
//             // );
//           });
//   const MacOSInitializationSettings initializationSettingsMacOS =
//       MacOSInitializationSettings(
//     requestAlertPermission: false,
//     requestBadgePermission: false,
//     requestSoundPermission: false,
//   );

//   final InitializationSettings initializationSettings = InitializationSettings(
//     android: initializationSettingsAndroid,
//     iOS: initializationSettingsIOS,
//     macOS: initializationSettingsMacOS,
//   );

//   await flutterLocalNotificationsPlugin.initialize(initializationSettings,
//       onSelectNotification: (String? payload) async {
//     try {
//       final NotificationAppLaunchDetails? notificationAppLaunchDetails =
//           await flutterLocalNotificationsPlugin
//               .getNotificationAppLaunchDetails();
//       String? payload = notificationAppLaunchDetails!.payload;
//       // await Fluttertoast.showToast(msg: payload.toString());

//       await Navigator.pushNamed(
//           MyApp.navigatorKey.currentState!.context, '/notificationpage',
//           arguments: {'allorder': true});
//     } catch (e) {
//       print(e.toString());
//     }
//     if (payload != null) {
//       debugPrint('notification payload: $payload');
//     }
//   });
//   const AndroidNotificationDetails androidPlatformChannelSpecifics =
//       AndroidNotificationDetails(
//     'rgc_admin1',
//     'rgc_admin',
//     importance: Importance.max,
//     priority: Priority.max,
//     playSound: true,
//     enableLights: true,
//     enableVibration: true,
//     // sound: RawResourceAndroidNotificationSound('notification'),
//   );
//   const NotificationDetails platformChannelSpecifics =
//       NotificationDetails(android: androidPlatformChannelSpecifics);
//   await flutterLocalNotificationsPlugin
//       .show(0, title, body, platformChannelSpecifics, payload: 'item x');
// }

showThisNotification(data) {
  print(data);
  print('-----------------here--------------------');
  String link = '/';
  // if (data['intent-type'] == 'PRODUCT') {
  //   link = '/product/detail';
  // } else if (data['intent-type'] == 'CHILD') {
  //   link = '/product';
  // } else {
  //   link = '/';
  // }
  //{HEADER: d, body: d, message: nwdj, intent-type: HOME, type: IMAGE, id: d, image: https://cityindia.in/gcm-media/16298763432019260076emptycart.png}

  showBigPictureNotification(
      data: data,
      body: data['body'] ?? ' ',
      image: data['image'] ?? ' ',
      title: data['title'] ?? ' ',
      link: link);

  //else {
  //   _showNotification(
  //       body: data['body'] ?? ' ',
  //       title: data['message'] ?? ' ',
  //       link: link,
  //       args: data['id'] ?? ' ');
  // }
}

Future<void> showBigPictureNotification(
    {Map? data,
    String body = '',
    String title = '',
    String image = '',
    String link = '',
    String args = ''}) async {
  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher');

  /// Note: permissions aren't requested here just to demonstrate that can be
  /// done later
  final IOSInitializationSettings initializationSettingsIOS =
      IOSInitializationSettings(
          requestAlertPermission: true,
          requestBadgePermission: true,
          requestSoundPermission: true,
          onDidReceiveLocalNotification: (
            int id,
            String? title,
            String? body,
            String? payload,
          ) async {
            // didReceiveLocalNotificationSubject.add(
            //   ReceivedNotification(
            //     id: id,
            //     title: title,
            //     body: body,
            //     payload: payload,
            //   ),
            // );
          });

  const iOSPlatformChannel = IOSNotificationDetails(
    sound: 'notification_sound.aiff',
    presentAlert: true,
    presentBadge: true,
    presentSound: true,
  );

  const MacOSInitializationSettings initializationSettingsMacOS =
      MacOSInitializationSettings(
    requestAlertPermission: false,
    requestBadgePermission: false,
    requestSoundPermission: false,
  );

  final InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
    iOS: initializationSettingsIOS,
    macOS: initializationSettingsMacOS,
  );

  await flutterLocalNotificationsPlugin.initialize(initializationSettings,
      onSelectNotification: (String? payload) async {
    try {
      final NotificationAppLaunchDetails? notificationAppLaunchDetails =
          await flutterLocalNotificationsPlugin
              .getNotificationAppLaunchDetails();
      String? payload = notificationAppLaunchDetails!.payload;

      // await Fluttertoast.showToast(msg: data.toString());

      if (data!['notification_type'].toString() == "1") {
        Future.delayed(const Duration(seconds: 1), () {
          Navigator.pushNamed(
              MyApp.navigatorKey.currentState!.context, '/gest_app_detail',
              arguments: {'id': data['user_id'], 'name': "", 'phone': ""});
        });
      }
    } catch (e) {
      print(e.toString());
    }
    if (payload != null) {
      debugPrint('notification payload: $payload');
    }
  });
  final String largeIconPath = await _downloadAndSaveFile(
      'https://cybertizeweb.com/cms//panel/assets/images/rgclogo.jpg',
      'largeIcon');
  print(image);
  final String bigPicturePath = await _downloadAndSaveFile(image, 'bigPicture');
  final BigPictureStyleInformation bigPictureStyleInformation =
      BigPictureStyleInformation(FilePathAndroidBitmap(bigPicturePath),
          largeIcon: FilePathAndroidBitmap(largeIconPath),
          contentTitle: '$title ',
          htmlFormatContentTitle: true,
          summaryText: '$body ',
          htmlFormatSummaryText: true);
  final AndroidNotificationDetails androidPlatformChannelSpecifics =
      AndroidNotificationDetails('rgc_admin1', 'rgc_admin',
          importance: Importance.max,
          priority: Priority.high,
          playSound: true,
          enableLights: true,
          enableVibration: true,
          sound: const RawResourceAndroidNotificationSound('notification'),
          styleInformation: bigPictureStyleInformation);

  final NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics, iOS: iOSPlatformChannel);
  await flutterLocalNotificationsPlugin
      .show(0, title, body, platformChannelSpecifics, payload: data.toString());

  FirebaseMessaging.onMessageOpenedApp.listen((event) async {
    try {
      if (event.data['notification_type'].toString() == "1") {
        Future.delayed(const Duration(seconds: 1), () {
          Navigator.pushNamed(
              MyApp.navigatorKey.currentState!.context, '/gest_app_detail',
              arguments: {
                'id': event.data['user_id'],
                'name': "",
                'phone': ""
              });
        });
      }
    } catch (e) {
      log(e.toString());
    }
  });
  // FirebaseMessaging.instance
  //     .getInitialMessage()
  //     .then((RemoteMessage? value) async {
  //   Fluttertoast.showToast(msg: "from ternimated");
  //   await Navigator.pushNamed(
  //       MyApp.navigatorKey.currentState!.context, '/notificationpage',
  //       arguments: {'allorder': true});
  // });
}
