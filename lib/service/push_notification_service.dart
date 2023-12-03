import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';

import '../controllers/profile_screen_controller/ProfileScreenController.dart';
import '../models/active_orders_resp/active_orders_data.dart';
import '../models/available_services/available_service_data.dart';
import '../models/notification_response/notification_model.dart';
import '../screens/Controller/HomeScreenController.dart';
import '../screens/chat/chat_screen.dart';
import '../screens/chat/message_controller.dart';
import '../screens/home_pass_button_screen.dart';
import '../screens/signup_or_login_screen.dart';

class PushNotificationService {
  final FirebaseMessaging _fcm = FirebaseMessaging.instance;
  final BuildContext context;

  PushNotificationService(this.context);

  Future initialise() async {
    // If you want to test the push notification locally,
    // you need to get the token and input to the Firebase console
    // https://console.firebase.google.com/project/YOUR_PROJECT_ID/notification/compose

    final DarwinInitializationSettings initializationSettingsIOS =
        const DarwinInitializationSettings(
      requestSoundPermission: true,
      requestBadgePermission: true,
      requestAlertPermission: true,
    );

    final InitializationSettings initializationSettings =
        InitializationSettings(iOS: initializationSettingsIOS);
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();
    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
    );

    String? token = await _fcm.getToken();
    print("FirebaseMessaging token: $token");

    DarwinNotificationDetails iOSPlatformChannelSpecifics =
        const DarwinNotificationDetails(
      presentAlert: true,
      // Present an alert when the notification is displayed and the application is in the foreground (only from iOS 10 onwards)
      presentBadge: true,
      // Present the badge number when the notification is displayed and the application is in the foreground (only from iOS 10 onwards)
      presentSound: true, // The application's icon badge numbe
    );

    NotificationDetails platformChannelSpecifics =
        NotificationDetails(iOS: iOSPlatformChannelSpecifics);

    FirebaseMessaging.onMessageOpenedApp.listen((event) {
      clickFunction(event);
    });

    FirebaseMessaging.onBackgroundMessage((event) async {
      clickFunction(event);
    });

    FirebaseMessaging.onMessage.listen((event) async {
      print("");
      if (event.data['type'] == "Status") {
        ProfileScreenController _controller = Get.find();
        _controller.getProfile();
        // return;
      }

      String title = event.data["title"] == null ? "" : event.data["title"]!;
      String body = event.data["body"] == null ? "" : event.data['body'];
      String requestedService = event.data["service_request_id"] == null
          ? ""
          : event.data['service_request_id'];
      String userId =
          event.data["user_id"] == null ? "" : event.data['user_id'];
      String type = event.data["type"] == null ? " " : event.data["type"];
      NotificationModel model = NotificationModel();
      model.title = title;
      model.body = body;
      model.serviceRequestId = requestedService;
      model.userId = userId;
      model.type = type;

      var payLoad = json.encode(model.toJson());
      HomeScreenController _homeScreenControlle = Get.find();
      print("${model.show}");
      await _homeScreenControlle.getAvailableJobs();

      await flutterLocalNotificationsPlugin
          .show(0, title, body, platformChannelSpecifics, payload: payLoad);

      await flutterLocalNotificationsPlugin.initialize(initializationSettings,
          onDidReceiveNotificationResponse: (value) async {
        var data = json.decode(value.payload!);
        NotificationModel model = NotificationModel.fromJson(data);
        controlData(model);
      });
    });
  }

  void clickFunction(RemoteMessage event) {
    print("");
    if (event.data['type'] == "Status") {
      ProfileScreenController _controller = Get.find();
      _controller.getProfile();
      return;
    }
    String title = event.data["title"] == null ? "" : event.data["title"]!;
    String body = event.data["body"] == null ? "" : event.data['body'];
    String requestedService = event.data["service_request_id"] == null
        ? ""
        : event.data['service_request_id'];
    String userId = event.data["user_id"] == null ? "" : event.data['user_id'];
    String type = event.data["type"] == null ? " " : event.data["type"];
    NotificationModel model = NotificationModel();
    model.title = title;
    model.body = body;
    model.serviceRequestId = requestedService;
    model.userId = userId;
    model.type = type;

    controlData(model);
  }
}

void controlData(NotificationModel model) {
  HomeScreenController _homeScreenControlle = Get.find();
  MessageController _messages = Get.find();
  print("${model.show}");
  List list = _homeScreenControlle.availableJos.value.availableServiceData;
  for (int index = 0; index < list.length; index++) {
    AvailableServiceData value = list[index];
    if (value.id.toString() == model.serviceRequestId) {
      if (model.title == "New request received") {
        Get.to(() => HomePassButtonScreen(
              datas: value,
            ));
      } else if (model.title == "New message received") {
        launchChatScreen(value, model, _messages);
      }

      break;
    }
  }
}

void launchChatScreen(AvailableServiceData value, NotificationModel model,
    MessageController messages) {
  for (int index = 0; index < messages.messageList.length; index++) {
    print("index");
    ActiveOrdersData valueX = messages.messageList.value[index];
    if (valueX.id.toString() == model.serviceRequestId) {
      var firstName = valueX.provider['first_name'].toString().capitalizeFirst;
      var lastName = valueX.provider['last_name'].toString().capitalizeFirst;
      Get.to(() => ChatScreen(
            senderId: valueX.message.senderId,
            receiverId: valueX.message.receiverId,
            orderId: value.id,
            name: "$firstName $lastName",
          ));
    }
  }
}
