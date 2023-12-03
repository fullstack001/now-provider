import 'package:fare_now_provider/components/buttons-management/part_of_file/part.dart';
import 'package:fare_now_provider/components/buttons-management/style_model.dart';
import 'package:fare_now_provider/models/available_services/available_service_data.dart';
import 'package:fare_now_provider/screens/Controller/HomeScreenController.dart';
import 'package:fare_now_provider/screens/accepted_order_page.dart';
import 'package:fare_now_provider/screens/home_pass_button_screen.dart';
import 'package:fare_now_provider/util/date_time_utills.dart';
import 'package:fare_now_provider/util/home_widgets.dart';
import 'package:fare_now_provider/widgets/data_not_available_widget.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../util/api_utils.dart';
import '../util/widgest_utills.dart';

List pages = [];
List<bool> flags = [true, false, false, false, false];

class ViewRenderWidget {
  getPages(availableJos, HomeScreenController homeScreenController,
      {tabUpDate, tabSelected}) {
    pages.clear();
    var list = [];
    for (int index = 0; index < flags.length; index++) {
      list = index == 0
          ? homeScreenController.requested.value
          : index == 1
              ? homeScreenController.accepted.value.isNotEmpty
                  ? homeScreenController.accepted.value
                  : homeScreenController.onGoing.value
              : index == 2
                  ? homeScreenController.rejected.value
                  : index == 3
                      ? homeScreenController.cancelled.value
                      : index == 4
                          ? homeScreenController.charRequest.value
                          : [];

      list = list.reversed.toList();
      list = resetList(list);

      list.isNotEmpty || list.isEmpty && index == 1
          ? pages.add(
              listOfWidgets(
                list,
                tabSelected,
                homeScreenController,
                index,
                tabUpDate,
              ),
            )
          : index == 4
              ? pages.add(ChatDataNotAvailableWidget())
              : pages.add(DataNotAvailableWidget());
    }

    return pages;
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

  acceptedView(tabSelected, RxList<dynamic> accepted, _screenController) {
    accepted.value.sort((a, b) => a.seconds.compareTo(b.seconds));
    if (accepted.isNotEmpty) {
      return ListView(
        children: [
          for (int indexI = 0; indexI < accepted.length; indexI++)
            if (accepted[indexI].user.id != null)
              AcceptedOrderPage(
                data: accepted[indexI],
                tabSelected: tabSelected,
              )
        ],
      );
    }
    return DataNotAvailableWidget();
  }

  listOfWidgets(
    List<dynamic> list,
    tabSelected,
    HomeScreenController homeScreenController,
    index,
    tabUpDate,
  ) {
    RefreshController _refreshController =
        RefreshController(initialRefresh: false);
    return Column(
      children: [
        if (index == 1) acceptOnGoingTabs(tabUpDate),
        const SizedBox(
          height: 12,
        ),
        sortWidgets(),
        Expanded(
          child: index == 1
              ? Container(
                  child: tabSelected == "accepted"
                      ? acceptedView(tabSelected, homeScreenController.accepted,
                          homeScreenController)
                      : acceptedView(tabSelected, homeScreenController.onGoing,
                          homeScreenController),
                )
              : ListView.builder(
                  itemCount: list.length,
                  itemBuilder: (BuildContext context, int index) {
                    return itemCard(list[index], homeScreenController);
                  },
                ),
        ),
      ],
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

  getDateTime(createdAt) {
    var convertedDateTime = DateTimeUtils().convertStringWoT(createdAt);
    String time = DateTimeUtils()
        .parseDateTime(convertedDateTime, "EE, d MMM y, hh:mm:ss aa");

    return time;
  }
}
