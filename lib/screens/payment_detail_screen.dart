import 'package:fare_now_provider/controllers/profile_screen_controller/ProfileScreenController.dart';
import 'package:fare_now_provider/custom_packages/keyboard_overlay/keyboard_overlay.dart';
import 'package:fare_now_provider/screens/work_type_dialog.dart';
import 'package:fare_now_provider/util/app_dialog_utils.dart';
import 'package:fare_now_provider/widgets/custom_toolbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'business_payment_screen.dart';

class PaymentDetailScreen extends StatefulWidget {
  PaymentDetailScreen({Key? key}) : super(key: key);

  @override
  _PaymentDetailScreenState createState() => _PaymentDetailScreenState();
}

class _PaymentDetailScreenState extends State<PaymentDetailScreen>
    with HandleFocusNodesOverlayMixin {
  ProfileScreenController _controller = Get.find();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: false,
        toolbarHeight: 64,
        automaticallyImplyLeading: false,
        flexibleSpace: CustomToolbar(
          title: "Payment Details",
          leading: InkWell(
            onTap: () {
              Get.back();
            },
            child: Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
          ),
        ),
      ),
      body: Container(
        child: BusinessPaymentScreen()

        /*ListView(
          children: [
            /*Container(
              padding: EdgeInsets.all(12),
              width: Get.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "How would you like to get paid?",
                    style: TextStyle(fontSize: 16),
                  ),
                  Container(
                    height: 32,
                    decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.all(Radius.circular(12))),
                    child: MaterialButton(
                      onPressed: () {
                        // if (!checkCreditNull()) {
                        Get.dialog(WorkTypeDialog(
                          update: (value) {
                            setState(() {});
                          },
                        ));
                        // } else {
                        //   alertDialog(
                        //       title: "Alert",
                        //       confirm: MaterialButton(
                        //         onPressed: () {
                        //           Get.back();
                        //         },
                        //         child: Text("Okay"),
                        //       ),
                        //       content:
                        //           "Buy subscription/credit to change payment type");
                        // }
                      },
                      child: Text(
                        _controller.userData.value.userProfileModel
                                    .hourlyRate ==
                                null
                            ? "Quotation Base"
                            : "Hourly \$${_controller.userData.value.userProfileModel.hourlyRate}",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            )*/

            BusinessPaymentScreen(),
          ],
        )*/
        ,
      ),
    );
  }

  bool checkCreditNull() {
    // if (_controller.userData.value.credit == null) {
    //   return true;
    // }
    // if (_controller.userData.value.credit.toString().isEmpty) {
    //   return true;
    // }
    // if (_controller.userData.value.credit.toString() == "0") {
    //   return true;
    // }
    if (_controller.userData.value.credit == null) {
      return true;
    }
    if (_controller.userData.value.credit.toString().isEmpty) {
      return true;
    }
    if (_controller.userData.value.credit.toString() == "0") {
      return true;
    }
    return false;
  }
}
