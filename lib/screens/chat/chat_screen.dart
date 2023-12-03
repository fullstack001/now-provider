import 'package:fare_now_provider/api_service/service_repository.dart';
import 'package:fare_now_provider/custom_packages/keyboard_overlay/keyboard_overlay.dart';
import 'package:fare_now_provider/models/chat/user_chat.dart';
import 'package:fare_now_provider/models/chat/user_chat_data.dart';
import 'package:fare_now_provider/models/chat/user_chat_list_data.dart';
import 'package:fare_now_provider/models/chat/user_chat_response.dart';
import 'package:fare_now_provider/util/api_utils.dart';
import 'package:fare_now_provider/util/app_colors.dart';
import 'package:fare_now_provider/util/date_time_utills.dart';
import 'package:fare_now_provider/util/shared_reference.dart';
import 'package:fare_now_provider/util/widgest_utills.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:laravel_echo/laravel_echo.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

import 'chatt_controller.dart';

class ChatScreen extends StatefulWidget {
  @required
  final senderId;
  @required
  final receiverId;
  final onUpdate;
  @required
  final name;
  final orderId;
  final isComplete;

  ChatScreen({
    Key? key,
    this.receiverId,
    this.isComplete,
    this.senderId,
    this.onUpdate,
    this.name,
    this.orderId,
  }) : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen>
    with HandleFocusNodesOverlayMixin {
  var messageController = TextEditingController();
  ChatController _chatController = Get.find();
  int line = 75;
  ScrollController _controller = ScrollController();

  List<UserChat> chatList = [];
  bool loading = false;
  var messageNode = FocusNode();
  var keyboardVisibilityController = KeyboardVisibilityController();
  bool hasFocus = false;

  @override
  void initState() {
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
      _chatController.fetchUserChat(
          id: widget.receiverId,
          orderId: widget.orderId,
          update: () {
            setState(() {});
          });
// Create echo instance
      setPagination();

      IO.Socket socket = IO.io('wss://api.farenow.com/socket.io');
      Echo echo = Echo(client: socket);
      socket.on('connect', (_) {
        print('connected');
      });

// Listening public channel
      echo
          .channel('newMessage-${widget.senderId}-${widget.receiverId}')
          .listen('MessageEvent', (e) {
        print(e);
        _chatController.fetchUserChat(
            id: widget.receiverId,
            orderId: widget.orderId,
            update: () {
              setState(() {});
            });
      });
      IO.Socket socket1 = IO.io('wss://api.farenow.com/socket.io');
      Echo echo1 = Echo(client: socket1);
      socket1.on('connect', (_) {
        print('connected');
      }); // Create ech
      /*Echo echo1 = Echo({
        'broadcaster': 'socket.io',
        'client': IO.io,
        "host": 'https://api.farenow.com',
      });

      echo1.socket.on('connect', (_) {
        print('connected');
      });*/

// Listening public channel
      echo1
          .channel('newMessage-${widget.receiverId}-${widget.senderId}')
          .listen('MessageEvent', (e) {
        print(e);
        _chatController.fetchUserChat(
            id: widget.receiverId,
            orderId: widget.orderId,
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
    } catch (e) {
      print(e);
    }
    refresh();
  }

  List<UserChatListData>? userChatListData = [];

  void refresh() {
    setState(() {
      _chatController.fetchUserChat(
          id: widget.receiverId,
          orderId: widget.orderId,
          update: () {
            setState(() {});
          });
      print("Refresh Called");
    });
  }

  void dispose() {
    userChatListData!.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // line = 45;
    // chatList = chatList.reversed.toList();
    chatOpen = true;
    if (_chatController.chatData.value.userChatData != null) {
      List data = _chatController.chatData.value.userChatData.userChatListData;
      userChatListData = data.cast<UserChatListData>();
    }

    return WillPopScope(
      onWillPop: () async {
        chatOpen = false;
        Get.back();
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          centerTitle: false,
          iconTheme: IconTheme.of(context).copyWith(color: black),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            color: black,
            onPressed: () {
              chatOpen = false;
              Get.back();
            },
          ),
          title: Text(
            widget.name ?? "",
            style: const TextStyle(
                color: Colors.black, fontSize: 18, fontWeight: FontWeight.w500),
          ),
        ),
        backgroundColor: Colors.grey[200],
        body: Column(
          children: [
            Expanded(
                child: Obx(() => ((_chatController
                                        .chatData.value.userChatData ??
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
                            List listData = _chatController
                                .chatData.value.userChatData.userChatListData;
                            userChatListData =
                                listData.cast<UserChatListData>();
                            return loading &&
                                    index == userChatListData!.length - 1
                                ? Container(
                                    width: Get.width,
                                    child: const Column(
                                      children: [
                                        CircularProgressIndicator(),
                                      ],
                                    ),
                                  )
                                : chatBubble(value, index);
                          },
                        ),
                      ))),
            if ((widget.isComplete ?? 0) != 1)
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
                                        borderSide:
                                            const BorderSide(color: white)),
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(30),
                                        borderSide:
                                            const BorderSide(color: white)),
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

                              Map _body = <String, String>{
                                "receiver_id": widget.receiverId.toString(),
                                "message": messageController.text.toString(),
                                "service_request_id": widget.orderId.toString()
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
                                  } /*widget.onUpdate*/);
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
            // if ((widget.isComplete ?? 0) != 1)
            // customContainer(
            //     width: Get.width,
            //     height: line < 150 ? line : 150,
            //     color: Colors.white,
            //     allRadius: 40,
            //     marginLeft: 24,
            //     marginRight: 24,
            //     marginBottom: 18,
            //     paddingLeft: 18,
            //     paddingRight: 8,
            //     child: Row(
            //       children: [
            //         Expanded(
            //             child: TextField(
            //           focusNode: messageNode,
            //           controller: messageController,
            //           keyboardType: TextInputType.multiline,
            //           maxLines: 10,
            //           textInputAction: TextInputAction.newline,
            //           onChanged: (val) {
            //             print(val);
            //             int count = val.split("\n").length;
            //             if (count > 1) {
            //               count = count - 1;
            //               line = 45 + (25 * count);
            //             } else {
            //               line = 45;
            //             }
            //             setState(() {});
            //           },
            //           decoration: InputDecoration(
            //               hintText: "Type a message",
            //               hintStyle: TextStyle(color: Colors.grey.shade500),
            //               border: InputBorder.none),
            //         )),
            //         SizedBox(
            //           width: 12,
            //         ),
            //         InkWell(
            //           onTap: () {
            // if (messageController.text.isEmpty) {
            //   return;
            // }

            // Map _body = <String, String>{
            //   "receiver_id": widget.receiverId.toString(),
            //   "message": messageController.text.toString(),
            //   "service_request_id": widget.orderId.toString()
            // };

            // UserChatListData data = UserChatListData(
            //     senderId: widget.senderId,
            //     receiverId: widget.receiverId,
            //     message: messageController.text);
            // if (userChatListData!.isNotEmpty) {
            //   userChatListData!.insert(0, data);
            // } else {
            //   userChatListData!.add(data);
            // }
            // UserChat userChat = UserChat(
            //     message: messageController.text.toString(),
            //     time: DateTime.now());
            // chatList.add(userChat);
            // messageController.text = "";

            // // UserChatListData value = userChatListData[index];

            // setState(() {});
            // _chatController.sendMessage(
            //     body: _body, onUpdate: widget.onUpdate);
            //           },
            //           child: customContainer(
            //               allRadius: 30,
            //               width: 40,
            //               height: 40,
            //               child: Icon(
            //                 Icons.send,
            //                 color: Colors.white,
            //               ),
            //               color: messageController.text.isEmpty
            //                   ? Colors.grey
            //                   : AppColors.appGreen),
            //         ),
            //       ],
            //     )),

            if (hasFocus)
              const SizedBox(
                height: 40,
              ),
          ],
        ),
      ),
    );
  }

  String getTime(String time) {
    DateTime dateTime = DateTimeUtils().convertStringWoT(time);
    String convertedTime = DateTimeUtils().parseDateTime(dateTime, "hh:mm aa");
    return convertedTime;
  }

  void setPagination() {
    _controller.addListener(() async {
      if (_controller.position.atEdge && _controller.position.pixels != 0) {
        print("pagination");
        if (_chatController.chatData.value.userChatData.nextPageUrl != null) {
          loading = true;
          setState(() {});
          String page = _chatController.chatData.value.userChatData.nextPageUrl
              .split("page=")[1];
          print(page);
          ServiceReposiotry _repo = ServiceReposiotry();
          String? authToken =
              await SharedRefrence().getString(key: ApiUtills.authToken);
          UserChatResponse response = await _repo.getUserChat(
              authToken: authToken, id: widget.receiverId, page: page);
          _chatController.chatData.value.userChatData.nextPageUrl =
              response.userChatData.nextPageUrl;
          _chatController.chatData.value.userChatData.userChatListData
              .addAll(response.userChatData.userChatListData);

          loading = false;
          setState(() {});
        }
      }
    });
  }

  checkSender(senderId) {
    if (senderId.toString() == widget.receiverId) {
      return true;
    }
    return false;
  }

  // Widget chatBubble(UserChatListData value, index) {
  //   return ChatBubble(
  //     clipper: ChatBubbleClipper4(
  //         type: checkSender(value)
  //             ? BubbleType.receiverBubble
  //             : BubbleType.sendBubble),
  //     alignment: checkSender(value) ? Alignment.topLeft : Alignment.topRight,
  //     margin: EdgeInsets.only(
  //         top: index == double.parse((userChatListData!.length - 1).toString())
  //             ? 12
  //             : 6,
  //         bottom: index == 0 ? 12 : 0),
  //     backGroundColor: Colors.white,
  //     child: Container(
  //       constraints: BoxConstraints(
  //         maxWidth: MediaQuery.of(context).size.width * 0.7,
  //       ),
  //       child: Stack(
  //         children: <Widget>[
  //           Padding(
  //             padding: const EdgeInsets.only(top: 0),
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
  //                 SizedBox(
  //                   height: 14,
  //                 )
  //               ],
  //             ),
  //           ),

  //           //real additionalInfo
  //           Positioned(
  //             child: Container(
  //               child: value.createdAt != null
  //                   ? RichText(
  //                       text: TextSpan(
  //                         children: <TextSpan>[
  //                           //real message
  //                           TextSpan(
  //                             text: getTime(value.createdAt),
  //                             style:
  //                                 TextStyle(fontSize: 12, color: Colors.grey),
  //                           ),
  //                         ],
  //                       ),
  //                     )
  //                   : SvgPicture.asset(
  //                       'assets/ic_time.svg',
  //                       width: 16,
  //                       color: Colors.grey,
  //                     ),
  //             ),
  //             right: 0.0,
  //             bottom: 0.0,
  //           )
  //         ],
  //       ),
  //     ),
  //   );
  // }

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

  Widget chatBubble(UserChatListData value, index) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Row(
          mainAxisAlignment: checkSender(value.senderId)
              ? MainAxisAlignment.start
              : MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            value.senderDetail != null
                ? checkSender(value.senderId)
                    ? value.senderDetail.image != null
                        ? InkWell(
                            onTap: () {
                              print("widget ${widget.receiverId}");
                              print("post ${checkSender(value)}");
                              print("sender ${value.senderId}");
                              print("reciver ${value.receiverId}");
                              print("sender image ${value.senderDetail.image}");
                              print(
                                  "reciver image ${value.reciverDetail.image}");
                            },
                            child: cacheNetworkImage(
                                radius: 90,
                                imageWidth: 45,
                                imageHeight: 45,
                                fit: BoxFit.cover,
                                imageUrl: ApiUtills.imageBaseUrl +
                                    value.senderDetail.image))
                        : const FittedBox(
                            child: Image(
                            image: AssetImage(
                                "assets/providerImages/png/userPic.png"),
                            width: 45,
                            height: 45,
                          ))
                    : Container()
                : Container(),
            // 5.width,
            Card(
              color: const Color(0xffE0E0E0),
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
                        // width: Get.width * 0.6,
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
            value.senderDetail != null
                ? !checkSender(value.senderId)
                    ? value.senderDetail.image != null
                        ? InkWell(
                            onTap: () {
                              // print("widget ${widget.receiverId}");
                              // print("post ${checkSender(value)}");
                              // print("sender ${value.senderId}");
                              // print("reciver ${value.receiverId}");
                              // print("sender image ${value.senderDetail.image}");
                              // print(
                              //     "reciver image ${value.reciverDetail.image}");
                            },
                            child: value.senderDetail.image == null
                                ? const Image(
                                    image: AssetImage(
                                        "assets/providerImages/png/userPic.png"),
                                    width: 45,
                                    height: 45,
                                  )
                                : cacheNetworkImage(
                                    imageWidth: 45,
                                    imageHeight: 45,
                                    radius: 90,
                                    fit: BoxFit.cover,
                                    imageUrl: ApiUtills.imageBaseUrl +
                                        value.senderDetail.image))
                        : const FittedBox(
                            child: Image(
                            image: AssetImage(
                                "assets/providerImages/png/userPic.png"),
                            width: 45,
                            height: 45,
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
}
