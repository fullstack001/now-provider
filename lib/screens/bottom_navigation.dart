// import 'package:fare_now_provider/screens/home_screen.dart';
// import 'package:fare_now_provider/screens/inbox.dart';
import 'dart:convert';

import 'package:fare_now_provider/controllers/profile_screen_controller/ProfileScreenController.dart';
import 'package:fare_now_provider/models/active_orders_resp/active_orders_data.dart';
import 'package:fare_now_provider/models/available_services/available_service_data.dart';
import 'package:fare_now_provider/models/notification_response/notification_model.dart';
import 'package:fare_now_provider/screens/Controller/HomeScreenController.dart';
import 'package:fare_now_provider/screens/chat/chat_screen.dart';
import 'package:fare_now_provider/screens/chat/chatt_controller.dart';
import 'package:fare_now_provider/screens/home_pass_button_screen.dart';
import 'package:fare_now_provider/screens/home_screen.dart';
import 'package:fare_now_provider/screens/inbox.dart';
import 'package:fare_now_provider/screens/notifications_screen.dart';
import 'package:fare_now_provider/screens/profile_screen.dart';
import 'package:fare_now_provider/service/notification_service.dart';
import 'package:fare_now_provider/util/api_utils.dart';
import 'package:fare_now_provider/util/app_colors.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../service/firebase_push_notifications_service.dart';
import '../service/new_firebase_service.dart';
import '../service/push_notification_service.dart';
import 'chat/message_controller.dart';

int selectedIndex = 3;

class BottomNavigation extends StatefulWidget {
  static const String id = 'bottom_navigation';

  static var currentScreen;
  static var currentProfileScreen;
  static final GlobalKey<ScaffoldState> scaffoldKey =
      GlobalKey<ScaffoldState>();
  static Function backToHomePage = () {};
  static Function changeProfileWidget = (Widget widget) {};

  @override
  _BottomNavigationState createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  Color darkGreen = const Color(0xff034f43);
  Color specialWhite = const Color(0xffececf6);
  Color lightGreen = const Color(0xff9be1c4);
  Color specialRed = const Color(0xFFFF506B);
  static const platform = const MethodChannel('flutter.native/helper');
  static const platformIOS =
      const MethodChannel('test.flutter.methodchannel/iOS');
  ProfileScreenController _controller = Get.put(ProfileScreenController());

  int delayTime = 4;

  @override
  void initState() {
    super.initState();
    BottomNavigation.currentProfileScreen = ProfileScreen();
    // print("bottom: ${_controller.userData.value.email}");
    // print("bottom: ${_controller.userData.value.status}");
    BottomNavigation.backToHomePage = () {
      setState(() {
        BottomNavigation.currentScreen = NotificationsScreen();
        selectedIndex = 1;
      });
    };
    BottomNavigation.changeProfileWidget = (Widget widget) {
      setState(() {
        BottomNavigation.currentScreen = widget;
      });
    };
    // if (GetPlatform.isAndroid) {
    // platfromSpecific();
    // }
    if (GetPlatform.isAndroid) {
      platform.setMethodCallHandler(nativeMethodCallHandler);
    } else if (GetPlatform.isIOS) {
      // NewFirebaseService().init();
      IoSPushNotificationsService().initialise();
    }

    iosMethodChannel();
    if (GetPlatform.isIOS) {
      delayTime = 6;
    }
    delayTime.delay().then((value) async {
      final prefs = await SharedPreferences.getInstance();
      var check = prefs.getString("test") ?? "";
      if (check.isNotEmpty) {
        prefs.setString("test", "");
        var data = json.decode(check);
        NotificationModel model = NotificationModel.fromJson(data);
        print("${model.title}");
        controlData(model);
      }
    });
  }

  Future<void> platfromSpecific() async {
    String response = "";
    try {
      final String? result = await platform.invokeMethod('helloFromNativeCode');
      response = result ?? "";
      print(response);
    } on PlatformException catch (e) {
      response = "Failed to Invoke: '${e.message}'.";
    }

    // try {
    //   final int result =
    //       await platform.invokeMethod("flutterToNative", {"text1": "true"});
    //   print("");
    //
    // } on PlatformException catch (e) {
    //   print(e.message);
    // }
  }

  Future<dynamic> nativeMethodCallHandler(MethodCall methodCall) async {
    print('Native call!');
    switch (methodCall.method) {
      case "open_notification":
        {
          if (chatOpen) {
            return;
          }
          String body = methodCall.arguments.toString();
          var jsonObj = json.decode(body);
          NotificationModel model = NotificationModel.fromJson(jsonObj);
          MessageController _messages = Get.put(MessageController());
          // await _messages.getUserList();

          print("pay load " + body);
          // if (body.isNotEmpty) {
          // var data = json.decode(body);
          //
          // model = MessageModel.fromJson(data);
          print("parsed");
          HomeScreenController _homeScreenControlle = Get.find();
           _homeScreenControlle.getAvailableJobs(flag: false);
          WidgetsFlutterBinding.ensureInitialized();

          // if (userOpen != model.senderId) {
          if (model.show) {
            print(ModalRoute.of(context)!.settings.name);
            await NotificationService().init(
                message: model.body,
                event: model,
                flag: false,
                onClick: (value) {
                  print("");
                  var jsonObj = json.decode(value);
                  NotificationModel parseModel =
                      NotificationModel.fromJson(jsonObj);
                  controlData(parseModel);
                  setState(() {});
                });
          } else {
            controlData(model);
          }
          // }
          // }
          break;
        }
    }
  }

  allGood() {
    // if (_controller.userData.value.timeSlots &&
    //     _controller.userData.value.document.isEmpty &&
    //     _controller.userData.value.serviceType != "MOVING" &&
    //     _controller.userData.value.status == "ACTIVE") {
    //   return "";
    // } else if (_controller.userData.value.timeSlots &&
    //     _controller.userData.value.serviceType != "MOVING" &&
    //     _controller.userData.value.status == "ACTIVE") {
    //   return "";
    // } else if (_controller.userData.value.document.isNotEmpty &&
    //     _controller.userData.value.status == "ACTIVE") {
    //   return "";
    // } else if (!_controller.userData.value.timeSlots &&
    //     _controller.userData.value.document.isEmpty &&
    //     _controller.userData.value.status == "ACTIVE") {
    //   return "Time slots and Licence & Documents are missing";
    // } else if (!_controller.userData.value.timeSlots &&
    //     _controller.userData.value.status == "ACTIVE") {
    //   return "Time slots are missing";
    // } else if (_controller.userData.value.document.isEmpty &&
    //     _controller.userData.value.status == "ACTIVE") {
    //   return "Licence & Documents are missing";
    // }
    // if (_controller.userData.value.timeSlots &&
    //     _controller.userData.value.serviceType != "MOVING" &&
    //     _controller.userData.value.status == "ACTIVE") {
    //   return "";
    // } else if (_controller.userData.value.timeSlots &&
    //     _controller.userData.value.serviceType != "MOVING" &&
    //     _controller.userData.value.status == "ACTIVE") {
    //   return "";
    // } else
    if (_controller.userData.value.status != null) {
      if (_controller.userData.value.status == "ACTIVE") {
        return "";
      } else if (_controller.userData.value.schedules != null &&
          _controller.userData.value.status == "ACTIVE") {
        return "Time slots and Licence & Documents are missing";
      } else if (_controller.userData.value.schedules != null &&
          _controller.userData.value.status == "ACTIVE") {
        return "Time slots are missing";
      }
    } else if (_controller.userData.value.docsLicenses == null &&
        _controller.userData.value.status == "ACTIVE") {
      return "Licence & Documents are missing";
    }
    if (_controller.userData.value.status != null) {
      if (_controller.userData.value.status == "ACTIVE") {
        return "";
      } else if (_controller.userData.value.schedules != null &&
          _controller.userData.value.status == "ACTIVE") {
        return "Time slots and Licence & Documents are missing";
      } else if (_controller.userData.value.schedules != null &&
          _controller.userData.value.status == "ACTIVE") {
        return "Time slots are missing";
      }
    } else if (_controller.userData.value.docsLicenses == null &&
        _controller.userData.value.status == "ACTIVE") {
      return "Licence & Documents are missing";
    }
    return "You can't perform any action. Your account is not approved by admin yet";
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
        key: BottomNavigation.scaffoldKey,
        body: getView(
            _controller.userData.value.schedules == null ? false : true),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: selectedIndex,
          backgroundColor: Colors.white,
          selectedItemColor: AppColors.solidBlue,
          unselectedItemColor: Color(0xff555555),
          selectedFontSize: 12,
          unselectedFontSize: 12,
          selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w700),
          unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.w400),
          onTap: (index) {
            if (selectedIndex != index) {
              if (allGood().toString().isNotEmpty) {
                Get.defaultDialog(
                    title: "Alert",
                    content: Text(allGood()),
                    confirm: MaterialButton(
                      onPressed: () {
                        _controller.getProfile();
                        Get.back();
                      },
                      child: const Text("Okay"),
                    ));
              } else if (allGood().toString().isEmpty) {
                debugPrint("SI $selectedIndex");
                debugPrint("I $index");
                debugPrint(allGood());
                outChat = false;
                setState(() {
                  if (index == 0) {
                    outChat = false;
                    BottomNavigation.currentScreen = HomeScreen();
                    selectedIndex = index;
                  }
                  // BottomNavigation.currentScreen = NotificationsScreen();
                  else if (index == 1) {
                    outChat = false;
                    BottomNavigation.currentScreen = NotificationsScreen();
                    selectedIndex = index;
                  } else if (index == 2) {
                    outChat = true;
                    BottomNavigation.currentScreen = const InboxScreen();
                    selectedIndex = index;
                  }
                  // BottomNavigation.currentScreen = InboxScreen();
                  else if (index == 3) {
                    outChat = false;
                    BottomNavigation.currentScreen = ProfileScreen();
                    selectedIndex = index;
                  }
                });
              }
            }
          },
          items: [
            BottomNavigationBarItem(
              label: 'Home',
              tooltip: "Home",
              icon: SvgPicture.asset(
                "assets/providerImages/svg/home_tab.svg",
                color: selectedIndex == 0 ? AppColors.solidBlue : null,
              ),
            ),
            BottomNavigationBarItem(
              label: 'Notifications',
              icon: SvgPicture.asset(
                "assets/providerImages/svg/notification_tab.svg",
                color: selectedIndex == 1 ? AppColors.solidBlue : null,
              ),
            ),
            BottomNavigationBarItem(
              label: 'Messages',
              icon: SvgPicture.asset(
                "assets/providerImages/svg/message_tab.svg",
                color: selectedIndex == 2 ? AppColors.solidBlue : null,
              ),
            ),
            BottomNavigationBarItem(
              label: 'Profile',
              icon: SvgPicture.asset(
                "assets/providerImages/svg/profile_tab.svg",
                color: selectedIndex == 3 ? AppColors.solidBlue : null,
              ),
            ),
          ],
        )));
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
        Get.to(ChatScreen(
          senderId: valueX.message.senderId,
          receiverId: valueX.message.receiverId,
          orderId: value.id,
          name: "$firstName $lastName",
        ));
      }
    }
  }

  getView(bool timeSlots) {
    return BottomNavigation.currentScreen ?? ProfileScreen();
  }

  Future<void> iosMethodChannel() async {
    String _model;
    try {
      // 1
      final String result = await platformIOS.invokeMethod('getDeviceModel');

      // 2
      _model = result;
    } catch (e) {
      // 3
      _model = "Can't fetch the method: '$e'.";
    }
    if (_model.contains("0_0")) {
      var list = _model.split("0_0");
      String title = list[0];
      String body = list[1];
      String requestServiceId = list[2];
      String userId = list[3];

      NotificationModel model = NotificationModel();
      model.title = title;
      model.body = body;
      model.serviceRequestId = requestServiceId;
      model.userId = userId;

      controlData(model);
    }

    print("model $_model");
  }
}
/*
Get.to(ChatScreen(
            senderId: providerId,
            receiverId: userId,
            name: name,
          ));
 */
