import 'dart:convert';

import 'package:fare_now_provider/api_service/service_repository.dart';
import 'package:fare_now_provider/models/available_services/available_data.dart';
import 'package:fare_now_provider/models/available_services/available_service_data.dart';
import 'package:fare_now_provider/models/available_services/available_service_response.dart';
import 'package:fare_now_provider/models/order_status/order_status_response.dart';
import 'package:fare_now_provider/models/service_time/timer_data.dart';
import 'package:fare_now_provider/models/service_time/timmer_response.dart';
import 'package:fare_now_provider/models/start_service/start_service_data.dart';
import 'package:fare_now_provider/models/start_service/start_service_response.dart';
import 'package:fare_now_provider/util/api_utils.dart';
import 'package:fare_now_provider/util/app_dialog_utils.dart';
import 'package:fare_now_provider/util/date_time_utills.dart';
import 'package:fare_now_provider/util/shared_reference.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../wallet_screens/wallet_screen.dart';

class HomeScreenController extends GetxController {
  bool _checkbox1 = true;
  var count = 0;
  var updateTry = 0;
  var timmerResponse = TimmerResponse().obs;
  var orderStatus = OrderStatusResponse().obs;

  var requested = [].obs;
  var rejected = [].obs;
  var charRequest = [].obs;
  var cancelled = [].obs;
  var accepted = [].obs;
  var onGoing = [].obs;
  var complete = [].obs;

  bool get checkbox1 => _checkbox1;
  ServiceReposiotry _serviceReposiotry = ServiceReposiotry();

  var availableJos = AvailableData().obs;

  HomeScreenController({home}) {
    bool fromHome = home ?? false;
    if (!fromHome) {
      getAvailableJobs(flag: true);
    }
  }

  void setCheckBox(bool val) {
    _checkbox1 = val;
    update();
  }

  bool _checkbox2 = true;

  bool get checkbox2 => _checkbox2;

  void setCheckBox2(bool val) {
    _checkbox2 = val;
    update();
  }

  // void recursiveCall() {
  //   getAvailableJobs(flag: true);
  //   Future.delayed(Duration(seconds: 5)).then((value) {
  //     recursiveCall();
  //     print("call init");
  //   });
  // }

  Future<void> getAvailableJobs(
      {flag, RefreshController? refreshController}) async {
    bool checkFlag = flag ?? false;
    if ((availableJos.value.availableServiceData ?? []).isEmpty) {
      if (!checkFlag) {
        AppDialogUtils.dialogLoading();
      }
    }
    try {
      String? authToken =
          await SharedRefrence().getString(key: ApiUtills.authToken);

      if (authToken?.isNotEmpty == true) {
        AvailableServiceResponse response =
            await _serviceReposiotry.getAvailableJobs(authToken ?? "");
        if (!response.error) {
          AppDialogUtils.dismiss();
          for (int index = 0;
              index < response.availableData.availableServiceData.length;
              index++) {
            DateTime now = DateTime.now();
            DateTime jobTime = DateTimeUtils().convertStringSeconds(
                response.availableData.availableServiceData[index].createdAt);

            int seconds = now.difference(jobTime).inSeconds;
            response.availableData.availableServiceData[index].seconds =
                seconds;

            if (refreshController != null) {
              refreshController.refreshCompleted();
            }

            // if(response.availableData.availableServiceData[index].)
          }
          List service = response.availableData.availableServiceData;
          service.sort((a, b) => a.createdAt.compareTo(b.createdAt));
          // service = service.reversed.toList();
          response.availableData.availableServiceData = service;

          List<AvailableServiceData> newList = [];
          for (int index = 0;
              index < response.availableData.availableServiceData.length;
              index++) {
            if (response.availableData.availableServiceData[index].user.id !=
                null) {
              newList.add(response.availableData.availableServiceData[index]);
            }
            // if (response
            //         .availableData.availableServiceData[index].workedHours !=
            //     null) {
            //   if (response
            //           .availableData.availableServiceData[index].paidAmount !=
            //       null) {
            //     newList.add(response.availableData.availableServiceData[index]);
            //   }
            // }
          }
          response.availableData.availableServiceData = newList;

          availableJos(response.availableData);
          filterData(response.availableData);
          availableJos.refresh();
          // getPages();
        } else {
          AppDialogUtils.dismiss();
        }
      }
    } catch (exception) {
      Logger().e(exception);
      AppDialogUtils.dismiss();
    }
  }

  void filterData(AvailableData serviceData) {
    requested.value.clear();
    rejected.value.clear();
    charRequest.value.clear();
    complete.value.clear();
    accepted.value.clear();
    onGoing.value.clear();
    for (int index = 0;
        index < serviceData.availableServiceData.length;
        index++) {
      AvailableServiceData value = serviceData.availableServiceData[index];
      if (value.status.toString().toLowerCase() == "pending" &&
          value.directContact == 0) {
        requested.value.add(value);
        requested(requested.value);
        update();
      } else if (value.status.toString().toLowerCase() == "rejected" &&
          value.directContact == 0) {
        rejected.value.add(value);
        rejected(rejected.value);
        update();
      } else if (value.status.toString().toLowerCase() == "accepted" &&
          value.isCompleted == 0 &&
          value.workingStatus.toString().toLowerCase() != "started" &&
          value.workingStatus.toString().toLowerCase() !=
              "PAUSED".toLowerCase() &&
          value.directContact == 0) {
        accepted.value.add(value);
        accepted(accepted.value);
        update();
      } else if (value.isCompleted == 0 &&
          checkStarted(value) &&
          value.directContact == 0) {
        onGoing.value.add(value);
        onGoing(onGoing.value);
        update();
      } else if (value.isCompleted == 0 && value.directContact == 1) {
        charRequest.value.add(value);
        charRequest(charRequest.value);
        update();
      } else if (value.isCompleted == 1) {
        complete.value.add(value);
        complete(complete.value);
        update();
      }
    }
    print("requested: ${requested.value.length}\n"
        "rejected: ${rejected.value.length}\n"
        "accepted: ${accepted.value.length}\n"
        "onGoing: ${onGoing.value.length}\n"
        "complete: ${complete.value.length}\n"
        "charRequest: ${charRequest.value.length}\n");
  }

  void updateStatus(int id, String status, {newStatus}) async {
    if (updateTry >= 2) {
      updateTry = 0;
    }
    AppDialogUtils.dialogLoading();
    try {
      String? authToken =
          await SharedRefrence().getString(key: ApiUtills.authToken);

      var respons =
          await _serviceReposiotry.updateStatus(authToken ?? "", id, status);
      var response = json.decode(respons);
      if (!response['error']) {
        AppDialogUtils.dismiss();
        getAvailableJobs(flag: true);
        if (newStatus != null) {
          newStatus(respons);
        }
      } else {
        AppDialogUtils.dismiss();
        alertDialog(
            title: "Alert",
            cancel: MaterialButton(
              onPressed: () {
                Get.back();
              },
              child: Text("Close"),
            ),
            confirm: MaterialButton(
              onPressed: () {
                Get.back();
                Get.to(() => WalletScreen());
              },
              child: Text("Buy Credit"),
            ),
            content: response["message"]);
        // AppDialogUtils.errorDialog(response["message"]);
      }
    } catch (exception) {
      Logger().e(exception);
      updateTry = 0;
      AppDialogUtils.errorDialog("Something went wrong");
      AppDialogUtils.dismiss();
    }
  }

  void setQuotation({id, body, update}) async {
    AppDialogUtils.dialogLoading();
    try {
      String? authToken =
          await SharedRefrence().getString(key: ApiUtills.authToken);

      var respons =
          await _serviceReposiotry.sendQuotation(authToken ?? "", id, body);
      var response = json.decode(respons);
      if (!response['error']) {
        AppDialogUtils.dismiss();
      } else {
        if (response['message'] == "OK") {
          if (update != null) {
            update(respons);
          }
          AppDialogUtils.dismiss();
        }

        // AppDialogUtils.errorDialog("Failed to resend OTP");
      }
    } catch (exception) {
      Logger().e(exception);
      AppDialogUtils.dismiss();
    }
  }

  void acceptOrRejectChat(id, body, {update}) async {
    AppDialogUtils.dialogLoading();
    try {
      String? authToken =
          await SharedRefrence().getString(key: ApiUtills.authToken);

      if (authToken?.isNotEmpty == true) {
        var response =
            await _serviceReposiotry.acceptOrRejectChat(authToken, id, body);
        if (response["message"] == "OK") {
          AppDialogUtils.dismiss();

          if (update != null) {
            String da = json.encode(response);
            update(da);
          }
          getAvailableJobs(flag: true);
        } else {
          AppDialogUtils.dismiss();
          alertDialog(
              title: "Alert",
              cancel: MaterialButton(
                onPressed: () {
                  Get.back();
                },
                child: Text("Close"),
              ),
              confirm: MaterialButton(
                onPressed: () {
                  Get.back();
                  Get.to(() => WalletScreen());
                },
                child: Text("Buy Credit"),
              ),
              content: "you don't have enough credit to Accept the offer");
        }
      }
    } catch (exception) {
      Logger().e(exception);
      AppDialogUtils.dismiss();
    }
  }

  void startService(Map<dynamic, dynamic> body, {onServiceStart}) async {
    AppDialogUtils.dialogLoading();
    try {
      String? authToken =
          await SharedRefrence().getString(key: ApiUtills.authToken);

      if (authToken?.isNotEmpty == true) {
        StartServiceResponse response =
            await _serviceReposiotry.startService(authToken, body);
        if (response.message == "OK") {
          AppDialogUtils.dismiss();
          if (!check(response.startServiceData,
              timmerResponse.value.timerData ?? [])) {
            if (onServiceStart != null) {
              onServiceStart();
            }
          }
        } else {
          AppDialogUtils.dismiss();
        }
      }
    } catch (exception) {
      Logger().e(exception);
      AppDialogUtils.dismiss();
    }
  }

  getTimeFromPrefs() async {
    String? res = await SharedRefrence().getString(key: "time");
    if (res?.isNotEmpty == true) {
      var obj = json.decode(res ?? "");
      timmerResponse(TimmerResponse.fromJson(obj));
    }
  }

  bool check(StartServiceData startServiceData, List<TimerData> timerData) {
    for (int index = 0; index < timerData.length; index++) {
      if (startServiceData.serviceRequestId ==
          timerData[index].serviceRequestId) {
        return true;
      }
    }
    return false;
  }

  bool isStarted(id) {
    for (int index = 0;
        index < (timmerResponse.value.timerData ?? []).length;
        index++) {
      if (timmerResponse.value.timerData[index].serviceRequestId.toString() ==
          id.toString()) {
        return true;
      }
    }
    return false;
  }

  String time(id) {
    for (int index = 0;
        index < (timmerResponse.value.timerData ?? []).length;
        index++) {
      if (timmerResponse.value.timerData[index].serviceRequestId.toString() ==
          id.toString()) {
        return timmerResponse.value.timerData[index].time;
      }
    }
    return "";
  }

  void setPause(id, String time) {
    for (int index = 0;
        index < (timmerResponse.value.timerData ?? []).length;
        index++) {
      if (timmerResponse.value.timerData[index].serviceRequestId.toString() ==
          id.toString()) {
        timmerResponse.value.timerData[index].isPaused =
            !timmerResponse.value.timerData[index].isPaused;
        timmerResponse.value.timerData[index].pauseTime = time;
        timmerResponse(timmerResponse.value);
        String res = json.encode(timmerResponse.value.toJson());
        Future.delayed(Duration(seconds: 0)).then((value) async {
          await SharedRefrence().saveString(key: "time", data: res);
        });
        break;
      }
    }
  }

  void saveTime(id, String time) {
    for (int index = 0;
        index < (timmerResponse.value.timerData ?? []).length;
        index++) {
      if (timmerResponse.value.timerData[index].serviceRequestId.toString() ==
          id.toString()) {
        timmerResponse.value.timerData[index].pauseTime = time;
        timmerResponse(timmerResponse.value);
        String res = json.encode(timmerResponse.value.toJson());
        Future.delayed(Duration(seconds: 0)).then((value) async {
          await SharedRefrence().saveString(key: "time", data: res);
        });
        break;
      }
    }
  }

  bool isPause(id) {
    for (int index = 0;
        index < (timmerResponse.value.timerData ?? []).length;
        index++) {
      if (timmerResponse.value.timerData[index].serviceRequestId.toString() ==
          id.toString()) {
        return timmerResponse.value.timerData[index].isPaused;
      }
    }
    return false;
  }

  bool pauseTimeEmpty(id) {
    for (int index = 0;
        index < (timmerResponse.value.timerData ?? []).length;
        index++) {
      if (timmerResponse.value.timerData[index].serviceRequestId.toString() ==
          id.toString()) {
        String time = timmerResponse.value.timerData[index].pauseTime ?? "";
        return time.isNotEmpty;
      }
    }
    return false;
  }

  void setEmpty(id) {
    for (int index = 0;
        index < (timmerResponse.value.timerData ?? []).length;
        index++) {
      if (timmerResponse.value.timerData[index].serviceRequestId.toString() ==
          id.toString()) {
        timmerResponse.value.timerData[index].pauseTime = "";
      }
    }
  }

  String getPauseTime(id) {
    for (int index = 0;
        index < (timmerResponse.value.timerData ?? []).length;
        index++) {
      if (timmerResponse.value.timerData[index].serviceRequestId.toString() ==
          id.toString()) {
        return timmerResponse.value.timerData[index].pauseTime;
      }
    }
    return "";
  }

  void getOrderStatus(id, {upDateView, flag}) async {
    bool hide = flag ?? false;
    if (hide) {
      AppDialogUtils.dialogLoading();
    }
    try {
      String? authToken =
          await SharedRefrence().getString(key: ApiUtills.authToken);
      OrderStatusResponse obj =
          await _serviceReposiotry.getOrderStatus(authToken, id);
      if (!obj.error) {
        orderStatus(obj);
        if (upDateView != null) {
          upDateView();
        }
      }

      AppDialogUtils.dismiss();
    } catch (exception) {
      Logger().e(exception);
      AppDialogUtils.dismiss();
    }
  }

  bool hasPending() {
    for (int index = 0;
        index < availableJos.value.availableServiceData.length;
        index++) {
      AvailableServiceData value =
          availableJos.value.availableServiceData[index];
      if (value.status.toString().toLowerCase() == "pending" &&
          value.directContact == 0) {
        return true;
      }
    }
    return false;
  }

  bool checkStarted(value) {
    if (value.status.toString().toLowerCase() == "accepted" &&
        value.workingStatus.toString().toLowerCase() == "started") {
      return true;
    }
    if (value.status.toString().toLowerCase() == "accepted" &&
        value.workingStatus.toString().toLowerCase() ==
            "PAUSED".toLowerCase()) {
      return true;
    }
    return false;
  }
}
