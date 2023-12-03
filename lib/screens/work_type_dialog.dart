import 'dart:convert';

import 'package:fare_now_provider/controllers/payment/payment_method_cotnroller.dart';
import 'package:fare_now_provider/controllers/profile_screen_controller/ProfileScreenController.dart';
import 'package:fare_now_provider/custom_packages/keyboard_overlay/keyboard_overlay.dart';
import 'package:fare_now_provider/models/payment_model/payment_model_data.dart';
import 'package:fare_now_provider/screens/Controller/HomeScreenController.dart';
import 'package:fare_now_provider/screens/wallet_screens/wallet_screen.dart';
import 'package:fare_now_provider/util/api_utils.dart';
import 'package:fare_now_provider/util/app_dialog_utils.dart';
import 'package:fare_now_provider/util/shared_reference.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WorkTypeDialog extends StatefulWidget {
  final update;

  WorkTypeDialog({Key? key, this.update}) : super(key: key);

  @override
  _WorkTypeDialogState createState() => _WorkTypeDialogState();
}

class _WorkTypeDialogState extends State<WorkTypeDialog>
    with HandleFocusNodesOverlayMixin {
  var isHour;
  ProfileScreenController _controller = Get.find();
  HomeScreenController _homeScreenController = Get.find();
  var _priceController = TextEditingController();

  PaymentMethodController _methodController = Get.find();

  var hourFocus = FocusNode();

  void setDoneButton() {
    if (GetPlatform.isIOS) {
      hourFocus = GetFocusNodeOverlay(
          child: TopKeyboardUtil(
        DoneButtonIos(
          label: 'Done',
          onSubmitted: () => Get.focusScope!.unfocus(),
          platforms: ['android', 'ios'],
        ),
      ));
    }
  }

  @override
  void initState() {
    setDoneButton();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // if (_controller.userData.value.userProfileModel.hourlyRate != null) {
    if (_controller.userData.value.providerProfile!.hourlyRate != null) {
      _priceController.text =
          // "\$${_controller.userData.value.userProfileModel.hourlyRate.toString()}";
          "\$${_controller.userData.value.providerProfile!.hourlyRate.toString()}";
    }
    if (isHour == null) {
      // isHour = _controller.userData.value.userProfileModel.hourlyRate != null;
      isHour = _controller.userData.value.providerProfile!.hourlyRate != null;
    }
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: EdgeInsets.all(32),
          width: Get.width,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(12))),
          child: Column(
            children: [
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.all(12),
                width: Get.width,
                child: Text(
                  "Choose Payment Method",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Divider(),
              InkWell(
                onTap: () {
                  if (!isHour) {
                    isHour = true;
                  }
                  setState(() {});
                },
                child: Container(
                  padding: EdgeInsets.all(12),
                  width: Get.width,
                  child: Row(
                    children: [
                      Icon(isHour
                          ? Icons.radio_button_checked
                          : Icons.radio_button_off),
                      SizedBox(
                        width: 12,
                      ),
                      Text(
                        "Hourly",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight:
                              isHour ? FontWeight.bold : FontWeight.normal,
                        ),
                      ),
                      Expanded(
                          child: SizedBox(
                        width: 10,
                      )),
                      Container(
                        alignment: Alignment.center,
                        width: 80,
                        child: TextField(
                          focusNode: hourFocus,
                          enabled: isHour,
                          controller: _priceController,
                          onChanged: (val) {
                            String value = "\$${val.replaceAll('\$', "")}";
                            _priceController.text = value;

                            _priceController.selection = TextSelection(
                                baseOffset: value.length,
                                extentOffset: value.length);
                            // _controller.userData.value.userProfileModel
                            //     .hourlyRate = int.parse(val);
                            _controller.userData.value.providerProfile!
                                .hourlyRate = val;
                            print(value);
                          },
                          textAlign: TextAlign.center,
                          keyboardType: TextInputType.number,
                          style: TextStyle(
                              color: isHour ? Colors.black : Colors.grey),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                            hintText: "\$00",
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  alertDialog(
                      title: "Alert",
                      confirm: MaterialButton(
                        onPressed: () {
                          Get.back();
                        },
                        child: Text("Okay"),
                      ),
                      content:
                          "Buy subscription/credit to change payment type");
                  // if (_controller.userData.value.credit == null ||
                  //     _controller.userData.value.credit.toString().isEmpty ||
                  //     _controller.userData.value.credit.toString() == "0") {
                  //   alertDialog(
                  //       title: "Alert",
                  //       cancel: MaterialButton(
                  //         onPressed: () {
                  //           Get.back();
                  //         },
                  //         child: Text("Close"),
                  //       ),
                  //       confirm: MaterialButton(
                  //         onPressed: () {
                  //           Get.back();
                  //           Get.to(() => WalletScreen());
                  //         },
                  //         child: Text("Buy Credit"),
                  //       ),
                  //       content:
                  //           "Buy subscription/credit to change payment type");

                  //   return;
                  // }
                  if (isHour) {
                    isHour = false;
                  }
                  setState(() {});
                },
                child: Container(
                  padding: EdgeInsets.all(12),
                  width: Get.width,
                  child: Row(
                    children: [
                      Icon(isHour
                          ? Icons.radio_button_off
                          : Icons.radio_button_checked),
                      SizedBox(
                        width: 12,
                      ),
                      Text(
                        "Quotation Base",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight:
                              isHour ? FontWeight.normal : FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                margin:
                    EdgeInsets.only(left: 12, right: 12, bottom: 12, top: 12),
                width: Get.width,
                decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.all(Radius.circular(12))),
                child: MaterialButton(
                  onPressed: () {
                    Get.focusScope!.unfocus();

                    var price = _priceController.text.replaceAll('\$', "");
                    if (isHour) {
                      if (price.isEmpty) {
                        showErrorDialog(
                            title: "Alert",
                            content: "Price required",
                            confirmTitle: "Okay",
                            confirm: () {
                              Get.back();
                            });
                        return;
                      }
                    }

                    if (!isHour) {
                      price = "";
                    }

                    Map body = <String, dynamic>{
                      "hourly_rate": price.isEmpty ? "" : int.parse(price)
                    };
                    bool hasPending = _homeScreenController.hasPending();
                    if (hasPending) {
                      alertDialog(
                          title: "Alert",
                          content:
                              "Before change payment method please accept or reject order from list",
                          confirm: MaterialButton(
                            onPressed: () {
                              Get.back();
                            },
                            child: Text("Okay"),
                          ));
                    } else {
                      _methodController.updatePaymentMethod(
                        body,
                        update: (value) {
                          print(value);
                          PaymentModelData data =
                              PaymentModelData.fromJson(json.decode(value));

                          // _controller.userData.value.userProfileModel
                          //     .hourlyRate = data.hourlyRate;
                          _controller.userData.value.providerProfile!
                              .hourlyRate = data.hourlyRate;
                          // String userStr = jsonEncode(_controller
                          //     .userData.value.userProfileModel
                          //     .toJson());
                          String userStr = jsonEncode(_controller
                              .userData.value.providerProfile!
                              .toJson());
                          SharedRefrence().saveString(
                              key: ApiUtills.userData, data: userStr);

                          if (widget.update != null) {
                            widget.update("");
                          }
                          Get.back();
                        },
                      );
                    }
                    print(price);
                  },
                  child: Text(
                    "Submit",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void showErrorDialog(
      {content, title, confirm, confirmTitle, cancel, cancelTitle}) {
    Get.defaultDialog(
      content: Text(content),
      title: title,
      confirm: confirm == null
          ? Container()
          : MaterialButton(
              onPressed: confirm,
              child: Text(confirmTitle),
            ),
      cancel: cancel == null
          ? Container()
          : MaterialButton(
              onPressed: cancel,
              child: Text(cancelTitle),
            ),
    );
  }
}
