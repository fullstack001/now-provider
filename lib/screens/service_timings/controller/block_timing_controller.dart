import 'package:fare_now_provider/api_service/service_repository.dart';
import 'package:fare_now_provider/screens/service_timings/controller/service_timing_controller.dart';
import 'package:fare_now_provider/util/app_dialog_utils.dart';
import 'package:nb_utils/nb_utils.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../util/api_utils.dart';
import '../../../util/shared_reference.dart';

class BlockTimingController extends GetxController {
  List<BlockTime> selectedTime = <BlockTime>[];
  DateTime firstDay = DateTime.now();
  updateFirstDay(DateTime v) {
    firstDay = v;
    update();
  }

  appendSelectedTime() {
    DateTime _date = DateTime.now();
    BlockTime _blockTime =
        BlockTime(date: _date, stime: "00:00", etime: "23:59");

    createTimeSlot(_blockTime);
  }

  deleteTimeSlot(int id) async {
    AppDialogUtils.dialogLoading();
    try {
      String? authToken =
          await SharedRefrence().getString(key: ApiUtills.authToken);
      var response = await ServiceReposiotry()
          .deleteBlockSlot(authToken: authToken, id: id);

      if (!response['error']) {
        await Get.find<ServiceTimingController>().getScheduleTiming();
        onInit();
        update();
        AppDialogUtils.successDialog("Successfuly delete");
      } else {
        AppDialogUtils.dismiss();
      }
    } catch (e) {
      AppDialogUtils.dismiss();
      print(e);
    }
  }

  updateTimeSlot(BlockTime blockTime) async {
    AppDialogUtils.dialogLoading();
    try {
      Map _body = {
        "date": DateFormat("yyyy-MM-dd").format(blockTime.date!),
        "from_time": blockTime.stime,
        "to_time": blockTime.etime
      };
      String? authToken =
          await SharedRefrence().getString(key: ApiUtills.authToken);
      var response = await ServiceReposiotry()
          .updateBlockSLot(authToken: authToken, body: _body, id: blockTime.id);
      if (!response['error']) {
        await Get.find<ServiceTimingController>().getScheduleTiming();
        onInit();
        update();
        AppDialogUtils.dismiss();
      } else {
        AppDialogUtils.dismiss();
      }
    } catch (e) {
      AppDialogUtils.dismiss();
      print(e);
    }
  }

  createTimeSlot(BlockTime blockTime) async {
    AppDialogUtils.dialogLoading();
    try {
      Map _body = {
        "date": DateFormat("yyyy-MM-dd").format(blockTime.date!),
        "from_time": blockTime.stime,
        "to_time": blockTime.etime
      };
      String? authToken =
          await SharedRefrence().getString(key: ApiUtills.authToken);
      var response = await ServiceReposiotry()
          .createBlockSLot(authToken: authToken, body: _body);
      if (!response['error']) {
        await Get.find<ServiceTimingController>().getScheduleTiming();
        onInit();
        update();
        AppDialogUtils.dismiss();
      } else {
        AppDialogUtils.dismiss();
      }
    } catch (e) {
      AppDialogUtils.dismiss();
      print(e);
    }
  }

  @override
  void onInit() {
    var _data = Get.find<ServiceTimingController>().blockedSlot;

    if (_data.isNotEmpty) {
      selectedTime.clear();
      _data.forEach((element) {
        selectedTime.add(BlockTime(
            id: element.id,
            date: element.date,
            stime: element.fromTime,
            etime: element.toTime));
      });
    }

    super.onInit();
  }

  setEndSelectedTime(int index, String endTime) async {
    var _hour = endTime.splitBefore(":");
    var _minute = endTime.splitAfter(":");
    var _time;
    if (_hour.length < 2) {
      _time = "0${_hour}";
    } else {
      _time = _hour;
    }
    if (_minute.length < 2) {
      _time = "${_time}:0${_minute}";
    } else {
      _time = "${_time}:${_minute}";
    }
    selectedTime[index].etime = _time;
    int st = int.parse(selectedTime[index].stime!.splitBefore(":"));
    int et = int.parse(selectedTime[index].etime!.splitBefore(":"));
    if (et > st) {
      await updateTimeSlot(selectedTime[index]);
    } else {
      AppDialogUtils.errorDialog("You can't choose time from a different day");
    }

    update();
  }

  setStartSelectedTime(int index, String startTime) async {
    var _hour = startTime.splitBefore(":");
    var _minute = startTime.splitAfter(":");
    var _time;
    if (_hour.length < 2) {
      _time = "0${_hour}";
    } else {
      _time = _hour;
    }
    if (_minute.length < 2) {
      _time = "${_time}:0${_minute}";
    } else {
      _time = "${_time}:${_minute}";
    }
    selectedTime[index].stime = "${_time}";
    int st = int.parse(selectedTime[index].stime!.splitBefore(":"));
    int et = int.parse(selectedTime[index].etime!.splitBefore(":"));
    if (et > st) {
      await updateTimeSlot(selectedTime[index]);
    } else {
      AppDialogUtils.errorDialog("You can't choose time from a different day ");
    }
    update();
  }

  setSelectedDate(int index, BlockTime blockTime) async {
    selectedTime[index].date = blockTime.date;
    await updateTimeSlot(selectedTime[index]);
    update();
  }

  inc() {
    appendSelectedTime();
    update();
  }

  dec(int index) {
    deleteTimeSlot(selectedTime[index].id!);
    selectedTime.removeAt(index);
  }

  getDay(int weekday) {
    switch (weekday) {
      case 1:
        return "Mon";
      case 2:
        return "Tue";
      case 3:
        return "Wed";
      case 4:
        return "Thu";
      case 5:
        return "Fri";
      case 6:
        return "Sat";
      case 7:
        return "Sun";

      default:
        return "";
    }
  }

  getMonth(int month) {
    switch (month) {
      case 1:
        return "Jan";

      case 2:
        return "Feb";

      case 3:
        return "Mar";

      case 4:
        return "April";

      case 5:
        return "May";

      case 6:
        return "June";

      case 7:
        return "July";

      case 8:
        return "Aug";

      case 9:
        return "Sep";

      case 10:
        return "Oct";

      case 11:
        return "Nov";

      case 12:
        return "Dec";

      default:
    }
  }
}

class BlockTime {
  int? id;
  DateTime? date;
  String? stime;
  String? etime;
  BlockTime({this.date, this.stime, this.etime, this.id});
}
