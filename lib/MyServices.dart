import 'package:fare_now_provider/models/services_list/provider_sub_services.dart';
import 'package:fare_now_provider/models/services_list/user_service_data.dart';
import 'package:fare_now_provider/models/services_list/user_sub_services.dart';
import 'package:fare_now_provider/util/app_colors.dart';
import 'package:fare_now_provider/widgets/custom_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';

import 'MyServicesController.dart';
import 'controllers/profile_screen_controller/ProfileScreenController.dart';
import 'controllers/services_list_controller.dart';

class MyServices extends StatefulWidget {
  static const id = "my_services_screen";

  MyServices({Key? key}) : super(key: key);

  @override
  State<MyServices> createState() => _MyServicesState();
}

class _MyServicesState extends State<MyServices> {
  ServicesListController _servicesListController =
      Get.put(ServicesListController());

  ProfileScreenController _profileScreenController =
      Get.put(ProfileScreenController());

  MyServicesController myServicesController = Get.put(MyServicesController());
  Set active = {};
  var activeService = 1.obs;

  void _handleTap(index) {
    if (_servicesListController.servicesList.value[index].status == 1) {
      _servicesListController.servicesList.value[index].status = 0;
    } else {
      _servicesListController.servicesList.value[index].status = 1;
    }
    setState(() {
      // active.contains(index) ? active.remove(index) : active.add(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final oldCheckboxTheme = theme.checkboxTheme;

    final newCheckBoxTheme = oldCheckboxTheme.copyWith(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
    );
    return WillPopScope(
        onWillPop: () async {
          _profileScreenController.getProfile();
          return true;
        },
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            title: const Text(
              "My Services",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1),
            ),
            centerTitle: true,
            actions: [
              IconButton(
                  onPressed: () {
                    Get.back();
                  },
                  icon: const Icon(
                    Icons.cancel_outlined,
                    color: Colors.black,
                  ))
            ],
          ),
          body: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                // buildContainer(label: "Electricity & Computers",
                //     value: false,
                //     onToggle: (val) {}),
                // Divider(),
                Obx(() {
                  List list = _servicesListController.servicesList.value;
                  return Container(
                    width: Get.width,
                    height: Get.height,
                    child: ListView(
                      children: [
                        for (int index = 0; index < list.length; index++)
                          serviceItem(list, list.length - 1, index, context),
                        SizedBox(
                          height: 100,
                        )
                      ],
                    ),
                  );
                }),
                // buildContainer(label:"Handyman Services",value: false,onToggle: (val){} ),
                // Divider(),
                // buildContainer(label:"Home Cleaning Services",value: false,onToggle: (val){} ),
                // Divider(),
                // buildContainer(label:"Moving Services",value: false,onToggle: (val){} ),
              ],
            ),
          ),
        ));
  }

  // Container buildContainer({ label, value, onToggle}) {
  serviceItem(list, int size, int index, context) {
    UserServiceData value = list[index];
    bool flag = checkAllFalse(list[index]);
    bool activeFlag = checkSubServicesFlag(value.userSubServices);
    bool parentActive = flag
        ? true
        : (value.status ?? 1) == 0
            ? false
            : true;
    int parentId = index;

    return CustomContainer(
      width: Get.width,
      child: _profileScreenController.userData.value.providerType ==
              'Individual' /* &&
              value.name != "Moving Services"*/
          ? Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    // margin: EdgeInsets.only(
                    //     left: 12,
                    //     right: 12,
                    //     top: index == 0 ? 12 : 6,
                    //     bottom: index == size ? 12 : 0),
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    width: Get.width,
                    height: 70,
                    decoration: const BoxDecoration(
                      color: white,
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            value.name!,
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        // GetBuilder<MyServicesController>(
                        //   builder: (value) =>
                        FlutterSwitch(
                            activeColor: AppColors.solidBlue,
                            height: 35.0,
                            padding: 3,
                            toggleSize: 35.0,
                            // value: active.contains(index) ? true : false,
                            value: parentActive,
                            //todo
                            onToggle: (onToggle) {
                              _handleTap(index);
                              //  value.onBusinessChanged(onToggle);
                              // myServicesController.onIndivisualChanged(onToggle);
                            }),
                        // ),
                        // if (checkAllFalse(list[index]))
                        //   FlutterSwitch(
                        //     width: 50.0,
                        //     height: 23.0,
                        //     valueFontSize: 0,
                        //     toggleSize: 22.0,
                        //     activeColor: getColor(parentActive),
                        //     inactiveColor: Colors.grey,
                        //     value: parentActive ? true : false,
                        //     toggleColor: Colors.white,
                        //     borderRadius: 18.0,
                        //     padding: 2.0,
                        //     showOnOff: true,
                        //     onToggle: (val) {
                        //       bool flag = !parentActive;
                        //       Map<String, dynamic> body = {
                        //         "service_id": value.id,
                        //         "sub_service_id": null,
                        //         "status": flag ? 1 : 0,
                        //       };
                        //
                        //       _servicesListController.updateService(
                        //           body: body,
                        //           serviceUpDate: (value) {
                        //             int id = flag ? 1 : 0;
                        //             print("$flag");
                        //             _servicesListController.servicesList
                        //                 .value[index].status = id;
                        //
                        //             bool isBussiness =
                        //             _profileScreenController
                        //                 .checkUser();
                        //             if (!isBussiness) {
                        //               print("$isBussiness");
                        //               // resetAll();
                        //             } else {
                        //               if (id == 0) {
                        //                 resetOnPosition(index);
                        //               }
                        //             }
                        //             _servicesListController.servicesList
                        //                 .refresh();
                        //           });
                        //     },
                        //   )
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
                        context,
                        index)
                ],
              ),
            ) /*Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  // margin: EdgeInsets.only(
                  //     left: 12,
                  //     right: 12,
                  //     top: index == 0 ? 12 : 6,
                  //     bottom: index == size ? 12 : 0),
                  padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 0),
                  width: Get.width,
                  height: 70,
                  color: AppColors.white,
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          value.name!,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      // GetBuilder<MyServicesController>(
                      //   builder: (value) =>
                      FlutterSwitch(
                          activeColor: AppColors.solidBlue,
                          height: 35.0,
                          padding: 3,
                          toggleSize: 35.0,
                          value: parentActive,
                          //todo
                          onToggle: (onToggle) async {
                            _handleTap(index);
                            // print(_servicesListController.getServiceList());
                            //
                            //   value.isIndivisualChecked.value=true;
                            // value.onIndivisualChanged(onToggle);
                            // myServicesController.onIndivisualChanged(onToggle);
                          }),
                      // ),
                      //     //if (checkAllFalse(list[index]))
                      //       // FlutterSwitch(
                      //       //   width: 50.0,
                      //       //   height: 23.0,
                      //       //   valueFontSize: 0,
                      //       //   toggleSize: 22.0,
                      //       //   activeColor: getColor(parentActive),
                      //       //   inactiveColor: Colors.grey,
                      //       //   value: parentActive ? true : false,
                      //       //   toggleColor: Colors.white,
                      //       //   borderRadius: 30.0,
                      //       //   padding: 0.0,
                      //       //   showOnOff: true,
                      //       //   onToggle: (val) {
                      //       //     bool flag = !parentActive;
                      //       //     Map<String, dynamic> body = {
                      //       //       "service_id": value.id,
                      //       //       "sub_service_id": null,
                      //       //       "status": flag ? 1 : 0,
                      //       //     };
                      //       //
                      //       //     _servicesListController.updateService(
                      //       //         body: body,
                      //       //         serviceUpDate: (value) {
                      //       //           int id = flag ? 1 : 0;
                      //       //           print("$flag");
                      //       //           _servicesListController
                      //       //               .servicesList.value[index].status = id;
                      //       //
                      //       //           bool isBussiness =
                      //       //           _profileScreenController.checkUser();
                      //       //           if (!isBussiness) {
                      //       //             print("$isBussiness");
                      //       //             // resetAll();
                      //       //           } else {
                      //       //             if (id == 0) {
                      //       //               resetOnPosition(index);
                      //       //             }
                      //       //           }
                      //       //           _servicesListController.servicesList
                      //       //               .refresh();
                      //       //         });
                      //       //   },
                      //       // )
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
                      context,
                      index)
              ],
            )*/
          : _profileScreenController.userData.value.providerType != 'Individual'
              ? Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        // margin: EdgeInsets.only(
                        //     left: 12,
                        //     right: 12,
                        //     top: index == 0 ? 12 : 6,
                        //     bottom: index == size ? 12 : 0),
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        width: Get.width,
                        height: 70,
                        decoration: const BoxDecoration(
                          color: white,
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                value.name!,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            // GetBuilder<MyServicesController>(
                            //   builder: (value) =>
                            FlutterSwitch(
                                activeColor: AppColors.solidBlue,
                                height: 35.0,
                                padding: 3,
                                toggleSize: 35.0,
                                // value: active.contains(index) ? true : false,
                                value: parentActive,
                                //todo
                                onToggle: (onToggle) {
                                  _handleTap(index);
                                  //  value.onBusinessChanged(onToggle);
                                  // myServicesController.onIndivisualChanged(onToggle);
                                }),
                            // ),
                            // if (checkAllFalse(list[index]))
                            //   FlutterSwitch(
                            //     width: 50.0,
                            //     height: 23.0,
                            //     valueFontSize: 0,
                            //     toggleSize: 22.0,
                            //     activeColor: getColor(parentActive),
                            //     inactiveColor: Colors.grey,
                            //     value: parentActive ? true : false,
                            //     toggleColor: Colors.white,
                            //     borderRadius: 18.0,
                            //     padding: 2.0,
                            //     showOnOff: true,
                            //     onToggle: (val) {
                            //       bool flag = !parentActive;
                            //       Map<String, dynamic> body = {
                            //         "service_id": value.id,
                            //         "sub_service_id": null,
                            //         "status": flag ? 1 : 0,
                            //       };
                            //
                            //       _servicesListController.updateService(
                            //           body: body,
                            //           serviceUpDate: (value) {
                            //             int id = flag ? 1 : 0;
                            //             print("$flag");
                            //             _servicesListController.servicesList
                            //                 .value[index].status = id;
                            //
                            //             bool isBussiness =
                            //             _profileScreenController
                            //                 .checkUser();
                            //             if (!isBussiness) {
                            //               print("$isBussiness");
                            //               // resetAll();
                            //             } else {
                            //               if (id == 0) {
                            //                 resetOnPosition(index);
                            //               }
                            //             }
                            //             _servicesListController.servicesList
                            //                 .refresh();
                            //           });
                            //     },
                            //   )
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
                            context,
                            index)
                    ],
                  ),
                )
              : Container(),
    );
  }

  getColor(bool status) {
    return status ? AppColors.solidBlue : Colors.transparent;
  }

  subServicesItem(List<UserSubServices> list, int size, int indexX,
      parentActive, parentId, context, index) {
    UserSubServices valueX = list[indexX];
    int status = getProviderStatus(valueX.id!, valueX.providerSubServices!);
    return parentActive
        ? Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            child: Container(
              width: Get.width,
              // height: 30,
              decoration: const BoxDecoration(
                  color: Color.fromRGBO(0, 104, 225, 0.1),
                  borderRadius: BorderRadius.all(Radius.circular(15))),
              child: Theme(
                data: Theme.of(context).copyWith(
                    checkboxTheme: Theme.of(context).checkboxTheme.copyWith(
                          side: const BorderSide(color: AppColors.solidBlue),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                              side: BorderSide(
                                  color: getColor(status == 0 ? false : true))),
                        )),
                //todo
                child: CheckboxListTile(
                  checkColor: Colors.white,
                  // checkboxShape: RoundedRectangleBorder(
                  //     side: BorderSide(color: AppColors.green)),
                  // shape: RoundedRectangleBorder(
                  //     borderRadius: BorderRadius.circular(15),
                  //     side: BorderSide(color: getColor(status == 0 ? false : true))),
                  title: Text("${valueX.name}"),
                  activeColor: getColor(status == 0 ? false : true),
                  value: !parentActive
                      ? false
                      : status == 0
                          ? false
                          : true,
                  onChanged: (value) {
                    //todo
                    if (value == 1) {
                      activeService(1);
                    } else if (value == 2) {
                      activeService(2);
                    } else if (value == 3) {
                      activeService(3);
                    }
                    bool individual =
                        _profileScreenController.userData.value.providerType ==
                            'Individual';
                    int idCheck = isActiveService(
                        _servicesListController.servicesList.value,
                        valueX.serviceId);
                    if (idCheck != valueX.serviceId && individual) {
                      Get.defaultDialog(
                        title: "Alert",
                        content: const Text("Do you want to switch service"),
                        confirm: MaterialButton(
                          onPressed: () {
                            updateService(
                                parentActive, status, valueX, indexX, parentId);
                            Get.back();
                          },
                          child: const Text("Yes"),
                        ),
                        cancel: MaterialButton(
                          onPressed: () {
                            Get.back();
                          },
                          child: const Text("No"),
                        ),
                      );
                    } else {
                      updateService(
                          parentActive, status, valueX, indexX, parentId);
                    }
                  },
                ),
              ),
            ))
        : Container();
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
        for (int indexJ = 0;
            indexJ <
                _servicesListController.servicesList.value[indexK]
                    .userSubServices[index].providerSubServices.length;
            index++) {
          var status = _servicesListController.servicesList.value[indexK]
              .userSubServices[index].providerSubServices[indexJ].status;
          _servicesListController.servicesList.value[indexK]
              .userSubServices[index].providerSubServices[indexJ].status = 0;
        }
      }
    }
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

  bool checkSubServicesFlag(list) {
    for (int index = 0; index < list.length; index++) {
      if (list[index].providerSubServices.isNotEmpty) {
        if (list[index].providerSubServices[0].status == 1) {
          return true;
        }
      }
    }
    return false;
  }
}
