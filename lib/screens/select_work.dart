import 'package:fare_now_provider/controllers/profile_screen_controller/ProfileScreenController.dart';
import 'package:fare_now_provider/controllers/services/service_controller.dart';
import 'package:fare_now_provider/controllers/services_list_controller.dart';
import 'package:fare_now_provider/models/main_service_response/datum.dart';
import 'package:fare_now_provider/screens/Controller/add_vehicle_controller.dart';
import 'package:fare_now_provider/screens/offer_services_screen.dart';
import 'package:fare_now_provider/screens/user_services_list.dart';
import 'package:fare_now_provider/util/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';

import 'auth_screen/zipcode/select_zipcode.dart';
import 'moving_list_screen.dart';

class SelectWorkScreen extends StatefulWidget {
  static const id = 'select_work_screen';

  @override
  _SelectWorkScreenState createState() => _SelectWorkScreenState();
}

class _SelectWorkScreenState extends State<SelectWorkScreen> {
  List<String> items = [
    'House Cleaning',
    'House Cleaning',
    'Bounce house and party rental'
  ];
  ServiceController _controller = Get.find();
  ServicesListController _servicesListController =
      Get.put(ServicesListController());
  AddVehicleController _addVehicleController = Get.put(AddVehicleController());
  ProfileScreenController _profileScreenController =
      Get.put(ProfileScreenController());

  @override
  void initState() {
    // TODO: implement initState
    /*setState(() {
      _controller.getToken();
      Future.delayed(const Duration(milliseconds: 100)).then((value) {
        _controller.getServiceList();
      });
    });*/

    _controller
        .getToken()
        .then((value) async => await _controller.getServiceList());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // _controller.getToken();
    // _controller.getServiceList();

    return Obx(() {
      // var data = _controller.zipCode.value;

      final mainServiceList = _controller.serviceList;
      List list = _servicesListController.servicesList.value;

      return Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // SizedBox(width: Get.width, height: 200, child: Step5()),
            // SizedBox(
            //   height: 12,
            // ),
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 15.0),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //     children: [
            //       Text(
            //         "What's your line of work?",
            //         style: TextStyle(
            //           color: Colors.black,
            //           fontSize: 20,
            //           fontWeight: FontWeight.w500,
            //         ),
            //       ),
            //       IconButton(
            //           icon: Icon(
            //             Icons.clear,
            //             color: Colors.grey,
            //           ),
            //           onPressed: () {
            //             Get.back();
            //           })
            //     ],
            //   ),
            // ),
            const SizedBox(
              height: 12,
            ),
            Expanded(
                child: UserServicesList(
              isRado: false,
            )),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              width: Get.width,
              child: Material(
                elevation: 5,
                borderRadius: const BorderRadius.all(Radius.circular(12)),
                color: AppColors.solidBlue,
                child: InkWell(
                  onTap: () {
                    print("dsf");

                    bool movingExist = movingCheck(mainServiceList);
                    print("$movingExist");

                    if (movingExist) {
                      Get.to(() => MovingListScreen());
                    } else {
                      Get.to(SelectZipcodeScreen());
                    }
                    _controller.getServiceList(flag: true);
                  },
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    alignment: Alignment.center,
                    width: Get.width,
                    child: Text(
                      movingCheck(list) ? "Next" : "Submit",
                      style:
                          const TextStyle(fontSize: 18, color: AppColors.white),
                    ),
                  ),
                ),
              ),
            ),
            10.height,
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 15.0),
            //   child: TextField(
            //     decoration: InputDecoration(
            //       hintText: "Enter your line of work",
            //       hintStyle: TextStyle(
            //           fontWeight: FontWeight.w300, color: Colors.blue),
            //       enabledBorder: new OutlineInputBorder(
            //           borderRadius: BorderRadius.circular(8),
            //           borderSide: new BorderSide(color: Colors.blue)),
            //       focusedBorder: OutlineInputBorder(
            //         borderSide: BorderSide(color: Colors.blue),
            //       ),
            //     ),
            //   ),
            // ),
            // Expanded(
            //   child: ListView.builder(
            //       itemCount: _controller.serviceList.length,
            //       itemBuilder: (BuildContext context, int index) {
            //         return serviceListItem(index);
            //       }),
            // )
          ],
        ),
      );
    });
  }

  Widget serviceListItem(int index) {
    MainServiceModel data = _controller.serviceList.value[index];
    return GestureDetector(
      onTap: () {
        // Navigator.pushNamed(context, OfferServices.id, arguments: index);
        _controller.serviceIndex(index);
        if (_controller.serviceList.value[index].name
            .toString()
            .toLowerCase()
            .contains("moving")) {
          _controller.selectedServiceType = "moving";
        } else {
          _controller.selectedServiceType = "§";
        }

        Get.toNamed(OfferServices.id);
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Container(
              alignment: Alignment.centerLeft,
              width: Get.width,
              height: 46,
              color: Colors.transparent,
              child: Text(
                data.name ?? "",
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                    color: Colors.grey.shade700),
              ),
            ),
          ),
          const Divider()
        ],
      ),
    );
  }

  bool movingCheck(List<dynamic> list) {
    for (int index = 0; index < list.length; index++) {
      print("$index");
      if (list[index].name.toString().contains("Moving")) {
        for (int indexI = 0;
            indexI < list[index].userSubServices.length;
            indexI++) {
          for (int indexJ = 0;
              indexJ <
                  list[index]
                      .userSubServices[indexI]
                      .providerSubServices
                      .length;
              indexJ++) {
            if (list[index]
                    .userSubServices[indexI]
                    .providerSubServices[indexJ]
                    .status ==
                1) {
              return true;
            }
          }
        }
      }
    }
    return false;
  }
}
