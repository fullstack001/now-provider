import 'package:fare_now_provider/components/buttons-management/part_of_file/part.dart';
import 'package:fare_now_provider/components/buttons-management/style_model.dart';
import 'package:fare_now_provider/models/available_services/available_service_data.dart';
import 'package:fare_now_provider/models/available_services/user_data_model.dart';
import 'package:fare_now_provider/screens/Controller/HomeScreenController.dart';
import 'package:fare_now_provider/screens/chat/chat_screen.dart';
import 'package:fare_now_provider/screens/timmer_widget.dart';
import 'package:fare_now_provider/util/app_colors.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nb_utils/nb_utils.dart';

var pages = [];
List<bool> flags = [true, false, false, false];
List<bool> flagTabs = [true, false];
sortWidgets() {
  return Container(
    height: 0,
    child: ListView(
      scrollDirection: Axis.horizontal,
      children: [
        InkWell(
          onTap: () {},
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Container(
              width: 142,
              padding: const EdgeInsets.all(10),
              alignment: Alignment.center,
              height: 38,
              decoration: BoxDecoration(
                  color: Colors.blue, borderRadius: BorderRadius.circular(30)),
              child: const Text(
                "Sort: Most Relevent",
                style: TextStyle(fontSize: 14, color: Colors.white),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: Container(
            width: 142,
            padding: const EdgeInsets.all(10),
            alignment: Alignment.center,
            height: 38,
            decoration: BoxDecoration(
                color: Colors.blue, borderRadius: BorderRadius.circular(30)),
            child: const Text(
              "Category 150 Miles",
              style: TextStyle(fontSize: 14, color: Colors.white),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: Container(
            width: 120,
            padding: const EdgeInsets.all(10),
            alignment: Alignment.center,
            height: 38,
            decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(30)),
            child: const Text(
              "Category",
              style: TextStyle(fontSize: 14, color: Colors.white),
            ),
          ),
        )
      ],
    ),
  );
}

acceptOnGoingTabs(tabUpDate) {
  return Row(
    children: [
      15.width,
      Flexible(
          child: AppButton(
        elevation: 0,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        onTap: () {
          resetTabsFlags();
          flagTabs[0] = true;
          HomeScreenController _homeScreenController = Get.find();
          _homeScreenController.getAvailableJobs();
          tabUpDate('accepted');
        },
        color: flagTabs[0] ? AppColors.solidBlue : const Color(0xffE0E0E0),
        text: "Accepted",
        textStyle: TextStyle(
            color: flagTabs[0] ? white : black,
            fontSize: 16,
            fontWeight: FontWeight.w400),
        shapeBorder:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      )),
      15.width,
      Flexible(
          child: AppButton(
        elevation: 0,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        onTap: () {
          resetTabsFlags();
          flagTabs[1] = true;
          HomeScreenController _homeScreenController = Get.find();
          _homeScreenController.getAvailableJobs();
          tabUpDate('on_going');
        },
        text: "On Going",
        color: flagTabs[1] ? AppColors.solidBlue : const Color(0xffE0E0E0),
        textStyle: TextStyle(
            color: flagTabs[1] ? white : black,
            fontSize: 16,
            fontWeight: FontWeight.w400),
        shapeBorder:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      )),
    ],
  );
}

void resetTabsFlags() {
  for (int index = 0; index < flagTabs.length; index++) {
    flagTabs[index] = false;
  }
}

resetList(services) {
  for (int index = 0; index < services.length; index++) {
    if (services[index].address != null) {
      if (services[index].directContact == 1) {
        services[index].directContact = 0;
      }
    }
  }
  return services;
}

bool checkServer(List services, String filter) {
  for (int index = 0; index < services.length; index++) {
    AvailableServiceData value = services[index];
    if (value.directContact == 0) {
      if (value.status.toLowerCase() == filter) {
        return true;
      }
    } else if (value.directContact == 1 && filter == "1") {
      return true;
    }
  }
  return false;
}

getTime({flag, homeScreenController, id}) {
  int hourResult = 0;
  int minResult = 0;
  int secResult = 0;
  if (homeScreenController.pauseTimeEmpty(id)) {
    String pauseTime = homeScreenController.getPauseTime(id);
    if (pauseTime.isNotEmpty) {
      hourResult = int.parse(pauseTime.split(":")[0]);
      minResult = int.parse(pauseTime.split(":")[1]);
      secResult = int.parse(pauseTime.split(":")[2]);
    }
    print(pauseTime);
  }

  return TimmerWidget(
      hours: hourResult,
      minutes: minResult,
      seconds: secResult,
      pause: homeScreenController.isPause(id),
      timeChange: (value) {
        print(value);
        homeScreenController.saveTime(id, value);
      });
}

acceptRejectButton(filterCheck, AvailableServiceData data,
    HomeScreenController homeScreenController) {
  return Row(
    children: [
      if (filterCheck == "rejected" ||
          filterCheck == "pending" ||
          filterCheck == "1")
        if (data.status.toString().toLowerCase() != "accepted")
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: FarenowButton(
                      title: getTitle(data),
                      onPressed: () {
                        getTitle(data) == "Cancelled"
                            ? Container()
                            : Get.dialog(Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    width: Get.width * 0.8,
                                    height: Get.width * 0.9,
                                    decoration: BoxDecoration(
                                        color: white,
                                        borderRadius:
                                            BorderRadius.circular(50)),
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 16),
                                    child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Container(
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(22)),
                                            child: SvgPicture.asset(
                                                "assets/providerImages/svg/delete.svg"),
                                          ),
                                          const Text(
                                            "Reject Service",
                                            style: TextStyle(
                                                fontSize: 24,
                                                color: AppColors.solidBlue,
                                                fontWeight: FontWeight.w500),
                                          ),
                                          const Text(
                                            "This action will remove this order from your job request list. Click confirm to complete action.",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: Color(0xff555555),
                                                fontWeight: FontWeight.w400),
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Flexible(
                                                child: FarenowButton(
                                                  style:
                                                      FarenowButtonStyleModel(
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                                  horizontal:
                                                                      12,
                                                                  vertical: 4)),
                                                  title: 'Cancel',
                                                  onPressed: () {
                                                    Get.back();
                                                  },
                                                  type: BUTTONTYPE.action,
                                                ),
                                              ),
                                              Flexible(
                                                child: FarenowButton(
                                                  style:
                                                      FarenowButtonStyleModel(
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                                  horizontal:
                                                                      12,
                                                                  vertical: 4)),
                                                  title: 'Submit',
                                                  onPressed: () {
                                                    if (filterCheck == "1" &&
                                                        data.status
                                                                .toString()
                                                                .toLowerCase() ==
                                                            "pending") {
                                                      Map body =
                                                          <String, String>{
                                                        "status": "REJECTED"
                                                      };
                                                      homeScreenController
                                                          .acceptOrRejectChat(
                                                              data.id, body);
                                                    } else if (data.status
                                                            .toLowerCase() !=
                                                        "rejected") {
                                                      homeScreenController
                                                          .updateStatus(data.id,
                                                              "REJECTED");
                                                    }
                                                    Get.back();
                                                  },
                                                  type: BUTTONTYPE.rectangular,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ]),
                                  )
                                ],
                              ));
                      },
                      style: FarenowButtonStyleModel(padding: EdgeInsets.zero),
                      type: BUTTONTYPE.action),
                ),
              ],
            ),
          ),
      if (data.status.toString().toLowerCase() == "pending")
        const SizedBox(
          width: 12,
        ),
      if (filterCheck == "accepted" ||
          filterCheck == "pending" ||
          filterCheck == "1")
        if (data.status.toString().toLowerCase() != "rejected")
          Expanded(
            child: FarenowButton(
                title: passTitle(data),
                onPressed: () {
                  if (data.status.toLowerCase() == "accepted" &&
                      data.directContact == 1) {
                    print("");
                    String userId = data.userId.toString();
                    String providerId = data.providerId;
                    String name = getUserName(data.user);
                    Get.to(ChatScreen(
                      senderId: providerId,
                      receiverId: userId,
                      orderId: data.id,
                      name: name,
                    ));
                  } else if (filterCheck == "1" &&
                      data.status.toString().toLowerCase() == "pending") {
                    Map body = <String, String>{"status": "ACCEPTED"};
                    homeScreenController.acceptOrRejectChat(data.id, body);
                  } else if (data.status.toLowerCase() != "accepted") {
                    homeScreenController.updateStatus(data.id, "ACCEPTED");
                  }
                },
                style: FarenowButtonStyleModel(padding: EdgeInsets.zero),
                type: BUTTONTYPE.rectangular),
          )
    ],
  );
}

String getUserName(UserDataModel user) {
  if (user.firstName == null) {
    return "N/A";
  }
  return "${user.firstName} ${user.lastName ?? ""}";
}

String getTitle(AvailableServiceData data) {
  if (data.status.toLowerCase() == "rejected") {
    return "Cancelled";
  }
  if (data.directContact == 1 && data.address == null) {
    return "decline".capitalizeFirst!;
  }
  return "Reject";
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
