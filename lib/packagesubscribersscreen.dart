import 'package:fare_now_provider/components/buttons-management/part_of_file/part.dart';
import 'package:fare_now_provider/screens/fare_now_pakages/controller/package_controller.dart';
import 'package:fare_now_provider/util/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:nb_utils/nb_utils.dart';

import 'components/buttons-management/enum/button_type.dart';
import 'components/buttons-management/farenow_button.dart';
import 'components/buttons-management/style_model.dart';

class PackagesSubscribersScreen extends StatelessWidget {
  PackagesSubscribersScreen({Key? key, this.index}) : super(key: key);
  final index;
  PackageController packageController = Get.put(PackageController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffCCCCCC).withOpacity(0.1),
      appBar: AppBar(
        iconTheme: IconTheme.of(context).copyWith(color: Colors.black),
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          "Packages",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w400),
        ),
      ),
      body: GetBuilder<PackageController>(builder: (controller) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(
              height: 20,
            ),
            Center(
              child: Container(
                height: 370,
                width: 358,
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(24))),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            controller
                                .subscribersList.single.data[index].startDate
                                .toString()
                                .split(' ')
                                .first,
                            style: const TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 16,
                                color: Color(0xff0068E1)),
                          ),
                          Text(
                            "\$${controller.subscribersList.single.data[index].serviceRequest.paidAmount}",
                            style: const TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 16,
                                color: Color(0xff151415)),
                          ),
                        ],
                      ),
                      const Divider(
                        thickness: 1,
                        color: Color(0xffE0E0E0),
                      ),
                      Text(
                        "${controller.subscribersList.single.data[index].serviceRequest.subService}",
                        style: const TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 16,
                            color: Color(0xff151415)),
                      ),
                      Text(
                        "${controller.subscribersList.single.data[index].startDate.toString().split(' ').first} - ${controller.subscribersList.single.data[index].endDate.toString().split(' ').first}",
                        style: const TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 12,
                            color: Color(0xff757575)),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Image.asset("assets/master card.png"),
                          const SizedBox(
                            width: 20,
                          ),
                          Text(
                            "**** **** **** ${controller.subscribersList.single.data[index].user.cardLastFour ?? "3456"}",
                            style: const TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 14,
                                color: Color(0xff151415)),
                          ),
                        ],
                      ),
                      const Divider(
                        thickness: 1,
                        color: Color(0xffE0E0E0),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Text(
                            "Subscriber:",
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                                color: Color(0xff757575)),
                          ),
                          const SizedBox(
                            width: 50,
                          ),
                          Image.asset(
                            "assets/providerImages/png/userPic.png",
                            height: 24,
                            width: 24,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            "${controller.subscribersList.single.data[index].user.firstName} ${controller.subscribersList.single.data[index].user.lastName}",
                            style: const TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                                color: Color(0xff151415)),
                          ),
                        ],
                      ),
                      const Divider(
                        thickness: 1,
                        color: Color(0xffE0E0E0),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Text(
                            "Plan:",
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                                color: Color(0xff757575)),
                          ),
                          const SizedBox(
                            width: 85,
                          ),
                          Image.asset(
                            "assets/blueprem.png",
                            height: 35,
                            width: 35,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Column(
                            children: [
                              Text(
                                "${controller.subscribersList.single.data[index].type}",
                                style: const TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14,
                                    color: Color(0xff151415)),
                              ),
                              Text(
                                "\$${controller.subscribersList.single.data[index].serviceRequest.paidAmount}",
                                style: const TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 12,
                                    color: Color(0xff757575)),
                              ),
                            ],
                          )
                        ],
                      ),
                      const Divider(
                        thickness: 1,
                        color: Color(0xffE0E0E0),
                      ),
                      const Text(
                        "Next billing date",
                        style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 16,
                            color: Color(0xff151415)),
                      ),
                      Text(
                        controller.subscribersList.single.data[index]
                            .subscriptionHistories[0].deductionDate
                            .toString()
                            .split(' ')
                            .first,
                        style: const TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 12,
                            color: Color(0xff757575)),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      GetBuilder<PackageController>(
                          init: PackageController(),
                          builder: (controller) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                SizedBox(
                                  width: 175,
                                  height: 75,
                                  child: FarenowButton(
                                      title: controller.isPaused
                                          ? "Re-activate"
                                          : "Pause",
                                      onPressed: () {
                                        print(controller.isPaused);
                                        print(!controller.isPaused);
                                        packageController.updateIsPaused(
                                            !controller.isPaused);
                                        controller.isPaused
                                            ? Get.dialog(Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Card(
                                                    color: Colors.white,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        55)),
                                                    child: Container(
                                                      width: Get.width * 0.8,
                                                      height: Get.width * 0.6,
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          horizontal: 24,
                                                          vertical: 24),
                                                      child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceEvenly,
                                                          children: [
                                                            Container(
                                                              child: const Text(
                                                                "Pause Package",
                                                                style: TextStyle(
                                                                    color: AppColors
                                                                        .solidBlue,
                                                                    fontSize:
                                                                        24,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500),
                                                              ),
                                                            ),
                                                            12.height,
                                                            Container(
                                                              child: const Text(
                                                                "This action will set user subscription package on hold. Click confirm to complete action.",
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                style: TextStyle(
                                                                    color: Color(
                                                                        0xff555555),
                                                                    fontSize:
                                                                        16,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400),
                                                              ),
                                                            ),
                                                            12.height,
                                                            Row(
                                                              children: [
                                                                Flexible(
                                                                    child:
                                                                        FarenowButton(
                                                                  style: FarenowButtonStyleModel(
                                                                      padding: const EdgeInsets
                                                                              .symmetric(
                                                                          horizontal:
                                                                              6)),
                                                                  title:
                                                                      "Cancel",
                                                                  onPressed:
                                                                      () {
                                                                    Get.back();
                                                                  },
                                                                  type: BUTTONTYPE
                                                                      .action,
                                                                )),
                                                                Flexible(
                                                                    child:
                                                                        FarenowButton(
                                                                  style: FarenowButtonStyleModel(
                                                                      padding: const EdgeInsets
                                                                              .symmetric(
                                                                          horizontal:
                                                                              6)),
                                                                  title:
                                                                      "Confirm",
                                                                  onPressed:
                                                                      () {},
                                                                  type: BUTTONTYPE
                                                                      .rectangular,
                                                                )),
                                                              ],
                                                            )
                                                          ]),
                                                    ),
                                                  )
                                                ],
                                              ))
                                            : null;
                                      },
                                      type: BUTTONTYPE.outline),
                                ),
                                SizedBox(
                                  width: 150,
                                  height: 75,
                                  child: FarenowButton(
                                      title: "Cancel",
                                      onPressed: () {
                                        Get.dialog(Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Card(
                                              color: Colors.white,
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          55)),
                                              child: Container(
                                                width: Get.width * 0.8,
                                                height: Get.width * 0.6,
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 24,
                                                        vertical: 24),
                                                child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceEvenly,
                                                    children: [
                                                      Container(
                                                        child: const Text(
                                                          "Cancel Package",
                                                          style: TextStyle(
                                                              color: AppColors
                                                                  .solidBlue,
                                                              fontSize: 24,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                        ),
                                                      ),
                                                      12.height,
                                                      Container(
                                                        child: const Text(
                                                          "This action will remove your subscription package from providers list. Click confirm to complete action.",
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: TextStyle(
                                                              color: Color(
                                                                  0xff555555),
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400),
                                                        ),
                                                      ),
                                                      12.height,
                                                      Row(
                                                        children: [
                                                          Flexible(
                                                              child:
                                                                  FarenowButton(
                                                            style: FarenowButtonStyleModel(
                                                                padding: const EdgeInsets
                                                                        .symmetric(
                                                                    horizontal:
                                                                        6)),
                                                            title: "Cancel",
                                                            onPressed: () {
                                                              Get.back();
                                                            },
                                                            type: BUTTONTYPE
                                                                .action,
                                                          )),
                                                          Flexible(
                                                              child:
                                                                  FarenowButton(
                                                            style: FarenowButtonStyleModel(
                                                                padding: const EdgeInsets
                                                                        .symmetric(
                                                                    horizontal:
                                                                        6)),
                                                            title: "Confirm",
                                                            onPressed: () {},
                                                            type: BUTTONTYPE
                                                                .rectangular,
                                                          )),
                                                        ],
                                                      )
                                                    ]),
                                              ),
                                            )
                                          ],
                                        ));
                                      },
                                      type: BUTTONTYPE.rectangular),
                                )
                              ],
                            );
                          })
                    ],
                  ),
                ),
              ),
            )
          ],
        );
      }),
    );
  }

  Container subsContainer(
      {title, subTitle, userName, subscriptionType, price, imagePath}) {
    return Container(
      height: 114,
      width: 327,
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(24))),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                  color: Color(0xff151415)),
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              subTitle,
              style: const TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 12,
                  color: Color(0xff757575)),
            ),
            const Divider(
              thickness: 1,
              color: Color(0xffE0E0E0),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Image.asset(
                  "assets/providerImages/png/userPic.png",
                  height: 24,
                  width: 24,
                ),
                Text(
                  userName,
                  style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                      color: Color(0xff151415)),
                ),
                Image.asset(
                  imagePath,
                  height: 35,
                  width: 35,
                ),
                Column(
                  children: [
                    Text(
                      subscriptionType,
                      style: const TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                          color: Color(0xff151415)),
                    ),
                    Text(
                      price,
                      style: const TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 12,
                          color: Color(0xff757575)),
                    ),
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Container packsContainer({imagePath, title, subTitle, cornerText}) {
    return Container(
      height: 88,
      width: 327,
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(24))),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              height: 56,
              width: 56,
              decoration: const BoxDecoration(
                  color: Color(0xffE0E0E0),
                  borderRadius: BorderRadius.all(Radius.circular(16))),
              child: Image.asset(imagePath),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 12,
                        color: Color(0xff757575)),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    subTitle,
                    style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 20,
                        color: Color(0xff151415)),
                  ),
                ],
              ),
            ),
            const SizedBox(
              width: 80,
            ),
            Text(
              cornerText,
              style: const TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                  color: Color(0xff00B181)),
            ),
          ],
        ),
      ),
    );
  }
}
