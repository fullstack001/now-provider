import 'package:fare_now_provider/screens/service_timings/controller/block_timing_controller.dart';
import 'package:fare_now_provider/screens/service_timings/controller/choose_time_dilalog_controller.dart';
import 'package:fare_now_provider/screens/service_timings/dialog_box/choose_time.dart';
import 'package:fare_now_provider/screens/service_timings/new_servie_timing/part_of_service_timing/app_bar_of_service_timing.dart';
import 'package:fare_now_provider/screens/service_timings/new_servie_timing/serive_timing_screen.dart';
import 'package:fare_now_provider/screens/service_timings/show_calender.dart';
import 'package:fare_now_provider/util/app_colors.dart';
/*import 'package:fdottedline/fdottedline.dart';*/
import 'package:fdottedline_nullsafety/fdottedline__nullsafety.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:nb_utils/nb_utils.dart';

class BlockServiceTiming extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<BlockTimingController>(
        init: BlockTimingController(),
        builder: (controller) {
          return Scaffold(
            backgroundColor: Colors.grey.shade200,
            appBar:
                appBarOfServiceTiming(context, "Services Timings", "Done", () {
              Get.back();
            }),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: SingleChildScrollView(
                child: Column(children: [
                  topTextWidget(context),
                  Column(
                    children: [
                      Container(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Block",
                            style: TextStyle(
                                color: Color(0xff323032),
                                fontSize: 18,
                                fontWeight: FontWeight.w400),
                          )),
                      20.height,
                      Column(
                        children: List.generate(
                          controller.selectedTime.length,
                          (index) => Container(
                            padding: EdgeInsets.symmetric(vertical: 8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Flexible(
                                  fit: FlexFit.tight,
                                  flex: 3,
                                  child: greyButton(context,
                                      "${DateFormat('E, MMM d, y').format(controller.selectedTime[index].date!)}",
                                      () {
                                    controller.firstDay =
                                        controller.selectedTime[index].date!;
                                    Get.dialog(
                                        ShowCalenderWidget(index: index));
                                  }),
                                ),
                                // 20.width,
                                GetBuilder<ChooseTimeDialogController>(
                                    init: ChooseTimeDialogController(),
                                    builder: (chooseController) {
                                      return Flexible(
                                        fit: FlexFit.tight,
                                        flex: 4,
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 6),
                                          child: Container(
                                            height: 50,
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 6),
                                            decoration: BoxDecoration(
                                                color: Color(0xffE0E0E0),
                                                borderRadius:
                                                    BorderRadius.circular(14)),
                                            child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  Flexible(
                                                    flex: 3,
                                                    fit: FlexFit.tight,
                                                    child: GestureDetector(
                                                        onTap: () {
                                                          Get.dialog(
                                                              ChooseTimeDialog(
                                                                  text: "Start",
                                                                  chooseTimeDialogController:
                                                                      chooseController,
                                                                  okTap: () {
                                                                    var value =
                                                                        chooseController
                                                                            .setSeelctedValue(context);

                                                                    if (value !=
                                                                        null) {
                                                                      controller.setStartSelectedTime(
                                                                          index,
                                                                          value);
                                                                      Get.back();
                                                                    }
                                                                  }));
                                                        },
                                                        child: FittedBox(
                                                            child: Text(
                                                          converTimeFrom24Hour(
                                                              controller
                                                                  .selectedTime[
                                                                      index]
                                                                  .stime!,
                                                              context),
                                                          style: TextStyle(
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                        ))),
                                                  ),
                                                  Flexible(
                                                    flex: 1,
                                                    fit: FlexFit.loose,
                                                    child: FittedBox(
                                                        child: Text(
                                                      "-",
                                                      style: TextStyle(
                                                          fontSize: 33,
                                                          fontWeight:
                                                              FontWeight.w100),
                                                    )),
                                                  ),
                                                  Flexible(
                                                    flex: 3,
                                                    fit: FlexFit.tight,
                                                    child: GestureDetector(
                                                        onTap: () {
                                                          Get.dialog(
                                                              ChooseTimeDialog(
                                                                  text: "End",
                                                                  chooseTimeDialogController:
                                                                      chooseController,
                                                                  okTap: () {
                                                                    var value =
                                                                        chooseController
                                                                            .setSeelctedValue(context);

                                                                    if (value !=
                                                                        null) {
                                                                      controller.setEndSelectedTime(
                                                                          index,
                                                                          value);
                                                                      Get.back();
                                                                    }
                                                                  }));
                                                        },
                                                        child: FittedBox(
                                                            child: Text(
                                                                converTimeFrom24Hour(
                                                                    controller
                                                                        .selectedTime[
                                                                            index]
                                                                        .etime!,
                                                                    context),
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        16,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500)))),
                                                  )
                                                ]),
                                          ),
                                        ),
                                      );
                                    }),
                                Flexible(
                                    fit: FlexFit.loose,
                                    flex: 1,
                                    child: GestureDetector(
                                      onTap: () {
                                        controller.dec(index);
                                      },
                                      child: Container(
                                        width: 40,
                                        height: 45,
                                        padding: EdgeInsets.all(8),
                                        decoration: BoxDecoration(
                                            color: Color(0xff0068E1),
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: FittedBox(
                                          child: Icon(
                                            Icons.remove,
                                            color: white,
                                          ),
                                        ),
                                      ),
                                    ))
                              ],
                            ),
                          ),
                        ),
                      ),
                      20.height,
                      FDottedLine(
                        color: AppColors.blue,
                        child: AppButton(
                          onTap: () {
                            controller.inc();
                          },
                          padding: EdgeInsets.all(0),
                          child: Container(
                            // color: Colors.blue.shade50,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 6),
                              child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Add more",
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge!
                                          .copyWith(
                                              color: Color(0xff0068E1),
                                              fontWeight: FontWeight.w500,
                                              fontSize: 16),
                                    ),
                                    Container(
                                      width: 50,
                                      height: 50,
                                      decoration: BoxDecoration(
                                          color: Color(0xff0068E1),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Icon(
                                        Icons.add,
                                        // size: 44,
                                        color: white,
                                      ),
                                    )
                                  ]),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                ]),
              ),
            ),
          );
        });
  }

  AppButton greyButton(BuildContext context, String text, Function onTap) {
    return AppButton(
      color: Color(0xffE0E0E0),
      elevation: 0,
      // width: 140,
      height: 50,
      shapeBorder:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      onTap: onTap,
      child: FittedBox(
        child: Text(
          text,
          style: Theme.of(context)
              .textTheme
              .titleSmall!
              .copyWith(fontSize: 16, fontWeight: FontWeight.w500),
        ),
      ),
    );
  }

  topTextWidget(BuildContext context) {
    return Container(
      width: Get.width,
      height: 100,
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            5.height,
            Padding(
              padding: const EdgeInsets.only(right: 65),
              child: FittedBox(
                child: Text(
                  "Block specific day & time",
                  style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                      fontWeight: FontWeight.w600, color: Colors.black87),
                ),
              ),
            ),
            5.height,
            FittedBox(
              child: Text(
                "Choose a day and time you wish to block",
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    fontWeight: FontWeight.w600, color: Colors.black45),
              ),
            ),
          ]),
    );
  }
}

class CustomClipPath extends CustomClipper<Path> {
  var radius = 10.0;
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.moveTo(radius, 0.0);
    path.arcToPoint(Offset(0.0, radius),
        clockwise: true, radius: Radius.circular(radius));
    path.lineTo(0.0, size.height - radius);
    path.arcToPoint(Offset(radius, size.height),
        clockwise: true, radius: Radius.circular(radius));
    path.lineTo(size.width - radius, size.height);
    path.arcToPoint(Offset(size.width, size.height - radius),
        clockwise: true, radius: Radius.circular(radius));
    path.lineTo(size.width, radius);
    path.arcToPoint(Offset(size.width - radius, 0.0),
        clockwise: true, radius: Radius.circular(radius));
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
