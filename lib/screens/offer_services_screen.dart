import 'package:fare_now_provider/controllers/services/service_controller.dart';
import 'package:fare_now_provider/models/services_model/main/sub_services.dart';
import 'package:fare_now_provider/screens/auth_screen/zipcode/select_zipcode.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/main_service_response/sub_service.dart';

class Service {
  String name;
  bool selected = false;

  Service(this.name);
}

class OfferServices extends StatefulWidget {
  static const id = 'offer_services_screen';

  @override
  _OfferServicesState createState() => _OfferServicesState();
}

class _OfferServicesState extends State<OfferServices> {
  List<Service> services = [
    Service('House Cleaning'),
    Service('House Cleaning'),
    Service('House Cleaning'),
  ];

  ServiceController _controller = Get.find();
  int indexObj = 0;

  @override
  Widget build(BuildContext context) {
    indexObj = _controller.serviceIndex.value;
    return Obx(() => Container(
          color: Colors.white,
          child: SafeArea(
            child: Scaffold(
              backgroundColor: Colors.white,
              body: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 59,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5.0),
                          child: IconButton(
                              icon: Icon(
                                Icons.clear,
                                size: 40,
                              ),
                              onPressed: () {
                                Navigator.pop(context);
                              }),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 45,
                    ),
                    Text(
                      "Select all the services you offer.",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 24,
                          fontWeight: FontWeight.w700),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "You’ll show up in search results and get leads for all services you select.",
                      style: TextStyle(
                          color: Color(0xffBDBDBD),
                          fontWeight: FontWeight.w500,
                          fontSize: 16),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    GestureDetector(
                      onTap: () {
                        // for (Service service in services)
                        //   service.selected = true;
                        for (int index = 0;
                            index <
                                (_controller.serviceList.value[indexObj]
                                        .subServices?.length ??
                                    0);
                            index++) {
                          (_controller.serviceList.value[indexObj]
                                  .subServices?[index] as MainSubServices)
                              .selected = true;
                        }

                        setState(() {});
                      },
                      child: Text(
                        "Select all",
                        style: TextStyle(
                            color: Color(0xff1B80F5),
                            fontWeight: FontWeight.w400,
                            fontSize: 16),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Expanded(
                      child: ListView.builder(
                          itemCount: _controller
                              .serviceList.value[indexObj].subServices?.length,
                          itemBuilder: (BuildContext context, int index) {
                            return subServiceItem(index, indexObj);
                          }),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(
                          vertical: 16, horizontal: 0),
                      child: ButtonTheme(
                        height: 50,
                        child: TextButton(
                          onPressed: () {
                            if (checkClick(_controller
                                .serviceList.value[indexObj].subServices)) {
                              Navigator.pushNamed(
                                  context, SelectZipcodeScreen.id);
                            } else {
                              Get.defaultDialog(
                                  title: "Alert",
                                  content:
                                      Text("You didn't select any service"),
                                  confirm: MaterialButton(
                                    onPressed: () {
                                      Get.back();
                                    },
                                    child: Text("Okay"),
                                  ));
                            }
                          },
                          child: Center(
                              child: Text(
                            "Next".toUpperCase(),
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          )),
                        ),
                      ),
                      decoration: BoxDecoration(
                        color: Color(0xff1B80F5),
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }

  Widget subServiceItem(int index, int indexObj) {
    MainSubService services = _controller
        .serviceList.value[indexObj].subServices?[index] as MainSubService;
    return GestureDetector(
      onTap: () {},
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 8, horizontal: 15),
            child: Row(
              children: [
                Theme(
                  data: Theme.of(context)
                      .copyWith(unselectedWidgetColor: Color(0xff1B80F5)),
                  child: Checkbox(
                    activeColor: const Color(0xff1B80F5),
                    checkColor: Colors.white,
                    onChanged: (value) {
                      services.copyWith(isSelected: !services.isSelected);
                      _controller.serviceList.value[indexObj]
                          .subServices?[index] = services;
                      _controller.updateList(index, indexObj, services);
                      print("abc");
                      setState(() {});
                    },
                    // value: services[index].selected,
                    value: services.isSelected,
                  ),
                ),
                Text(
                  services.name!,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: const Color(0xff757575),
                  ),
                ),
              ],
            ),
          ),
          Divider()
        ],
      ),
    );
  }

  bool checkClick(subServices) {
    for (int index = 0; index < subServices.length; index++) {
      if (subServices[index].selected) {
        return true;
      }
    }
    return false;
  }
}
