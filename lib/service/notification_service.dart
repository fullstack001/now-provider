import 'dart:convert';

import 'package:fare_now_provider/models/notification_response/notification_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';

import '../controllers/profile_screen_controller/ProfileScreenController.dart';
import '../models/active_orders_resp/active_orders_data.dart';
import '../models/available_services/available_service_data.dart';
import '../screens/Controller/HomeScreenController.dart';
import '../screens/chat/chat_screen.dart';
import '../screens/chat/message_controller.dart';
import '../screens/home_pass_button_screen.dart';
import '../screens/signup_or_login_screen.dart';
import '../util/api_utils.dart';
import '../util/shared_reference.dart';
import 'awsom_notification_service.dart';

class NotificationService {
  BuildContext? context;
  var onClick;
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  static final NotificationService _notificationService =
      NotificationService._internal();

  factory NotificationService() {
    return _notificationService;
  }

  NotificationService._internal();

  Future<void> init({message, event, flag, var onClick}) async {
    this.onClick = onClick;

    if (event.title == "Account suspended") {
      SharedRefrence().clearPrefs(key: ApiUtills.authToken);
      SharedRefrence().clearPrefs(key: ApiUtills.userData);
      SharedRefrence().clearPrefs(key: ApiUtills.firstName);
      SharedRefrence().clearPrefs(key: ApiUtills.image);
      SharedRefrence().clearPrefs(key: ApiUtills.lastName);
      SharedRefrence().clearPrefs(key: "userId");
      Get.clearRouteTree();
      Get.offNamedUntil(SignupOrLoginScreen.id, (route) => false);
    }
    if (event.type == "Status") {
      ProfileScreenController _controller = Get.find();
      _controller.getProfile();
    }
    notificationDetail(event);
  }

  void notificationDetail(event) async {
    try {
      // String title = event.data["title"] == null ? "" : event.data["title"]!;
      // String body = event.data["body"] == null ? "" : event.data['body'];
      // String requestedService = event.data["service_request_id"] == null
      //     ? ""
      //     : event.data['service_request_id'];
      // String userId =
      //     event.data["user_id"] == null ? "" : event.data['user_id'];
      String title = event.title == null ? "" : event.title!;
      String body = event.body == null ? "" : event.body;
      String requestedService =
          event.serviceRequestId == null ? "" : event.serviceRequestId;
      String userId = event.userId == null ? "" : event.userId;
      String type = event.type == null ? "" : event.type;
      bool show = event.show == null ? false : event.show;

      NotificationModel model = NotificationModel();
      model.title = title;
      model.body = body;
      model.serviceRequestId = requestedService;
      model.userId = userId;
      model.type = type;
      model.show = show;

      // var payLoad = json.encode(model.toJson());

      // if (GetPlatform.isIOS) {
      //   AwsomNotificationService().showNotification(model);
      //   return;
      // }
      if (GetPlatform.isAndroid) {
        showNotification(message: body, path: event);
      }
    } on Exception catch (e) {
      print("$e");
    }
  }

  Future selectNotificationPdf(NotificationResponse payload) async {
    var data = json.decode(payload.payload.toString());
    var token = await SharedRefrence().getString(key: ApiUtills.authToken);

    if (token != "") {
      if (data["title"] == "Account suspended") {
        SharedRefrence().clearPrefs(key: ApiUtills.authToken);
        SharedRefrence().clearPrefs(key: ApiUtills.userData);
        SharedRefrence().clearPrefs(key: ApiUtills.firstName);
        SharedRefrence().clearPrefs(key: ApiUtills.image);
        SharedRefrence().clearPrefs(key: ApiUtills.lastName);
        SharedRefrence().clearPrefs(key: "userId");
        Get.clearRouteTree();
        Get.offNamedUntil(SignupOrLoginScreen.id, (route) => false);
      }
    } else if (data['type'] != null && token != "") {
      if (data['type'] == "Status") {
        ProfileScreenController _controller = Get.find();
        _controller.getProfile();
      }
    } else {
      onClick("${payload.payload}");
    }

    // Navigator.pushNamed(context, 'fileViewer', arguments: payload);
  }

  // "{"body":"Account status changed to suspended","service_request_id":null,"title":"Account suspended","user_id":"1002","type":null,"show":true}"

  Future selectNotificationCSV(String payload) async {
    // Navigator.pushNamed(context, 'csvViewer', arguments: payload);
    // final AndroidIntent intent = AndroidIntent(
    //   action: 'action_view',
    //   data: Uri.encodeFull('https://flutter.io'),
    //   flags: <int>[Flag.FLAG_ACTIVITY_NEW_TASK]
    // );
    // intent.launch();
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
        var firstName =
            valueX.provider['first_name'].toString().capitalizeFirst;
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

  void showNotification({path, message}) async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('ic_app_launcher');

    // const DarwinInitializationSettings initializationSettingsIOS =
    //     DarwinInitializationSettings(
    //   requestSoundPermission: true,
    //   requestBadgePermission: true,
    //   requestAlertPermission: true,
    //   // onDidReceiveLocalNotification: onDidReceiveLocalNotification,
    // );

    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
    );
    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse: selectNotificationPdf);

    AndroidNotificationDetails androidPlatformChannelSpecifics =
        const AndroidNotificationDetails('0', 'Farenow',
            channelDescription: 'Business app',
            importance: Importance.max,
            priority: Priority.high,
            ticker: 'ticker');

    NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse: selectNotificationPdf);
    await flutterLocalNotificationsPlugin.show(
        0, path.title, message, platformChannelSpecifics,
        payload: json.encode(path.toJson()));
  }
}
