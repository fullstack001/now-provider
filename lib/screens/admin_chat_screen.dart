import 'package:fare_now_provider/api_service/service_repository.dart';
import 'package:fare_now_provider/custom_packages/keyboard_overlay/keyboard_overlay.dart';
import 'package:fare_now_provider/models/chat/user_chat.dart';
import 'package:fare_now_provider/models/chat/user_chat_data.dart';
import 'package:fare_now_provider/models/chat/user_chat_list_data.dart';
import 'package:fare_now_provider/models/chat/user_chat_response.dart';
import 'package:fare_now_provider/screens/chat/chatt_controller.dart';
import 'package:fare_now_provider/util/api_utils.dart';
import 'package:fare_now_provider/util/app_colors.dart';
import 'package:fare_now_provider/util/date_time_utills.dart';
import 'package:fare_now_provider/util/shared_reference.dart';
import 'package:fare_now_provider/util/widgest_utills.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:laravel_echo/laravel_echo.dart';
import 'package:logger/logger.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class AdminChatScreen extends StatefulWidget {
  final senderId;
  final receiverId;

  AdminChatScreen({
    Key? key,
    required this.receiverId,
    required this.senderId,
  }) : super(key: key);

  @override
  _AdminChatScreenState createState() => _AdminChatScreenState();
}

class _AdminChatScreenState extends State<AdminChatScreen>
    with HandleFocusNodesOverlayMixin {
  var messageController = TextEditingController();
  ChatController _chatController = Get.find();
  int line = 70;
  ScrollController _controller = ScrollController();

  List<UserChat> chatList = [];
  bool loading = false;
  var messageNode = FocusNode();
  var keyboardVisibilityController = KeyboardVisibilityController();
  bool hasFocus = false;

  @override
  void initState() {
    print("hello");
    if (GetPlatform.isIOS) {
      messageNode = GetFocusNodeOverlay(
          child: TopKeyboardUtil(
        DoneButtonIos(
          label: 'Done',
          onSubmitted: () => Get.focusScope!.unfocus(),
          platforms: ['android', 'ios'],
        ),
      ));
    }
    super.initState();
    outChat = true;
    try {
      _chatController.adminChat(
          id: widget.receiverId,
          orderId: 0,
          update: () {
            setState(() {});
          });
// Create echo instance
      setPagination();
      IO.Socket socket2 = IO.io('wss://api.farenow.com/socket.io');
      Echo echo = Echo(
        client: socket2,
        broadcaster: EchoBroadcasterType.SocketIO,
      );
      socket2.on('connect', (_) {
        print('connected');
      });

// Listening public channel
      echo
          .channel('newMessage-${widget.senderId}-${widget.receiverId}')
          .error((e) {
        print("");
      }).listen('MessageEvent', (e) {
        print(e);

        _chatController.adminChat(
            id: widget.receiverId,
            hid: true,
            update: () {
              setState(() {});
            });
      });
      // Create ech
      IO.Socket socket1 = IO.io('wss://api.farenow.com/socket.io');
      Echo echo1 = Echo(
        client: socket1,
        broadcaster: EchoBroadcasterType.SocketIO,
      );
      socket1.on('connect', (_) {
        print('connected');
      });

// Listening public channel
      echo1
          .channel('newMessage-${widget.receiverId}-${widget.senderId}')
          .error((e) {
        print("");
      }).listen('MessageEvent', (e) {
        print(e);
        _chatController.adminChat(
            id: widget.receiverId,
            hid: true,
            update: () {
              setState(() {});
            });
      });
// Listening public channel
      echo1
          .channel('newMessage-${widget.receiverId}-${widget.senderId}')
          .error((e) {
        print("");
      }).listen('MessageEvent', (e) {
        print(e);
        _chatController.adminChat(
            id: widget.receiverId,
            hid: true,
            update: () {
              setState(() {});
            });
      });

      if (GetPlatform.isIOS) {
        keyboardVisibilityController.onChange.listen((bool visible) {
          print('Keyboard visibility update. Is visible: $visible');
          hasFocus = !hasFocus;
          setState(() {});
        });
      }
    } catch (exception) {
      Logger().e(exception);
    }
    refresh();
  }

  List<UserChatListData>? userChatListData = [];

  void refresh() {
    setState(() {
      _chatController.adminChat(
          id: widget.receiverId,
          hid: true,
          update: () {
            setState(() {});
          });
      print("Refresh Called");
    });
  }

  @override
  Widget build(BuildContext context) {
    // line = 45;
    // chatList = chatList.reversed.toList();
    chatOpen = true;
    if (_chatController.adminChatData.value.userChatData != null) {
      List data =
          _chatController.adminChatData.value.userChatData.userChatListData;
      userChatListData = data.cast<UserChatListData>();
    }

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        centerTitle: false,
        title: Row(
          children: [
            Stack(
              alignment: Alignment.bottomRight,
              children: [
                const FittedBox(
                  child: Image(
                    image: AssetImage("assets/providerImages/png/userPic.png"),
                    width: 40,
                    height: 40,
                  ),
                ),
                Container(
                  width: 16,
                  height: 16,
                  decoration:
                      const BoxDecoration(shape: BoxShape.circle, color: white),
                  padding: const EdgeInsets.all(2),
                  child: Container(
                    width: 12,
                    height: 12,
                    decoration: const BoxDecoration(
                        color: greenColor, shape: BoxShape.circle),
                  ),
                )
              ],
            ),
            const Text(
              " Admin",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.w500),
            ),
          ],
        ),
        leading: IconButton(
          onPressed: () {
            outChat = false;
            Get.back();
          },
          icon: Icon(
            GetPlatform.isAndroid ? Icons.arrow_back : Icons.arrow_back_ios,
            size: 25,
            color: Colors.black,
          ),
        ),
      ),
      backgroundColor: Colors.grey[200],
      body: Column(
        children: [
          Expanded(
              child: Obx(() => ((_chatController
                                      .adminChatData.value.userChatData ??
                                  UserChatData())
                              .userChatListData ??
                          [])
                      .isEmpty
                  ? Container()
                  : Container(
                      padding: const EdgeInsets.only(left: 12, right: 12),
                      child: ListView.builder(
                        controller: _controller,
                        reverse: true,
                        itemCount: (userChatListData ?? []).length,
                        itemBuilder: (BuildContext context, int index) {
                          // int index = (userChatListData.length - 1) - ind;
                          UserChatListData value = userChatListData![index];
                          List listData = _chatController.adminChatData.value
                              .userChatData.userChatListData;
                          userChatListData = listData.cast<UserChatListData>();
                          return loading &&
                                  index == userChatListData!.length - 1
                              ? Container(
                                  width: Get.width,
                                  child: Column(
                                    children: const [
                                      CircularProgressIndicator(),
                                    ],
                                  ),
                                )
                              : chatBubble(value, index);
                        },
                      ),
                    ))),
          // FarenowTextField(
          //   hint: "EnterSOme ",
          //   label: "",
          //   node: messageNode,
          //   controller: messageController,
          // ),

          customContainer(
              width: Get.width,
              height: line < 150 ? line : 150,
              color: AppColors.solidBlue,
              allRadius: 0,
              marginLeft: 0,
              marginRight: 0,
              marginBottom: 0,
              paddingLeft: 6,
              paddingRight: 6,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Flexible(
                    flex: 1,
                    fit: FlexFit.loose,
                    child: InkWell(
                      onTap: () {},
                      child: SvgPicture.asset(
                        "assets/providerImages/svg/gallery-add_sheet.svg",
                        color: white,
                        width: 33,
                        height: 33,
                      ),
                    ),
                  ),
                  Flexible(
                      fit: FlexFit.tight,
                      flex: 5,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        child: Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30)),
                          child: TextField(
                            focusNode: messageNode,
                            controller: messageController,
                            keyboardType: TextInputType.multiline,
                            maxLines: 10,
                            textInputAction: TextInputAction.newline,
                            onChanged: (val) {
                              print(val.length);
                              print(val);
                              int count = val.split("\n").length;
                              if (count > 1) {
                                count = count - 1;
                                print("$count");
                                line = 75 + (25 * count);
                              } else {
                                line = 75;
                              }
                              setState(() {});
                            },
                            decoration: InputDecoration(
                                fillColor: white,
                                filled: true,
                                hintText: "Type a message",
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30),
                                    borderSide: const BorderSide(color: white)),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30),
                                    borderSide: const BorderSide(color: white)),
                                errorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30),
                                    borderSide:
                                        const BorderSide(color: redColor)),
                                hintStyle:
                                    TextStyle(color: Colors.grey.shade500),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30),
                                    borderSide:
                                        const BorderSide(color: white))),
                          ),
                        ),
                      )),
                  Flexible(
                    flex: 1,
                    fit: FlexFit.loose,
                    child: InkWell(
                        onTap: () async {
                          if (messageController.text.isEmpty) {
                            return;
                          }

                          Map _body = <String, dynamic>{
                            "receiver_id": 1,
                            "message": messageController.text.toString(),
                            "is_admin": 1
                          };

                          UserChatListData data = UserChatListData(
                              senderId: widget.senderId,
                              receiverId: widget.receiverId,
                              message: messageController.text);
                          if (userChatListData!.isNotEmpty) {
                            userChatListData!.insert(0, data);
                          } else {
                            userChatListData!.add(data);
                          }
                          UserChat userChat = UserChat(
                              message: messageController.text.toString(),
                              time: DateTime.now());
                          chatList.add(userChat);
                          messageController.text = "";

                          // UserChatListData value = userChatListData[index];

                          setState(() {});
                          _chatController.sendMessage(
                              body: _body,
                              onUpdate: () {
                                refresh();
                              });
                        },
                        child: SvgPicture.asset(
                            "assets/providerImages/svg/send.svg")

                        // customContainer(
                        //     allRadius: 30,
                        //     width: 40,
                        //     height: 40,
                        //     child: const Icon(
                        //       Icons.send,
                        //       color: Colors.white,
                        //     ),
                        //     color: messageController.text.isEmpty
                        //         ? Colors.grey
                        //         : AppColors.appGreen),
                        ),
                  ),
                ],
              )),

          if (hasFocus)
            const SizedBox(
              height: 40,
            ),
        ],
      ),
    );
  }

  String getTime(String time) {
    DateTime dateTime = DateTimeUtils().convertStringWoT(time);
    // String convertedTime = DateTimeUtils().parseDateTime(dateTime, "hh:mm aa");
    String convertedTime = DateFormat("MMM d, yyyy hh:mm aa").format(dateTime);
    return convertedTime;
  }

  void setPagination() {
    _controller.addListener(() async {
      if (_controller.position.atEdge && _controller.position.pixels != 0) {
        print("pagination");
        if (_chatController.adminChatData.value.userChatData.nextPageUrl !=
            null) {
          loading = true;
          setState(() {});
          String page = _chatController
              .adminChatData.value.userChatData.nextPageUrl
              .split("page=")[1];
          print(page);
          ServiceReposiotry _repo = ServiceReposiotry();
          String? authToken =
              await SharedRefrence().getString(key: ApiUtills.authToken);
          UserChatResponse response = await _repo.getUserChat(
              authToken: authToken,
              id: widget.receiverId,
              page: page,
              isAdmin: true);

          _chatController.adminChatData.value.userChatData.nextPageUrl =
              response.userChatData.nextPageUrl;
          _chatController.adminChatData.value.userChatData.userChatListData
              .addAll(response.userChatData.userChatListData);

          loading = false;
          setState(() {});
        }
      }
    });
  }

  checkSender(UserChatListData value) {
    if (value.senderId.toString() == widget.receiverId) {
      return true;
    }
    return false;
  }

  Widget chatBubble(UserChatListData value, index) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Row(
          mainAxisAlignment: checkSender(value)
              ? MainAxisAlignment.start
              : MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            value.senderDetail != null
                ? checkSender(value)
                    ? value.senderDetail.image != null
                        ? cacheNetworkImage(
                            imageWidth: 80,
                            imageHeight: 80,
                            fit: BoxFit.cover,
                            imageUrl: ApiUtills.imageBaseUrl +
                                value.senderDetail.image)
                        : const FittedBox(
                            child: Image(
                            image: AssetImage(
                                "assets/providerImages/png/userPic.png"),
                            width: 40,
                            height: 40,
                          ))
                    : Container()
                : Container(),
            5.width,
            Card(
              color: Color(0xffE0E0E0),
              shape: RoundedRectangleBorder(
                  borderRadius: checkSender(value)
                      ? const BorderRadius.only(
                          topRight: Radius.circular(16),
                          bottomLeft: Radius.circular(16),
                          bottomRight: Radius.circular(16))
                      : const BorderRadius.only(
                          topLeft: Radius.circular(16),
                          bottomLeft: Radius.circular(16),
                          bottomRight: Radius.circular(16))),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      value.createdAt != null
                          ? RichText(
                              text: TextSpan(
                                children: <TextSpan>[
                                  //real message
                                  TextSpan(
                                    text: getTime(value.createdAt),
                                    style: const TextStyle(
                                        fontSize: 12,
                                        color: Color(0xff757575),
                                        fontWeight: FontWeight.w400),
                                  ),
                                ],
                              ),
                            )
                          : SvgPicture.asset(
                              'assets/ic_time.svg',
                              width: 16,
                              color: Colors.grey,
                            ),
                      Container(
                        width: Get.width * 0.6,
                        child: RichText(
                          text: TextSpan(
                            children: <TextSpan>[
                              //real message
                              TextSpan(
                                text: getMessage(value),
                                style: Theme.of(context).textTheme.subtitle1,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ]),
              ),
            ),
            5.width,
            value.reciverDetail != null
                ? !checkSender(value)
                    ? value.reciverDetail.image != null
                        ? cacheNetworkImage(
                            imageWidth: 80,
                            imageHeight: 80,
                            fit: BoxFit.cover,
                            imageUrl: ApiUtills.imageBaseUrl +
                                value.reciverDetail.image)
                        : const FittedBox(
                            child: Image(
                            image: AssetImage(
                                "assets/providerImages/png/userPic.png"),
                            width: 40,
                            height: 40,
                          ))
                    : Container()
                : Container()
          ],
        ));
    // return Padding(
    //   padding: const EdgeInsets.symmetric(vertical: 4),
    //   child: ChatBubble(
    //     clipper: ChatBubbleClipper4(
    //         type: checkSender(value)
    //             ? BubbleType.receiverBubble
    //             : BubbleType.sendBubble),
    //     alignment: checkSender(value) ? Alignment.topLeft : Alignment.topRight,
    //     margin: EdgeInsets.only(
    //         top:
    //             index == double.parse((userChatListData!.length - 1).toString())
    //                 ? 12
    //                 : 6,
    //         bottom: index == 0 ? 12 : 0),
    //     backGroundColor: Colors.white,
    //     child: Container(
    //       constraints: BoxConstraints(
    //         maxWidth: MediaQuery.of(context).size.width * 0.55,
    //       ),
    //       child: Stack(
    //         children: <Widget>[
    //           Positioned(
    //             child: Container(
    //               alignment: Alignment.centerLeft,
    // child: value.createdAt != null
    //     ? RichText(
    //         text: TextSpan(
    //           children: <TextSpan>[
    //             //real message
    //             TextSpan(
    //               text: getTime(value.createdAt),
    //               style: const TextStyle(
    //                   fontSize: 12, color: Colors.grey),
    //             ),
    //           ],
    //         ),
    //       )
    //     : SvgPicture.asset(
    //         'assets/ic_time.svg',
    //         width: 16,
    //         color: Colors.grey,
    //       ),
    //             ),
    //           ),

    //           Padding(
    //             padding: const EdgeInsets.only(top: 22),
    //             child: Column(
    //               children: [
    //                 RichText(
    //                   text: TextSpan(
    //                     children: <TextSpan>[
    //                       //real message
    //                       TextSpan(
    //                         text: getMessage(value),
    //                         style: Theme.of(context).textTheme.subtitle1,
    //                       ),
    //                     ],
    //                   ),
    //                 ),
    //                 const SizedBox(
    //                   height: 14,
    //                 )
    //               ],
    //             ),
    //           ),

    //           //real additionalInfo
    //         ],
    //       ),
    //     ),
    //   ),
    // );
  }

  getMessage(UserChatListData value) {
    String whiteSpaces = "";
    int size = int.parse(
        (value.message!.length < 18 ? (18 - value.message!.length) : 0)
            .toString());
    for (int index = 0; index < size; index++) {
      whiteSpaces = whiteSpaces + " ";
    }

    String finalString = value.message + whiteSpaces;
    //"${value.message}" + "                 "
    return finalString;
  }
}
