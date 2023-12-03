import 'package:fare_now_provider/components/buttons-management/part_of_file/part.dart';
import 'package:fare_now_provider/screens/fare_now_pakages/controller/package_controller.dart';
import 'package:fare_now_provider/screens/fare_now_pakages/create_package.dart';
import 'package:fare_now_provider/screens/fare_now_pakages/models/pacakge_plan_model.dart';
import 'package:fare_now_provider/util/app_colors.dart';
import 'package:fare_now_provider/util/app_dialog_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:carousel_slider/carousel_slider.dart';


class ShowAllPackages extends StatefulWidget {
  const ShowAllPackages({Key? key}) : super(key: key);

  @override
  State<ShowAllPackages> createState() => _ShowAllPackagesState();
}

class _ShowAllPackagesState extends State<ShowAllPackages> {
  CarouselController buttonCarouselController = CarouselController();
  int _current = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffCCCCCC).withOpacity(0.1),
      appBar: AppBar(
        iconTheme: IconTheme.of(context).copyWith(color: black),
        backgroundColor: white,
        elevation: 0,
        title: const Text(
          "Packages",
          style: TextStyle(color: black, fontWeight: FontWeight.w400),
        ),
        actions: [
          Center(
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Get.to(CreatePackage.new);
                  },
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    child: Text(
                      "Add new",
                      style: TextStyle(
                          color: AppColors.solidBlue,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
      body: GetBuilder<PackageController>(
          init: PackageController(),
          builder: (controller) {
            return SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      4.height,
                      Flexible(
                          child: Row(
                        children: [
                          Flexible(
                            child: AppButton(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 24, vertical: 12),
                                onTap: () {
                                  controller.updateIsShow(true);
                                },
                                color: controller.isShow
                                    ? AppColors.solidBlue
                                    : const Color(0xffE0E0E0),
                                shapeBorder: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30)),
                                child: Text(
                                  "Packages",
                                  style: TextStyle(
                                      color: controller.isShow ? white : black,
                                      fontSize: 16),
                                )),
                          ),
                          20.width,
                          Flexible(
                            child: AppButton(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 24, vertical: 12),
                                color: !controller.isShow
                                    ? AppColors.solidBlue
                                    : const Color(0xffE0E0E0),
                                shapeBorder: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30)),
                                onTap: () {
                                  controller.updateIsShow(false);
                                  // Get.to(()=>PackagesSubscribersScreen());
                                },
                                child: Text(
                                  "Subscribers",
                                  style: TextStyle(
                                      color: controller.isShow ? black : white,
                                      fontSize: 16),
                                )),
                          ),
                        ],
                      )),
                      controller.isShow
                          ? SizedBox(
                            //  height: Get.width * 0.2,
                            )
                          : 0.height,
                      controller.isShow
                          ? controller.planListData.isNotEmpty
                              ? CarouselSlider.builder(
                                  itemCount: controller.planListData.length,
                                  itemBuilder: (BuildContext context, int index,
                                      int pageViewIndex) {
                                    Datum data = controller.planListData[index];
                                    return Card(
                                      color: index.isEven
                                          ? AppColors.solidBlue
                                          : Colors.white.withOpacity(0.97),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(18)),
                                      elevation: 4,
                                      child: Stack(
                                        fit: StackFit.loose,
                                        children: [
                                          Positioned(
                                              top: 60,
                                              right: 0,
                                              child: Image.asset(
                                                "assets/subscription icon.png",
                                                fit: BoxFit.cover,
                                                height: 260,
                                              )),
                                          Container(
                                            width: Get.width * 0.85,
                                            // height: Get.width * 0.9,
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 18, vertical: 10),
                                            child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      Card(
                                                        elevation: 5,
                                                        shape: RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        12)),
                                                        child: Container(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(10),
                                                          width: 60,
                                                          height: 60,
                                                          child: SvgPicture.asset(
                                                              "assets/providerImages/svg/preview_package.svg"),
                                                        ),
                                                      ),
                                                      10.width,
                                                      Column(
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            data.title
                                                                .toString(),
                                                            style: TextStyle(
                                                                color: index
                                                                        .isEven
                                                                    ? white
                                                                    : const Color(
                                                                        0xff151415),
                                                                fontSize: 22,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700),
                                                          ),
                                                          Row(
                                                            children: [
                                                              Text(
                                                                  "${data.off}%",
                                                                  style: TextStyle(
                                                                      color: index
                                                                              .isEven
                                                                          ? white
                                                                          : const Color(
                                                                              0xff151415),
                                                                      fontSize:
                                                                          20,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w700)),
                                                              Text(" discount",
                                                                  style: TextStyle(
                                                                      color: index
                                                                              .isEven
                                                                          ? white
                                                                          : const Color(
                                                                              0xff757575),
                                                                      fontSize:
                                                                          16,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w400)),
                                                            ],
                                                          ),
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                  15.height,
                                                  Container(
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: Text(
                                                        "${data.description}",
                                                        style: TextStyle(
                                                            color: index.isEven
                                                                ? white
                                                                : const Color(
                                                                    0xff757575),
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w400)),
                                                  ),
                                                  15.height,
                                                  Column(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Icon(
                                                            Icons.check,
                                                            color: index.isEven
                                                                ? white
                                                                : greenColor,
                                                          ),
                                                          10.width,
                                                          Text(
                                                              "Type: ${data.type}",
                                                              style: TextStyle(
                                                                  color: index
                                                                          .isEven
                                                                      ? white
                                                                      : const Color(
                                                                          0xff757575),
                                                                  fontSize: 16,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400)),
                                                        ],
                                                      ),
                                                      8.height,
                                                      Row(
                                                        children: [
                                                          Icon(
                                                            Icons.check,
                                                            color: index.isEven
                                                                ? white
                                                                : greenColor,
                                                          ),
                                                          10.width,
                                                          Text(
                                                              "Duration: ${data.duration}",
                                                              style: TextStyle(
                                                                  color: index
                                                                          .isEven
                                                                      ? white
                                                                      : const Color(
                                                                          0xff757575),
                                                                  fontSize: 16,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400)),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                  15.height,
                                                ]),
                                          ),
                                          Align(
                                            alignment: Alignment.bottomCenter,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(24.0),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  AppButton(
                                                    elevation: 0,
                                                    shapeBorder:
                                                        RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        12),
                                                            side: BorderSide(
                                                                color: index
                                                                        .isEven
                                                                    ? white
                                                                    : AppColors
                                                                        .solidBlue,
                                                                width: 1)),
                                                    color: index.isEven
                                                        ? AppColors.solidBlue
                                                        : white,
                                                    width: Get.width,
                                                    onTap: () {
                                                      Get.to(
                                                          () => CreatePackage(
                                                                data: data,
                                                                isUpdate: true,
                                                              ));
                                                    },
                                                    child: Text(
                                                      "Edit Package",
                                                      style: TextStyle(
                                                          color: index.isEven
                                                              ? white
                                                              : AppColors
                                                                  .solidBlue,
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    ),
                                                  ),
                                                  10.height,
                                                  AppButton(
                                                    elevation: 0,
                                                    shapeBorder:
                                                        RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        12),
                                                            side: BorderSide
                                                                .none),
                                                    color: index.isEven
                                                        ? white
                                                        : const Color(
                                                            0xffF5F5F5),
                                                    width: Get.width,
                                                    onTap: () {
                                                      controller.deletePackage(
                                                          id: data.id);
                                                    },
                                                    child: const Text(
                                                      "Delete",
                                                      style: TextStyle(
                                                          color: AppColors
                                                              .solidBlue,
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    );
                                  },
                                  carouselController: buttonCarouselController,
                                  options: CarouselOptions(
                                    onPageChanged: (index, reason) {
                                      setState(() {
                                        _current = index;
                                      });
                                    },
                                    height: Get.width,
                                    aspectRatio: 16 / 9,
                                    viewportFraction: 1,
                                    initialPage: 0,
                                    enableInfiniteScroll: false,
                                    reverse: false,
                                    autoPlay: false,
                                    autoPlayInterval:
                                        const Duration(seconds: 3),
                                    autoPlayAnimationDuration:
                                        const Duration(milliseconds: 800),
                                    autoPlayCurve: Curves.fastOutSlowIn,
                                    enlargeCenterPage: true,
                                    scrollDirection: Axis.horizontal,
                                  ))
                              : Container(
                        child: SvgPicture.asset(
                          "assets/providerImages/svg/empty state card.svg",
                          width: Get.width * 0.9,
                        ),
                      )
                          : controller.subscribersList.isNotEmpty
                              ? Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    //  ElevatedButton(onPressed: (){controller.getSubscribersList();}, child: Text("api call")),
                                    packsContainer(
                                        imagePath: "assets/profile-2user.png",
                                        title: "Total Subscribers",
                                        subTitle: controller
                                            .subscribersList.single.data.length,
                                        cornerText: ""),
                                    const SizedBox(
                                      height: 16,
                                    ),
                                    packsContainer(
                                        imagePath: "assets/dollar-circle.png",
                                        title: "Total Payment",
                                        subTitle:
                                            "\$${controller.totalPayement.value.toStringAsFixed(2)}",
                                        cornerText: ""),
                                    const SizedBox(
                                      height: 8,
                                    ),
                                    const Align(
                                      alignment: Alignment.topLeft,
                                      child: Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 25, vertical: 10),
                                          child: Text(
                                            "Subscribers",
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w400,
                                                color: Color(0xff555555)),
                                          )),
                                    ),

                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 12, vertical: 0),
                                      child: Row(
                                        children: [
                                          Flexible(
                                            child: AppButton(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 14,
                                                        vertical: 6),
                                                onTap: () {
                                                  controller
                                                      .updateSubscribersStatus(
                                                          "Active");
                                                },
                                                color: controller
                                                            .subscribersStatus
                                                            .value ==
                                                        "Active"
                                                    ? AppColors.solidBlue
                                                    : const Color(0xffE0E0E0),
                                                shapeBorder:
                                                    RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(30)),
                                                child: Text(
                                                  "Active",
                                                  style: TextStyle(
                                                      color: controller
                                                                  .subscribersStatus
                                                                  .value ==
                                                              "Active"
                                                          ? Colors.white
                                                          : Colors.black,
                                                      fontSize: 12),
                                                )),
                                          ),
                                          20.width,
                                          // Flexible(
                                          //   child: AppButton(
                                          //       padding: EdgeInsets.symmetric(
                                          //           horizontal: 14, vertical: 6),
                                          //       color: controller.subscribersStatus.value=="On-hold"? AppColors.solidBlue:Color(0xffE0E0E0),
                                          //       shapeBorder: RoundedRectangleBorder(
                                          //           borderRadius:
                                          //               BorderRadius.circular(30)),
                                          //       onTap: () {
                                          //         controller.updateSubscribersStatus("On-hold");
                                          //       },
                                          //       child: Text(
                                          //         "On-hold",
                                          //         style: TextStyle(
                                          //             color: controller.subscribersStatus.value=="On-hold"?Colors.white:Colors.black,
                                          //             fontSize: 12),
                                          //       )),
                                          // ),
                                          // 20.width,
                                          Flexible(
                                            child: AppButton(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 12,
                                                        vertical: 6),
                                                color: controller
                                                            .subscribersStatus
                                                            .value ==
                                                        "Cancelled"
                                                    ? AppColors.solidBlue
                                                    : const Color(0xffE0E0E0),
                                                shapeBorder:
                                                    RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(30)),
                                                onTap: () {
                                                  controller
                                                      .updateSubscribersStatus(
                                                          "Cancelled");
                                                },
                                                child: Text(
                                                  "Cancelled",
                                                  style: TextStyle(
                                                      color: controller
                                                                  .subscribersStatus
                                                                  .value ==
                                                              "Cancelled"
                                                          ? Colors.white
                                                          : Colors.black,
                                                      fontSize: 12),
                                                )),
                                          ),
                                        ],
                                      ),
                                    ),

                                    controller.subscribersStatus.value ==
                                            "Active"
                                        ? Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              for (int i = 0;
                                                  i <
                                                      controller.subscribersList
                                                          .single.data.length;
                                                  i++)
                                                controller
                                                            .subscribersList
                                                            .single
                                                            .data[i]
                                                            .status ==
                                                        "ACTIVE"
                                                    ? Column(
                                                        children: [
                                                          Container(
                                                            child:
                                                                subsContainer(
                                                                    onTap: () {
                                                                      // Get.to(()=>PackagesSubscribersScreen(index: i,));
                                                                    },
                                                                    title: "",
                                                                    // controller
                                                                    //     .subscribersList
                                                                    //     .single
                                                                    //     .data[i]
                                                                    //     .serviceRequest
                                                                    //     .subService,
                                                                    subTitle:
                                                                        "${controller.subscribersList.single.data[i].startDate.toString().split(' ').first} - ${controller.subscribersList.single.data[i].endDate.toString().split(' ').first}",
                                                                    userName:
                                                                        "${controller.subscribersList.single.data[i].user.firstName} ${controller.subscribersList.single.data[i].user.lastName}",
                                                                    subscriptionType:
                                                                        "${controller.subscribersList.single.data[i].type}",
                                                                    price: controller.subscribersList.single.data[i].serviceRequest ==
                                                                            null
                                                                        ? ""
                                                                        : "\$${controller.subscribersList.single.data[i].serviceRequest.paidAmount ?? ""}",
                                                                    imagePath:
                                                                        "assets/blueprem.png"),
                                                          ),
                                                          const SizedBox(
                                                            height: 16,
                                                          ),
                                                        ],
                                                      )
                                                    : Container(),
                                            ],
                                          )
                                        //     :controller.subscribersStatus.value=="On-hold"?Column(
                                        //   mainAxisSize: MainAxisSize.min,
                                        //   children: [
                                        //     SizedBox(
                                        //       height: 10,
                                        //     ),
                                        //     for(int i=0;i<controller.subscribersList.single.data.length;i++)
                                        //       controller.subscribersList.single.data[i].status=="ON-HOLD" ?Column(
                                        //         children: [
                                        //           Container(
                                        //             child: subsContainer(
                                        //                 onTap: (){
                                        //                   // Get.to(()=>PackagesSubscribersScreen(index: i,));
                                        //                 },
                                        //                 title: controller.subscribersList.single.data[i].serviceRequest.subService,
                                        //                 subTitle: "${controller.subscribersList.single.data[i].serviceRequest.createdAt.toString().split(' ').first} - ${controller.subscribersList.single.data[i].serviceRequest.isCompleted==1?"Completed":"On Going"}",
                                        //                 userName: "${controller.subscribersList.single.data[i].user.firstName} ${controller.subscribersList.single.data[i].user.lastName}",
                                        //                 subscriptionType: "${controller.subscribersList.single.data[i].type}",
                                        //                 price: "\$${controller.subscribersList.single.data[i].serviceRequest.paidAmount}",
                                        //                 imagePath: "assets/blueprem.png"),
                                        //           ),
                                        //           SizedBox(height: 10,),
                                        //         ],
                                        //       ):Container(),
                                        //   ],
                                        // ):
                                        : controller.subscribersStatus.value ==
                                                "Cancelled"
                                            ? Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                  for (int i = 0;
                                                      i <
                                                          controller
                                                              .subscribersList
                                                              .single
                                                              .data
                                                              .length;
                                                      i++)
                                                    controller
                                                                .subscribersList
                                                                .single
                                                                .data[i]
                                                                .status ==
                                                            "CANCELLED"
                                                        ? Column(
                                                            children: [
                                                              Container(
                                                                child: controller
                                                                            .subscribersList
                                                                            .single
                                                                            .data[
                                                                                i]
                                                                            .serviceRequest1 !=
                                                                        null
                                                                    ? subsContainer(
                                                                        onTap:
                                                                            () {
                                                                          // Get.to(()=>PackagesSubscribersScreen(index: i,));
                                                                        },
                                                                        title: controller.subscribersList.single.data[i].serviceRequest.subService ??
                                                                            "",
                                                                        subTitle:
                                                                            "${controller.subscribersList.single.data[i].serviceRequest.createdAt.toString().split(' ').first} - ${controller.subscribersList.single.data[i].serviceRequest.isCompleted == 1 ? "Completed" : "On Going"}",
                                                                        userName:
                                                                            "${controller.subscribersList.single.data[i].user.firstName} ${controller.subscribersList.single.data[i].user.lastName}",
                                                                        subscriptionType:
                                                                            "${controller.subscribersList.single.data[i].type}",
                                                                        price:
                                                                            "\$${controller.subscribersList.single.data[i].serviceRequest.paidAmount}",
                                                                        imagePath:
                                                                            "assets/blueprem.png")
                                                                    : Container(),
                                                              ),
                                                            ],
                                                          )
                                                        : Container(),
                                                ],
                                              )
                                            : Container()
                                    //   :  Column(
                                    //   children: [
                                    //     Container(
                                    //       child: SvgPicture.asset(
                                    //         "assets/providerImages/svg/empty state card.svg",
                                    //         width: Get.width * 0.9,
                                    //       ),
                                    //     ),
                                    //   ],
                                    // )
                                  ],
                                )
                              : Container(
                                  child: SvgPicture.asset(
                                    "assets/providerImages/svg/empty state card.svg",
                                    width: Get.width * 0.9,
                                  ),
                                ),
                      const SizedBox(
                        height: 20,
                      ),
                      controller.isShow
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: controller.planListData
                                  .asMap()
                                  .entries
                                  .map((entry) {
                                return GestureDetector(
                                  onTap: () => buttonCarouselController
                                      .animateToPage(entry.key),
                                  child: Container(
                                    width: 12.0,
                                    height: 12.0,
                                    margin: const EdgeInsets.symmetric(
                                        vertical: 8.0, horizontal: 4.0),
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: AppColors.solidBlue.withOpacity(
                                            _current == entry.key ? 0.9 : 0.4)),
                                  ),
                                );
                              }).toList()

                              // FarenowButton(
                              //     title: "Publish",
                              //     onPressed: () {},
                              //     type: BUTTONTYPE.rectangular)
                              )
                          : Container()
                    ]),
              ),
            );
          }),
    );
  }

  InkWell subsContainer(
      {title, subTitle, userName, subscriptionType, price, imagePath, onTap}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 120,
        width: Get.width,
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(24))),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
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
                height: 3,
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
              Padding(
                padding: const EdgeInsets.only(right: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Image.asset(
                          "assets/providerImages/png/userPic.png",
                          height: 24,
                          width: 24,
                        ),
                        12.width,
                        Text(
                          userName,
                          style: const TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                              color: Color(0xff151415)),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Image.asset(
                          imagePath,
                          height: 35,
                          width: 35,
                        ),
                        12.width,
                        Column(
                          mainAxisSize: MainAxisSize.min,
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
              )
            ],
          ),
        ),
      ),
    );
  }

  Container packsContainer({imagePath, title, subTitle, cornerText}) {
    return Container(
      height: 88,
      width: Get.width,
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
                mainAxisSize: MainAxisSize.min,
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
                    "${subTitle}",
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
