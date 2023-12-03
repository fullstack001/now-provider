import 'package:fare_now_provider/components/radio_buttons/fare_now_radio_button.dart';
import 'package:fare_now_provider/models/services_list/provider_sub_services.dart';
import 'package:fare_now_provider/screens/auth_screen/profile_data_steps/steps_appbar.dart';
import 'package:fare_now_provider/screens/auth_screen/profile_data_steps/steps_controller/step_controller.dart';
import 'package:fare_now_provider/screens/auth_screen/zipcode/select_zipcode.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../components/buttons-management/enum/button_type.dart';
import '../../../components/buttons-management/farenow_button.dart';
import '../../../controllers/profile_screen_controller/ProfileScreenController.dart';
import '../../../controllers/services/service_controller.dart';
import '../../../controllers/services_list_controller.dart';
import '../../../models/services_list/user_service_data.dart';
import '../../../models/services_list/user_sub_services.dart';
import '../../../util/app_colors.dart';
import '../../Controller/add_vehicle_controller.dart';
import '../../moving_list_screen.dart';

ServicesListController _servicesListController = Get.find();
ProfileScreenController _profileScreenController = Get.find();

class Step6 extends StatefulWidget {
  Step6({Key? key, this.isIndivisual}) : super(key: key);
  bool? isIndivisual;
  static const id = "step_6_screen";
  @override
  State<Step6> createState() => _Step6State();
}

class _Step6State extends State<Step6> {
  ServiceController _controller = Get.find();

  AddVehicleController _addVehicleController = Get.put(AddVehicleController());
  StepsController _stepsController = Get.put(StepsController());
  List<String> items = [
    'House Cleaning',
    'House Cleaning',
    'Bounce house and party rental'
  ];
  ServicesListController _servicesListController = Get.find();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller.getToken();
    Future.delayed(Duration(seconds: 2)).then((value) {
      _controller.getServiceList();
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _stepsController.movingIndex.clear();
    _stepsController.homeCleaningIndex.clear();
    _stepsController.handymanIndex.clear();
    _stepsController.elctricityIndex.clear();
    _stepsController.selectedSubServices.clear();
    super.dispose();
  }

  String idOfSubservice = "";
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      var data = _controller.zipCode.value;
      List list = _servicesListController.servicesList.value;
      return GetBuilder<StepsController>(
          init: StepsController(),
          builder: (controller) {
            return Scaffold(
              backgroundColor: white,
              appBar: stepsAppBar(6),
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    Stack(
                      children: [
                        ListView(
                          physics: ScrollPhysics(),
                          shrinkWrap: true,
                          children: [
                            // 20.height,
                            // boldHeaderText(),
                            // blackProfleText(),
                            // Padding(
                            //   padding: const EdgeInsets.symmetric(
                            //       horizontal: 24),
                            //   child:   Row(
                            //     children: [
                            //       getGroupButton(
                            //           "Electricity & Computers",
                            //           controller.stepFiveButtonIndex == 0
                            //               ? true
                            //               : false, () {
                            //         controller.setStepFiveButtonIndex(0);
                            //       }),
                            //     ],
                            //   ),),
                            /* Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      SizedBox(width: 24),
                                      getGroupButton(
                                          "Electricity & Computers",
                                          controller.stepFiveButtonIndex ==
                                              0
                                              ? true
                                              : false, () {
                                        print("isIndivisual:${widget
                                            .isIndivisual}");
                                        controller
                                            .setStepFiveButtonIndex(0);
                                        if (widget.isIndivisual ==
                                            true) {
                                          if (controller.selectedSubServices
                                              .isNotEmpty ||
                                              controller.homeCleaningIndex
                                                  .isNotEmpty ||
                                              controller.elctricityIndex
                                                  .isNotEmpty ||
                                              controller.handymanIndex
                                                  .isNotEmpty ||
                                              controller
                                                  .movingIndex.isNotEmpty) {
                                            Get.defaultDialog(
                                                buttonColor: AppColors.white,
                                                barrierDismissible: false,
                                                cancelTextColor:AppColors.solidBlue ,
                                                confirmTextColor:AppColors.solidBlue,
                                                title: "Are you sure?",
                                                middleText:
                                                "Do want to switch service category?",
                                                onConfirm: () {
                                                  controller.elctricityIndex
                                                      .clear();
                                                  controller.handymanIndex
                                                      .clear();
                                                  controller
                                                      .homeCleaningIndex
                                                      .clear();
                                                  controller.movingIndex
                                                      .clear();
                                                  controller
                                                      .selectedSubServices
                                                      .clear();
                                                  // if (controller.elctricityIndex.isNotEmpty) {

                                                  setState(() {});
                                                  // }else{
                                                  //   setState(() {});
                                                  // }
                                                  Get.back();
                                                  // Get.to(()=>Step5());
                                                },
                                                onCancel: () {

                                                  // Navigator.of(Get.overlayContext!).pop();
                                                  Get.back();
                                                  // Get.back(closeOverlays: true);
                                                  // Get.close(1);
                                                  Get.to(() => Step5());
                                                });
                                          }
                                        }
                                      }),
                                      SizedBox(width: 10,),
                                      getGroupButton(
                                          "Handyman Services  ",
                                          controller.stepFiveButtonIndex ==
                                              1
                                              ? true
                                              : false, () {
                                        controller
                                            .setStepFiveButtonIndex(1);
                                        if (widget.isIndivisual ==
                                            true) {
                                          if (controller.selectedSubServices
                                              .isNotEmpty ||
                                              controller.homeCleaningIndex
                                                  .isNotEmpty ||
                                              controller.elctricityIndex
                                                  .isNotEmpty ||
                                              controller.handymanIndex
                                                  .isNotEmpty ||
                                              controller
                                                  .movingIndex.isNotEmpty) {
                                            Get.defaultDialog(
                                                buttonColor: AppColors.white,
                                                barrierDismissible: false,
                                                cancelTextColor:AppColors.solidBlue ,
                                                confirmTextColor:AppColors.solidBlue,
                                                title: "Are you sure?",
                                                middleText:
                                                "Do want to switch service category?",
                                                onConfirm: () {
                                                  controller.elctricityIndex
                                                      .clear();
                                                  controller.handymanIndex
                                                      .clear();
                                                  controller
                                                      .homeCleaningIndex
                                                      .clear();
                                                  controller.movingIndex
                                                      .clear();
                                                  controller
                                                      .selectedSubServices
                                                      .clear();
                                                  // if (controller.handymanIndex.isNotEmpty) {

                                                  setState(() {});
                                                  // }else{
                                                  //   setState(() {});
                                                  // }
                                                  Get.back();
                                                  //  Get.to(()=>Step5());
                                                },
                                                onCancel: () {

                                                  Get.back();
                                                  Get.to(() => Step5());
                                                });
                                          }
                                        }
                                      }),

                                      SizedBox(width: 24),
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [

                                      SizedBox(width: 24),
                                      getGroupButton(
                                          "Home Cleaning Services",
                                          controller.stepFiveButtonIndex ==
                                              2
                                              ? true
                                              : false, () {
                                        controller
                                            .setStepFiveButtonIndex(2);
                                        if (widget.isIndivisual ==
                                            true) {
                                          if (controller.selectedSubServices
                                              .isNotEmpty ||
                                              controller.homeCleaningIndex
                                                  .isNotEmpty ||
                                              controller.elctricityIndex
                                                  .isNotEmpty ||
                                              controller.handymanIndex
                                                  .isNotEmpty ||
                                              controller
                                                  .movingIndex.isNotEmpty) {
                                            Get.defaultDialog(
                                                buttonColor: AppColors.white,
                                                barrierDismissible: false,
                                                cancelTextColor:AppColors.solidBlue ,
                                                confirmTextColor:AppColors.solidBlue,
                                                title: "Are you sure?",
                                                middleText:
                                                "Do want to switch service category?",
                                                onConfirm: () {
                                                  controller.elctricityIndex
                                                      .clear();
                                                  controller.handymanIndex
                                                      .clear();
                                                  controller
                                                      .homeCleaningIndex
                                                      .clear();
                                                  controller.movingIndex
                                                      .clear();
                                                  controller
                                                      .selectedSubServices
                                                      .clear();
                                                  // if (controller.homeCleaningIndex.isNotEmpty) {

                                                  setState(() {});
                                                  // }else{
                                                  //   setState(() {});
                                                  // }
                                                  Get.back();
                                                  //  Get.to(()=>Step5());
                                                },
                                                onCancel: () {

                                                  Get.back();
                                                  Get.to(() => Step5());
                                                });
                                          }
                                        }
                                      }),
                                      SizedBox(width: 10,),
                                      getGroupButton(
                                          "Moving Services   ",
                                          controller.stepFiveButtonIndex ==
                                              3
                                              ? true
                                              : false, () {
                                        controller
                                            .setStepFiveButtonIndex(3);
                                        if (widget.isIndivisual ==
                                            true) {
                                          if (controller.selectedSubServices
                                              .isNotEmpty ||
                                              controller.homeCleaningIndex
                                                  .isNotEmpty ||
                                              controller.elctricityIndex
                                                  .isNotEmpty ||
                                              controller.handymanIndex
                                                  .isNotEmpty ||
                                              controller
                                                  .movingIndex.isNotEmpty) {
                                            Get.defaultDialog(
                                                buttonColor: AppColors.white,
                                                barrierDismissible: false,
                                                cancelTextColor:AppColors.solidBlue ,
                                                confirmTextColor:AppColors.solidBlue,
                                                title: "Are you sure?",
                                                middleText:
                                                "Do want to switch service category?",
                                                onConfirm: () {
                                                  controller.elctricityIndex
                                                      .clear();
                                                  controller.handymanIndex
                                                      .clear();
                                                  controller
                                                      .homeCleaningIndex
                                                      .clear();
                                                  controller.movingIndex
                                                      .clear();
                                                  controller
                                                      .selectedSubServices
                                                      .clear();
                                                  // if (controller.movingIndex.isNotEmpty) {

                                                  setState(() {});
                                                  // }else{
                                                  //   setState(() {});
                                                  // }
                                                  Get.back();
                                                  // Get.to(()=>Step5());
                                                },
                                                onCancel: () {

                                                  Get.back();
                                                  Get.to(() => Step5());
                                                });
                                          }
                                        }
                                      }),
                                      SizedBox(width: 24),
                                    ],
                                  ),
                                ],
                              ),*/
                            //   Wrap(
                            //          spacing: 12,
                            //          runSpacing: 12,
                            //          direction: Axis.horizontal,
                            //          children: List.generate(list.length, (index) {
                            //            return getGroupButton(
                            //                list[index].name,
                            //                controller.stepFiveButtonIndex == index
                            //                    ? true
                            //                    : false, () {
                            //
                            //              controller.elctricity.clear();
                            //              controller.elctricityIndex.clear();
                            //              setSubServiceAndSelected(
                            //                  list[index], controller);
                            //              controller.setStepFiveButtonIndex(index);
                            //            });
                            //          }),
                            //       ),
                            // ),
                            controller.stepFiveButtonIndex == 0
                                ? FarenowRadioButtons(
                                    selectedIndex: controller.elctricityIndex,
                                    onSelected: (v1, v2, v3) {
                                      print("$v1,$v2,$v3");
                                      if (widget.isIndivisual == true) {
                                        controller.selectedSubServices.add(v3);
                                        setState(() {});
                                      } else {
                                        controller.elctricity.assignAll(v1);

                                        setState(() {});
                                      }
                                    },
                                    list: controller.servicesList[
                                        controller.stepFiveButtonIndex],
                                    isRadio: false,
                                  )
                                : Container(),
                            controller.stepFiveButtonIndex == 1
                                ? FarenowRadioButtons(
                                    selectedIndex: controller.handymanIndex,
                                    onSelected: (v1, v2, v3) {
                                      if (widget.isIndivisual == true) {
                                        controller.selectedSubServices.add(v3);
                                        setState(() {});
                                      } else {
                                        controller.handyman.assignAll(v1);
                                        setState(() {});
                                      }
                                    },
                                    list: controller.servicesList[
                                        controller.stepFiveButtonIndex],
                                    isRadio: false,
                                  )
                                : Container(),
                            controller.stepFiveButtonIndex == 2
                                ? FarenowRadioButtons(
                                    selectedIndex: controller.homeCleaningIndex,
                                    onSelected: (v1, v2, v3) {
                                      if (widget.isIndivisual == true) {
                                        controller.selectedSubServices.add(v3);
                                        setState(() {});
                                      } else {
                                        controller.homeCleaning.assignAll(v1);
                                        setState(() {});
                                      }
                                    },
                                    list: controller.servicesList[
                                        controller.stepFiveButtonIndex],
                                    isRadio: false,
                                  )
                                : Container(),
                            controller.stepFiveButtonIndex == 3
                                ? FarenowRadioButtons(
                                    selectedIndex: controller.movingIndex,
                                    onSelected: (v1, v2, v3) {
                                      if (widget.isIndivisual == true) {
                                        controller.selectedSubServices.add(v3);
                                        setState(() {});
                                      } else {
                                        controller.moving.assignAll(v1);
                                        setState(() {});
                                      }
                                    },
                                    list: controller.servicesList[
                                        controller.stepFiveButtonIndex],
                                    isRadio: false,
                                  )
                                : Container(),

                            // controller.stepFiveButtonIndex == 0
                            //     ? FarenowRadioButtons(
                            //         selectedIndex: controller.elctricityIndex,
                            //         onSelected: (v1, v2, v3) {
                            //           print(v1[v3]);
                            //           controller.elctricity.assignAll(v1);
                            //         },
                            //         list: controller.elctricity,
                            //         isRadio: false,
                            //       )
                            //     : Container(),
                            // controller.stepFiveButtonIndex == 1
                            //     ? FarenowRadioButtons(
                            //         selectedIndex: controller.elctricityIndex,
                            //         onSelected: (v1, v2, v3) {
                            //           controller.handyman.assignAll(v1);
                            //           setState(() {});
                            //         },
                            //         list: controller.elctricity,
                            //         isRadio: false,
                            //       )
                            //     : Container(),
                            // controller.stepFiveButtonIndex == 2
                            //     ? FarenowRadioButtons(
                            //         selectedIndex: controller.elctricityIndex,
                            //         onSelected: (v1, v2, v3) {
                            //           controller.homeCleaning.assignAll(v1);
                            //           setState(() {});
                            //         },
                            //         list: controller.elctricity,
                            //         isRadio: false,
                            //       )
                            //     : Container(),
                            // controller.stepFiveButtonIndex == 3
                            //     ? FarenowRadioButtons(
                            //         selectedIndex: controller.elctricityIndex,
                            //         onSelected: (v1, v2, v3) {
                            //           controller.moving.assignAll(v1);
                            //           print(controller.moving);
                            //           setState(() {});
                            //         },
                            //         list: controller.elctricity,
                            //         isRadio: false,
                            //       )
                            //     : Container(),
                          ],
                        ),
                      ],
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 24),
                        child: Container(
                          color: Colors.white,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              FarenowButton(
                                  title: "Next",
                                  onPressed: () {
                                    controller.nextstepCounter();
                                    // Get.to(AddZipcode.new);
                                    // Get.to(SelectZipcodeScreen.new);
                                    print("dsf");
                                    bool movingExist = movingCheck(list);
                                    print("$movingExist");
                                    if (movingExist) {
                                      Get.to(() => MovingListScreen());
                                    } else {
                                      Navigator.pushNamed(
                                          context, SelectZipcodeScreen.id);
                                    }
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
                    ),
                  ],
                ),
              ),
            );
          });
    });
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

  Container boldHeaderText() {
    return Container(
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: const Text(
        "Choose service category",
        style: TextStyle(
            fontSize: 28, fontWeight: FontWeight.w700, color: AppColors.black),
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

  bool movingCheck(List<dynamic> list) {
    for (int index = 0; index < list.length; index++) {
      print("$index");
      if (list[index].name.toString().contains("Moving")) {
        for (int indexI = 0;
            indexI < list[index].userSubServices.length;
            indexI++) {
          for (int indexJ = 0;
              indexJ <
                  list[index]
                      .userSubServices[indexI]
                      .providerSubServices
                      .length;
              indexJ++) {
            if (list[index]
                    .userSubServices[indexI]
                    .providerSubServices[indexJ]
                    .status ==
                1) {
              return true;
            }
          }
        }
      }
    }
    return false;
  }

  setSubServiceAndSelected(
      UserServiceData userServiceData, StepsController stepsController) {
    List<UserSubServices> userSubServices = [];
    List<ProviderSubServices>? providerSubServices = [];
    if (userServiceData.userSubServices!.isNotEmpty) {
      userSubServices.assignAll(userServiceData.userSubServices!);
    }
    if (userSubServices.isNotEmpty) {
      for (var i = 0; i < userSubServices.length; i++) {
        stepsController.elctricity.add(userSubServices[i].name!);
        if (userSubServices[i].providerSubServices!.isNotEmpty) {
          stepsController.elctricityIndex.add(i);
        }
      }
    }
    setState(() {});
    // stepsController.elctricity.assignAll(userSubServices);
    print(userServiceData);
  }
}
