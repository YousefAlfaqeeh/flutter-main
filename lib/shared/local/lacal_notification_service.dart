//
// import 'package:flutter/material.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:udemy_flutter/shared/components/dialog.dart';
// // import 'package:rxdart/subjects.dart';
// // import 'package:timezone/timezone.dart' as tz;
// // import 'package:timezone/data/latest.dart' as tz;
//  String title_firbase = '';
//  String message_firbase = '';
//  bool flag_firbase = false;
// final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin=FlutterLocalNotificationsPlugin();
// Future<void> initNotifications() async
// {
// try {
//   const AndroidInitializationSettings initializationSettingsAndroid = AndroidInitializationSettings(
//       'icon_notif');
//   const DarwinInitializationSettings intializationSettingsIos = DarwinInitializationSettings();
//
//   const InitializationSettings initializationSettings = InitializationSettings(
//     android: initializationSettingsAndroid, iOS: intializationSettingsIos,);
//   await flutterLocalNotificationsPlugin.initialize(initializationSettings);
// }
// catch(e){
//   print("initNotifications"+e.toString());
//
// }
// }
//
// Future<void> mostrarNotification(String title,String body)async
// {
//   try{
//  const DarwinNotificationDetails ios=DarwinNotificationDetails(sound: "new_beeb.mp3");
//
//   const AndroidNotificationDetails androidNotificationDetails=AndroidNotificationDetails('your_channel_id', 'your_channel_ame',
//       sound: RawResourceAndroidNotificationSound("new_beeb"),
//       importance: Importance.max
//
//   );
//   const NotificationDetails darwinNotificationDetails=NotificationDetails(android: androidNotificationDetails,iOS:ios );
//   await flutterLocalNotificationsPlugin.show(1, title, body, darwinNotificationDetails);}
//       catch(e){
//     print("mostrarNotification"+e.toString());
//       }
// }
//
// void setShowNot(String title,String message,bool flag)async
// {title_firbase=title;
// message_firbase=message;
// flag_firbase=flag;
// print("111111111");
//
// }
// Future<bool> getShowNot()async
// {
// return flag_firbase;
//
//
// }