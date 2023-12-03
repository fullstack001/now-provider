import 'package:fare_now_provider/controllers/profile_screen_controller/ProfileScreenController.dart';
import 'package:fare_now_provider/screens/wallet_screens/add_credit_screen.dart';
import 'package:fare_now_provider/screens/wallet_transaction_widget.dart';
import 'package:fare_now_provider/screens/wallet_widget.dart';
import 'package:fare_now_provider/util/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../util/api_utils.dart';
import '../../util/shared_reference.dart';
import '../../util/widgest_utills.dart';
import '../../withdrawscreen.dart';
import 'controller/wallet_controller.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({Key? key}) : super(key: key);

  @override
  _WalletScreenState createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen>
    with SingleTickerProviderStateMixin {
  List<Widget> pages = [
    WalletWidget(),
    WalletTransactionWidget(),
  ];

  var _controller;
  final PageController _pageController = PageController();
  final ProfileScreenController _profileScreenController = Get.find();
  int _selectedIndex = 0;

  final WalletController _walletController = Get.find();
  String currencyValue = "";
  Future countryCurrency() async {
    _profileScreenController
        .fetchDataForCurrency(await SharedRefrence().getIsocode(key: "IsoCode"))
        .then((value) async {
      currencyValue = value!;
      setState(() {
        currencyValue = value;
        _walletController.currencyValue = currencyValue;
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // Create TabController for getting the index of current tab
    _controller = TabController(length: pages.length, vsync: this);
    _walletController.getCredit();
    countryCurrency();
    _controller.addListener(() {
      setState(() {
        _selectedIndex = _controller.index;
      });
      print("Selected Index: " + _controller.index.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          iconTheme: IconTheme.of(context).copyWith(color: black),
          elevation: 0,
          backgroundColor: white,
          title: Row(
            children: [
              _profileScreenController.userData.value.image != null
                  ? cacheNetworkImage(
                      imageWidth: 40,
                      imageHeight: 40,
                      fit: BoxFit.cover,
                      radius: 90,
                      imageUrl: ApiUtills.imageBaseUrl +
                          _profileScreenController.userData.value.image)
                  : const FittedBox(
                      child: Image(
                      image:
                          AssetImage("assets/providerImages/png/userPic.png"),
                      width: 40,
                      height: 40,
                    )),
              8.width,
              Text(
                "${_profileScreenController.firstName.toString().capitalizeFirst} ${_profileScreenController.lastName.toString().capitalizeFirst}",
                style: const TextStyle(
                    color: Color(0xff151415),
                    fontWeight: FontWeight.w700,
                    fontSize: 16),
              )
            ],
          ),
        ),
        backgroundColor: white,
        body: currencyValue!.isEmpty
            ? const Center(
                child: CircularProgressIndicator.adaptive(
                backgroundColor: AppColors.solidBlue,
              ))
            : ListView(
                children: [
                  // Card(
                  //   elevation: 1,
                  //   child: Container(
                  //     // height: 100,
                  //     width: Get.width,
                  //     padding:
                  //         const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  //     child: Row(
                  //         mainAxisAlignment: MainAxisAlignment.start,
                  //         crossAxisAlignment: CrossAxisAlignment.start,
                  //         children: [
                  //           // IconButton(
                  //           //     onPressed: () {}, icon: Icon(Icons.arrow_back_ios)),
                  //           // Row(
                  //           //   children: [
                  //           //     _profileScreenController.userData.value.image != null
                  //           //         ? cacheNetworkImage(
                  //           //             imageWidth: 40,
                  //           //             imageHeight: 40,
                  //           //             fit: BoxFit.cover,
                  //           //             imageUrl: ApiUtills.imageBaseUrl +
                  //           //                 _profileScreenController
                  //           //                     .userData.value.image)
                  //           //         : const FittedBox(
                  //           //             child: Image(
                  //           //             image: AssetImage(
                  //           //                 "assets/providerImages/png/userPic.png"),
                  //           //             width: 40,
                  //           //             height: 40,
                  //           //           )),
                  //           //     5.width,
                  //           //     Text(
                  //           //       "${_profileScreenController.firstName} ${_profileScreenController.lastName}",
                  //           //       style: const TextStyle(
                  //           //           color: Color(0xff151415),
                  //           //           fontWeight: FontWeight.w700,
                  //           //           fontSize: 16),
                  //           //     )
                  //           //   ],
                  //           // ),
                  //           // GestureDetector(
                  //           //   onTap: () {
                  //           //     Get.to(AddCreditScreen.new);
                  //           //   },
                  //           //   child: Container(
                  //           //     padding: const EdgeInsets.symmetric(
                  //           //         horizontal: 8, vertical: 6),
                  //           //     decoration: BoxDecoration(
                  //           //         color: const Color(0xffEBF4FF),
                  //           //         borderRadius: BorderRadius.circular(30)),
                  //           //     child: Row(children: [
                  //           //       const Text(
                  //           //         "Add Credit",
                  //           //         style: TextStyle(
                  //           //             fontWeight: FontWeight.w500,
                  //           //             fontSize: 14,
                  //           //             color: Color(0xff151415)),
                  //           //       ),
                  //           //       12.width,
                  //           //       Container(
                  //           //         decoration: BoxDecoration(
                  //           //             color: Colors.transparent,
                  //           //             border:
                  //           //                 Border.all(color: AppColors.solidBlue),
                  //           //             shape: BoxShape.circle),
                  //           //         padding: const EdgeInsets.all(3),
                  //           //         child: Container(
                  //           //           decoration: const BoxDecoration(
                  //           //               color: AppColors.solidBlue,
                  //           //               shape: BoxShape.circle),
                  //           //           child: const Icon(
                  //           //             Icons.add,
                  //           //             color: white,
                  //           //             size: 22,
                  //           //           ),
                  //           //         ),
                  //           //       )
                  //           //     ]),
                  //           //   ),
                  //           // )
                  //         ]),
                  //   ),
                  // ),

                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 12),
                    child: Column(
                      children: [
                        Container(
                          width: Get.width,
                          height: 102,
                          decoration: BoxDecoration(
                              color: const Color(0xff3B5998),
                              borderRadius: BorderRadius.circular(17)),
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  "Account Balance",
                                  style: TextStyle(
                                      color: white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500),
                                ),
                                5.height,
                                Text(
                                  "$currencyValue ${_profileScreenController.userData.value.credit ?? "0"} ",
                                  // "\$ ${_walletController.getUserCredit.value.data ?? "0"} ",
                                  style: const TextStyle(
                                      fontFamily: "Roboto",
                                      color: white,
                                      fontSize: 24,
                                      fontWeight: FontWeight.w700),
                                )
                              ]),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          child: Row(
                            children: [
                              Flexible(
                                fit: FlexFit.tight,
                                child: InkWell(
                                  onTap: () {
                                    Get.to(AddCreditScreen.new);
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(12),
                                    decoration: BoxDecoration(
                                        color: const Color(0xffE1F5ED),
                                        borderRadius:
                                            BorderRadius.circular(12)),
                                    child: Column(children: [
                                      SvgPicture.asset(
                                          "assets/providerImages/svg/direct-inbox.svg"),
                                      const Text("Deposit")
                                    ]),
                                  ),
                                ),
                              ),
                              12.width,
                              Flexible(
                                fit: FlexFit.tight,
                                child: InkWell(
                                  onTap: () {
                                    Get.to(WithdrawScreen.new);
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(12),
                                    decoration: BoxDecoration(
                                        color: const Color(0xffFED7D7),
                                        borderRadius:
                                            BorderRadius.circular(12)),
                                    child: Column(children: [
                                      SvgPicture.asset(
                                          "assets/providerImages/svg/direct-send.svg"),
                                      const Text("Withdraw")
                                    ]),
                                  ),
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),

                  WalletTransactionWidget(),

                  // Expanded(
                  //   child: Container(
                  //     color: Colors.grey[200],
                  //     child: PageView(
                  //       children: pages,
                  //       controller: _pageController,
                  //       onPageChanged: (index) {
                  //         _selectedIndex = index;
                  //         _controller.index = index;
                  //         _controller.animateTo(_selectedIndex);
                  //       },
                  //     ),
                  //   ),
                  // )
                ],
              ),
      ),
    );
  }
}
