import 'package:fare_now_provider/util/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';

import 'steps_controller/step_controller.dart';

AppBar stepsAppBar(int counterValue) {
  return AppBar(
    backgroundColor: white,
    elevation: 1,
    leading: IconButton(
      icon: const Icon(
        Icons.close,
        color: Color(0xff555555),
      ),
      onPressed: () {
        Get.back();
      },
    ),
    actions: [
      Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child: Text(
              "Step ${counterValue} of 7",
              style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: AppColors.solidBlue),
            ),
          ))
    ],
  );
}
