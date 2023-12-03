import 'dart:convert';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../controllers/profile_screen_controller/ProfileScreenController.dart';
import '../main.dart';
import '../models/active_orders_resp/active_orders_data.dart';
import '../models/available_services/available_service_data.dart';
import '../models/notification_response/notification_model.dart';
import '../screens/Controller/HomeScreenController.dart';
import '../screens/chat/chat_screen.dart';
import '../screens/chat/message_controller.dart';
import '../screens/home_pass_button_screen.dart';
import '../screens/signup_or_login_screen.dart';
import '../util/api_utils.dart';
import '../util/shared_reference.dart';

class IoSPushNotificationsService {
  Future initialise() async {
    print("hello");
    FirebaseMessaging.onMessage.listen((event) async {
      print(event);
      String? authToken =
      await SharedRefrence().getString(key: ApiUtills.authToken);
      if ((authToken)?.isEmpty==true) {
        return;
      }
      if (Platform.isIOS) {
        if (event.data["title"] == "Account suspended") {
          print(
              "ACCOUNT SUS LOGGING OUT ${event.data["title"]} ${event.data["body"]}");
          SharedRefrence().clearPrefs(key: ApiUtills.authToken);
          SharedRefrence().clearPrefs(key: ApiUtills.userData);
          SharedRefrence().clearPrefs(key: ApiUtills.firstName);
          SharedRefrence().clearPrefs(key: ApiUtills.image);
          SharedRefrence().clearPrefs(key: ApiUtills.lastName);
          SharedRefrence().clearPrefs(key: "userId");
          Get.clearRouteTree();
          Get.offNamedUntil(SignupOrLoginScreen.id, (route) => false);
        }
      }

      showNotification(event);
    });

    FirebaseMessaging.onMessageOpenedApp.listen((event) {
      clickFunction(event);
    });

    FirebaseMessaging.onBackgroundMessage((event) async {
      NotificationModel model = NotificationModel.fromJson(event.data);
      final prefs = await SharedPreferences.getInstance();
      prefs.setString("test", json.encode(model.toJson()));
      clickFunction(event);
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

    NotificationModel model = NotificationModel();
    model.title = title;
    model.body = body;
    model.serviceRequestId = requestedService;
    model.userId = userId;

    controlData(model);
  }
}

Future<void> showNotification(event) async {
  try {

    if (event.data['type'] == "Status") {
      ProfileScreenController _controller = Get.find();
      _controller.getProfile();
    }

    String title = event.data["title"] == null ? "" : event.data["title"]!;
    String body = event.data["body"] == null ? "" : event.data['body'];
    String requestedService = event.data["service_request_id"] == null
        ? ""
        : event.data['service_request_id'];
    String userId = event.data["user_id"] == null ? "" : event.data['user_id'];

    NotificationModel model = NotificationModel();
    model.title = title;
    model.body = body;
    model.serviceRequestId = requestedService;
    model.userId = userId;

    var payLoad = json.encode(model.toJson());

    // if (GetPlatform.isIOS) {
    //   AwsomNotificationService().showNotification(model);
    //   return;
    // }
    HomeScreenController _homeScreenControlle = Get.find();
    print("${model.show}");
    await _homeScreenControlle.getAvailableJobs();

    final DarwinInitializationSettings initializationSettingsIOS =
        DarwinInitializationSettings(
            requestAlertPermission: false,
            requestBadgePermission: false,
            requestSoundPermission: false,
            onDidReceiveLocalNotification: (
              int id,
              String? title,
              String? body,
              String? payload,
            ) async {
              didReceiveLocalNotificationSubject.add(
                ReceivedNotification(
                  id: id,
                  title: title,
                  body: body,
                  payload: payload,
                ),
              );
            });

    final InitializationSettings initializationSettings =
        InitializationSettings(
      iOS: initializationSettingsIOS,
    );
    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse: (NotificationResponse payload) async {
      var data = json.decode(payload.payload!);
      NotificationModel model = NotificationModel.fromJson(data);
      controlData(model);
    });
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails('0', 'Farenow',
            channelDescription: 'Business app',
            importance: Importance.max,
            priority: Priority.high,
            ticker: 'ticker');

    if (GetPlatform.isIOS) {
      return;
    }

    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);

    await flutterLocalNotificationsPlugin.show(
        0, title, body, platformChannelSpecifics,
        payload: json.encode(model.toJson()));
  } on Exception catch (e) {
    print("$e");
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
      } else if (model.title == "New message received" ||
          model.title == "New Chat Request received") {
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
