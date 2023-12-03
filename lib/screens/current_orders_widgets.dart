import 'dart:convert';

import 'package:fare_now_provider/components/buttons-management/part_of_file/part.dart';
import 'package:fare_now_provider/components/buttons-management/style_model.dart';
import 'package:fare_now_provider/controllers/profile_screen_controller/ProfileScreenController.dart';
import 'package:fare_now_provider/models/active_orders_resp/active_orders_data.dart';
import 'package:fare_now_provider/models/chat/user_chat_response.dart';
import 'package:fare_now_provider/screens/Controller/HomeScreenController.dart';
import 'package:fare_now_provider/screens/chat/chat_screen.dart';
import 'package:fare_now_provider/screens/chat/chatt_controller.dart';
import 'package:fare_now_provider/screens/chat/message_controller.dart';
import 'package:fare_now_provider/screens/inbox.dart';
import 'package:fare_now_provider/util/api_utils.dart';
import 'package:fare_now_provider/util/app_colors.dart';
import 'package:fare_now_provider/util/date_time_utills.dart';
import 'package:fare_now_provider/util/widgest_utills.dart';

import 'package:intl/intl.dart';
import 'package:nb_utils/nb_utils.dart';

class CurrentOrdersWidgets extends StatefulWidget {
  final senderId;
  final receiverId;
  final onUpdate;

  CurrentOrdersWidgets({
    Key? key,
    this.senderId,
    this.receiverId,
    this.onUpdate,
  }) : super(key: key);

  @override
  _CurrentOrdersWidgetsState createState() => _CurrentOrdersWidgetsState();
}

class _CurrentOrdersWidgetsState extends State<CurrentOrdersWidgets> {
  final HomeScreenController _screenController = Get.find();
  final MessageController _messageController = Get.find();
  final ProfileScreenController _controller = Get.find();
  final ChatController _chatController = Get.find();

  @override
  Widget build(BuildContext context) {
    outChat = false;
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          elevation: 1,
          backgroundColor: Colors.white,
          centerTitle: false,
          iconTheme: IconTheme.of(context).copyWith(color: black),
          title: const Text(
            "Current Services",
            style: TextStyle(
                color: Colors.black, fontSize: 18, fontWeight: FontWeight.w500),
          ),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: Get.width,
              child: const Padding(
                padding: EdgeInsets.all(10.0),
                /*child: Card(
                  child: TextFormField(
                    onChanged: (val) {},
                    decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.search,
                          color: Colors.black26,
                          size: 18,
                        ),
                        fillColor: AppColors.white,
                        contentPadding: EdgeInsets.symmetric(vertical: 10),
                        border: OutlineInputBorder(borderSide: BorderSide.none),
                        hintText: "Search service you want...",
                        hintStyle:
                            TextStyle(fontSize: 14, color: Colors.black38)),
                  ),
                ),*/
              ),
            ),
            Expanded(
              child: Container(
                width: Get.width,
                height: 130,
                child: Obx(() {
                  var list = _screenController.availableJos.value;
                  return !hasActiveOrder(
                          _messageController.messageList, widget.receiverId)
                      ? emptyNote()
                      // Container(
                      //     alignment: Alignment.center,
                      //     child: const Text(
                      //       "No Active Order",
                      //       textAlign: TextAlign.center,
                      //       style: TextStyle(
                      //           fontSize: 20, fontWeight: FontWeight.bold),
                      //     ),
                      //   )

                      : ListView.builder(
                          itemCount:
                              (getList(_messageController.messageList.value) ??
                                      [])
                                  .length,
                          itemBuilder: (BuildContext context, int index) {
                            List list = _messageController.messageList;
                            ActiveOrdersData value = list[index];

                            return listBuilder(
                                value,
                                index,
                                (getList(_messageController.messageList) ?? [])
                                    .length);
                          },
                        );
                }),
              ),
            )
          ],
        ));
  }

  getProviderName(ActiveOrdersData provider) {
    return "${provider.provider['first_name'].toString().capitalizeFirst} ${provider.provider['last_name'].toString().capitalizeFirst}";
  }

  String checkSince(ActiveOrdersData value) {
    DateTime update = DateTimeUtils().convertString(value.createdAt);
    String since = DateTimeUtils().checkSince(update);
    return DateTimeUtils().checkSince(
        DateFormat("yyyy-MM-ddTHH:mm:ss").parse(value.updatedAt, true));
  }

  checkStatus(ActiveOrdersData value) {
    if (value.status.toString().toLowerCase() == "rejected") {
      return false;
    }
    if (_controller.userData.value.providerType != "Business") {
      // if (_controller.userData.value.userProfileModel.hourlyRate == null) {
      if (_controller.userData.value.providerProfile!.hourlyRate == null) {
        return true;
      }
    }
    if (value.status.toString().toLowerCase() == "accepted") {
      return true;
    }
    return false;
  }

  getTrailingWidget(ActiveOrdersData value, int index) {
    if (value.directContact == 1 &&
        value.address == null &&
        value.status.toString().toLowerCase() != "accepted") {
      return Container(
          width: 120,
          alignment: Alignment.centerRight,
          child: _screenController
                  .availableJos.value.availableServiceData[index].loading
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: const [
                    CircularProgressIndicator(),
                  ],
                )
              : Column(
                  children: [
                    Flexible(
                      child: InkWell(
                        onTap: () {
                          _screenController.availableJos.value
                              .availableServiceData[index].loading = true;
                          setState(() {});
                          Map body = <String, String>{"status": "ACCEPTED"};
                          _screenController.acceptOrRejectChat(value.id, body,
                              update: (res) {
                            var object = json.decode(res);
                            if (!object['error']) {
                              _screenController
                                  .availableJos
                                  .value
                                  .availableServiceData[index]
                                  .status = object['data']['status'];
                              _screenController.availableJos.value
                                  .availableServiceData[index].loading = false;

                              _screenController.getAvailableJobs();
                              _screenController.availableJos.refresh();
                              setState(() {});
                            }
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.all(6),
                          decoration: const BoxDecoration(
                              color: AppColors.solidBlue,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(6))),
                          child: const FittedBox(
                            child: Text(
                              "Accept",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 6,
                    ),
                    Flexible(
                      child: InkWell(
                        onTap: () {
                          _screenController.availableJos.value
                              .availableServiceData[index].loading = true;
                          setState(() {});
                          Map body = <String, String>{"status": "REJECTED"};
                          _screenController.acceptOrRejectChat(value.id, body,
                              update: (res) {
                            var object = json.decode(res);
                            if (!object['error']) {
                              _screenController
                                  .availableJos
                                  .value
                                  .availableServiceData[index]
                                  .status = object['data']['status'];
                              _screenController.availableJos.value
                                  .availableServiceData[index].loading = false;
                              setState(() {});
                            }
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                              color: AppColors.white,
                              border: Border.all(color: AppColors.solidBlue),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(6))),
                          child: const FittedBox(
                            child: Text(
                              "Decline",
                              style: TextStyle(
                                  color: AppColors.solidBlue, fontSize: 12),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ));
    }
    return const Icon(Icons.message_rounded);
  }

  hasActiveOrder(serviceListData, receiverId) {
    for (int index = 0; index < (serviceListData ?? []).length; index++) {
      ActiveOrdersData value = serviceListData[index];
      if (value.provider['id'].toString() == receiverId) {
        if (value.status.toString().toLowerCase() != "pending" ||
            value.status.toString().toLowerCase() != "accepted" ||
            value.status.toString().toLowerCase() != "ended") {
          return true;
        }
      } else if (value.provider['id'] != null) {
        if (value.isReplied == 1 &&
                value.status.toString().toLowerCase() != "completed" ||
            value.status.toString().toLowerCase() != "ended") {
          return false;
        }
      }
    }
    return false;
  }

  getNetworkImage(provider) {
    String url = provider == null ? "" : provider['image'] ?? "";
    if (url.isEmpty) {
      return true;
    }
    return cacheNetworkImage(
        imageUrl: "${ApiUtills.imageBaseUrl + url}",
        imageWidth: 48,
        imageHeight: 48,
        radius: 30,
        placeHolder: "assets/images/img_profile_place_holder.jpg");
  }

  Widget listBuilder(ActiveOrdersData value, int index, size) {
    if (value.provider == null) {
      return emptyContainer();
    }
    return value.provider['id'].toString() != widget.receiverId
        ? Container(
            width: Get.width,
            height: 0,
            color: Colors.red,
          )
        : checkStatus(value)
            ? listItem(value, index, size)
            : emptyContainer();
  }

  listItem(ActiveOrdersData value, int index, size) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 3),
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        color: white,
        child: ListTile(
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          onTap: () {
            outChat = true;
            _chatController.chatData(UserChatResponse());
            Get.to(ChatScreen(
              isComplete: value.isCompleted,
              senderId: widget.senderId,
              receiverId: widget.receiverId,
              orderId: value.id.toString(),
              name: getProviderName(value),
              onUpdate: () async {
                await _messageController.getUserList();
                setState(() {});
              },
            ));
          },
          trailing: getTrailingWidget(value, index),
          leading: getNetworkImage(value.provider) is bool
              ? Container(
                  width: 48,
                  height: 48,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(24)),
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage(
                        'assets/images/img_profile_place_holder.jpg',
                      ),
                    ),
                  ),
                )
              : Container(
                  width: 48,
                  height: 48,
                  child: getNetworkImage(value.provider),
                ),
          title: Text(
            getProviderName(value),
            style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Color(0xff151415)),
          ),
          subtitle: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              3.height,
              Text(
                checkSince(value),
                style: const TextStyle(
                    color: Color(0xff757575),
                    fontSize: 14,
                    fontWeight: FontWeight.w400),
              ),
              Text(
                value.message.message,
                style: const TextStyle(
                    color: Color(0xff555555),
                    fontSize: 14,
                    fontWeight: FontWeight.w400),
              ),
            ],
          ),
        ),
      ),
    );
    // return CustomContainer(
    //   marginLeft: 24,
    //   marginRight: 24,
    // onTap: () {
    //   outChat = true;
    //   _chatController.chatData(UserChatResponse());
    //   Get.to(ChatScreen(
    //     isComplete: value.isCompleted,
    //     senderId: widget.senderId,
    //     receiverId: widget.receiverId,
    //     orderId: value.id.toString(),
    //     name: getProviderName(value),
    //     onUpdate: () async {
    //       await _messageController.getUserList();
    //       setState(() {});
    //     },
    //   ));
    // },
    //   width: Get.width,
    //   shadowColor: Colors.black.withOpacity(0.5),
    //   shadowOffsetY: 3,
    //   shadowSpreadRadius: 4,
    //   shadowBlurRadius: 7,
    //   shadowOffsetX: 3,
    //   color: white,
    //   allRadius: 16,
    //   marginTop: index == 0 ? 0 : 16,
    //   marginBottom: index == size - 1 ? 16 : 0,
    //   child: ListTile(
    //     minVerticalPadding: 10,
    //     trailing: getTrailingWidget(value, index),
    // leading: getNetworkImage(value.provider) is bool
    //     ? Container(
    //         width: 48,
    //         height: 48,
    //         decoration: const BoxDecoration(
    //           borderRadius: BorderRadius.all(Radius.circular(24)),
    //           image: DecorationImage(
    //             fit: BoxFit.cover,
    //             image: AssetImage(
    //               'assets/images/img_profile_place_holder.jpg',
    //             ),
    //           ),
    //         ),
    //       )
    //     : Container(
    //         width: 48,
    //         height: 48,
    //         child: getNetworkImage(value.provider),
    //       ),
    // title: Text(
    //   getProviderName(value),
    //   style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
    // ),
    // subtitle: Text(checkSince(value)),
    //   ),
    // );
  }

  getList(List<dynamic> value) {
    List list = value;
    return list;
  }
}
