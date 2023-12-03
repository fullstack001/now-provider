// import 'dart:math';
//
// import 'package:awesome_notifications/awesome_notifications.dart';
//
// class AwsomNotificationService {
//   static initializeAwesomeNotification() async {
//     await AwesomeNotifications().initialize(
//       // set the icon to null if you want to use the default app icon
//       'resource://drawable/ic_launcher',
//       [
//         appNotificationChannel(),
//       ],
//     );
//     //requet notifcation permission if not allowed
//     AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
//       if (!isAllowed) {
//         // Insert here your friendly dialog box before call the request method
//         // This is very important to not harm the user experience
//         AwesomeNotifications().requestPermissionToSendNotifications();
//       }
//     });
//   }
//
//   static NotificationChannel appNotificationChannel({
//     channelKey = '10001',
//     channelName = 'Farenow Provider',
//   }) {
//     //firebase fall back channel key
//     //fcm_fallback_notification_channel
//     return NotificationChannel(
//       channelKey: channelKey,
//       channelName: channelName,
//       channelDescription: 'Notification channel for app',
//       importance: NotificationImportance.High,
//       playSound: true,
//     );
//   }
//
//   showNotification(payload) async {
//     AwesomeNotifications().createNotification(
//       content: NotificationContent(
//           id: Random().nextInt(10000),
//           channelKey: "10001",
//           title: payload.title,
//           body: payload.body,
//           icon: "resource://drawable/ic_launcher",
//           notificationLayout: NotificationLayout.Default,
//           payload: Map<String, String>.from(payload.toJson()),
//           displayOnBackground: true,
//           displayOnForeground: true),
//     );
//   }
//
//   listAction() {
//     AwesomeNotifications().actionStream.listen((event) {
//       print("");
//     });
//   }
// }
