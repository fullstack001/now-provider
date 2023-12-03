import 'dart:convert';

import 'package:fare_now_provider/components/buttons-management/part_of_file/part.dart';
import 'package:fare_now_provider/components/buttons-management/style_model.dart';
import 'package:fare_now_provider/controllers/profile_screen_controller/ProfileScreenController.dart';
import 'package:fare_now_provider/models/available_services/available_service_data.dart';
import 'package:fare_now_provider/models/available_services/quotation_info.dart';
import 'package:fare_now_provider/models/available_services/user_data_model.dart';
import 'package:fare_now_provider/models/order_status/data.dart';
import 'package:fare_now_provider/models/order_status/order_status_response.dart';
import 'package:fare_now_provider/models/order_status/worked_times.dart';
import 'package:fare_now_provider/screens/Controller/HomeScreenController.dart';
import 'package:fare_now_provider/screens/chat/chat_screen.dart';
import 'package:fare_now_provider/screens/payment/feed_back_page.dart';
import 'package:fare_now_provider/screens/timmer_widget.dart';
import 'package:fare_now_provider/util/api_utils.dart';
import 'package:fare_now_provider/util/app_colors.dart';
import 'package:fare_now_provider/util/date_time_utills.dart';
import 'package:fare_now_provider/util/widgest_utills.dart';
import 'package:fare_now_provider/widgets/custom_container.dart';
import 'package:fare_now_provider/widgets/rating_start.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:nb_utils/nb_utils.dart';

class HomePassButtonScreen extends StatefulWidget {
  final datas;
  final onClickPause;

  HomePassButtonScreen({Key? key, this.datas, this.onClickPause})
      : super(key: key);

  @override
  _HomePassButtonScreenState createState() => _HomePassButtonScreenState();
}

class _HomePassButtonScreenState extends State<HomePassButtonScreen> {
  HomeScreenController _homeScreenController = Get.find();
  ProfileScreenController _profileScreenController = Get.find();

  var data;
  var timePause;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _homeScreenController.getTimeFromPrefs();

    if (widget.datas.status.toString().toLowerCase() == "accepted" &&
        widget.datas.workingStatus != null) {
      _homeScreenController.getOrderStatus(widget.datas.id, flag: true,
          upDateView: () {
        setState(() {});
      });
    }
  }

  var _timmerWidget;

  @override
  Widget build(BuildContext context) {
    if (data == null) {
      data = widget.datas;
    }

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.blue,
          ),
        ),
        backgroundColor: Colors.white,
        centerTitle: false,
        title: const Text(
          "Service Detail",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ListView(
              shrinkWrap: true,
              physics: const ScrollPhysics(),
              children: [
                Container(
                  width: double.infinity,
                  height: 180,
                  child: Stack(
                    children: [
                      Container(
                        width: double.infinity,
                        height: 135,
                        decoration: const BoxDecoration(
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image:
                                    AssetImage("assets/images/mapHeader.png"))),
                      ),
                      (widget.datas.user.image ?? "") == ""
                          ? Container(
                              width: 80,
                              height: 80,
                              margin: EdgeInsets.only(
                                  top: 95, left: (Get.width / 2) - 40),
                              decoration: const BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(60)),
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: AssetImage(
                                    'assets/images/img_profile_place_holder.jpg',
                                  ),
                                ),
                              ),
                            )
                          : CustomContainer(
                              alignment: Alignment.topCenter,
                              marginLeft: (Get.width / 2) - 40,
                              marginTop: 95,
                              child: cacheNetworkImage(
                                  fit: BoxFit.fill,
                                  imageWidth: 80,
                                  imageHeight: 80,
                                  radius: 60,
                                  imageUrl:
                                      "${ApiUtills.imageBaseUrl + (widget.datas.user.image ?? "")}"),
                            )
                    ],
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        getUserName(data.user),
                        style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontSize: 24),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              const Icon(
                                Icons.star,
                                color: Color(0xffFF9E45),
                                size: 22,
                              ),
                              Text(
                                "${double.parse((data.user.rating ?? 0.0).toString())}",
                                style: const TextStyle(
                                    color: Color(0xff151415),
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14),
                              ),
                              Text(
                                " (${data.user.feedback_count ?? 0})",
                                style: const TextStyle(
                                    fontWeight: FontWeight.w400, fontSize: 14),
                              )
                            ],
                          ),
                          20.width,
                        ],
                      ),
                      // RatingStar(
                      //   size: 20,
                      //   rating:
                      //       double.parse((data.user.rating ?? 0.0).toString()),
                      //   color: AppColors.appGreen,
                      // ),
                      // if (data.address != null)
                      //   Text(
                      //     "${data.address}",
                      //     style: TextStyle(
                      //         color: Colors.grey.shade600, fontSize: 12),
                      //   ),
                      // const SizedBox(
                      //   height: 10,
                      // ),
                      // InkWell(
                      //   onTap: () {
                      //     if (checkProviderType(data)) {
                      //       Get.to(ChatScreen(
                      //         receiverId: data.userId.toString(),
                      //         senderId: _profileScreenController.userData.value.id
                      //             .toString(),
                      //         name: getUserName(data.user),
                      //         orderId: data.id.toString(),
                      //       ));
                      //     }
                      //   },
                      //   child: customContainer(
                      //       width: 300,
                      //       height: 40,
                      //       color:
                      //           checkProviderType(data) ? Colors.blue : Colors.grey,
                      //       allRadius: 20,
                      //       child: Text(
                      //         "Message",
                      //         style: TextStyle(color: Colors.white, fontSize: 16),
                      //         textAlign: TextAlign.center,
                      //       )),
                      // ),
                      const Divider(
                        endIndent: 10,
                        indent: 10,
                        thickness: 1,
                      )
                    ],
                  ),
                ),
                if (getList(_homeScreenController.orderStatus.value)
                        .isNotEmpty &&
                    data.status.toString().toLowerCase() == "accepted" &&
                    widget.datas.workingStatus != null &&
                    widget.datas.type.toString().toLowerCase() !=
                        "moving_request")
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    width: double.infinity,
                    height: 100,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const Text(
                          "Job Timer",
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Color(0xff555555),
                              fontSize: 18),
                        ),
                        Obx(
                          () => getTime(
                              getList(_homeScreenController.orderStatus.value)),
                        ),
                        const Divider(
                          thickness: 1,
                          indent: 10,
                          endIndent: 10,
                        )
                      ],
                    ),
                  ),

                if (data.requestInfos.isNotEmpty)
                  data.requestInfos.first.question != null
                      ? Container(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          width: double.infinity,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              const Text(
                                "Job Type",
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xff555555),
                                    fontSize: 18),
                              ),
                              if (data.requestInfos.first.question != null)
                                Text(
                                  data.requestInfos.first.question.subService
                                      .name,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w300,
                                      fontSize: 20),
                                ),
                              Text(
                                "${DateTimeUtils().checkSince(DateTimeUtils().onlyDate(data.createdAt))}",
                                style: const TextStyle(
                                    fontWeight: FontWeight.w500, fontSize: 16),
                              ),
                              const Divider(
                                thickness: 1,
                                indent: 10,
                                endIndent: 10,
                              )
                            ],
                          ))
                      : Container(),

                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      // Text(
                      //   "When the work should be done",
                      //   style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                      // ),

                      const Text(
                        "Date",
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Color(0xff555555),
                            fontSize: 18),
                      ),
                      Text(
                        "${DateTimeUtils().parseDateTime(DateTimeUtils().convertString(data.createdAt), "dd MMM yyyy")}",
                        style: const TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 16),
                      ),
                      if (data.timeSlots.isNotEmpty)
                        Text(
                          "Timing : ${data.timeSlots.first.start}",
                          style: const TextStyle(
                              fontWeight: FontWeight.normal, fontSize: 17),
                        ),
                      // Text(
                      //   "Timing : Afternoon (3pm- 6pm)",
                      //   style: TextStyle(fontWeight: FontWeight.normal, fontSize: 20),
                      // ),
                      // Text(
                      //   "${DateTimeUtils().checkSince(DateTimeUtils().convertString(data.createdAt))}",
                      //   style: TextStyle(fontWeight: FontWeight.w300, fontSize: 16),
                      // ),
                      if (widget.datas.type.toString().toLowerCase() ==
                          "moving_request")
                        Column(
                          children: [
                            const SizedBox(
                              height: 12,
                            ),
                            const Divider(
                              thickness: 1,
                              indent: 10,
                              endIndent: 10,
                            ),
                            const SizedBox(
                              height: 0,
                            ),
                            Container(
                              width: double.infinity,
                              height: 100,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  const Text(
                                    "Job Type",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 14),
                                  ),
                                  const Text(
                                    "Moving",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 14),
                                  ),
                                  Text(
                                    "${DateTimeUtils().checkSince(DateTimeUtils().onlyDate(data.createdAt))}",
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16),
                                  ),
                                  const Divider(
                                    thickness: 1,
                                    indent: 10,
                                    endIndent: 10,
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              width: double.infinity,
                              height: 100,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  const Text(
                                    "From Address",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 14),
                                  ),
                                  Text(
                                    "${widget.datas.movingQuotationInfo.fromAddress ?? "N/A"}",
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16),
                                  ),
                                  const Divider(
                                    thickness: 1,
                                    indent: 10,
                                    endIndent: 10,
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              width: double.infinity,
                              height: 100,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  const Text(
                                    "To Address",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 14),
                                  ),
                                  Text(
                                    "${widget.datas.movingQuotationInfo.toAddress ?? "N/A"}",
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),

                      const Divider(
                        thickness: 1,
                        indent: 10,
                        endIndent: 10,
                      ),
                    ],
                  ),
                ),
                // getContainer("Prototo Type", "Home"),
                if (data.address != null)
                  getContainer("Project location", "${data.address}"),
                // getContainer(
                //     "Job Type", data.requestInfos.first.question.subService.name),
                for (int index = 0; index < data.requestInfos.length; index++)
                  if (data.requestInfos[index].question != null)
                    getContainer(data.requestInfos[index].question.question,
                        getOption(data.requestInfos[index].question.id, index)),
                // getContainer("Message",
                //     "Lorem ipsum dolor sit amet, consectetur adipiscing elit ut aliquam"),
                // getContainer(
                //     "Travel prefrences", "Professional must travel to my address"),
                // const SizedBox(
                //   height: 60,
                // ),

                // const SizedBox(
                //   height: 20,
                // )
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Row(
                    children: [
                      if (data.status.toLowerCase() != "accepted" ||
                          data.directContact == 1)
                        if (data.status.toLowerCase() != "accepted")
                          Expanded(
                            child: FarenowButton(
                                style: FarenowButtonStyleModel(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 16)),
                                title: data.status.toLowerCase() != "rejected"
                                    ? data.address == null
                                        ? "Decline"
                                        : "Reject"
                                    : "Rejected",
                                onPressed: () {
                                  if (data.directContact == 1 &&
                                      data.status.toString().toLowerCase() ==
                                          "pending") {
                                    Map body = <String, String>{
                                      "status": "REJECTED"
                                    };
                                    _homeScreenController.acceptOrRejectChat(
                                      data.id,
                                      body,
                                      update: newStatus,
                                    );
                                  } else if (data.status.toLowerCase() !=
                                      "rejected") {
                                    _homeScreenController.updateStatus(
                                        data.id, "REJECTED",
                                        newStatus: newStatus);
                                  }
                                },
                                type: BUTTONTYPE.outline),
                          ),
                    ],
                  ),
                  getList(_homeScreenController.orderStatus.value).isNotEmpty &&
                          data.status.toString().toLowerCase() == "accepted" &&
                          widget.datas.workingStatus != null
                      ? pauseComplete()
                      : actionButton(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  updateObject(value) {
    var response = json.decode(value);

    QuotationInfo info =
        QuotationInfo.fromJson(response['data']['quotation_info']);
    data.quotationInfo = info;

    print(value);
    setState(() {});
  }

  String getUserName(UserDataModel user) {
    if (user.firstName == null) {
      return "N/A";
    }
    return "${user.firstName} ${user.lastName ?? ""}";
  }

  Container getContainer(String val1, val2, {hide}) {
    bool lineHide = hide ?? false;
    return Container(
      padding: const EdgeInsets.only(top: 0, bottom: 0, left: 20, right: 20),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: lineHide ? 0 : 12,
          ),
          Text(
            "$val1",
            style: const TextStyle(
                fontWeight: FontWeight.w600,
                color: Color(0xff555555),
                fontSize: 18),
          ),
          const SizedBox(
            height: 4,
          ),
          if (val2 != null)
            Text(
              "$val2",
              style:
                  const TextStyle(fontWeight: FontWeight.normal, fontSize: 16),
            ),
          if (!lineHide)
            Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                const Divider(
                  thickness: 1,
                  indent: 10,
                  endIndent: 10,
                ),
                const SizedBox(
                  height: 2,
                ),
              ],
            ),
        ],
      ),
    );
  }

  newStatus(value) {
    var response = json.decode(value);
    data.status = response['data']['status'];
    print(value);
    setState(() {});
  }

  check(data) {
    if (data.status.toLowerCase() != "accepted") {
      return false;
    }
    if (data.status.toLowerCase() != "rejected") {
      return false;
    }

    return true;
  }

  getOption(int id, int index) {
    if (data.requestInfos[index].option.questionId == id) {
      return data.requestInfos[index].option.option;
    }
    return "N/A";
  }

  checkProviderType(AvailableServiceData data) {
    // if (_profileScreenController.userData.value.userProfileModel == null) {
    if (_profileScreenController.userData.value.providerProfile == null) {
      return false;
    }
    // if (_profileScreenController.userData.value.userProfileModel.hourlyRate ==
    //     null) {
    //   return true;
    // }
    return data.status.toString().toLowerCase() == "accepted";
  }

  getTime(listdata, {flag}) {
    String time = getStartTime(listdata);
    DateTime cTime = DateTimeUtils().convertStringSeconds(time);
    String convertTime =
        DateTimeUtils().parseDateTime(DateTime.now(), "yyyy-MM-dd hh:mm:ss");
    DateTime now = DateTimeUtils().convertStringSeconds(convertTime);

    int diffSc = _homeScreenController.orderStatus.value.data.isPaused == 1
        ? getPauseTime(getList(_homeScreenController.orderStatus.value))
        : _homeScreenController.orderStatus.value.data.isCompleted == 1
            ? getWorkedTime(getList(_homeScreenController.orderStatus.value))
            : now.difference(cTime).inSeconds;
    diffSc = diffSc < 0 ? 0 : diffSc;
    int beakLaps =
        getBeakTime(getList(_homeScreenController.orderStatus.value));
    // if (_homeScreenController.orderStatus.value.data.isCompleted == 0) {
    diffSc = diffSc - beakLaps;
    // }
    int sec = diffSc ~/ 60;
    int secResult = diffSc - (sec * 60);
    int hourResult = sec ~/ 60;
    int minResult = sec - (hourResult * 60);
    int days = hourResult ~/ 24;
    if (days != 0) {
      int daysInHours = days * 24;
      hourResult = hourResult - daysInHours;
    }

    return TimmerWidget(
        hours: hourResult,
        minutes: minResult,
        seconds: secResult,
        // days: days,
        pause: _homeScreenController.orderStatus.value.data.isCompleted == 1 &&
                widget.datas.workingStatus.toString().toLowerCase() == "ended"
            ? true
            : _homeScreenController.orderStatus.value.data.isPaused == 1
                ? true
                : false,
        timeChange: (value) {
          timePause = value;
          print("tik tik $timePause");
        });
  }

  actionButton() {
    if (data.status.toLowerCase() != "rejected" || data.directContact == 1) {
      if (data.status.toLowerCase() != "rejected") {
        return FarenowButton(
            title: data.status.toLowerCase() == "accepted"
                ? "Start Service"
                : data.address == null
                    ? "Accepted"
                    : "Accept",
            onPressed: () {
              if (data.status.toLowerCase() == "accepted") {
                Map body = <String, dynamic>{
                  "service_request_id": data.id,
                  "is_paused": false,
                  "type": "start_at"
                };
                _homeScreenController.startService(body, onServiceStart: () {
                  setState(() {
                    _homeScreenController.getOrderStatus(widget.datas.id,
                        upDateView: () {
                      data.workingStatus = "started";
                      setState(() {});
                    });
                  });
                });
              } else if (data.directContact == 1 &&
                  data.status.toString().toLowerCase() == "pending") {
                Map body = <String, String>{"status": "ACCEPTED"};
                _homeScreenController.acceptOrRejectChat(
                  data.id,
                  body,
                  update: newStatus,
                );
              } else if (data.status.toLowerCase() != "accepted") {
                _homeScreenController.updateStatus(
                  data.id,
                  "ACCEPTED",
                  newStatus: newStatus,
                );
              }
            },
            style: FarenowButtonStyleModel(padding: EdgeInsets.zero),
            type: BUTTONTYPE.rectangular);
      }
    }

    return emptyContainer();
  }

  Widget pauseComplete() {
    return Row(
      children: [
        if (_homeScreenController.orderStatus.value.data.isCompleted == 0 &&
            widget.datas.type.toString().toLowerCase() != "moving_request")
          Flexible(
            fit: FlexFit.tight,
            child: FarenowButton(
                style: FarenowButtonStyleModel(
                    padding: const EdgeInsets.symmetric(horizontal: 12)),
                title: (_homeScreenController.orderStatus.value.data.isPaused ??
                            0) ==
                        1
                    ? "Resume"
                    : "Pause",
                onPressed: () {
                  // TODO feedback calling

                  int pause =
                      _homeScreenController.orderStatus.value.data.isPaused ??
                          0;
                  String filter = pause == 0 ? "start_at" : "end_at";
                  Map body = <String, dynamic>{
                    "service_request_id": data.id,
                    "is_paused": true,
                    "type": filter
                  };

                  print("$filter");
                  _homeScreenController.startService(body, onServiceStart: () {
                    int value =
                        _homeScreenController.orderStatus.value.data.isPaused ??
                            0;
                    _homeScreenController.orderStatus.value.data.isPaused =
                        value == 0 ? 1 : 0;

                    setState(() {});
                    _homeScreenController.getOrderStatus(widget.datas.id,
                        upDateView: () {
                      setState(() {});
                    });

                    Future.delayed(const Duration(seconds: 0))
                        .then((valu) async {
                      await _homeScreenController.getAvailableJobs(flag: true);
                      if (widget.onClickPause != null) {
                        int val = _homeScreenController
                                .orderStatus.value.data.isPaused ??
                            0;
                        widget.onClickPause(val == 1 ? true : false);
                      }
                    });
                  });
                },
                type: BUTTONTYPE.outline),
          ),
        // if (_homeScreenController.orderStatus.value.data.isCompleted == 0 &&
        //     widget.datas.type.toString().toLowerCase() != "moving_request")
        //   10.height,
        Flexible(
          fit: FlexFit.tight,
          child: FarenowButton(
              style: FarenowButtonStyleModel(
                  padding: const EdgeInsets.symmetric(horizontal: 12)),
              title: _homeScreenController.orderStatus.value.data.isCompleted ==
                          1 &&
                      widget.datas.workingStatus.toString().toLowerCase() ==
                          "ended"
                  ? "Finished"
                  : "Finish",
              onPressed: () {
                if (_homeScreenController.orderStatus.value.data.isCompleted ==
                    0) {
                  Map body = <String, dynamic>{
                    "service_request_id": data.id,
                    "is_paused": false,
                    "type": "end_at"
                  };

                  _homeScreenController.startService(body, onServiceStart: () {
                    // Get.dialog(FeedBackPage(
                    //     data: widget.datas,
                    //     onRateComplete: () {
                    //       _homeScreenController.getAvailableJobs(flag: true);
                    //     }));
                    showModalBottomSheet(
                        backgroundColor: white,
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(30),
                                topRight: Radius.circular(30))),
                        context: context,
                        builder: ((context) {
                          return FeedBackPage(
                              data: widget.datas,
                              onRateComplete: () {
                                _homeScreenController.getAvailableJobs(
                                    flag: true);
                              });
                        }));
                    _homeScreenController.orderStatus.value.data.isCompleted =
                        1;
                    setState(() {});
                    _homeScreenController.getOrderStatus(widget.datas.id,
                        upDateView: () {
                      setState(() {});
                    });
                  });
                }
              },
              type: BUTTONTYPE.rectangular),
        ),
      ],
    );
  }

  buttonCustom({title, fontSize, fontColor, @required onTap}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 10,
        height: 50,
        alignment: Alignment.center,
        decoration: const BoxDecoration(
          color: AppColors.appGreen,
          borderRadius: BorderRadius.all(
            Radius.circular(12),
          ),
        ),
        child: Text(
          title,
          style: TextStyle(
            fontSize: double.parse((fontSize ?? 14).toString()),
            color: fontColor ?? Colors.black,
          ),
        ),
      ),
    );
  }

  int getBeakTime(List workedTimes) {
    int count = 0;
    workedTimes.sort((a, b) => a.startAt.compareTo(b.startAt));
    if (workedTimes.length > 1) {
      for (int index = 0; index < workedTimes.length; index++) {
        if (workedTimes[index].endAt != null && index != 0) {
          DateTime startTime =
              DateTimeUtils().convertStringSeconds(workedTimes[index].startAt);
          DateTime endTime =
              DateTimeUtils().convertStringSeconds(workedTimes[index].endAt);

          int diffSc = endTime.difference(startTime).inSeconds;
          count = count + diffSc;
        }
      }
    }
    return count;
  }

  String getStartTime(List workedTimes) {
    List<WorkedTimes> list = [];
    for (int index = 0; index < workedTimes.length; index++) {
      WorkedTimes value = workedTimes[index];
      list.add(value);
    }
    list.sort((a, b) => a.startAt.compareTo(b.startAt));

    for (int index = 0; index < list.length; index++) {
      if (list[index].endAt == null) {
        var dateTime =
            DateFormat("yyyy-MM-ddTHH:mm:ss").parse(list.first.createdAt, true);
        String tme = dateTime.toLocal().toString();
        if (tme.toString().toLowerCase().contains("t")) {
          tme = tme.replaceAll("T", " ");
        }
        return tme;
      } else {
        var dateTime =
            DateFormat("yyyy-MM-ddTHH:mm:ss").parse(list.first.createdAt, true);
        String tme = dateTime.toLocal().toString();
        if (tme.toString().toLowerCase().contains("t")) {
          tme = tme.replaceAll("T", " ");
        }
        return tme;
      }
    }
    return DateTime.now().toString();
  }

  getWorkedTime(List workedTimes) {
    int count = 0;
    workedTimes.sort((a, b) => a.startAt.compareTo(b.startAt));
    for (int index = 0; index < workedTimes.length; index++) {
      DateTime startTime =
          DateTimeUtils().convertStringSeconds(workedTimes[index].startAt);
      DateTime endTime =
          DateTimeUtils().convertStringSeconds(workedTimes[index].endAt);

      int diffSc = endTime.difference(startTime).inSeconds;
      count = count + diffSc;
      break;
    }

    return count;
  }

  getPauseTime(List workedTimes) {
    int count = 0;
    workedTimes.sort((a, b) => a.startAt.compareTo(b.startAt));
    DateTime startTime =
        DateTimeUtils().convertWorkingHoursTime(workedTimes[0].createdAt);
    DateTime endTime = DateTime.now();

    if (workedTimes.length == 1) {
      endTime = DateTimeUtils().convertStringSeconds(workedTimes[0].endAt);
    } else {
      // endTime = DateTimeUtils().convertStringSeconds(workedTimes.last.endAt);
      endTime =
          DateTimeUtils().convertWorkingHoursTime(workedTimes.last.updatedAt);
    }

    int diffSc = endTime.difference(startTime).inSeconds;
    count = count + diffSc;

    return count;
  }

  List getList(OrderStatusResponse value) {
    Data data = _homeScreenController.orderStatus.value.data ?? Data();
    List list = data.workedTimes ?? [];
    return list;
  }
}
