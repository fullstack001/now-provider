import 'package:fare_now_provider/controllers/profile_screen_controller/ProfileScreenController.dart';
import 'package:fare_now_provider/controllers/services_list_controller.dart';
import 'package:fare_now_provider/models/services_list/provider_sub_services.dart';
import 'package:fare_now_provider/models/services_list/user_service_data.dart';
import 'package:fare_now_provider/models/services_list/user_sub_services.dart';
import 'package:fare_now_provider/util/app_colors.dart';
import 'package:fare_now_provider/widgets/custom_container.dart';
import 'package:fare_now_provider/widgets/custom_toolbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';

class MyServicesListScreen extends StatelessWidget {
  MyServicesListScreen({Key? key}) : super(key: key);

  ServicesListController _servicesListController = Get.find();
  ProfileScreenController _profileScreenController = Get.find();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        _profileScreenController.getProfile();
        return true;
      },
      child: Scaffold(
        // backgroundColor: Color(0xffE0E0E0),
        backgroundColor: Colors.white24,
        appBar: AppBar(
          elevation: 1,
          iconTheme: IconTheme.of(context).copyWith(color: black),
          backgroundColor: white,
          title: Text(
            "My Services",
            style: TextStyle(color: black),
          ),
        ),
        body: Obx(() {
          List list = _servicesListController.servicesList.value;
          return Container(
            width: Get.width,
            height: Get.height,
            child: ListView(
              children: [
                for (int index = 0; index < list.length; index++)
                  serviceItem(list, list.length - 1, index)
              ],
            ),
          );
        }),
      ),
    );
  }

  serviceItem(list, int size, int index) {
    UserServiceData value = list[index];
    bool flag = checkAllFalse(list[index]);
    bool parentActive = !flag
        ? true
        : (value.status ?? 1) == 0
            ? false
            : true;
    int parentId = index;

    return CustomContainer(
      width: Get.width,
      child: _profileScreenController.userData.value.providerType ==
                  'Individual' &&
              value.name != "Moving Services"
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  // margin: EdgeInsets.only(
                  //     left: 12,
                  //     right: 12,
                  //     top: index == 0 ? 12 : 6,
                  //     bottom: index == size ? 12 : 0),
                  padding: EdgeInsets.symmetric(horizontal: 0, vertical: 12),
                  width: Get.width,
                  height: 50,
                  color: AppColors.white,
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          value.name!,
                          style: TextStyle(color: Colors.black, fontSize: 18),
                        ),
                      ),
                      if (checkAllFalse(list[index]))
                        FlutterSwitch(
                          width: 50.0,
                          height: 23.0,
                          valueFontSize: 0,
                          toggleSize: 22.0,
                          activeColor: getColor(parentActive),
                          inactiveColor: Colors.grey,
                          value: parentActive ? true : false,
                          toggleColor: Colors.white,
                          borderRadius: 30.0,
                          padding: 0.0,
                          showOnOff: true,
                          onToggle: (val) {
                            bool flag = !parentActive;
                            Map<String, dynamic> body = {
                              "service_id": value.id,
                              "sub_service_id": null,
                              "status": flag ? 1 : 0,
                            };

                            _servicesListController.updateService(
                                body: body,
                                serviceUpDate: (value) {
                                  int id = flag ? 1 : 0;
                                  print("$flag");
                                  _servicesListController
                                      .servicesList.value[index].status = id;

                                  bool isBussiness =
                                      _profileScreenController.checkUser();
                                  if (!isBussiness) {
                                    print("$isBussiness");
                                    // resetAll();
                                  } else {
                                    if (id == 0) {
                                      resetOnPosition(index);
                                    }
                                  }
                                  _servicesListController.servicesList
                                      .refresh();
                                });
                          },
                        )
                    ],
                  ),
                ),
                for (int indexX = 0;
                    indexX < value.userSubServices!.length;
                    indexX++)
                  subServicesItem(
                    value.userSubServices!,
                    value.userSubServices!.length - 1,
                    indexX,
                    parentActive,
                    parentId,
                  )
              ],
            )
          : _profileScreenController.userData.value.providerType != 'Individual'
              ? Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 0, vertical: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        // margin: EdgeInsets.only(
                        //     left: 12,
                        //     right: 12,
                        //     top: index == 0 ? 12 : 6,
                        //     bottom: index == size ? 12 : 0),
                        padding: EdgeInsets.symmetric(horizontal: 12),
                        width: Get.width,
                        height: 50,
                        decoration: BoxDecoration(
                          color: white,
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                value.name!,
                                style: TextStyle(
                                    color: Colors.black, fontSize: 18),
                              ),
                            ),
                            if (checkAllFalse(list[index]))
                              FlutterSwitch(
                                width: 50.0,
                                height: 23.0,
                                valueFontSize: 0,
                                toggleSize: 22.0,
                                activeColor: getColor(parentActive),
                                inactiveColor: Colors.grey,
                                value: parentActive ? true : false,
                                toggleColor: Colors.white,
                                borderRadius: 18.0,
                                padding: 2.0,
                                showOnOff: true,
                                onToggle: (val) {
                                  bool flag = !parentActive;
                                  Map<String, dynamic> body = {
                                    "service_id": value.id,
                                    "sub_service_id": null,
                                    "status": flag ? 1 : 0,
                                  };

                                  _servicesListController.updateService(
                                      body: body,
                                      serviceUpDate: (value) {
                                        int id = flag ? 1 : 0;
                                        print("$flag");
                                        _servicesListController.servicesList
                                            .value[index].status = id;

                                        bool isBussiness =
                                            _profileScreenController
                                                .checkUser();
                                        if (!isBussiness) {
                                          print("$isBussiness");
                                          // resetAll();
                                        } else {
                                          if (id == 0) {
                                            resetOnPosition(index);
                                          }
                                        }
                                        _servicesListController.servicesList
                                            .refresh();
                                      });
                                },
                              )
                          ],
                        ),
                      ),
                      for (int indexX = 0;
                          indexX < value.userSubServices!.length;
                          indexX++)
                        subServicesItem(
                          value.userSubServices!,
                          value.userSubServices!.length - 1,
                          indexX,
                          parentActive,
                          parentId,
                        )
                    ],
                  ),
                )
              : Container(),
    );
  }

  subServicesItem(
    List<UserSubServices> list,
    int size,
    int indexX,
    parentActive,
    parentId,
  ) {
    UserSubServices valueX = list[indexX];
    int status = getProviderStatus(valueX.id!, valueX.providerSubServices!);
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        child: Container(
          width: Get.width,
          // height: 30,
          decoration: BoxDecoration(color: Color.fromRGBO(0, 104, 225, 0.1)),

          child: CheckboxListTile(
            checkColor: Colors.white,
            checkboxShape: RoundedRectangleBorder(
                side: BorderSide(color: AppColors.green)),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: BorderSide(color: getColor(status == 0 ? false : true))),
            title: Text("${valueX.name}"),
            activeColor: getColor(status == 0 ? false : true),
            value: !parentActive
                ? false
                : status == 0
                    ? false
                    : true,
            onChanged: (value) {
              bool individual =
                  _profileScreenController.userData.value.providerType ==
                      'Individual';
              int idCheck = isActiveService(
                  _servicesListController.servicesList.value, valueX.serviceId);
              if (idCheck != valueX.serviceId && individual) {
                Get.defaultDialog(
                  title: "Alert",
                  content: Text("Do you want to switch service"),
                  confirm: MaterialButton(
                    onPressed: () {
                      updateService(
                          parentActive, status, valueX, indexX, parentId);
                      Get.back();
                    },
                    child: Text("Yes"),
                  ),
                  cancel: MaterialButton(
                    onPressed: () {
                      Get.back();
                    },
                    child: Text("No"),
                  ),
                );
              } else {
                updateService(parentActive, status, valueX, indexX, parentId);
              }
            },
          ),
        ));

    // Container(
    //   width: Get.width,
    //   height: 30,
    //   margin: EdgeInsets.symmetric(horizontal: 12),
    //   child: Row(
    //     children: [
    //       Expanded(
    //         child: Text(
    //           valueX.name!,
    //           style: TextStyle(color: Colors.black, fontSize: 16),
    //         ),
    //       ),
    //       FlutterSwitch(
    //         width: 50.0,
    //         height: 23.0,
    //         valueFontSize: 0,
    //         toggleSize: 22.0,
    //         activeColor: getColor(status == 0 ? false : true),
    //         inactiveColor: Colors.grey,
    //         value: !parentActive
    //             ? false
    //             : status == 0
    //                 ? false
    //                 : true,
    //         toggleColor: Colors.yellow,
    //         borderRadius: 30.0,
    //         padding: 0.0,
    //         showOnOff: true,
    //         onToggle: (val) {
    //           bool individual =
    //               _profileScreenController.userData.value.providerType ==
    //                   'Individual';
    //           int idCheck = isActiveService(
    //               _servicesListController.servicesList.value, valueX.serviceId);
    //           if (idCheck != valueX.serviceId && individual) {
    //             Get.defaultDialog(
    //               title: "Alert",
    //               content: Text("Do you want to switch service"),
    //               confirm: MaterialButton(
    //                 onPressed: () {
    //                   updateService(
    //                       parentActive, status, valueX, indexX, parentId);
    //                   Get.back();
    //                 },
    //                 child: Text("Yes"),
    //               ),
    //               cancel: MaterialButton(
    //                 onPressed: () {
    //                   Get.back();
    //                 },
    //                 child: Text("No"),
    //               ),
    //             );
    //           } else {
    //             updateService(parentActive, status, valueX, indexX, parentId);
    //           }
    //         },
    //       )
    //     ],
    //   ),
    // );
  }

  getColor(bool status) {
    return status ? AppColors.solidBlue : Colors.transparent;
  }

  int getProviderStatus(int id, List<ProviderSubServices> providerSubServices) {
    for (int index = 0; index < providerSubServices.length; index++) {
      ProviderSubServices vx = providerSubServices[index];
      if (vx.subServiceId == id) {
        return vx.status!;
      }
    }
    return 0;
  }

  void resetOnPosition(int position) {
    for (int index = 0;
        index <
            _servicesListController
                .servicesList.value[position].userSubServices.length;
        index++) {
      print("$index");
      for (int indexJ = 0;
          indexJ <
              _servicesListController.servicesList.value[position]
                  .userSubServices[index].providerSubServices.length;
          index++) {
        var status = _servicesListController.servicesList.value[position]
            .userSubServices[index].providerSubServices[indexJ].status;
        print("$status");
        _servicesListController.servicesList.value[position]
            .userSubServices[index].providerSubServices[indexJ].status = 0;

        print(
            "${_servicesListController.servicesList.value[position].userSubServices[index].providerSubServices[indexJ].status}");
      }
    }
  }

  void resetAll() {
    for (int indexK = 0;
        indexK < _servicesListController.servicesList.value.length;
        indexK++) {
      _servicesListController.servicesList[indexK].status = 0;
      _servicesListController.servicesList.refresh();
      for (int index = 0;
          index <
              _servicesListController
                  .servicesList.value[indexK].userSubServices.length;
          index++) {
        print("$index");
        for (int indexJ = 0;
            indexJ <
                _servicesListController.servicesList.value[indexK]
                    .userSubServices[index].providerSubServices.length;
            index++) {
          var status = _servicesListController.servicesList.value[indexK]
              .userSubServices[index].providerSubServices[indexJ].status;
          print("$status");
          _servicesListController.servicesList.value[indexK]
              .userSubServices[index].providerSubServices[indexJ].status = 0;

          print(
              "${_servicesListController.servicesList.value[indexK].userSubServices[index].providerSubServices[indexJ].status}");
        }
      }
    }

    print("sdfs");
  }

  checkAllFalse(
    UserServiceData list,
  ) {
    for (int index = 0; index < list.userSubServices!.length; index++) {
      UserSubServices value = list.userSubServices![index];
      for (int indexK = 0;
          indexK < value.providerSubServices!.length;
          indexK++) {
        ProviderSubServices valusX = value.providerSubServices![indexK];
        if (valusX.status == 1) {
          return true;
        }
      }
    }
    return false;
  }

  void updateService(parentActive, status, valueX, indexX, parentId) {
    if (parentActive) {
      bool flag = status == 0 ? true : false;
      Map<String, dynamic> body = {
        "sub_service_id": valueX.id,
        "status": flag ? 1 : 0,
      };

      _servicesListController.updateService(
          body: body,
          serviceUpDate: (value) {
            int id = flag ? 1 : 0;
            print("$flag");
            // resetAll();
            if (value != null) {
              List<ProviderSubServices> list = [];
              ProviderSubServices model = ProviderSubServices(
                  id: value.serviceUpdateData.id,
                  status: id,
                  subServiceId: valueX.id);
              list.add(model);
              _servicesListController.servicesList.value[parentId]
                  .userSubServices[indexX].providerSubServices = list;
              _servicesListController.servicesList.refresh();
            } else {
              List datList = _servicesListController.servicesList
                  .value[parentId].userSubServices[indexX].providerSubServices;
              for (int indexY = 0; indexY < datList.length; indexY++) {
                ProviderSubServices newValue = datList[indexY];
                if (newValue.subServiceId == valueX.id) {
                  print("${valueX.id}");
                  _servicesListController
                      .servicesList
                      .value[parentId]
                      .userSubServices[indexX]
                      .providerSubServices[indexY]
                      .status = newValue.status == 1 ? 0 : 1;
                  _servicesListController.servicesList.refresh();
                }
              }
            }
            bool flags = checkAllFalse(
                _servicesListController.servicesList.value[parentId]);

            _servicesListController.servicesList.value[parentId].status =
                flags ? 1 : 0;
            _servicesListController.getServiceList();
          });
    }
  }

  int isActiveService(List<dynamic> value, list) {
    for (int index = 0; index < value.length; index++) {
      if (value[index].status == 1) {
        return value[index].id;
      }
    }
    return list;
  }
}
