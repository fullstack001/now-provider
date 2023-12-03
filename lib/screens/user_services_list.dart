import 'package:fare_now_provider/controllers/profile_screen_controller/ProfileScreenController.dart';
import 'package:fare_now_provider/controllers/services_list_controller.dart';
import 'package:fare_now_provider/models/main_service_response/datum.dart';
import 'package:fare_now_provider/models/services_list/provider_sub_services.dart';
import 'package:fare_now_provider/models/services_list/user_service_data.dart';
import 'package:fare_now_provider/models/services_list/user_sub_services.dart';
import 'package:fare_now_provider/screens/auth_screen/profile_data_steps/steps_controller/step_controller.dart';
import 'package:fare_now_provider/util/app_colors.dart';
import 'package:fare_now_provider/util/app_dialog_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:nb_utils/nb_utils.dart';

import '../controllers/services/service_controller.dart';
import '../models/main_service_response/sub_service.dart';
import '../util/widgest_utills.dart';
import 'auth_screen/profile_data_steps/steps_appbar.dart';

int parentIndex = 0;
bool expand = false;

class UserServicesList extends StatefulWidget {
  var isRado;

  UserServicesList({Key? key, required this.isRado}) : super(key: key);

  @override
  State<UserServicesList> createState() => _UserServicesListState();
}

class _UserServicesListState extends State<UserServicesList> {
  final ServicesListController _servicesListController = Get.find();
  final ServiceController _controller = Get.find();
  final ProfileScreenController _profileScreenController = Get.find();
  bool status = false;
  @override
  void initState() {
    Logger().d("init state");

    _controller.getServiceList(flag: true);
    // Future.delayed(const Duration(seconds: 5)).then((value) {
    //   _controller.getServiceList();
    //   _controller.serviceList;

    //   _controller.serviceList;
    // });
    super.initState();
  }

  Container boldHeaderText() {
    return Container(
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: const Text(
        "Choose service category",
        style: TextStyle(
            fontSize: 28, fontWeight: FontWeight.w700, color: AppColors.black),
      ),
    );
  }

  Container blackProfileText() {
    return Container(
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: const Text(
        "What is your line of work",
        style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: Color(0xff555555)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      // expand = false;
      // List list = _servicesListController.servicesList;

      // print("pacce ki list ${jsonEncode(anotherList)}");
      // list[parentIndex].expand = expand;
      // if ((anotherList.isNotEmpty)) {
      // anotherList[parentIndex].expand = expand;
      // }
      return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: const Color(0XFFF5F5F5),
        appBar: stepsAppBar(6),
        body: _controller.serviceList.isEmpty
            ? const Center(
                child: CircularProgressIndicator.adaptive(),
              )
            : GetBuilder<StepsController>(
                init: StepsController(),
                builder: (controller) {
                  return Stack(
                    children: [
                      ListView(
                        children: [
                          boldHeaderText(),
                          blackProfileText(),
                          Container(
                            margin: const EdgeInsets.only(left: 12),
                            child: Wrap(
                              children: [
                                for (int index = 0;
                                    index < _controller.serviceList.length;
                                    index++)
                                  serviceItem(_controller.serviceList, index),
                              ],
                            ),
                          ),

                          ///new
                          // for (int index = 0; index < anotherList.length; index++)
                          if (_controller.selectedMainService.value.id != null)
                            Obx(
                              () {
                                return wrapItem(_controller.subServiceList);
                              },
                            ),

                          ///old
                          /*  for (int index = 0; index < list.length; index++)
                        wrapItem(list, list.length - 1, index),*/
                          // Padding(
                          //   padding: const EdgeInsets.symmetric(horizontal: 0),
                          //   child: Column(
                          //     children: [
                          //       12.height,
                          //       boldHeaderText(),
                          //       blackProfleText(),
                          //       Wrap(
                          //         spacing: 12,
                          //         runSpacing: 12,
                          //         direction: Axis.horizontal,
                          //         children: List.generate(list.length, (index) {
                          //           return getGroupButton(
                          //               list[index].name,
                          //               controller.stepFiveButtonIndex == index
                          //                   ? true
                          //                   : false, () {
                          //             controller.elctricity.clear();
                          //             controller.elctricityIndex.clear();
                          //             setSubServiceAndSelected(
                          //                 list[index], controller);
                          //             controller.setStepFiveButtonIndex(index);
                          //           });
                          //         }),
                          //       ),
                          //     ],
                          //   ),
                          // ),
                          // controller.stepFiveButtonIndex == 0
                          //     ? FarenowRadioButtons(
                          //         selectedIndex: controller.elctricityIndex,
                          //         onSelected: (v1, v2, v3) {
                          //           print(v1[v3]);
                          //           controller.elctricity.assignAll(v1);
                          //         },
                          //         list: controller.elctricity,
                          //         isRadio: false,
                          //       )
                          //     : Container(),
                          // controller.stepFiveButtonIndex == 1
                          //     ? FarenowRadioButtons(
                          //         selectedIndex: controller.elctricityIndex,
                          //         onSelected: (v1, v2, v3) {
                          //           controller.handyman.assignAll(v1);
                          //           setState(() {});
                          //         },
                          //         list: controller.elctricity,
                          //         isRadio: false,
                          //       )
                          //     : Container(),
                          // controller.stepFiveButtonIndex == 2
                          //     ? FarenowRadioButtons(
                          //         selectedIndex: controller.elctricityIndex,
                          //         onSelected: (v1, v2, v3) {
                          //           controller.homeCleaning.assignAll(v1);
                          //           setState(() {});
                          //         },
                          //         list: controller.elctricity,
                          //         isRadio: false,
                          //       )
                          //     : Container(),
                          // controller.stepFiveButtonIndex == 3
                          //     ? FarenowRadioButtons(
                          //         selectedIndex: controller.elctricityIndex,
                          //         onSelected: (v1, v2, v3) {
                          //           controller.moving.assignAll(v1);
                          //           print(controller.moving);
                          //           setState(() {});
                          //         },
                          //         list: controller.elctricity,
                          //         isRadio: false,
                          //       )
                          //     : Container(),
                        ],
                      ),
                    ],
                  );
                }),
      );
    });
  }

  ///for survice item Ui
  getGroupButton(String text, bool selected, Function onTap) {
    return AppButton(
      elevation: 0,
      width: Get.width / 2.3,
      height: 47,
      shapeBorder:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      color: selected ? AppColors.solidBlue : const Color(0xffE0E0E0),
      onTap: onTap,
      child: Text(
        text,
        style: TextStyle(color: selected ? white : black, fontSize: 14),
      ),
    );
  }

  setSubServiceAndSelected(
      UserServiceData userServiceData, StepsController stepsController) {
    List<UserSubServices> userSubServices = [];
    List<ProviderSubServices>? providerSubServices = [];
    if (userServiceData.userSubServices!.isNotEmpty) {
      userSubServices.assignAll(userServiceData.userSubServices!);
    }
    if (userSubServices.isNotEmpty) {
      for (var i = 0; i < userSubServices.length; i++) {
        stepsController.elctricity.add(userSubServices[i].name!);
        if (userSubServices[i].providerSubServices!.isNotEmpty) {
          stepsController.elctricityIndex.add(i);
        }
      }
    }
    setState(() {});
    // stepsController.elctricity.assignAll(userSubServices);
  }

  ///new by me
  wrapItem(list) {
    MainServiceModel value =
        _controller.serviceList[_controller.serviceIndex.value];
    bool flag =
        checkAllFalse(_controller.serviceList[_controller.serviceIndex.value]);

    bool parentActive = !flag
        ? true
        : (value.status ?? 1) == 0
            ? false
            : true;
    // int parentId = index;

    return Column(
      children: [
        for (int indexX = 0; indexX < value.subServices!.length; indexX++)
          _controller.selectedMainService.value.id == null
              ? emptyContainer()
              : subServicesItem(
                  value.subServices!, indexX, parentActive, indexX)
      ],
    );
  }

  ///old
  /*wrapItem(list, int size, index) {
    UserServiceData value = list[index];
    print(value.name);
    bool flag = checkAllFalse(list[index]);
    bool parentActive = !flag
        ? true
        : (value.status ?? 1) == 0
            ? false
            : true;
    int parentId = index;

    return Column(
      children: [
        for (int indexX = 0; indexX < value.userSubServices!.length; indexX++)
          !value.expand
              ? emptyContainer()
              : subServicesItem(
                  value.userSubServices!,
                  value.userSubServices!.length - 1,
                  indexX,
                  parentActive,
                  parentId,
                )
      ],
    );
  }*/

  ///new by me:
  serviceItem(List<MainServiceModel> anotherList, int index) {
    MainServiceModel value = anotherList[index];

    // bool flag = checkAllFalse(anotherList[index]);
    // bool parentActive = !flag
    //     ? true
    //     : (value.status ?? 1) == 0
    //         ? false
    //         : true;
    // int parentId = index;

    return Container(
        margin: const EdgeInsets.only(top: 12, right: 12),
        width: (Get.width - 36) / 2,
        child: getGroupButton(
            value.name!, _controller.selectedMainService.value == value, () {
          // for (int indexI = 0;
          //     indexI < _controller.serviceList.length;
          //     indexI++) {
          //   _controller.serviceList[indexI].expand = false;

          // }
          _controller.getSelectedMainService(value);
          // _controller.getSubServices();
          _controller.serviceIndex.value = index;

          // parentIndex = index;
          _controller.serviceList.refresh();
        }));
  }

  ///old
  /*serviceItem(list, int size, int index) {
    UserServiceData value = list[index];
    print("Service item calling 111111111111");
    print("Valueeeee issssss ${value.name}");
    bool flag = checkAllFalse(list[index]);
    bool parentActive = !flag
        ? true
        : (value.status ?? 1) == 0
            ? false
            : true;
    int parentId = index;

    return Container(
        margin: EdgeInsets.only(top: 12, right: 12),
        width: (Get.width - 36) / 2,
        child: getGroupButton(value.name!, value.expand, () {
          for (int indexI = 0;
              indexI < _servicesListController.servicesList.length;
              indexI++) {
            _servicesListController.servicesList.value[indexI].expand = false;
          }

          bool flag = _servicesListController.servicesList.value[index].expand;
          _servicesListController.servicesList.value[index].expand = !flag;
          expand = !flag;

          print("flag $flag");
          print("expand $expand");
          parentIndex = index;
          _servicesListController.servicesList.refresh();
          print("Service item calling 222222222222222");
        }));
  }*/

  ///new
  int getMainStatus(int id, List<MainSubService> mainSubServices) {
    for (int index = 0; index < mainSubServices.length; index++) {
      MainSubService vx = mainSubServices[index];
      if (vx.serviceId == id) {
        return vx.status!;
      }
    }
    return 0;
  }

  ///old
  int getProviderStatus(int id, List<ProviderSubServices> providerSubServices) {
    for (int index = 0; index < providerSubServices.length; index++) {
      ProviderSubServices vx = providerSubServices[index];
      if (vx.subServiceId == id) {
        return vx.status!;
      }
    }
    return 0;
  }

  ///for subService item ui
  ///new by me
  subServicesItem(
    List<MainSubService> list,
    int indexX,
    parentActive,
    parentId,
  ) {
    MainSubService valueX = list[indexX];
    // int status = getMainStatus(valueX.id!, list);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: Container(
        width: Get.width,
        // height: 30,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        decoration: BoxDecoration(
            color: const Color.fromRGBO(0, 104, 225, 0.1),
            borderRadius: const BorderRadius.all(
              Radius.circular(12),
            ),
            border:
                Border.all(color: getColor(valueX.isSelected ? false : true))),
        child: Row(
          children: [
            Text("${valueX.name}"),
            const Expanded(child: SizedBox(width: 12)),
            Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                  color: valueX.isSelected ? AppColors.solidBlue : null,
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: AppColors.solidBlue)),
              child: valueX.isSelected
                  ? const Center(
                      child: Icon(
                      Icons.check,
                      color: white,
                      size: 18,
                    ))
                  : null,
            )
          ],
        ).onTap(
          () async {
            // setState(() {
            //   valueX.isSelected == true
            //       ? valueX.copyWith(isSelected: false)
            //       : valueX.copyWith(isSelected: true);
            // });
            // bool individual =
            //     _profileScreenController.userData.value.providerType ==
            //         'Individual';
            // int idCheck =
            //     isActiveService(_controller.serviceList, valueX.serviceId);
            // bool isSelected = list.contains(
            //     list.firstWhere((element) => element.isSelected = true));
            // if (/*idCheck != valueX.serviceId &&*/ individual) {
            int count = 0;
            for (int j = 0; j < _controller.serviceList.length; j++) {
              for (int k = 0;
                  k < (_controller.serviceList[j].subServices?.length ?? 0);
                  k++) {
                if (_controller.serviceList[j].subServices?[k].isSelected ==
                    true) {
                  if (_controller.serviceList[j].subServices?[k].serviceId !=
                      valueX.serviceId) {
                    count++;

                    Logger().i(count);

                    if (count == 1) {
                      Logger().i("count==1");
                      await Get.defaultDialog<bool>(
                        title: "Alert",
                        content: const Text("Do you want to switch service"),
                        confirm: MaterialButton(
                          onPressed: () {
                            final tempLocation =
                                (_controller.serviceList[j].subServices ??
                                    [])[k];
                            _controller.serviceList[j].subServices?.insert(
                                k,
                                tempLocation.copyWith(
                                  name: tempLocation.name,
                                  id: tempLocation.id,
                                  credit: tempLocation.credit,
                                  serviceId: tempLocation.serviceId,
                                  image: tempLocation.image,
                                  terms: tempLocation.terms,
                                  status: tempLocation.status,
                                  isSelected: false,
                                  updatedAt: tempLocation.updatedAt,
                                  createdAt: tempLocation.createdAt,
                                ));
                            _controller.serviceList[j].subServices
                                ?.removeAt(k + 1);

                            Get.back(result: true);
                          },
                          child: const Text("Yes"),
                        ),
                        cancel: MaterialButton(
                          onPressed: () {
                            Get.back(result: false);

                            _controller.isPopUpCanceled.value = true;
                          },
                          child: const Text("No"),
                        ),
                      ).then((value) async {
                        Logger().d(value);
                        if (value != false) {
                          await updateService(
                              parentActive, status, valueX, indexX);
                          _controller.isUpdated.value = true;
                          Logger().d(" Api Called On Main Service Changed");
                        }
                      });
                    } else {
                      if (_controller.isPopUpCanceled.value == false) {
                        Logger()
                            .i("_controller.isPopUpCanceled.value == false");
                        final tempLocation =
                            (_controller.serviceList[j].subServices ?? [])[k];
                        _controller.serviceList[j].subServices?.insert(
                            k,
                            tempLocation.copyWith(
                              name: tempLocation.name,
                              id: tempLocation.id,
                              credit: tempLocation.credit,
                              serviceId: tempLocation.serviceId,
                              image: tempLocation.image,
                              terms: tempLocation.terms,
                              status: tempLocation.status,
                              isSelected: false,
                              updatedAt: tempLocation.updatedAt,
                              createdAt: tempLocation.createdAt,
                            ));
                        _controller.serviceList[j].subServices?.removeAt(k + 1);
                      } else {
                        break;
                      }
                    }
                  }
                }
              }
            }
            if (_controller.isUpdated.value == false &&
                _controller.isPopUpCanceled.value == false) {
              await updateService(parentActive, status, valueX, indexX);
              Logger().d(" Api Called normal case");
            }
            _controller.isUpdated.value = false;
            _controller.isPopUpCanceled.value = false;
            // } else {
            //   int count = 0;
            //   for (int j = 0; j < _controller.serviceList.length; j++) {
            //     for (int k = 0;
            //     k < (_controller.serviceList[j].subServices?.length ?? 0);
            //     k++) {
            //       if (_controller.serviceList[j].subServices?[k].isSelected ==
            //           true) {
            //         if (_controller.serviceList[j].subServices?[k].serviceId !=
            //             valueX.serviceId) {
            //           count++;

            //           if (count == 1) {
            //             final isYes = await Get.defaultDialog<bool>(
            //               title: "Alert",
            //               content: const Text("Do you want to switch service"),
            //               confirm: MaterialButton(
            //                 onPressed: () {
            //                   final tempLocation =
            //                   (_controller.serviceList[j].subServices ??
            //                       [])[k];
            //                   _controller.serviceList[j].subServices?.insert(
            //                       k,
            //                       tempLocation.copyWith(
            //                         name: tempLocation.name,
            //                         id: tempLocation.id,
            //                         credit: tempLocation.credit,
            //                         serviceId: tempLocation.serviceId,
            //                         image: tempLocation.image,
            //                         terms: tempLocation.terms,
            //                         status: tempLocation.status,
            //                         isSelected: false,
            //                         updatedAt: tempLocation.updatedAt,
            //                         createdAt: tempLocation.createdAt,
            //                       ));
            //                   _controller.serviceList[j].subServices
            //                       ?.removeAt(k + 1);

            //                   Get.back(result: true);
            //                 },
            //                 child: const Text("Yes"),
            //               ),
            //               cancel: MaterialButton(
            //                 onPressed: () {
            //                   Get.back(result: false);
            //                 },
            //                 child: const Text("No"),
            //               ),
            //             );
            //             if (isYes == true) {
            //               await updateService(
            //                   parentActive, status, valueX, indexX);
            //               Logger().d(" Api Called ");

            //               _controller.isUpdated.value = true;
            //             }
            //           } else {
            //             final tempLocation =
            //             (_controller.serviceList[j].subServices ?? [])[k];
            //             _controller.serviceList[j].subServices?.insert(
            //                 k,
            //                 tempLocation.copyWith(
            //                   name: tempLocation.name,
            //                   id: tempLocation.id,
            //                   credit: tempLocation.credit,
            //                   serviceId: tempLocation.serviceId,
            //                   image: tempLocation.image,
            //                   terms: tempLocation.terms,
            //                   status: tempLocation.status,
            //                   isSelected: false,
            //                   updatedAt: tempLocation.updatedAt,
            //                   createdAt: tempLocation.createdAt,
            //                 ));
            //             _controller.serviceList[j].subServices?.removeAt(k + 1);
            //           }
            //         }
            //       }
            //     }
            //   }
            //   if (_controller.isUpdated.value == false) {
            //     await updateService(parentActive, status, valueX, indexX);
            //     Logger().d(" Api Called ");
            //   }
            //   _controller.isUpdated.value = false;
            // }
          },
        ),
      ),

      /*
      CheckboxListTile(
          checkColor: Colors.white,
          checkboxShape:
              RoundedRectangleBorder(side: BorderSide(color: AppColors.green)),
          title: Text("${valueX.name}"),
          activeColor: getColor(status == 0 ? false : true),
          value: !parentActive
              ? false
              : status == 0
                  ? false
                  : true,
          onChanged: (x) {

          },
        )
       */
    );
  }

  ///old
  /*  subServicesItem(
    List<UserSubServices> list,
    int size,
    int indexX,
    parentActive,
    parentId,
  ) {
    print("subServicesItem calling 111111111111");
    UserSubServices valueX = list[indexX];
    int status = getProviderStatus(valueX.id!, valueX.providerSubServices!);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: Container(
        width: Get.width,
        // height: 30,
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        decoration: BoxDecoration(
            color: Color.fromRGBO(0, 104, 225, 0.1),
            borderRadius: BorderRadius.all(
              Radius.circular(12),
            ),
            border: Border.all(color: getColor(status == 0 ? false : true))),

        child: Row(
          children: [
            Text("${valueX.name}"),
            Expanded(child: SizedBox(width: 12)),
            Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                  color: status == 1 ? AppColors.solidBlue : null,
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: AppColors.solidBlue)),
              child: status == 1
                  ? const Center(
                      child: Icon(
                      Icons.check,
                      color: white,
                      size: 18,
                    ))
                  : null,
            )
          ],
        ).onTap(() {
          bool individual =
              _profileScreenController.userData.value.providerType ==
                  'Individual';
          int idCheck = isActiveService(
              _servicesListController.servicesList.value, valueX.serviceId);
          if (idCheck != valueX.serviceId && individual) {
            Get.defaultDialog(
              title: "Alert",
              content: const Text("Do you want to switch service"),
              confirm: MaterialButton(
                onPressed: () {
                  updateService(parentActive, status, valueX, indexX, parentId);
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
            updateService(parentActive, status, valueX, indexX, parentId);
          }
        }),
      ),

      /*
      CheckboxListTile(
          checkColor: Colors.white,
          checkboxShape:
              RoundedRectangleBorder(side: BorderSide(color: AppColors.green)),
          title: Text("${valueX.name}"),
          activeColor: getColor(status == 0 ? false : true),
          value: !parentActive
              ? false
              : status == 0
                  ? false
                  : true,
          onChanged: (x) {

          },
        )
       */
    );
  }*/

  Future<void> updateService(
    parentActive,
    status,
    MainSubService valueX,
    indexX,
  ) async {
    AppDialogUtils.dialogLoading();
    if (parentActive) {
      bool flag = status == 0 ? true : false;
      Map<String, dynamic> body = {
        "sub_service_id": valueX.id,
        "status": flag ? 1 : 0,
      };
      await _servicesListController.updateService(
          body: body,
          serviceUpDate: (value) {
            int id = flag ? 1 : 0;
            // resetAll();
            if (value != null) {
              // _controller.serviceList.removeAt(1);
              // _controller.serviceIndex.value.subServices?[indexX].copyWith(isSelected: !valueX.isSelected);
              _controller
                  .serviceList[_controller.serviceIndex.value].subServices
                  ?.insert(
                      indexX,
                      valueX.copyWith(
                        name: valueX.name,
                        id: valueX.id,
                        credit: valueX.credit,
                        serviceId: valueX.serviceId,
                        image: valueX.image,
                        terms: valueX.terms,
                        status: id,
                        isSelected: !valueX.isSelected,
                        updatedAt: valueX.updatedAt,
                        createdAt: valueX.createdAt,
                      ));
              _controller
                  .serviceList[_controller.serviceIndex.value].subServices
                  ?.removeAt(indexX + 1);

              // for (MainServiceModel msm in _controller.serviceList) {
              //   for (MainSubService mss in msm.subServices ?? []) {
              //     msm.subServices?.lastWhere((element) =>
              //         mss.serviceId != valueX.serviceId && mss.isSelected);
              //     msm.subServices?.addIf(
              //         mss.serviceId != valueX.serviceId && mss.isSelected,
              //         mss.copyWith(
              //           name: mss.name,
              //           id: mss.id,
              //           credit: mss.credit,
              //           serviceId: mss.serviceId,
              //           image: mss.image,
              //           terms: mss.terms,
              //           status: mss.status,
              //           isSelected: false,
              //           updatedAt: mss.updatedAt,
              //           createdAt: mss.createdAt,
              //         ));
              //   }
              // }

              // if (_controller.serviceList[j].subServices?[k].isSelected !=
              //         false &&
              //     _controller.serviceList[j].subServices?[k].serviceId !=
              //         valueX.serviceId) {
              //   print(_controller.serviceList[j].subServices?[k].name);
              //   _controller.serviceList[j].subServices?.insert(
              //       k,
              //       valueX.copyWith(
              //         name: valueX.name,
              //         id: valueX.id,
              //         credit: valueX.credit,
              //         serviceId: valueX.serviceId,
              //         image: valueX.image,
              //         terms: valueX.terms,
              //         status: valueX.status,
              //         isSelected: !valueX.isSelected,
              //         updatedAt: valueX.updatedAt,
              //         createdAt: valueX.createdAt,
              //       ));
              //   _controller.serviceList[j].subServices?.removeAt(k + 1);

              //   print("under condition");
              //   print("$j, $k");
              //   print("=======================");

              //   // _controller.serviceList.refresh();
              // }
              //   }
              // }

              // _controller.getSubServices();
              // _controller.subServiceList.refresh();
              // _controller.selectedMainService.refresh();
              _controller.serviceList.refresh();
              AppDialogUtils.dismiss();
            } else {
              // List datList = _servicesListController.servicesList
              //     .value[parentId].userSubServices[indexX].providerSubServices;
              List<MainSubService> datList0 =
                  _controller.selectedMainService.value.subServices ?? [];
              // for (int indexY = 0; indexY < datList.length; indexY++) {
              //   ProviderSubServices newValue = datList[indexY];
              //   if (newValue.subServiceId == valueX.id) {
              //     print("${valueX.id}");
              //     _servicesListController
              //         .servicesList[parentId]
              //         .userSubServices[indexX]
              //         .providerSubServices[indexY]
              //         .status = newValue.status == 1 ? 0 : 1;
              //     _servicesListController.servicesList.refresh();
              //     AppDialogUtils.dismiss();
              //   }
              // }
              for (int indexZ = 0; indexZ < datList0.length; indexZ++) {
                MainSubService newValue = datList0[indexZ];
                if (newValue.serviceId == valueX.serviceId) {
                  _controller.subServiceList[indexZ].copyWith(
                    status: newValue.status == 1 ? 0 : 1,
                  );
                  // _controller.getServiceList();
                  _controller.serviceList.refresh();
                  AppDialogUtils.dismiss();
                }
              }
            }
            // bool flags = checkAllFalse(
            //     _servicesListController.servicesList.value[parentId]);

            // _servicesListController.servicesList.value[parentId].status =
            //     flags ? 1 : 0;
            // _servicesListController.getServiceList();
            // bool flags0 = checkAllFalse(_controller.selectedMainService.value);

            // _controller.subServiceList[indexX].copyWith(status: flags0 ? 1 : 0);

            // _controller.getServiceList();

            // _controller.serviceList.refresh();
          });
      AppDialogUtils.dismiss();
    }
  }

  getColor(bool status) {
    return status ? AppColors.solidBlue : Colors.transparent;
  }

  int isActiveService(List<dynamic> value, list) {
    for (int index = 0; index < value.length; index++) {
      if (value[index].status == 1) {
        return value[index].id;
      }
    }
    return list;
  }

  ///new by me
  checkAllFalse(
    MainServiceModel service,
  ) {
    for (int index = 0; index < (service.subServices?.length ?? 0); index++) {
      MainSubService valueX = service.subServices![index];
      if (valueX.status == 1) {
        return true;
      }
    }
    return false;
  }

  ///old
/*  checkAllFalse(
    UserServiceData list,
  ) {
    print("checkAllFalse calling 111111111111");
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
  }*/

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
        _servicesListController.servicesList.value[position]
            .userSubServices[index].providerSubServices[indexJ].status = 0;
      }
    }
  }

  getCheckBox(checkSelected) {
    return Container(
      width: 30,
      height: 30,
      decoration: BoxDecoration(
          color: checkSelected ? AppColors.solidBlue : null,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: AppColors.solidBlue)),
      child: checkSelected
          ? const Center(
              child: Icon(
              Icons.check,
              color: white,
              size: 18,
            ))
          : null,
    );
  }
}
/*
CustomContainer(
        width: Get.width / 2,
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
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    width: Get.width,
                    height: 50,
                    color: AppColors.appBlue,
                    child: Row(
                      children: [
                        getGroupButton(
                            "Electricity & Computers", value.expand, () {})
                        // Expanded(
                        //   child: Text(
                        //     value.name!,
                        //     style: const TextStyle(
                        //         color: Colors.white, fontSize: 18),
                        //   ),
                        // ),
                        // InkWell(
                        //   onTap: () {
                        //     bool flag = _servicesListController
                        //         .servicesList.value[index].expand;
                        //     _servicesListController
                        //         .servicesList.value[index].expand = !flag;
                        //     expand = !flag;
                        //
                        //     print("flag $flag");
                        //     print("expand $expand");
                        //     parentIndex = index;
                        //     _servicesListController.servicesList.refresh();
                        //   },
                        //   child: Icon(
                        //     !value.expand
                        //         ? Icons.keyboard_arrow_down_rounded
                        //         : Icons.keyboard_arrow_up,
                        //     color: AppColors.white,
                        //   ),
                        // )
                      ],
                    ),
                  ),
                  // for (int indexX = 0;
                  //     indexX < value.userSubServices!.length;
                  //     indexX++)
                  //   !value.expand
                  //       ? emptyContainer()
                  //       : subServicesItem(
                  //           value.userSubServices!,
                  //           value.userSubServices!.length - 1,
                  //           indexX,
                  //           parentActive,
                  //           parentId,
                  //         )
                ],
              )
            : _profileScreenController.userData.value.providerType !=
                    'Individual'
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () {
                          bool flag = _servicesListController
                              .servicesList.value[index].expand;
                          _servicesListController
                              .servicesList.value[index].expand = !flag;
                          expand = !flag;

                          print("flag $flag");
                          print("expand $expand");
                          parentIndex = index;
                          _servicesListController.servicesList.refresh();
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 6),
                          child: Container(
                            // margin: EdgeInsets.only(
                            //     left: 12,
                            //     right: 12,
                            //     top: index == 0 ? 12 : 6,
                            //     bottom: index == size ? 12 : 0),
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            width: Get.width,
                            height: 55,
                            color: AppColors.white,
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    value.name!,
                                    style: const TextStyle(
                                        color: Colors.black, fontSize: 18),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    bool flag = _servicesListController
                                        .servicesList.value[index].expand;
                                    _servicesListController.servicesList
                                        .value[index].expand = !flag;
                                    expand = !flag;

                                    print("flag $flag");
                                    print("expand $expand");
                                    parentIndex = index;
                                    _servicesListController.servicesList
                                        .refresh();
                                  },
                                  child: Icon(
                                    !value.expand
                                        ? Icons.keyboard_arrow_down_rounded
                                        : Icons.keyboard_arrow_up,
                                    color: AppColors.black,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      for (int indexX = 0;
                          indexX < value.userSubServices!.length;
                          indexX++)
                        !value.expand
                            ? emptyContainer()
                            : subServicesItem(
                                value.userSubServices!,
                                value.userSubServices!.length - 1,
                                indexX,
                                parentActive,
                                parentId,
                              )
                    ],
                  )
                : Container())
 */