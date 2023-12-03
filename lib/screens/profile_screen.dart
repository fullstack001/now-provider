import 'dart:async';

import 'package:fare_now_provider/api_service/service_repository.dart';
import 'package:fare_now_provider/components/buttons-management/part_of_file/part.dart';
import 'package:fare_now_provider/controllers/profile_screen_controller/ProfileScreenController.dart';
import 'package:fare_now_provider/controllers/services/service_controller.dart';
import 'package:fare_now_provider/models/verify_otp/provider_profile_detail.dart';

import 'package:fare_now_provider/screens/Controller/HomeScreenController.dart';
import 'package:fare_now_provider/screens/admin_chat_screen.dart';
import 'package:fare_now_provider/screens/chat/message_controller.dart';
import 'package:fare_now_provider/screens/service_settings.dart';
import 'package:fare_now_provider/util/api_utils.dart';
import 'package:fare_now_provider/util/app_colors.dart';
import 'package:fare_now_provider/util/shared_reference.dart';
import 'package:fare_now_provider/util/widgest_utills.dart';
import 'package:fare_now_provider/widgets/custom_container.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:laravel_echo/laravel_echo.dart';
import 'package:nb_utils/nb_utils.dart';

bool documentFlag = false;
bool slotsFlag = false;

class ProfileScreen extends StatefulWidget {
  static const id = 'profile_screen';

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  ProfileScreenController _controller = Get.find();
  HomeScreenController _homeScreenController = Get.find();
  MessageController _messageController = Get.find();

  Timer? _timer;
  late Echo echo;
  @override
  void initState() {
    super.initState();
    _homeScreenController.getAvailableJobs(flag: true);
    _messageController.getUserList();
    _controller.getProviderProfile(flag: true);
    _controller.getUsrName();
    FirebaseMessaging _firebase = FirebaseMessaging.instance;
    print("fcm");
    _firebase.getToken().then((token) async {
      print("fcm token: $token");
      int platform = GetPlatform.isIOS ? 2 : 1;
      print("plats: ${platform}");
      String? authToken =
          await SharedRefrence().getString(key: ApiUtills.authToken);
      await ServiceReposiotry().uploadToken(token!, authToken, platform);
    });

    _controller.getProviderProfile(
        id: _controller.userData.value.id,
        flag: true,
        upDate: () {
          setState(() {});
        });

    // IO.Socket socket = IO.io('https://api.farenow.com');
    // echo = Echo(client: socket);
    // socket.on('connect', (_) {
    //   print('connected');
    // });

    // echo
    //     .channel("user-status-change-${_controller.userData.value.id}")
    //     .error((e) {
    //   print("");
    // }).listen('UserStatusChangeEvent', (e) {
    //   print(e);
    _controller.getProfile();
    // _controller.getProviderProfile(
    //     id: _controller.userData.value.id,
    //     flag: true,
    //     upDate: () {
    //       print("ookkkk call");
    //     });
    // });

    // Listening public channel

    // _timer = Timer.periodic(Duration(seconds: 1), (timer) {
    //   if (timer.tick % 5 == 1) {
    //     if (_controller.userData.value.status.toString().toLowerCase() ==
    //         "active") {
    //       _timer!.cancel();
    //     }
    //   }
    //
    //   print("sdfsdf");
    // });
  }

  @override
  Widget build(BuildContext context) {
    // echo
    //     .channel("user-status-change-${_controller.userData.value.id}")
    //     .error((e) {
    //   print("");
    // }).listen('UserStatusChangeEvent', (e) {
    //   print(e);
    //_controller.getProfile();
    // _controller.getProviderProfile(
    //     id: _controller.userData.value.id,
    //     flag: true,
    //     upDate: () {
    //       print("ookkkk call");
    //     });
    // });
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 0.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  color: white,
                  width: Get.width,
                  height: Get.width * 0.53,
                  padding: EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Expanded(
                          child: FittedBox(
                            child: Row(
                              children: [
                                Obx(
                                  () => profileImage(
                                      imageWidget: _controller
                                                  .userData.value.image !=
                                              null
                                          ? cacheNetworkImage(
                                              imageWidth: 110,
                                              imageHeight: 110,
                                              fit: BoxFit.cover,
                                              imageUrl: ApiUtills.imageBaseUrl +
                                                  _controller
                                                      .userData.value.image)
                                          : SvgPicture.asset(
                                              "assets/providerImages/svg/user_profile_pics.svg",
                                              alignment: Alignment.centerLeft,
                                            )),
                                ),
                                15.width,
                                Obx(() {
                                  return Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      getName(_controller.userData.value),
                                      5.height,
                                      Text(
                                        "${_controller.userData.value.email ?? ""}",
                                        style: const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                            color: Color(0xff555555)),
                                      ),
                                      7.height,
                                      GestureDetector(
                                          onTap: () {
                                            if (kDebugMode) {
                                              print(_controller.userData.value);
                                              // Get.dialog(FeedBackPage(
                                              //   data: _controller.userData.value,
                                              // ));
                                            }
                                          },
                                          child: Container(
                                            width: 93,
                                            height: 32,
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 2),
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                                color: Color.fromARGB(
                                                    79, 64, 192, 141),
                                                borderRadius:
                                                    BorderRadius.circular(30)),
                                            child: Text(
                                              getStatus(_controller
                                                  .userData.value.status
                                                  .toString()
                                                  .toLowerCase()),
                                              style: const TextStyle(
                                                color: Color(0xff00B181),
                                                fontSize: 16,
                                              ),
                                            ),
                                          )),
                                    ],
                                  );
                                })
                              ],
                            ),
                          ),
                        ),
                        40.height
                      ]),
                ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   children: const [
                //     // Obx(
                //     //   () => profileImage(
                //     //       imageWidget: _controller.userData.value.image != null
                //     //           ? cacheNetworkImage(
                //     //               imageWidth: 110,
                //     //               imageHeight: 110,
                //     //               fit: BoxFit.cover,
                //     //               imageUrl: ApiUtills.imageBaseUrl +
                //     //                   _controller.userData.value.image)
                //     //           : Image.asset(
                //     //               "assets/images/img_profile_place_holder.jpg",
                //     //               width: 90,
                //     //               height: 90,
                //     //               fit: BoxFit.cover,
                //     //             )),
                //     // ),
                //     // const SizedBox(
                //     //     height: 70,
                //     //     child: VerticalDivider(color: Color(0xff979797))),
                //     // Obx(() {
                //     //   return Column(
                //     //     children: [
                //     //       // const Text(
                //     //       //   "Profile Status",
                //     //       //   style: TextStyle(
                //     //       //       fontSize: 14,
                //     //       //       fontWeight: FontWeight.normal,
                //     //       //       color: Color(0xff979797)),
                //     //       // ),
                //     //       // const SizedBox(
                //     //       //   height: 10,
                //     //       // ),
                //     //     //   Container(
                //     //     //     height: 19,
                //     //     //     width: 80,
                //     //     //     child: ElevatedButton(
                //     //     //       onPressed: () {
                //     //     //         if (kDebugMode) {
                //     //     //           print(_controller.userData.value);
                //     //     //           // Get.dialog(FeedBackPage(
                //     //     //           //   data: _controller.userData.value,
                //     //     //           // ));
                //     //     //         }
                //     //     //       },
                //     //     //       style: ButtonStyle(
                //     //     //         padding:
                //     //     //             MaterialStateProperty.all(EdgeInsets.zero),
                //     //     //         backgroundColor:
                //     //     //             MaterialStateProperty.resolveWith<Color>(
                //     //     //           (Set<MaterialState> states) {
                //     //     //             return const Color(
                //     //     //                 0xff40C08C); // Use the component's default.
                //     //     //           },
                //     //     //         ),
                //     //     //         shape: MaterialStateProperty.all<
                //     //     //             RoundedRectangleBorder>(
                //     //     //           const RoundedRectangleBorder(
                //     //     //             borderRadius:
                //     //     //                 BorderRadius.all(Radius.circular(20)),
                //     //     //             // side: BorderSide(
                //     //     //             //     width: 2, color: Color(0xff9be1c4)),
                //     //     //           ),
                //     //     //         ),
                //     //     //       ),
                //     //     //       child: Center(
                //     //     //           child: Text(
                //     //     //         _controller.userData.value.status
                //     //     //             .toString()
                //     //     //             .capitalize!,
                //     //     //         style: const TextStyle(
                //     //     //           color: Colors.white,
                //     //     //           fontSize: 12,
                //     //     //         ),
                //     //     //       )),
                //     //     //     ),
                //     //     //   ),
                //     //     // ],
                //     //   );
                //     // })
                //   ],
                // ),
                // const SizedBox(
                //   height: 24,
                // ),
                // Obx(
                //   () => getName(_controller.userData.value),
                // ),

                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                  child: ListTile(
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 18, vertical: 12),
                    tileColor: white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18)),
                    leading: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(12)),
                      padding: EdgeInsets.all(8),
                      child: SvgPicture.asset(
                        "assets/providerImages/svg/edit.svg",
                        alignment: Alignment.centerLeft,
                      ),
                    ),
                    title: const Text(
                      'Edit Profile',
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 18,
                          color: AppColors.solidBlue),
                    ),
                    trailing: const Icon(
                      Icons.arrow_forward_ios,
                      size: 22,
                      color: Color(0xff555555),
                    ),
                    onTap: () {
                      _controller.getProviderProfile(
                          id: _controller.userData.value.id);
                    },
                  ),
                ),

                //Second

                Container(
                  color: white,
                  child: Column(
                    children: [
                      15.height,
                      Obx(() {
                        return ListTile(
                          onTap: () {
                            _controller.getProfile();
                            Get.to(ServiceSettings());
                            // BottomNavigation.changeProfileWidget(ServiceSettings());
                          },
                          leading: SvgPicture.asset(
                            "assets/providerImages/svg/service_setting.svg",
                            alignment: Alignment.centerLeft,
                          ),
                          title: FittedBox(
                            alignment: Alignment.centerLeft,
                            fit: BoxFit.scaleDown,
                            child: Padding(
                              padding: const EdgeInsets.only(right: 0),
                              child: Row(
                                children: [
                                  const Text(
                                    'Services Settings',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 18,
                                        color: Colors.black),
                                  ),
                                  if (allGood())
                                    CustomContainer(
                                      onTap: () {
                                        String message = "";
                                        // if (!_controller.userData.value.timeSlots &&
                                        //     _controller
                                        //         .userData.value.document.isEmpty &&
                                        //     _controller.userData.value.serviceType !=
                                        //         "MOVING") {
                                        //   message = "Time slots are missing";
                                        // } else if (!_controller
                                        //         .userData.value.timeSlots &&
                                        //     _controller.userData.value.serviceType !=
                                        //         "MOVING") {
                                        //   message = "Time slots are missing";
                                        // } else if (_controller
                                        //     .userData.value.document.isEmpty) {
                                        //   message = "Licence & Documents are missing";
                                        // }
                                        // if (_controller.userData.value.credit ==
                                        //         null &&
                                        //     _controller.userData.value.providerType ==
                                        //         "Business") {
                                        //   message =
                                        //       "$message${_controller.userData.value.timeSlots ? "" : " & "}please add credit into your wallet";
                                        // }
                                        if (_controller.userData.value.schedules == null &&
                                            _controller.userData.value
                                                    .portfolios ==
                                                null &&
                                            _controller.userData.value
                                                    .serviceType !=
                                                "MOVING") {
                                          message = "Time slots are missing";
                                        } else if (!_controller.userData.value
                                                .schedules!.isEmpty &&
                                            _controller.userData.value
                                                    .serviceType !=
                                                "MOVING") {
                                          message = "Time slots are missing";
                                        } else if (_controller.userData.value
                                            .portfolios!.isEmpty) {
                                          message =
                                              "Licence & Documents are missing";
                                        }
                                        // if (_controller.userData.value.credit ==
                                        //         null &&
                                        //     _controller.userData.value.providerType ==
                                        //         "Business") {
                                        //   message =
                                        //       "$message${_controller.userData.value.timeSlots ? "" : " & "}please add credit into your wallet";
                                        // }
                                        Get.defaultDialog(
                                            title: "Alert",
                                            content: Text(
                                              message
                                                  .trim()
                                                  .toString()
                                                  .capitalizeFirst
                                                  .toString(),
                                              textAlign: TextAlign.center,
                                            ),
                                            confirm: MaterialButton(
                                              onPressed: () {
                                                Get.back();
                                              },
                                              child: const Text("Okay"),
                                            ));
                                      },
                                      width: width * 0.0989,
                                      height: height * 0.05,
                                      child: const Icon(
                                        Icons.info_outlined,
                                        color: Colors.redAccent,
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ),
                          trailing: const Icon(
                            Icons.arrow_forward_ios,
                            size: 22,
                            color: Color(0xff555555),
                          ),
                        );
                      }),
                      7.height,
                      const Divider(
                        thickness: 1,
                      ),
                      7.height,
                      ListTile(
                        leading: SvgPicture.asset(
                          "assets/providerImages/svg/personal_setting.svg",
                          alignment: Alignment.centerLeft,
                        ),
                        title: const Text(
                          'Personal Settings',
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 18,
                              color: Colors.black),
                        ),
                        trailing: const Icon(
                          Icons.arrow_forward_ios,
                          size: 22,
                          color: Color(0xff555555),
                        ),
                        onTap: () {
                          _controller.getProviderProfile(
                            id: _controller.userData.value.id,
                          );
                          // BottomNavigation.changeProfileWidget(
                          //     ProfileSettingsScreen());
                        },
                      ),
                      7.height,
                      const Divider(
                        thickness: 1,
                      ),
                      7.height,
                      ListTile(
                        leading: SvgPicture.asset(
                          "assets/providerImages/svg/contact_admin.svg",
                          alignment: Alignment.centerLeft,
                        ),
                        title: const Text(
                          'Contact to Admin',
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 18,
                              color: Colors.black),
                        ),
                        trailing: const Icon(
                          Icons.arrow_forward_ios,
                          size: 22,
                          color: Color(0xff555555),
                        ),
                        onTap: () {
                          var id = _controller.userData.value.id;
                          Get.to(() => AdminChatScreen(
                                senderId: id,
                                receiverId: "1",
                              ));
                        },
                      ),
                      7.height,
                      const Divider(
                        thickness: 1,
                      ),
                      7.height,
                      ListTile(
                        leading: SvgPicture.asset(
                          "assets/providerImages/svg/logout.svg",
                          alignment: Alignment.centerLeft,
                        ),
                        title: const Text(
                          'Logout',
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 18,
                              color: Colors.black),
                        ),
                        trailing: const Icon(
                          Icons.arrow_forward_ios,
                          size: 22,
                          color: Color(0xff555555),
                        ),
                        onTap: () {
                          Get.defaultDialog(
                              title: "Alert",
                              content: const Text("Do you want to log out??"),
                              confirm: MaterialButton(
                                onPressed: () {
                                  // Get.back();
                                  _controller.logout();
                                },
                                child: const Text("Yes"),
                              ),
                              cancel: MaterialButton(
                                onPressed: () {
                                  Get.back();
                                },
                                child: const Text("No"),
                              ));
                        },
                      ),
                      15.height
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  profileImage({imageWidget}) {
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
          ),
          child: ClipOval(
            child: imageWidget,
          ),
        ),
        InkWell(
          onTap: () =>
              _controller.getProviderProfile(id: _controller.userData.value.id),
          child: Padding(
            padding: const EdgeInsets.all(0.0),
            child: Container(
              width: 27,
              height: 27,
              decoration:
                  const BoxDecoration(color: white, shape: BoxShape.circle),
              child: const Icon(
                Icons.circle,
                color: Colors.green,
                size: 22,
              ),
            ),
          ),
        )
      ],
    );
  }

  getName(Provider value) {
    // if (value.providerType == "Business") {
    //   return Text(
    //     value.userProfileModel == null
    //         ? ""
    //         : value.userProfileModel.businessName,
    //     style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
    //   );
    // }
    if (value.providerType == "Business") {
      if (value.status == "ACTIVE") {
        if (value.providerProfile != null) {
          return Text(
            value.providerProfile.businessName != null
                ? value.providerProfile.businessName
                : "",
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
          );
        }
      } else {
        return Text(
          "Inactive account",
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
        );
      }
    }
    // print(value.providerProfile.businessName);
    // print("${getFirstName(value.firstName, value)} ${getLastName(value)}");
    print("bend");
    return Text(
      "${getFirstName(value.firstName, value)} ${getLastName(value)}",
      style: const TextStyle(
          fontSize: 20, fontWeight: FontWeight.w500, color: Color(0xff555555)),
    );

    // return Column(
    //   crossAxisAlignment: CrossAxisAlignment.start,
    //   mainAxisAlignment: MainAxisAlignment.start,
    //   children: [
    //     // Text(
    //     //   "${getFirstName(value.firstName, value)} ${getLastName(value)}",
    //     //   style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
    //     // ),
    //     // Text(
    //     //   getLastName(value),
    //     //   style: const TextStyle(
    //     //     color: Color(0xff979797),
    //     //     fontSize: 30,
    //     //   ),
    //     // ),
    //   ],
    // );
  }

  borderColor() {
    // if (_controller.userData.value.id == null) {
    //   return Colors.red;
    // } else if (!_controller.userData.value.timeSlots &&
    //     _controller.userData.value.serviceType != "MOVING") {
    //   return Colors.red;
    // } else if (_controller.userData.value.document.isEmpty) {
    //   return Colors.red;
    // }
    if (_controller.userData.value.id == null) {
      return Colors.red;
      // } else if (!_controller.userData.value.timeSlots &&
    } else if (!_controller.userData.value.schedules!.isEmpty &&
        _controller.userData.value.serviceType != "MOVING") {
      return Colors.red;
    }
    return Colors.transparent;
  }

  allGood() {
// providerType:
// "Business"
    // if (_controller.userData.value.id == null) {
    //   return true;
    // } else if (!_controller.userData.value.schedules == null &&
    //     _controller.userData.value.docsLicenses == null &&
    //     _controller.userData.value.serviceType != "MOVING") {
    //   return true;
    // } else if (!_controller.userData.value.schedules == null &&
    //     _controller.userData.value.serviceType != "MOVING") {
    //   return true;
    // } else if (_controller.userData.value.docsLicenses == null) {
    //   return true;
    // }

    // version 2
    // if (_controller.userData.value.providerType != "Business") {
    //   if (_controller.userData.value.id == null) {
    //     return true;
    //   } else if ((_controller.userData.value.schedules ?? []).isEmpty &&
    //       _controller.userData.value.serviceType != "MOVING") {
    //     return true;
    //   } else if (_controller.userData.value.status == "PENDING" &&
    //       _controller.userData.value.serviceType != "MOVING") {
    //     return true;
    //   }
    // } else if (_controller.userData.value.providerType == "Business" &&
    //     _controller.userData.value.status != "ACTIVE") {
    //   return true;
    // }
    // return false;

    bool listEmpty = (_controller.userData.value.schedules ?? []).isEmpty;

    if (listEmpty) {
      return true;
    }
    return false;
  }

  String getFirstName(firstName, value) {
    String fName =
        (firstName ?? _controller.firstName.value).toString().capitalizeFirst!;
    if ((value.socialType ?? "").isNotEmpty) {
      return fName.toString().split(" ")[0];
    }
    return fName;
  }

  String getLastName(value) {
    String lName = (value.lastName ?? _controller.firstName.value)
        .toString()
        .capitalizeFirst!;
    if ((value.socialType ?? "").isNotEmpty) {
      String name = lName.toString().split(" ")[0];
      return lName.toString().replaceAll("${name} ", "").capitalizeFirst!;
    }
    return lName;
  }

  String getStatus(String? status) {
    if (status != null) {
      if (status.toLowerCase() == "pending") {
        return "PENDING";
      }
      if (status.toLowerCase() == "suspended") {
        return "SUSPENDED";
      }
      if (status.toLowerCase() == "active") {
        return "ACTIVE";
      }
    }
    return "PENDING";
  }
}
