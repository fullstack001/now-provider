import 'package:fare_now_provider/controllers/location_controller/locaction_controller.dart';
import 'package:fare_now_provider/controllers/payment/payment_method_cotnroller.dart';
import 'package:fare_now_provider/controllers/profile_screen_controller/ProfileScreenController.dart';
import 'package:fare_now_provider/controllers/rating_controller.dart';
import 'package:fare_now_provider/controllers/services/service_controller.dart';
import 'package:fare_now_provider/screens/Controller/HomeScreenController.dart';
import 'package:fare_now_provider/screens/ViewBusinessController.dart';
import 'package:fare_now_provider/screens/chat/chatt_controller.dart';
import 'package:fare_now_provider/screens/chat/message_controller.dart';
import 'package:fare_now_provider/screens/wallet_screens/controller/wallet_controller.dart';
import 'package:fare_now_provider/util/api_utils.dart';
import 'package:fare_now_provider/util/shared_reference.dart';
import 'package:get/get.dart';
import 'package:laravel_echo/laravel_echo.dart';

import 'package:socket_io_client/socket_io_client.dart' as IO;

class ControllerInit {
  Future<void> init() async {
    String? authToken =
        await SharedRefrence().getString(key: ApiUtills.authToken);
    // if (authToken.isNotEmpty) {
    print(authToken);
    ProfileScreenController _ = Get.put(ProfileScreenController(flag: true));
    ServiceController _serviceController = Get.put(ServiceController());
    LocationController _locationController = Get.put(LocationController());
    MessageController _messageController = Get.put(MessageController());
    ViewBusinessController controller = Get.put(ViewBusinessController());

    HomeScreenController _homeScreenController =
        Get.put(HomeScreenController());
    PaymentMethodController _methodController =
        Get.put(PaymentMethodController());
    WalletController _walletController = Get.put(WalletController());
    ChatController _chatController = Get.put(ChatController());
    RatingController rating = Get.put(RatingController());
    // }
  }

  Echo socketCall(String event, String signature) {
    IO.Socket socket = IO.io('https://api.farenow.com');
    Echo echo = Echo(client: socket);
    socket.on('connect', (_) {
      print('connected');
    });
    //echo.connect();
    return echo;
  }
}
