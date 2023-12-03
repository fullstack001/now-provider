// import 'package:fare_now_provider/screens/Servicearea.dart';
// import 'package:fare_now_provider/screens/Servicetimings.dart';
import 'package:fare_now_provider/controllers/profile_screen_controller/ProfileScreenController.dart';
import 'package:fare_now_provider/controllers/services_list_controller.dart';
import 'package:fare_now_provider/models/service_settings_model.dart';
import 'package:fare_now_provider/screens/fare_now_pakages/controller/package_controller.dart';
import 'package:fare_now_provider/screens/fare_now_pakages/show_all_packages.dart';
import 'package:fare_now_provider/screens/project_history.dart';
import 'package:fare_now_provider/screens/wallet_screens/wallet_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';

import '../MyServices.dart';
import '../paymentmethodsscreen.dart';
import '../portfolio_controller.dart';
import '../util/app_dialog_utils.dart';
import '../widgets/custom_container.dart';

class ServiceSettings extends StatefulWidget {
  static const id = "service_setting_screen";
  @override
  _ServiceSettingsState createState() => _ServiceSettingsState();
}

class _ServiceSettingsState extends State<ServiceSettings> {
  ProfileScreenController _controller = Get.find();
  PortfolioController _portfolioController = Get.put(PortfolioController());
  ServicesListController _servicesListController =
      Get.put(ServicesListController()); //todo change it back to find
  List<ServiceSettingModel> settingsList = [];
  ProfileScreenController _profileScreenController = Get.find();
  PackageController _packageController=Get.put(PackageController());
  @override
  void initState() {
    _controller.getProviderZipCodes(icon: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Obx(() {
      var data =
          _profileScreenController.userData.value.serviceType == "MOVING";
      _controller.isMover(data);
      createList();
      return WillPopScope(
        onWillPop: () async {
          return true;
        },
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            iconTheme: IconTheme.of(context).copyWith(color: black),
            title: const Text(
              "Services Settings",
              style: TextStyle(color: black),
            ),
          ),
          body: SingleChildScrollView(
              child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                createServiceList(),
                SizedBox(
                  height: Get.height * 60 / 800,
                ),
                GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: Container(
                    margin: const EdgeInsets.only(left: 20),
                    width: width * 0.28,
                    height: height * 0.048,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: const Color(0xffF0F0F0)),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Icon(
                          Icons.arrow_back_ios,
                          color: Color(0xff1B80F5),
                        ),
                        Text(
                          "Back Page",
                          style: TextStyle(
                              fontSize: 13, fontWeight: FontWeight.w500),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          )),
        ),
      );
    });
  }

  void createList() {
    settingsList.clear();
    settingsList.add(
      getObject(
        title: "Services Timings",
        icon: "assets/providerImages/svg/service_timing_icon.svg",
        onTap: () {
          _controller.getServiceTimmings();
        },
        mover: _controller.isMover.value ? false : true,
      ),
    );
    settingsList.add(
      getObject(
          title: "Services Area",
          icon: "assets/providerImages/svg/location.svg",
          onTap: () {
            _controller.getProviderZipCodes();
          },
          mover: true),
    );
    settingsList.add(
      getObject(
          title: "My Services",
          icon: "assets/providerImages/svg/my_service.svg",
          onTap: () {
            _servicesListController.getServiceList(loading: true);
            Get.to(MyServices()); //todo
          },
          mover: true),
    );
    settingsList.add(
      getObject(
          title: "License & Docs",
          icon: "assets/providerImages/svg/license_document.svg",
          onTap: () {
            _controller.getDocumentList();
          },
          mover: true),
    );
    settingsList.add(
      getObject(
          title: "Portfolio",
          icon: "assets/providerImages/svg/portfolio.svg",
          onTap: () {
            // _controller.getDocumentList();
            _portfolioController.getPortfolio();
          },
          mover: true),
    );
    // settingsList.add(
    //   getObject(
    //     title: "Payment Details",
    //     icon: "assets/providerImages/svg/payment_method.svg",
    //     onTap: () {
    //       Get.to(PaymentDetailScreen());
    //     },
    //     mover: _controller.isMover.value ? false : true,
    //   ),
    // );
    settingsList.add(
      getObject(
        title: "Service History",
        icon: "assets/providerImages/svg/service_history.svg",
        onTap: () {
          Get.to(() => ProjectHistory());
        },
        mover: _controller.isMover.value ? false : true,
      ),
    );
    settingsList.add(
      getObject(
        title: "Payment Methods",
        icon: "assets/Icon.svg",
        onTap: () {
          Get.to(() => PaymentMethodsScreen());
        },
        mover: _controller.isMover.value ? false : true,
      ),
    );

    // if (_controller.userData.value.providerType == "Business") {
    //   settingsList.add(
    //     getObject(
    //       title: "Moving History",
    //       icon: "assets/providerImages/svg/.svg",
    //       onTap: () {
    //         Get.to(() => MovingHistoryWidget());
    //       },
    //       mover: _controller.isMover.value ? true : false,
    //     ),
    //   );
    // }
    // if (_controller.userData.value.providerType == "Business") {
    //   settingsList.add(
    //     getObject(
    //       title: "Vehicles",
    //       icon: "assets/providerImages/svg/contact_admin.svg",
    //       onTap: () {
    //         Get.to(() => VehicleListScreen());
    //       },
    //       mover: _controller.isMover.value ? true : false,
    //     ),
    //   );
    // }

    if (_controller.userData.value.providerType == "Business") {
      settingsList.add(
        getObject(
          title: "Wallet",
          icon: "assets/providerImages/svg/wallet.svg",
          onTap: () {
            Get.to(() => const WalletScreen());
          },
          svg: false,
          mover: true,
        ),
      );
    }
    if (_profileScreenController.userData.value.providerType
            .toString()
            .toLowerCase() ==
        "individual") {
      settingsList.add(
        getObject(
          title: "Packages",
          icon: "assets/providerImages/svg/pkg.svg",
          onTap: () {
           _packageController.getPackages();
           //Get.to(() => const ShowAllPackages());
          },
          mover: _controller.isMover.value ? false : true,
        ),
      );
    }
    // }
  }

  createServiceList() {
    return Column(
      children: [
        // Container(
        //   width: 0,
        //   height: 0,
        //   child: Text("${_controller.userData.value.timeSlots}"),
        // ),
        for (int index = 0; index < settingsList.length; index++)
          serViceItem(index, settingsList[index]),
      ],
    );
  }

  serViceItem(int index, ServiceSettingModel model) {
    return Column(
      children: [
        const SizedBox(height: 12),
        Row(
          children: [
            const SizedBox(width: 16),
            model.icon,
            const SizedBox(width: 18),
            Text(
              model.title,
              style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 18,
                  color: Colors.black),
            ),
            const SizedBox(width: 2),
            if (showInfoIcon(model))
              CustomContainer(
                onTap: () {
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
                        "${model.title} missing",
                        textAlign: TextAlign.center,
                      ),
                      confirm: MaterialButton(
                        onPressed: () {
                          Get.back();
                        },
                        child: const Text("Okay"),
                      ));
                },
                width: Get.width * 0.0989,
                height: Get.height * 0.05,
                child: const Icon(
                  Icons.info_outlined,
                  color: Colors.redAccent,
                ),
              ),
            const SizedBox(width: 12).expand(),
            Icon(
              Icons.arrow_forward_ios,
              size: 22,
              color: borderColor(model),
            ),
            const SizedBox(width: 12),
          ],
        ).onTap(() {
          model.onTap();
        }),
        const SizedBox(height: 12),
        const Divider(
          thickness: 1,
        )
      ],
    );
    // return TextWithIcon(
    //   visibility: model.isMover,
    //   // visibility: true,
    //   marginTop: index == 0 ? 0 : 12,
    //   width: Get.width,
    //   alignment: MainAxisAlignment.start,
    //   marginLeft: 12,
    //   title: model.title,
    //   paddingBottom: 8,
    //   fontSize: 18,
    //   containerClick: model.onTap,
    //   fontWeight: FontWeight.w500,
    //   icon: model.icon,
    //   flex: 1,
    //   marginRight: 14,
    //   space: 24,
    //   trailingIcon: CustomContainer(
    //       width: Get.width * 0.0989,
    //       height: Get.height * 0.05,
    //       color: Colors.black.withOpacity(0.25),
    //       borderColor: borderColor(model),
    //       borderWidth: 2,
    //       allRadius: 8,
    //       child: Icon(
    //         Icons.arrow_forward_ios,
    //         color: Colors.black,
    //         size: 14,
    //       )),
    // );
  }

  ServiceSettingModel getObject({
    icon,
    title,
    onTap,
    mover = false,
    svg = false,
  }) {
    return ServiceSettingModel(
        title: "$title",
        icon: Container(
          width: Get.width * 0.09,
          height: Get.height * 0.043,
          decoration: BoxDecoration(
              color: const Color(0xffE5F7FF),
              borderRadius: BorderRadius.circular(15)),
          child: SvgPicture.asset(icon),
        ),
        isMover: mover,
        onTap: onTap);
  }

  borderColor(ServiceSettingModel model) {
    // if (model.title == "Services Timings" &&
    //     !_controller.userData.value.timeSlots) {
    //   return Colors.red;
    // } else if (model.title == "Wallet" &&
    //     _controller.userData.value.credit == null &&
    //     _controller.userData.value.providerType == "Business") {
    //   return Colors.red;
    // }

    // else if (model.title == "License & Docs" &&
    //     _controller.userData.value.document.isEmpty) {
    //   return Colors.red;
    // }
    return const Color(0xff555555);
  }

  showInfoIcon(ServiceSettingModel model) {
    bool listEmpty = (_controller.userData.value.schedules ?? []).isEmpty;
    if (model.title == "Services Timings") {
      if (listEmpty) {
        return true;
      }
    }
    if (model.title == "Services Area") {
      return _controller.zipcodeAvalaible.value;
    }

    return false;
  }
}
