import 'package:fare_now_provider/controllers/profile_screen_controller/ProfileScreenController.dart';
import 'package:fare_now_provider/models/active_orders_resp/active_orders_data.dart';
import 'package:fare_now_provider/models/inbox/inbox_data.dart';
import 'package:fare_now_provider/screens/chat/message_controller.dart';
import 'package:fare_now_provider/screens/current_orders_widgets.dart';
import 'package:fare_now_provider/util/api_utils.dart';
import 'package:fare_now_provider/util/date_time_utills.dart';
import 'package:fare_now_provider/util/widgest_utills.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:nb_utils/nb_utils.dart';

class InboxScreen extends StatefulWidget {
  const InboxScreen({Key? key}) : super(key: key);

  @override
  _InboxScreenState createState() => _InboxScreenState();
}

class _InboxScreenState extends State<InboxScreen> {
  MessageController _messageController = Get.find();
  ProfileScreenController _registrationController = Get.find();

  List<ActiveOrdersData> filterList = [];
  String query = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _messageController.getUserList().then((value) {
      setState(() {});
    });
  }

  var activeOrderList;

  @override
  Widget build(BuildContext context) {
    activeOrderList = getOrderList(_messageController.messageList);
    _messageController.newList(activeOrderList);
    // _messageController.messageList.value.clear();
    return Scaffold(
      backgroundColor: const Color(0xfff5f5f5),
      appBar: AppBar(
        backgroundColor: white,
        elevation: 1,
        centerTitle: true,
        title: const Text(
          "Messages",
          style: TextStyle(
              color: Colors.black, fontSize: 18, fontWeight: FontWeight.w500),
        ),
      ),
      body: Obx(() => _messageController.newList.isEmpty
          ? emptyNote()
          : SingleChildScrollView(
              child: Column(
                children: [
                  20.height,
                  Container(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height * 0.75,
                    child: _messageController.newList.isEmpty
                        ? emptyNote()
                        : checkMessageList(query.isNotEmpty
                                ? filterList
                                : _messageController.newList.value)
                            ? emptyNote()
                            : ListView.builder(
                                itemCount: query.isNotEmpty
                                    ? filterList.length
                                    : _messageController.newList.length,
                                itemBuilder: (context, index) {
                                  ActiveOrdersData value = query.isNotEmpty
                                      ? filterList[index]
                                      : _messageController.newList.value[index];
                                  return checkNull(value)
                                      ? emptyContainer()
                                      : inboxItem(
                                          value,
                                          index,
                                          query.isNotEmpty
                                              ? filterList.length
                                              : _messageController
                                                  .newList.length,
                                        );
                                }),
                  )
                ],
              ),
            )),
    );
  }

  String getName(ActiveOrdersData value) {
    String firstName = value.provider['first_name'].toString().capitalizeFirst!;
    String lastName = value.provider['last_name'].toString().capitalizeFirst!;

    return "$firstName $lastName";
    // return "abc";
  }

  String checkSince(ActiveOrdersData value) {
    DateTime update = DateTimeUtils()
        .convertStringWoT(value.updatedAt ?? DateTime.now().toString());
    String since = DateTimeUtils().checkSince(update);

    return DateTimeUtils().checkSince(
        DateFormat("yyyy-MM-ddTHH:mm:ss").parse(value.updatedAt, true));
  }

  String lastMessage(InboxData value) {
    int senderLastUpdateTime = 0;
    int receiverLastUpdateTime = 0;

    if (value.senderMessage != null) {
      DateTime update = DateTimeUtils().convertStringWoT(
          value.senderMessage.updatedAt ?? DateTime.now().toString());
      String since = DateTimeUtils().checkSince(update);
      print("sender time: $since");
      senderLastUpdateTime = timeInMinutes(update);
    }
    if (value.receiverMessage != null) {
      DateTime update = DateTimeUtils().convertStringWoT(
          value.receiverMessage.updatedAt ?? DateTime.now().toString());
      String since = DateTimeUtils().checkSince(update);
      print("sender time: $since");
      receiverLastUpdateTime = timeInMinutes(update);
    }
    if (value.receiverMessage == null && value.senderMessage == null) {
      return "";
    }
    if (value.senderMessage == null) {
      return value.receiverMessage.message;
    }
    if (value.receiverMessage == null) {
      return value.senderMessage.message;
    }
    if (senderLastUpdateTime == 0) {
      return value.receiverMessage.message;
    }
    if (receiverLastUpdateTime == 0) {
      return value.senderMessage.message;
    }
    if (senderLastUpdateTime < receiverLastUpdateTime) {
      return value.senderMessage.message;
    }

    return value.receiverMessage.message;
  }

  String lastMessageTime(InboxData value) {
    int senderLastUpdateTime = 0;
    int receiverLastUpdateTime = 0;

    if (value.senderMessage != null) {
      DateTime update = DateTimeUtils().convertStringWoT(
          value.senderMessage.updatedAt ?? DateTime.now().toString());
      String since = DateTimeUtils().checkSince(update);
      print("sender time: $since");
      senderLastUpdateTime = timeInMinutes(update);
    }
    if (value.receiverMessage != null) {
      DateTime update = DateTimeUtils().convertStringWoT(
          value.receiverMessage.updatedAt ?? DateTime.now().toString());
      String since = DateTimeUtils().checkSince(update);
      print("sender time: $since");
      receiverLastUpdateTime = timeInMinutes(update);
    }
    if (value.receiverMessage == null && value.senderMessage == null) {
      return value.updatedAt ?? DateTime.now().toString();
    }
    if (value.senderMessage == null) {
      return value.receiverMessage.updatedAt;
    }
    if (value.receiverMessage == null) {
      return value.senderMessage.updatedAt;
    }
    if (senderLastUpdateTime == 0) {
      return value.receiverMessage.updatedAt;
    }
    if (receiverLastUpdateTime == 0) {
      return value.senderMessage.updatedAt;
    }
    if (senderLastUpdateTime < receiverLastUpdateTime) {
      return value.senderMessage.updatedAt;
    }

    return value.receiverMessage.updatedAt;
  }

  int timeInMinutes(DateTime update) {
    final startTime = DateTime(2020, 02, 20, 10, 30);
    final currentTime = DateTime.now();

    final diff_dy = currentTime.difference(update).inDays;
    final diff_hr = currentTime.difference(update).inHours;
    final diff_mn = currentTime.difference(update).inMinutes;
    final diffSc = currentTime.difference(update).inSeconds;

    print(diff_dy);
    print(diff_hr);
    print(diff_mn);
    print(diffSc);
    return diffSc;
  }

  String getImagePath(ActiveOrdersData value) {
    if (value.provider == null) {
      return "";
    }
    String image = value.provider['image'] ?? "";
    if (image.isEmpty) {
      return image;
    }
    return ApiUtills.imageBaseUrl + image;
  }

  checkNull(ActiveOrdersData value) {
    if (value.id == _registrationController.userData.value.id) {
      return false;
    }
    // if (value.provider.firstName == null && value.provider.lastName == null) {
    //   return true;
    // }
    if (value.updatedAt == null) {
      return true;
    }
    return false;
  }

  checkMessageList(object) {
    //InboxData
    print("abc");
    for (int index = 0; index < object.length; index++) {
      if (object[index].provider['id'] !=
          _registrationController.userData.value.id) {
        return false;
      }
    }
    return true;
  }

  isNullValues(InboxData value) {
    if (value.receiverMessage == null && value.senderMessage == null) {
      return true;
    }
    return false;
  }

  inboxItem(ActiveOrdersData value, int index, size) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 3),
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        color: white,
        child: ListTile(
          onTap: () {
            String senderId =
                _registrationController.userData.value.id.toString();
            String receiverId = value.provider['id'].toString();
            Get.to(CurrentOrdersWidgets(
              senderId: senderId,
              receiverId: receiverId,
            ));
          },
          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          leading: Container(
            decoration: const BoxDecoration(shape: BoxShape.circle),
            child: getImagePath(value).isEmpty
                ? Container(
                    width: 70,
                    height: 70,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: AssetImage(
                          'assets/providerImages/png/userPic.png',
                        ),
                      ),
                    ),
                  )
                : cacheNetworkImage(
                    radius: 180,
                    imageWidth: 70,
                    imageHeight: 70,
                    imageUrl: getImagePath(value),
                    placeHolder:
                        'assets/providerImages/png/img_placeholder.png',
                  ),
          ),
          subtitle: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              2.height,
              Text(
                checkSince(value),
                style: const TextStyle(
                    color: Color(0xff757575),
                    fontWeight: FontWeight.w400,
                    fontSize: 14),
              ),
              Marquee(
                directionMarguee: DirectionMarguee.oneDirection,
                direction: Axis.horizontal,
                animationDuration: const Duration(seconds: 5),
                child: Text(
                  value.message.message.toString(),
                  style: const TextStyle(
                      color: Color(0xff555555),
                      fontWeight: FontWeight.w400,
                      fontSize: 14),
                ),
              )
            ],
          ),
          title: Row(
            children: [
              Text(getName(value),
                  style: const TextStyle(
                      color: Color(0xff151415),
                      fontSize: 16,
                      fontWeight: FontWeight.w500)),
              5.width,
              // Icon(
              //   Icons.verified,
              //   color: value.verifiedAt != null ? AppColors.solidBlue : null,
              //   size: 20,
              // )
            ],
          ),
        ),
      ),
    );
    // return CustomContainer(
    //   width: Get.width,
    //   shadowOffsetY: 3,
    //   shadowOffsetX: 3,
    //   allRadius: 16,
    //   marginTop: index == 0 ? 0 : 12,
    //   marginBottom: index == size - 1 ? 12 : 0,
    //   marginLeft: 24,
    //   marginRight: 24,
    //   color: Colors.white,
    //   shadowSpreadRadius: 3,
    //   shadowBlurRadius: 6,
    //   shadowColor: Colors.black.withOpacity(0.5),
    //   child: ListTile(
    //     subtitle: Column(
    //       mainAxisAlignment: MainAxisAlignment.start,
    //       crossAxisAlignment: CrossAxisAlignment.start,
    //       children: [
    //         SizedBox(
    //           height: 5,
    //         ),
    //         Text(
    //           checkSince(value),
    //           style:
    //               TextStyle(color: Colors.black, fontWeight: FontWeight.w100),
    //         )
    //       ],
    //     ),
    // title: Text(getName(value),
    //     style: TextStyle(
    //         color: Colors.black,
    //         fontSize: 18,
    //         fontWeight: FontWeight.bold)),
    //   leading: Container(
    //     width: 48,
    //     height: 48,
    //     decoration: BoxDecoration(shape: BoxShape.circle),
    //     child: getImagePath(value).isEmpty
    //         ? Container(
    //             width: 48,
    //             height: 48,
    //             decoration: BoxDecoration(
    //               borderRadius: BorderRadius.all(Radius.circular(24)),
    //               image: DecorationImage(
    //                 fit: BoxFit.cover,
    //                 image: AssetImage(
    //                   'assets/images/img_profile_place_holder.jpg',
    //                 ),
    //               ),
    //             ),
    //           )
    //         : cacheNetworkImage(
    //             radius: 30,
    //             imageUrl: "${getImagePath(value)}",
    //             placeHolder: 'assets/images/img_profile_place_holder.jpg',
    //           ),
    //   ),
    // ),
    //   onTap: () {
    //     String senderId = _registrationController.userData.value.id.toString();
    //     String receiverId = value.provider['id'].toString();
    //     Get.to(CurrentOrdersWidgets(
    //       senderId: senderId,
    //       receiverId: receiverId,
    //     ));
    //   },
    // );
  }

  getOrderList(RxList<dynamic> messageList) {
    List list = [];
    DateTime now = DateTime.now();

    for (int index = 0; index < messageList.length; index++) {
      ActiveOrdersData value = messageList.value[index];
      if (!existObject(list, value)) {
        var group = getGroup(messageList, value);
        list.add(group);
      }
    }
    list = list.reversed.toList();
    list.sort((a, b) => a.seconds.compareTo(b.seconds));
    return list;
  }

  bool existObject(List<dynamic> list, ActiveOrdersData value) {
    if (value.provider == null) {
      return true;
    }
    for (int index = 0; index < list.length; index++) {
      ActiveOrdersData obj = list[index];
      if (value.provider['id'] == obj.provider['id']) {
        return true;
      }
    }

    return false;
  }

  getGroup(RxList<dynamic> messageList, ActiveOrdersData valueX) {
    List list = [];
    for (int index = 0; index < messageList.length; index++) {
      ActiveOrdersData value = messageList.value[index];
      if (value.provider != null) {
        if (value.provider['id'] == valueX.provider['id']) {
          print("");
          list.add(value);
        }
      }
    }
    var objects = list.reduce((a, b) => a.seconds < b.seconds ? a : b);
    return objects;
  }
}

emptyNote() {
  return FittedBox(
    alignment: Alignment.center,
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18),
      child: SvgPicture.asset(
        'assets/providerImages/svg/no_message.svg',
        width: Get.width,
        fit: BoxFit.scaleDown,
        alignment: Alignment.center,
        height: Get.width,
      ),
    ),
  );
}
