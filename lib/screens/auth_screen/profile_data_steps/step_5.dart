import 'package:fare_now_provider/components/radio_buttons/fare_now_radio_button.dart';
import 'package:fare_now_provider/screens/auth_screen/profile_data_steps/step_5.dart';
import 'package:fare_now_provider/screens/auth_screen/profile_data_steps/steps_appbar.dart';
import 'package:fare_now_provider/screens/auth_screen/profile_data_steps/steps_controller/step_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../IndivisualStep5.dart';
import '../../../components/buttons-management/enum/button_type.dart';
import '../../../components/buttons-management/farenow_button.dart';
import '../../../util/app_colors.dart';

class Step5 extends StatefulWidget {
  const Step5({Key? key}) : super(key: key);

  @override
  State<Step5> createState() => _Step5State();
}

class _Step5State extends State<Step5> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<StepsController>(
        init: StepsController(),
        builder: (controller) {
          return Scaffold(
            backgroundColor: white,
            appBar: stepsAppBar(5),
            body: Stack(
              children: [
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 24),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        FarenowButton(
                            title: "Next",
                            onPressed: () {
                              controller.nextstepCounter();
                              Get.to(Step5.new);
                              // Get.to(IndivisualStep5.new);
                            },
                            type: BUTTONTYPE.rectangular),
                        FarenowButton(
                            title: "Previous",
                            onPressed: () {
                              controller.previousstepCounter();
                              Get.back();
                            },
                            type: BUTTONTYPE.action),
                      ],
                    ),
                  ),
                ),
                Column(
                  children: [
                    12.height,
                    businessProfleText(),
                    boldHeaderText(),
                    blackProfleText(),
                    FarenowRadioButtons(
                      onSelected: (v1, v2, v3) {
                        setState(() {});
                      },
                      list: controller.stepFourlist,
                      isRadio: true,
                    )
                  ],
                ),
              ],
            ),
          );
        });
  }

  Container boldHeaderText() {
    return Container(
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: const Text(
        "Choose your role",
        style: TextStyle(
            fontSize: 28, fontWeight: FontWeight.w700, color: AppColors.black),
      ),
    );
  }

  Container businessProfleText() {
    return Container(
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: const Text(
        "Set up your business profile",
        style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: AppColors.solidBlue),
      ),
    );
  }

  Container blackProfleText() {
    return Container(
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: const Text(
        "Let’s help you find customers.",
        style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: Color(0xff555555)),
      ),
    );
  }
}
