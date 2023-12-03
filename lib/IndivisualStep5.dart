import 'package:fare_now_provider/screens/auth_screen/profile_data_steps/steps_appbar.dart';
import 'package:fare_now_provider/screens/auth_screen/profile_data_steps/steps_controller/step_controller.dart';
import 'package:fare_now_provider/screens/auth_screen/zipcode/select_zipcode.dart';
import 'package:fare_now_provider/util/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';

import 'components/buttons-management/enum/button_type.dart';
import 'components/buttons-management/farenow_button.dart';
import 'components/radio_buttons/fare_now_radio_button.dart';
import 'controllers/services_list_controller.dart';

class IndivisualStep5 extends StatefulWidget {
  static const id = "indivisual_step5screen";

  const IndivisualStep5({Key? key}) : super(key: key);

  @override
  State<IndivisualStep5> createState() => _IndivisualStep5State();
}

class _IndivisualStep5State extends State<IndivisualStep5> {
  ServicesListController _servicesListController =
      Get.put(ServicesListController());
  @override
  Widget build(BuildContext context) {
    return GetBuilder<StepsController>(
        init: StepsController(),
        builder: (controller) {
          return Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.white,
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
                      "Step 5 of 6",
                      style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: AppColors.solidBlue),
                    ),
                  ))
                ],
              ),
              body: Column(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  boldHeaderText(),
                  blackProfleText(),
                  ListView(
                    shrinkWrap: true,
                    physics: ScrollPhysics(),
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                getGroupButton(
                                    "Electricity & Computers",
                                    controller.stepFiveButtonIndex == 0
                                        ? true
                                        : false, () {
                                  controller.setStepFiveButtonIndex(0);
                                }),
                                SizedBox(
                                  width: 15,
                                ),
                                getGroupButton(
                                    "Handyman Services",
                                    controller.stepFiveButtonIndex == 1
                                        ? true
                                        : false, () {
                                  controller.setStepFiveButtonIndex(1);
                                }),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                getGroupButton(
                                    "Home Cleaning Services",
                                    controller.stepFiveButtonIndex == 2
                                        ? true
                                        : false, () {
                                  controller.setStepFiveButtonIndex(2);
                                }),
                                SizedBox(
                                  width: 15,
                                ),
                                getGroupButton(
                                    "Moving Services",
                                    controller.stepFiveButtonIndex == 3
                                        ? true
                                        : false, () {
                                  controller.setStepFiveButtonIndex(3);
                                }),
                              ],
                            ),
                          ],
                        ),
                      ),
                      controller.stepFiveButtonIndex == 0
                          ? FarenowRadioButtons(
                              selectedIndex: controller.elctricityIndex,
                              onSelected: (v1, v2, v3) {
                                controller.elctricity.assignAll(v1);
                              },
                              list: controller
                                  .servicesList[controller.stepFiveButtonIndex],
                              isRadio: false,
                            )
                          : Container(),
                      controller.stepFiveButtonIndex == 1
                          ? FarenowRadioButtons(
                              selectedIndex: controller.handymanIndex,
                              onSelected: (v1, v2, v3) {
                                controller.handyman.assignAll(v1);
                                setState(() {});
                              },
                              list: controller
                                  .servicesList[controller.stepFiveButtonIndex],
                              isRadio: false,
                            )
                          : Container(),
                      controller.stepFiveButtonIndex == 2
                          ? FarenowRadioButtons(
                              selectedIndex: controller.homeCleaningIndex,
                              onSelected: (v1, v2, v3) {
                                controller.homeCleaning.assignAll(v1);
                                setState(() {});
                              },
                              list: controller
                                  .servicesList[controller.stepFiveButtonIndex],
                              isRadio: false,
                            )
                          : Container(),
                      controller.stepFiveButtonIndex == 3
                          ? FarenowRadioButtons(
                              selectedIndex: controller.movingIndex,
                              onSelected: (v1, v2, v3) {
                                controller.moving.assignAll(v1);
                                print(controller.moving);
                                setState(() {});
                              },
                              list: controller
                                  .servicesList[controller.stepFiveButtonIndex],
                              isRadio: false,
                            )
                          : Container(),
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
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
                                // Get.to(AddZipcode.new);
                                Get.to(SelectZipcodeScreen.new);
                              },
                              type: BUTTONTYPE.rectangular),
                          FarenowButton(
                              title: "Previous",
                              onPressed: () {
                                controller.previousstepCounter();
                                Get.back();
                                // Get.to(SelectZipcodeScreen.new);
                              },
                              type: BUTTONTYPE.action),
                        ],
                      ),
                    ),
                  ),
                ],
              ));
        });
  }

  Container boldHeaderText() {
    return Container(
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: const Text(
        "Choose service category",
        style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.w700,
            color: AppColors.black,
            letterSpacing: 1),
      ),
    );
  }

  Container blackProfleText() {
    return Container(
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: const Text(
        "What is your line of work?",
        style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: Color(0xff555555)),
      ),
    );
  }

  Flexible getGroupButton(String text, bool selected, Function onTap) {
    return Flexible(
      fit: FlexFit.tight,
      child: AppButton(
        elevation: 0,
        shapeBorder:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        color: selected ? AppColors.solidBlue : Color(0xffE0E0E0),
        onTap: onTap,
        height: 47,
        child: FittedBox(
            child: Text(
          text,
          style: TextStyle(color: selected ? white : black, fontSize: 14),
        )),
      ),
    );
  }
}
