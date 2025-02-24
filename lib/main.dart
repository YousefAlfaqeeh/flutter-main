import 'dart:io';


import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
// import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sizer/sizer.dart';
import 'package:udemy_flutter/localizations.dart';
import 'package:udemy_flutter/modules/cubit/blocObserver.dart';
import 'package:udemy_flutter/modules/cubit/cubit.dart';
import 'package:udemy_flutter/modules/cubit/states.dart';
import 'package:udemy_flutter/modules/splash_screen/home_screen.dart';
import 'package:udemy_flutter/shared/local/cache_helper.dart';
import 'package:udemy_flutter/shared/network/remote/dio_helper.dart';



class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}


Future<void>firbaseMessgingBackgroundHandler(RemoteMessage event)async {
    // print("dddddddddd");
    // AppCubit().get_notif ('','');

    if (event.data.isNotEmpty) {
      CacheHelper.saveData(
          key: 'pickup', value: event.data['picked'].toString());
      CacheHelper.saveData(
          key: 'pickup' + event.data['student_id'],
          value: event.data['picked'].toString());
      if(event.data['model_name'].toString()=='chat') {
        CacheHelper.saveData(key: 'new_chat'+event.data['student_id'].toString(), value: true);
      }
    }
    String title = '';
    String message = '';

    title = event.notification!.title.toString();
    message = event.notification!.body.toString();


    // const sou=MethodChannel('somethinguniqueforyou.com/channel_tes');
    // final arg={'id':'1','name':event.notification.title.toString(),"description":event.notification.body.toString()};
    // await sou.invokeMethod('createNotificationChannel',arg);

  // Example: Show a toast message or handle the notification
  // Fluttertoast.showToast(
  //     msg: "Notification: $title - $message",
  //     toastLength: Toast.LENGTH_SHORT,
  //     gravity: ToastGravity.BOTTOM,
  //     timeInSecForIosWeb: 1,
  //     backgroundColor: Colors.grey,
  //     textColor: Colors.black,
  //     fontSize: 16.0
  // );
}

void requestPermission() async {
  var status = await Permission.storage.status;
  if (!status.isGranted) {
    await Permission.storage.request();
  }
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    await CacheHelper.init();
    await FlutterDownloader.initialize();
    await Firebase.initializeApp();
    // FirebaseAnalytics analytics = FirebaseAnalytics.instance;
    // Initialize plugins that may require permissions
    await DioHelper.init();
    await DioHelper1.init();
    await DioHelperChat.init();

    // Request necessary permissions
    await Firebase.initializeApp();
  } catch (e) {
    print('Initialization error: $e');
  }

  // await DioHelper.init();
  // await DioHelper1.init();
  // await CacheHelper.init();
  // // await initNotifications();
  // await FlutterDownloader.initialize();


   // const platform = const MethodChannel('nl.sobit');
  HttpOverrides.global = MyHttpOverrides();

  Bloc.observer = MyBlocObserver();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitUp,
  ]);

  FirebaseMessaging messaging = FirebaseMessaging.instance;

  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );
//   platform.invokeMethod('createChannelGroup', {
//     "groupId": "1234", // id of the group
//     "groupName": "my group name" // name of the group
//   });
//
// // to delete a notificationchannelgroup
//   platform.invokeMethod('deleteChannelGroup', {
//     "groupId": "1234", // id of the group
//   });
//
// // to create a notificationchannel
//   platform.invokeMethod('createChannel', {
//     "id": "abcd", // id of the channel
//     "name": "nl.sobit", // name of the channel
//     "description": "a nice description", // optional description of the channel, could be empty as in ""
//     "sound": "plucky", // name of the sound
//     "groupId": "1234" // id of the notificationchannelgroup created earlier
//   });
//
// // to delete a notificationchannel
// // to delete a notificationchannelgroup
//   platform.invokeMethod('deleteChannel', {
//     "id": "1234", // id of the group
//   });

  var message = await FirebaseMessaging.instance.getInitialMessage();
  // if (message != null) {
  //   print(message.data);
  //   if (message.data.isNotEmpty) {
  //     CacheHelper.saveData(
  //         key: 'pickup', value: message.data['picked'].toString());
  //     CacheHelper.saveData(
  //         key: 'pickup' + message.data['student_id'],
  //         value: message.data['picked'].toString());
  //   }
  // }
  // if (settings.authorizationStatus == AuthorizationStatus.authorized) {
  //   log('User granted permission');
  // } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
  //   log('User granted provisional permission');
  // } else {
  //   log('User declined or has not accepted permission');
  // }
  // FirebaseMessaging.onMessageOpenedApp.listen((event) {
  //   // print("dddddddddd");
  //   // AppCubit().get_notif ('','');
  //   if (event.data.isNotEmpty) {
  //     CacheHelper.saveData(
  //         key: 'pickup', value: event.data['picked'].toString());
  //     CacheHelper.saveData(
  //         key: 'pickup' + event.data['student_id'],
  //         value: event.data['picked'].toString());
  //   }
  //   String title = '';
  //   String message = '';
  //   title = event.notification.title.toString();
  //   message = event.notification.body.toString();
  // });
  var initializtionSettingsAn = await FirebaseMessaging.instance
      .setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );

  // log('User granted permission: ${settings.authorizationStatus}');
  // if (CacheHelper.getBoolean(key: 'authorization') != null) {
  //   BlocProvider(create: (context) => AppCubit()..getChildren());
  // }

  // FirebaseMessaging.onMessage.listen((event) {
  //
  //   if (event.data.isNotEmpty) {
  //     CacheHelper.saveData(
  //         key: 'pickup', value: event.data['picked'].toString());
  //     CacheHelper.saveData(
  //         key: 'pickup' + event.data['student_id'],
  //         value: event.data['picked'].toString());
  //   }
  //
  //   String title = '';
  //   String body = '';
  //   title = event.notification.title.toString();
  //   body = event.notification.body.toString();
  //
  // });
  FirebaseMessaging.onBackgroundMessage(firbaseMessgingBackgroundHandler);
  final DBRef = FirebaseDatabase.instance.ref();
  runApp(Phoenix(child: MyApp()));
}

class MyApp extends StatefulWidget {
  // MyApp({Key key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int i = 0;

  @override
  void initState() {

    super.initState();

  }



  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => AppCubit(),
        child: BlocConsumer<AppCubit, AppStates>(
          listener: (context, state) {},
          builder: (context, state) {
            return Sizer(
                builder: (context, orientation, deviceType) {
                  return  MaterialApp(
                    locale: AppCubit.locale.toString().isEmpty
                        ? Localizations.localeOf(context)
                        : AppCubit.locale,
                    debugShowCheckedModeBanner: false,
                    home: HomeScreen(),
                    localizationsDelegates: [
                      AppLocalizations.delegate,
                      // GlobalMaterialLocalizations.delegate,
                      // GlobalWidgetsLocalizations.delegate
                      GlobalMaterialLocalizations.delegate,
                      GlobalCupertinoLocalizations.delegate, // 추가
                      GlobalWidgetsLocalizations.delegate,
                    ],
                    // locale: _locale,
                    supportedLocales: [
                      Locale("en", ""),
                      Locale("ar", ""),
                    ],
                    localeResolutionCallback: (currentlang, supportlang) {
                      if (currentlang != null) {
                        for (Locale locale in supportlang) {
                          if (locale.languageCode == currentlang.languageCode) {
                            // AppCubit.get(context).setLang();
                            //  getToken();
                            if (CacheHelper.getBoolean(key: 'authorization') ==
                                null) {
                              CacheHelper.saveData(
                                  key: 'lang',
                                  value: currentlang.languageCode.toString());
                            } else {
                              if (i == 0) {
                                i += 1;

                                AppCubit.get(context).getSetting();
                              }
                            }
                            AppCubit.locale = Locale(
                                CacheHelper.getBoolean(key: 'lang').toString());
                            return currentlang;
                          }
                        }
                      }

                      return supportlang.first;
                    },
                  );
                }

            );
          },
        ));
  }
}
