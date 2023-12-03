import 'package:fare_now_provider/components/buttons-management/part_of_file/part.dart';
import 'package:fare_now_provider/components/buttons-management/style_model.dart';
import 'package:fare_now_provider/models/available_services/available_service_data.dart';
import 'package:fare_now_provider/models/available_services/user_data_model.dart';
import 'package:fare_now_provider/screens/Controller/HomeScreenController.dart';
import 'package:fare_now_provider/screens/chat/chat_screen.dart';
import 'package:fare_now_provider/screens/home_pass_button_screen.dart';
import 'package:fare_now_provider/screens/payment/feed_back_page.dart';
import 'package:fare_now_provider/screens/timmer_widget.dart';
import 'package:fare_now_provider/util/date_time_utills.dart';
import 'package:fare_now_provider/widgets/custom_container.dart';
import 'package:fare_now_provider/widgets/text_with_icon.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:nb_utils/nb_utils.dart';

import '../util/api_utils.dart';
import '../util/widgest_utills.dart';

class AcceptedOrderPage extends StatefulWidget {
  final data;
  final tabSelected;

  const AcceptedOrderPage({Key? key, this.data, this.tabSelected})
      : super(key: key);

  @override
  _AcceptedOrderPageState createState() => _AcceptedOrderPageState();
}

class _AcceptedOrderPageState extends State<AcceptedOrderPage> {
  HomeScreenController homeScreenController = Get.find();

  List<bool> flags = [true, false];

  @override
  Widget build(BuildContext context) {
    String type = widget.tabSelected;
    return Column(
      children: [
        type == "accepted" &&
                widget.data.workingStatus == null &&
                widget.data.isCompleted != 1
            ? getWidget("accepted".capitalizeFirst)
            : type == "on_going" &&
                    getStatus(
                        widget.data.workingStatus.toString().toLowerCase()) &&
                    widget.data.isCompleted != 1
                ? getWidget("started".capitalizeFirst)
                : Container(),
      ],
    );
  }

  String getUserName(UserDataModel user) {
    if (user.firstName == null) {
      return "N/A";
    }
    return "${user.firstName} ${user.lastName ?? ""}";
  }

  String passTitle(AvailableServiceData data) {
    if (data.status.toLowerCase() == "accepted" && data.directContact == 1) {
      return "Message";
    }
    if (data.status.toLowerCase() == "accepted") {
      return "accepted".capitalizeFirst!;
    }
    if (data.directContact == 1 && data.address == null) {
      return "accept".capitalizeFirst!;
    }
    return "accept".capitalizeFirst!;
  }

  getWidget(title) {
    return Container(
      padding: const EdgeInsets.all(14),
      child: Stack(
        alignment: Alignment.topRight,
        children: [
          Card(
            color: white,
            elevation: 3,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(22)),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            alignment: Alignment.centerLeft,
                            child: Row(
                              children: [
                                widget.data.user.image != null
                                    ? cacheNetworkImage(
                                        radius: 180,
                                        imageWidth: 50,
                                        imageHeight: 50,
                                        fit: BoxFit.cover,
                                        imageUrl: ApiUtills.imageBaseUrl +
                                            widget.data.user.image)
                                    : Image.asset(
                                        "assets/providerImages/png/userPic.png",
                                        alignment: Alignment.centerLeft,
                                        height: 40,
                                        width: 40,
                                      ),
                                10.width,
                                Text(
                                  getUserName(widget.data.user),
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      if (title.toString().toLowerCase() == "started" &&
                          widget.data.type.toString().toLowerCase() !=
                              "moving_request")
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              margin: const EdgeInsets.only(right: 2, top: 2),
                              padding: const EdgeInsets.only(
                                  left: 12, right: 12, top: 6, bottom: 6),
                              child: getTime(
                                  homeScreenController: homeScreenController,
                                  data: widget.data),
                              // color: Colors.black.withOpacity(0.2),
                            ),
                          ],
                        ),
                    ],
                  ),
                  10.height,
                  getMovingDateAndAddress(widget.data, title),
                  if (widget.data.address != null)
                    Column(
                      children: [
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
                                        .parse(widget.data.createdAt, true)),
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 12),
                              ),
                            ),
                          ],
                        ),
                        10.height,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SvgPicture.asset(
                              "assets/providerImages/svg/location_icon.svg",
                              width: 20,
                              height: 20,
                            ),
                            8.width,
                            FittedBox(
                              child: Text(
                                "${widget.data.address}",
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 12),
                              ),
                            ),
                          ],
                        ),
                        14.height,
                        if (widget.data.status.toString().toLowerCase() ==
                            "accepted")
                          startButton(title),
                        14.height,
                        viewDetailButton(),
                      ],
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget getTime({homeScreenController, data}) {
    var dta = getList(data);
    String time = getStartTime(dta);
    DateTime cTime = DateTimeUtils().convertStringSeconds(time);
    String convertTime =
        DateTimeUtils().parseDateTime(DateTime.now(), "yyyy-MM-dd hh:mm:ss");
    DateTime now = DateTimeUtils().convertStringSeconds(convertTime);

    int diffSc = data.workingStatus == "PAUSED"
        ? getPauseTime(dta)
        : data.isCompleted == 1
            ? getWorkedTime(dta)
            : now.difference(cTime).inSeconds;
    diffSc = diffSc < 0 ? 0 : diffSc;

    int beakLaps = getBeakTime(dta);
    // if (_data.isCompleted == 0) {
    diffSc = diffSc - beakLaps;
    // }
    int sec = diffSc ~/ 60;
    int secResult = diffSc - (sec * 60);
    int hourResult = sec ~/ 60;
    int minResult = sec - (hourResult * 60);
    int days = hourResult ~/ 24;
    // if (days != 0) {
    //   int daysInHours = days * 24;
    //   hourResult = hourResult - daysInHours;
    // }

    return TimmerWidget(
        hours: hourResult,
        minutes: minResult,
        seconds: secResult,
        // days: days,
        pause: widget.data.workingStatus.toString().toLowerCase() == "paused"
            ? true
            : false,
        timeChange: (value) {
          // timePause = value;
          // print("tik tik $timePause");
        });
  }

  String getStartTime(List workedTimes) {
    workedTimes.sort((a, b) => a.startAt.compareTo(b.startAt));

    for (int index = 0; index < workedTimes.length; index++) {
      if (workedTimes[index].endAt == null) {
        var dateTime = DateFormat("yyyy-MM-ddTHH:mm:ss")
            .parse(workedTimes.first.createdAt, true);
        String tme = dateTime.toLocal().toString();
        if (tme.toString().toLowerCase().contains("t")) {
          tme = tme.replaceAll("T", " ");
        }
        return tme;
      } else {
        if (kDebugMode) {
          DateTime time =
              DateTimeUtils().convertStringWoT(workedTimes.first.startAt);
          time = time.add(const Duration(hours: 0));
          return time.toString();
        }
        return workedTimes.first.startAt;
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
          DateTimeUtils().convertWorkingHoursTime(workedTimes.last.createdAt);
    }

    int diffSc = endTime.difference(startTime).inSeconds;
    count = count + diffSc;

    return count;
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

  List getList(value) {
    List list = value.workedTimes ?? [];
    return list;
  }

  bool getStatus(String lowerCase) {
    if (widget.data.workingStatus.toString().toLowerCase() == "started") {
      return true;
    } else if (widget.data.workingStatus.toString().toLowerCase() == "paused") {
      return true;
    }

    return false;
  }

  resumeService(AvailableServiceData data) async {
    int pause = data.workingStatus.toString().toLowerCase() == "paused" ? 1 : 0;
    String filter = pause == 0 ? "start_at" : "end_at";
    Map body = <String, dynamic>{
      "service_request_id": data.id,
      "is_paused": true,
      "type": filter
    };

    print("$filter");
    homeScreenController.startService(body, onServiceStart: () {
      homeScreenController.orderStatus.value.data.isPaused = pause == 0 ? 1 : 0;

      setState(() {});
      homeScreenController.getOrderStatus(widget.data.id, upDateView: () {
        setState(() {});
      });

      Future.delayed(const Duration(seconds: 0)).then((valu) async {
        await homeScreenController.getAvailableJobs(flag: true);
        setState(() {});
      });
    });
  }

  getMovingDateAndAddress(AvailableServiceData data, title) {
    String type = data.type ?? "";

    if (type.toLowerCase() == "moving_request") {
      return Column(
        children: [
          TextWithIcon(
            icon: CustomContainer(
              height: 10,
              width: 10,
              allRadius: 12,
              marginRight: 12,
              color: Colors.black,
            ),
            width: Get.width,
            flex: 1,
            maxLine: 2,
            fontSize: 16,
            fontColor: Colors.black,
            fontWeight: FontWeight.w200,
            alignment: MainAxisAlignment.start,
            title: "${data.movingQuotationInfo.fromAddress ?? "N/A"}",
          ),
          TextWithIcon(
            icon: CustomContainer(
              height: 10,
              width: 10,
              allRadius: 12,
              marginRight: 12,
              color: Colors.black,
            ),
            width: Get.width,
            fontSize: 16,
            marginTop: 6,
            fontColor: Colors.black,
            fontWeight: FontWeight.w200,
            alignment: MainAxisAlignment.start,
            title: "Date:  ${getDate(widget.data)}",
          ),
          const SizedBox(
            height: 10,
          ),
          startButton(title),
          const SizedBox(
            height: 10,
          ),
          viewDetailButton(),
        ],
      );
    }

    return CustomContainer(
      width: 0,
      height: 0,
    );
  }

  viewDetailButton() {
    return FarenowButton(
        title: "View Details",
        onPressed: () {
          if (widget.data.user.id == null) {
            Get.defaultDialog(
                title: "Alert",
                content: const Text("Service detail not available"),
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
            Get.to(HomePassButtonScreen(
                datas: widget.data,
                onClickPause: (value) {
                  print("pause");
                  widget.data.isPaused = value;
                  setState(() {});
                }));
          }
        },
        style: FarenowButtonStyleModel(padding: EdgeInsets.zero),
        type: BUTTONTYPE.rectangular);
  }

  getDate(AvailableServiceData data) {
    var conertDate = DateTimeUtils().onlyDate(data.movingQuotationInfo.date);
    var date = DateTimeUtils().parseDateTime(conertDate, "dd MMM yyyy");
    return date;
  }

  startButton(title) {
    return FarenowButton(
      title: title.toString().toLowerCase() == "accepted"
          ? "Start Service"
          : widget.data.workingStatus.toString().toLowerCase() == "paused"
              ? "Resume"
              : title.toString().toLowerCase() == "started"
                  ? "Finish"
                  : title,
      onPressed: () {
        if (widget.data.workingStatus.toString().toLowerCase() == "paused") {
          resumeService(widget.data);
        } else if (title.toString().toLowerCase() == "started") {
          Map body = <String, dynamic>{
            "service_request_id": widget.data.id,
            "is_paused": false,
            "type": "end_at"
          };

          homeScreenController.startService(body, onServiceStart: () {
            Get.dialog(FeedBackPage(
                data: widget.data,
                onRateComplete: () {
                  homeScreenController.getAvailableJobs(flag: true);
                }));
            homeScreenController.orderStatus.value.data.isCompleted = 1;
            setState(() {});
            homeScreenController.getOrderStatus(widget.data.id, upDateView: () {
              setState(() {});
            });
          });
        } else if (widget.data.status.toLowerCase() == "accepted" &&
            widget.data.directContact == 1) {
          print("");
          String userId = widget.data.userId.toString();
          String providerId = widget.data.providerId;
          String name = getUserName(widget.data.user);
          Get.to(ChatScreen(
            senderId: providerId,
            receiverId: userId,
            name: name,
          ));
        } else if (widget.data.status.toLowerCase() == "accepted" &&
            widget.data.directContact == 0) {
          Map body = <String, dynamic>{
            "service_request_id": widget.data.id,
            "is_paused": false,
            "type": "start_at"
          };
          homeScreenController.startService(body, onServiceStart: () {
            setState(() {
              homeScreenController.getOrderStatus(widget.data.id,
                  upDateView: () {
                widget.data.workingStatus = "started";
                setState(() {});
              });
            });
          });
        }
      },
      style: FarenowButtonStyleModel(padding: EdgeInsets.zero),
      type: title.toString().toLowerCase() == "accepted"
          ? BUTTONTYPE.outline
          : widget.data.workingStatus.toString().toLowerCase() == "paused"
              ? BUTTONTYPE.action
              : title.toString().toLowerCase() == "started"
                  ? BUTTONTYPE.action
                  : BUTTONTYPE.outline,
    );
  }
}
