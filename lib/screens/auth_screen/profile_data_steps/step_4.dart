import 'package:fare_now_provider/components/radio_buttons/fare_now_radio_button.dart';
import 'package:fare_now_provider/screens/auth_screen/profile_data_steps/steps_appbar.dart';
import 'package:fare_now_provider/screens/auth_screen/profile_data_steps/steps_controller/step_controller.dart';
import 'package:fare_now_provider/util/app_dialog_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../components/buttons-management/enum/button_type.dart';
import '../../../components/buttons-management/farenow_button.dart';
import '../../../controllers/profile_screen_controller/ProfileScreenController.dart';
import '../../../util/app_colors.dart';
import 'business_profile_settings_screen.dart';
import 'profile_settings_screen.dart';

class Step4 extends StatefulWidget {
  const Step4({Key? key}) : super(key: key);
  static const id = "step_4_screen";

  @override
  State<Step4> createState() => _Step4State();
}

class _Step4State extends State<Step4> {
  String selectedService = "";
  late String selectedRole;

  ProfileScreenController _profileScreenController = Get.find();


  @override
  Widget build(BuildContext context) {
    return GetBuilder<StepsController>(
        init: StepsController(),
        builder: (controller) {
          return Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: white,
            appBar: stepsAppBar(4),
            body: Stack(
              children: [
                SingleChildScrollView(
                  child: Column(
                    children: [
                      12.height,
                      businessProfleText(),
                      boldHeaderText(),
                      blackProfleText(),
                      FarenowRadioButtons(
                        onSelected: (v1, v2, v3) {
                          selectedService = v1[0];
                          print(selectedService);
                          _profileScreenController.userData.value.serviceType =
                              selectedService;
                          print("Service-type");

                          print(_profileScreenController
                              .userData.value.serviceType);
                          setState(() {});
                        },
                        list: controller.stepFourlist,
                        isRadio: true,
                      ),
                      150.height,
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: FittedBox(
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 24),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          FarenowButton(
                              title: "Next",
                              onPressed: () {
                                if (selectedService.isNotEmpty) {
                                  if (selectedService
                                      .contains(controller.stepFourlist[0])) {
                                    Navigator.pushNamed(
                                      context,
                                      ProfileSettingsScreen.id,
                                      arguments: true,
                                    );
                                  }
                                } else {
                                  AppDialogUtils.errorDialog("Select Service");
                                }

                                controller.nextstepCounter();
                                // Get.to(Step4.new);
                              },
                              type: BUTTONTYPE.rectangular),
                          FarenowButton(
                              title: "Previous",
                              onPressed: () {
                                controller.previousstepCounter();
                                Get.back();
                              },
                              type: BUTTONTYPE.outline),
                        ],
                      ),
                    ),
                  ),
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
      child: const FittedBox(
        child: Text(
          "Choose Service Type",
          style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w700,
              color: AppColors.black),
        ),
      ),
    );
  }

  Container businessProfleText() {
    return Container(
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: const FittedBox(
        child: Text(
          "Set up your business profile",
          style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: AppColors.solidBlue),
        ),
      ),
    );
  }

  Container blackProfleText() {
    return Container(
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: const FittedBox(
        child: Text(
          "Let’s help you find customers.",
          style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: Color(0xff555555)),
        ),
      ),
    );
  }
}
