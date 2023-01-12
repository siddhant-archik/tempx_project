// import 'dart:convert';
// import 'dart:io';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// class FirebaseNotificationService {
//   FirebaseNotificationService._internal() {
//     // save the client so that it can be used else where
//     _firebaseMessaging = FirebaseMessaging();
//     // setup listeners
//     firebaseCloudMessagingListeners();
//   }

//   static final FirebaseNotificationService _instance =
//       FirebaseNotificationService._internal();

//   static FirebaseNotificationService get instance {
//     return _instance;
//   }

//   // get the message stream
//   // MessageStream _messageStream = MessageStream.instance;
//   // LogoutStream _logoutStream = LogoutStream.instance;
//   FirebaseMessaging _firebaseMessaging;
//   FlutterLocalNotificationsPlugin fltNotification;
//   // FlutterTts flutterTts = new FlutterTts();
//   int _counter = 0;
//   // final translator = GoogleTranslator();
//   var translation;
//   bool status = false;

//   // getter for firebase messaging client
//   get firebaseMessaging => _firebaseMessaging;

//   Future<String> getToken() async {
//     return await _firebaseMessaging.getToken();
//   }

//   // method for getting the messaging token
//   void sendDeviceToken() {
//     _firebaseMessaging.subscribeToTopic('all');
//     _firebaseMessaging.getToken().then((token) {
//       print("MESSAGING TOKEN: " + token);
//       debugPrint("MESSAGING TOKEN: " + token);
//     });
//   }

//   void initState() {
//     sendDeviceToken();
//     firebaseCloudMessagingListeners();
//     initMessaging();
//     //super.initState();
//   }

//   void initMessaging() {
//     var androiInit =
//         AndroidInitializationSettings('@mipmap/ic_launcher'); //for logo
//     // var iosInit = IOSInitializationSettings();
//     var initSetting = InitializationSettings(
//       android: androiInit,
//     );
//     fltNotification = FlutterLocalNotificationsPlugin();
//     fltNotification.initialize(initSetting);
//     var androidDetails = AndroidNotificationDetails(
//       '1',
//       'channelName',
//     );
//     // var iosDetails = IOSNotificationDetails();
//     var generalNotificationDetails = NotificationDetails(
//       android: androidDetails,
//     );
//   }

//   void firebaseCloudMessagingListeners() {
//     // if (Platform.isIOS) getIOSPermission();

//     _firebaseMessaging.configure(
//       onMessage: (Map<String, dynamic> message) async {
//         try {
//           print("Firebase Meesage: " + message.toString());
//           if (message.containsKey('notification')) {
//             var notification = message['notification'];
//             if (notification["title"] != null && notification["body"] != null) {
//               print("Received Notification: " + notification.toString());
//               // speak(notification.toString());
//               //setState(() => notification = message["notification"]["body"]["data"]);
//               // var ntitle = notification["title"].toString();
//               // var nbody = notification["body"].toString();
//               // if (notification != null) {
//               //   ///Show local notification
//               //   sendNotification(title: ntitle, body: nbody);
//               // }

//             } else {
//               print("Received Notification: " + notification.toString());
//             }
//           }
//         } catch (e) {
//           print(e.toString());
//         }
//         // if (message.containsKey('data') && message['data']['dataType'] == '2') {
//         //   _logoutStream.addMessage(message);
//         // } else {
//         //   // add message to stream
//         //   _messageStream.addMessage(message);
//         // }
//       },
//       onResume: (Map<String, dynamic> message) async {
//         //speak(message['body'].toString());
//         //setState(() => message = message["notification"]["body"]["data"]);
//         debugPrint('on resume $message');
//         try {
//           print("Firebase Meesage: " + message.toString());
//           if (message.containsKey('notification')) {
//             var notification = message['notification'];
//             if (notification["title"] != null && notification["body"] != null) {
//               print("Received Notification: " + notification.toString());
//               // speak(notification.toString());
//               //setState(() => notification = message["notification"]["body"]["data"]);

//             } else {
//               print("Received Notification: " + notification.toString());
//             }
//           }
//         } catch (e) {
//           print(e.toString());
//         }
//         //gotoAlertDetailPage(message);
//       },
//       onLaunch: (Map<String, dynamic> message) async {
//         //speak(message['body'].toString());
//         //setState(() => message = message["notification"]["body"]["data"]);
//         debugPrint('on launch ${message['data']['dataBody']}');
//         try {
//           print("Firebase Meesage: " + message.toString());
//           if (message.containsKey('notification')) {
//             var notification = message['notification'];
//             if (notification["title"] != null && notification["body"] != null) {
//               print("Received Notification: " + notification.toString());
//               // speak(notification.toString());
//               //setState(() => notification = message["notification"]["body"]["data"]);

//             } else {
//               print("Received Notification: " + notification.toString());
//             }
//           }
//         } catch (e) {
//           print(e.toString());
//         }
//         // gotoAlertDetailPage(message);
//       },
//     );
//   }

//   // speak(String text) async {
//   //   //print(await flutterTts.getLanguages);
//   //   await flutterTts.setLanguage("en-US");
//   //   await flutterTts.setVolume(1.0);
//   //   // if(status == true)
//   //   // {
//   //   //   translation = await translator.translate(text, to: 'hi');
//   //   // }
//   //   // else
//   //   // {
//   //   //   translation = await translator.translate(text, to: 'en');
//   //   // }
//   //   await flutterTts.speak(text);
//   //   //await flutterTts.stop();
//   //   print(translation.toString());
//   // }

//   // void getIOSPermission() {
//   //   _firebaseMessaging.requestNotificationPermissions(
//   //       IosNotificationSettings(sound: true, badge: true, alert: true));
//   //   _firebaseMessaging.onIosSettingsRegistered
//   //       .listen((IosNotificationSettings settings) {
//   //     print("Settings registered: $settings");
//   //   });
//   // }

//   void dispose() {
//     sendDeviceToken();
//     firebaseCloudMessagingListeners();
//     dispose();
//   }
// }
