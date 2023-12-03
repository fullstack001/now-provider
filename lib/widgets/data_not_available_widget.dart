import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class DataNotAvailableWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: Align(
        alignment: Alignment.topCenter,
        child: SvgPicture.asset(
          "assets/providerImages/svg/empty state card.svg",
          width: Get.width * 0.9,
        ),
      ),
    );
  }
}

class ChatDataNotAvailableWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: Align(
        alignment: Alignment.topCenter,
        child: SvgPicture.asset(
          "assets/providerImages/svg/chatDataNotAvailable.svg",
          width: Get.width * 0.9,
        ),
      ),
    );
  }
}
