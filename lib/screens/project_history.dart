import 'dart:convert';

import 'package:fare_now_provider/components/buttons-management/part_of_file/part.dart';
import 'package:fare_now_provider/components/buttons-management/style_model.dart';
import 'package:fare_now_provider/models/available_services/available_service_data.dart';
import 'package:fare_now_provider/screens/Controller/HomeScreenController.dart';
import 'package:fare_now_provider/screens/home_pass_button_screen.dart';
import 'package:fare_now_provider/screens/plumberprofileView.dart';
import 'package:fare_now_provider/util/app_colors.dart';
import 'package:fare_now_provider/util/date_time_utills.dart';
import 'package:fare_now_provider/util/widgest_utills.dart';
import 'package:fare_now_provider/widgets/data_not_available_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:nb_utils/nb_utils.dart';

import '../util/api_utils.dart';
import '../util/home_widgets.dart';

class ProjectHistory extends StatefulWidget {
  ProjectHistory({Key? key}) : super(key: key);

  @override
  _ProjectHistoryState createState() => _ProjectHistoryState();
}

class _ProjectHistoryState extends State<ProjectHistory> {
  HomeScreenController _homeScreenController = Get.find();

  bool pending = false;
  List paid = [];
  List pendingList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    for (int index = 0;
    index <
        _homeScreenController
            .availableJos.value.availableServiceData.length;
    index++) {
      AvailableServiceData value =
      _homeScreenController.availableJos.value.availableServiceData[index];
      if ((value.workedHours) != null &&
          (value.type ?? "").toString().toLowerCase() != "moving_request") {
        if (value.paidAmount != null) {
          if (checkPayable(value)) {
            pendingList.add(value);
          } else {
            paid.add(value);
          }
        }
      }
      // else if ((value.type ?? "").toString().toLowerCase() ==
      //         "moving_request" &&
      //     value.workingStatus.toString().toLowerCase() == "ended") {
      //   paid.add(value);
      // }
    }
    pendingList = _homeScreenController.requested.value;
    paid = _homeScreenController.complete.value;
  }

  bool checkPayable(AvailableServiceData data) {
    int hours = int.parse(data.hours.toString());
    int workedHours = int.parse((data.workedHours ?? "1").toString());
    int result = hours - workedHours;
    bool has = result < 0 ? true : false;
    return has;
  }

  @override
  Widget build(BuildContext context) {
    // paid.clear();
    // pendingList.clear();
    // print(paid[0]);
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        elevation: 1,
        centerTitle: false,
        iconTheme: IconTheme.of(context).copyWith(color: black),
        backgroundColor: Colors.white,
        title: const Text(
          "Service History",
          style: TextStyle(
              color: Color(0xff555555),
              fontSize: 18,
              fontWeight: FontWeight.w500),
        ),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 24,
          ),
          Row(
            children: [
              15.width,
              Flexible(
                  child: AppButton(
                    elevation: 0,
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    onTap: () {
                      if (pending) {
                        pending = false;
                      }
                      setState(() {});
                    },
                    color: !pending ? AppColors.solidBlue : Color(0xffE0E0E0),
                    text: "Paid",
                    textStyle: TextStyle(
                        color: !pending ? white : black,
                        fontSize: 16,
                        fontWeight: FontWeight.w400),
                    shapeBorder: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)),
                  )),
              15.width,
              Flexible(
                  child: AppButton(
                    elevation: 0,
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    onTap: () {
                      if (!pending) {
                        pending = true;
                      }
                      setState(() {});
                    },
                    text: "Pending",
                    color: pending ? AppColors.solidBlue : Color(0xffE0E0E0),
                    textStyle: TextStyle(
                        color: pending ? white : black,
                        fontSize: 16,
                        fontWeight: FontWeight.w400),
                    shapeBorder: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)),
                  )),
            ],
          ),
          Expanded(
            flex: 6,
            child: Padding(
                padding: const EdgeInsets.all(12.0),
                // child: paid.isEmpty && !pending
                //     ? DataNotAvailableWidget()
                //     : pendingList.isEmpty && pending
                //         ? DataNotAvailableWidget()
                //         : ListView(
                //             children: [
                //               for (int index = 0; index < getSize(); index++)
                //                 historyCard(index, getValue(index)),
                //             ],
                //           ),

                child: pending
                    ? Visibility(
                  child: pendingList.isEmpty
                      ? DataNotAvailableWidget()
                      : ListView.builder(
                    itemCount: pendingList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return itemCard(pendingList[index],
                          _homeScreenController);
                    },
                  ),
                  visible: pending,
                )
                    : Visibility(
                  child: paid.isEmpty
                      ? DataNotAvailableWidget()
                      : ListView(
                    children: [
                      for (int index = 0;
                      index < getSize();
                      index++)
                        historyCard(index, getValue(index)),
                    ],
                  ),
                  visible: !pending,
                )),
          ),
        ],
      ),
    );
  }

  historyCard(int index, AvailableServiceData availableServiceData) {
    return availableServiceData.isCompleted == 1
        ? Card(
      elevation: 2,
      color: white,
      child: Container(
        margin: EdgeInsets.only(top: index == 0 ? 0 : 20),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
              10), /* border: Border.all(color: Colors.green, width: 1)*/
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    availableServiceData.user.image != null
                        ? cacheNetworkImage(
                        imageWidth: 40,
                        imageHeight: 40,
                        radius: 180,
                        fit: BoxFit.cover,
                        imageUrl: ApiUtills.imageBaseUrl +
                            availableServiceData.user.image)
                        : SvgPicture.asset(
                      "assets/providerImages/svg/user_profile_pics.svg",
                      alignment: Alignment.centerLeft,
                      height: 40,
                      width: 40,
                    ),
                    10.width,
                    Text(
                      "${availableServiceData.user.firstName} ${availableServiceData.user.lastName}",
                      style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ),
                  ],
                ),
                Container(
                  height: 30,
                  width: 60,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                    color: Color(0xff4ed595),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.only(top: 5),
                    child: Text(
                      "Paid",
                      /*"${availableServiceData.paidAmount}\$",*/
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                          fontSize: 16),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              "${availableServiceData.subService}",
              style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                  fontSize: 16),
            ),
            if (pending)
              const SizedBox(
                height: 10,
              ),
            if (pending)
              Text(
                "Pending Amount : ${getPayableAmount(availableServiceData)}",
                style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w300,
                    fontSize: 16),
              ),
            10.height,
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SvgPicture.asset(
                  "assets/providerImages/svg/calendar.svg",
                  width: 20,
                  height: 20,
                ),
                8.width,
                FittedBox(
                  child: Text(
                    "${getDateTime(availableServiceData.createdAt)}",
                    style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                        fontSize: 12),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SvgPicture.asset(
                  "assets/providerImages/svg/location_icon.svg",
                  width: 20,
                  height: 20,
                ),
                8.width,
                Flexible(
                  child: Text(
                    "${availableServiceData.address}",
                    style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                        fontSize: 12),
                  ),
                ),
              ],
            ),
            10.height,
            FarenowButton(
                style: FarenowButtonStyleModel(padding: EdgeInsets.zero),
                title: pending ? "Pending" : "Paid",
                onPressed: () {
                  Get.to(() => PlumberProfileView(
                    data: availableServiceData,
                    hasPayable: pending,
                  ));
                },
                type: BUTTONTYPE.rectangular),
            10.height,

            /*FarenowButton(
                      title: "View Details",
                      onPressed: () {
                        if (availableServiceData.user.id == null) {
                          Get.defaultDialog(
                              title: "Alert",
                              content:
                              const Text("Service detail not available"),
                              confirm: MaterialButton(
                                onPressed: () {
                                  Get.back();
                                },
                                child: const Text(
                                  "Okay",
                                  style: TextStyle(fontSize: 18),
                                ),
                              ));
                        } else {
                          Get.to(() => HomePassButtonScreen(datas: availableServiceData));
                        }
                      },
                      style:
                      FarenowButtonStyleModel(padding: EdgeInsets.zero),
                      type: BUTTONTYPE.rectangular),*/
          ],
        ),
      ),
    )
        : Container(
      width: 300,
      height: 0,
      color: Colors.amber,
    );
  }

  getDateTime(createdAt) {
    var convertedDateTime = DateTimeUtils().convertStringWoT(createdAt);
    String time = DateTimeUtils()
        .parseDateTime(convertedDateTime, "EE, d MMM y, hh:mm:ss aa");

    return time;
  }

  getPayableAmount(data) {
    AvailableServiceData value = data;
    double hours = double.parse(value.hours.toString());
    double paidAmount = double.parse(value.paidAmount.toString());
    double perHrAmount = paidAmount / hours;
    double extraHours = double.parse(value.workedHours.toString()) - hours;
    double amountTobePaid = extraHours * perHrAmount;

    return "($extraHours * $perHrAmount) \$$amountTobePaid";
  }

  int getSize() {
    return pending ? pendingList.length : paid.length;
  }

  AvailableServiceData getValue(index) {
    return pending ? pendingList[index] : paid[index];
  }

  itemCard(AvailableServiceData data, HomeScreenController homeScreenController,
      {index}) {
    int ind = index ?? -1;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      child: Card(
        elevation: 5,
        color: white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(22)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Stack(
            alignment: Alignment.topRight,
            children: [
              Column(
                children: [
                  //  username
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        data.user.image != null
                            ? cacheNetworkImage(
                            radius: 180,
                            imageWidth: 40,
                            imageHeight: 40,
                            fit: BoxFit.cover,
                            imageUrl:
                            ApiUtills.imageBaseUrl + data.user.image)
                            : Image.asset(
                          "assets/providerImages/png/userPic.png",
                          alignment: Alignment.centerLeft,
                          height: 40,
                          width: 40,
                        ),
                        10.width,
                        Text(
                          getUserName(data.user),
                          style: const TextStyle(
                              color: Color(0xff151415),
                              fontSize: 18,
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ),
                  10.height,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SvgPicture.asset(
                        "assets/providerImages/svg/calendar.svg",
                        width: 20,
                        height: 20,
                      ),
                      8.width,
                      FittedBox(
                        child: Text(
                          DateTimeUtils().checkSince(
                              DateFormat("yyyy-MM-ddTHH:mm:ss")
                                  .parse(data.createdAt, true)),
                          style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w400,
                              fontSize: 12),
                        ),
                      ),
                    ],
                  ),
                  10.height,
                  // since time

                  if (data.type == 'MOVING_REQUEST') movingRequestWidget(data),

                  if (data.address != null)
                    Column(
                      children: [
                        // address
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SvgPicture.asset(
                              "assets/providerImages/svg/location_icon.svg",
                              width: 20,
                              height: 20,
                            ),
                            8.width,
                            Container(
                              width: Get.width * 0.6,
                              child: Text(
                                "${data.address}",
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 12),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(
                          height: 12,
                        ),
                      ],
                    ),
                  const SizedBox(
                    height: 10,
                  ),
                  acceptRejectButton(data.status.toString().toLowerCase(), data,
                      homeScreenController),
                  const SizedBox(
                    height: 10,
                  ),
                  if (data.status.toString().toLowerCase() != "rejected")
                    FarenowButton(
                        title: "View Details",
                        onPressed: () {
                          if (data.user.id == null) {
                            Get.defaultDialog(
                                title: "Alert",
                                content:
                                const Text("Service detail not available"),
                                confirm: MaterialButton(
                                  onPressed: () {
                                    Get.back();
                                  },
                                  child: const Text(
                                    "Okay",
                                    style: TextStyle(fontSize: 18),
                                  ),
                                ));
                          } else {
                            Get.to(() => HomePassButtonScreen(datas: data));
                          }
                        },
                        style:
                        FarenowButtonStyleModel(padding: EdgeInsets.zero),
                        type: BUTTONTYPE.rectangular),
                ],
              ),
              if (homeScreenController.pauseTimeEmpty(data.id))
                Container(
                  width: 100,
                  padding: const EdgeInsets.only(
                      left: 12, right: 12, top: 6, bottom: 6),
                  child: getTime(
                      homeScreenController: homeScreenController, id: data.id),
                  color: Colors.black.withOpacity(0.2),
                )
            ],
          ),
        ),
      ),
    );
  }

  movingRequestWidget(AvailableServiceData data) {
    return Column(
      children: [
        Row(
          children: [
            const Icon(Icons.location_on_outlined),
            const SizedBox(
              width: 12,
            ),
            Expanded(child: Text("${data.movingQuotationInfo.fromAddress}"))
          ],
        ),
        const SizedBox(
          height: 8,
        ),
        Row(
          children: [
            const Icon(Icons.location_on_outlined),
            const SizedBox(
              width: 12,
            ),
            Expanded(child: Text("${data.movingQuotationInfo.toAddress}"))
          ],
        ),
      ],
    );
  }

// emptyView() {
//   return Container(
//     alignment: Alignment.center,
//     color: Colors.white,
//     child: const Text(
//       "Data not available",
//       style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
//     ),
//   );
// }
}
