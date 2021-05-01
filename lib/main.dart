import 'package:aunty_rafiki/providers/appointment_provider.dart';
import 'package:aunty_rafiki/providers/auth_provider.dart';
import 'package:aunty_rafiki/providers/baby_bump_provider.dart';
import 'package:aunty_rafiki/providers/blood_level_provider.dart';
import 'package:aunty_rafiki/providers/chat_provider.dart';
import 'package:aunty_rafiki/providers/config_provider.dart';
import 'package:aunty_rafiki/providers/food_provider.dart';
import 'package:aunty_rafiki/providers/group_provider.dart';
import 'package:aunty_rafiki/providers/hospital_bag_provider.dart';
import 'package:aunty_rafiki/providers/mother_provider.dart';
import 'package:aunty_rafiki/providers/post_provider.dart';
import 'package:aunty_rafiki/providers/task_provider.dart';
import 'package:aunty_rafiki/providers/timeline_provider.dart';
import 'package:aunty_rafiki/providers/tracker_provider.dart';
import 'package:aunty_rafiki/providers/user_provider.dart';
import 'package:aunty_rafiki/providers/utility_provider.dart';

import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'App.dart';

// const MethodChannel platform = MethodChannel('aunty-rafiki.qlicue.co.tz');

// /// Define a top-level named handler which background/terminated messages will
// /// call.
// ///
// /// To verify things are working, check out the native platform logs.
// Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
//   // If you're going to use other Firebase services in the background, such as Firestore,
//   // make sure you call `initializeApp` before using other Firebase services.
//   await Firebase.initializeApp();
//   print('Handling a background message ${message.messageId}');
// }

// // /// Create a [AndroidNotificationChannel] for heads up notifications
// AndroidNotificationChannel channel = AndroidNotificationChannel(
//   Platform.isAndroid
//       ? 'com.qlicue.aunty_rafiki'
//       : 'com.qlicue.auntyrafiki', // id
//   'Chat Messages Notifications', // title
//   'This channel is used for chat notifications.', // description
//   importance: Importance.high,
// );

// // /// Initialize the [FlutterLocalNotificationsPlugin] package.
// final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//     FlutterLocalNotificationsPlugin();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  // await _configureLocalTimeZone();

  // // Set the background messaging handler early on, as a named top-level function
  // FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  // /// Create an Android Notification Channel.
  // ///
  // /// We use this channel in the `AndroidManifest.xml` file to override the
  // /// default FCM channel to enable heads up notifications.
  // await flutterLocalNotificationsPlugin
  //     .resolvePlatformSpecificImplementation<
  //         AndroidFlutterLocalNotificationsPlugin>()
  //     ?.createNotificationChannel(channel);

  // /// configure local notification
  // ///
  // ///
  // // final NotificationAppLaunchDetails notificationAppLaunchDetails =
  // //     await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();
  // // String initialRoute = homePage;
  // // if (notificationAppLaunchDetails?.didNotificationLaunchApp ?? false) {

  // //   initialRoute = chatRoomPage;
  // // }

  // const AndroidInitializationSettings initializationSettingsAndroid =
  //     AndroidInitializationSettings('@mipmap/ic_launcher');

  // /// Note: permissions aren't requested here just to demonstrate that can be
  // /// done later
  // final IOSInitializationSettings initializationSettingsIOS =
  //     IOSInitializationSettings(
  //   requestAlertPermission: true,
  //   requestBadgePermission: true,
  //   requestSoundPermission: true,
  // );
  // const MacOSInitializationSettings initializationSettingsMacOS =
  //     MacOSInitializationSettings(
  //         requestAlertPermission: true,
  //         requestBadgePermission: true,
  //         requestSoundPermission: true);
  // final InitializationSettings initializationSettings = InitializationSettings(
  //     android: initializationSettingsAndroid,
  //     iOS: initializationSettingsIOS,
  //     macOS: initializationSettingsMacOS);
  // await flutterLocalNotificationsPlugin.initialize(initializationSettings,
  //     onSelectNotification: (String payload) async {
  //   if (payload != null) {
  //     debugPrint('notification payload: $payload');
  //   }
  // });

  // /// Update the iOS foreground notification presentation options to allow
  // /// heads up notifications.
  // await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
  //   alert: true,
  //   badge: true,
  //   sound: true,
  // );
  // if (FirebaseAuth.instance.currentUser != null) {
  //   FirebaseMessaging.instance.getToken().then((token) {
  //     print('token: $token');
  //     FirebaseFirestore.instance
  //         .collection('users')
  //         .doc(FirebaseAuth.instance.currentUser.uid)
  //         .update({'pushToken': token});
  //   }).catchError((err) {
  //     // Fluttertoast.showToast(msg: err.message.toString());
  //   });
  // }

  // ///

  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => AuthProvider()),
    ChangeNotifierProvider(create: (_) => ChatProvider()),
    ChangeNotifierProvider(create: (_) => UtilityProvider()),
    ChangeNotifierProvider(create: (_) => TaskProvider()),
    ChangeNotifierProvider(create: (_) => AppointmentProvider()),
    ChangeNotifierProvider(create: (_) => BloodLevelProvider()),
    ChangeNotifierProvider(create: (_) => TimelineProvider()),
    ChangeNotifierProvider(create: (_) => BabyBumpProvider()),
    ChangeNotifierProvider(create: (_) => TrackerProvider()),
    ChangeNotifierProvider(create: (_) => UserProvider()),
    ChangeNotifierProvider(create: (_) => GroupProvider()),
    ChangeNotifierProvider(create: (_) => FoodProvider()),
    ChangeNotifierProvider(create: (_) => HostipalBagProvider()),
    ChangeNotifierProvider(create: (_) => ConfigProvider()),
    ChangeNotifierProvider(create: (_) => PostProvider()),
    ChangeNotifierProvider(create: (_) => MotherProvider()),
  ], child: App()));
}

// Future<void> _configureLocalTimeZone() async {
//   tz.initializeTimeZones();
//   final String timeZoneName = await platform.invokeMethod('getTimeZoneName');
//   tz.setLocalLocation(tz.getLocation(timeZoneName));
// }
