import 'package:fare_now_provider/components/buttons-management/part_of_file/part.dart';
import 'package:fare_now_provider/components/buttons-management/style_model.dart';
import 'package:fare_now_provider/components/text_fields/farenow_text_field.dart';
import 'package:fare_now_provider/controllers/profile_screen_controller/ProfileScreenController.dart';
import 'package:fare_now_provider/screens/payment/stripe.dart';
import 'package:fare_now_provider/screens/wallet_screens/controller/wallet_controller.dart';
import 'package:fare_now_provider/screens/wallet_screens/desposit_success_dialog.dart';
import 'package:fare_now_provider/util/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';


class WithdrawScreen extends GetView<WalletController> {

  final amountController = TextEditingController();
  final descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: white,
        elevation: 1,
        iconTheme: IconTheme.of(context).copyWith(color: black),
        title: const Text(
          "Withdrawal",
          style: TextStyle(color: black),
        ),
      ),
      body:  GetBuilder<WalletController>(
            init: WalletController(),
            builder: (controller) {
              return ListView(children: [
                 Container(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 24),
                  child: Stack(children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        SizedBox(height: 20,),
                        Container(
                          alignment: Alignment.centerLeft,
                          child: const Text(
                            "Withdrawal Amount",
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 32),
                          ),
                        ),
                        12.height,
                        FarenowTextField(
                            controller: amountController,
                            hint: "Enter withdraw amount",
                            label:
                            "How much do you want to withdraw"),
                        12.height,
                        FarenowTextField(
                            controller: descriptionController,
                            hint: "Description",
                            label:
                            "Why do you want to withdraw"),
                        SizedBox(
                          height: Get.width * 0.75,
                        ),

                        12.height,
                        FarenowButton(
                            title: "Continue",
                            onPressed: () {
                              String amount =
                              amountController.text.toString();
                              String description=descriptionController.text.toString();
                              if (amount.isEmpty) {
                                Get.defaultDialog(
                                    title: "Alert",
                                    content: const Text(
                                      "Please select withdraw amount before you proceed forward",
                                      textAlign: TextAlign.center,
                                    ),
                                    confirm: MaterialButton(
                                      onPressed: () {
                                        Get.back();
                                      },
                                      child: const Text("Okay"),
                                    ));
                                return;
                              }
                              if (description.isEmpty) {
                                Get.defaultDialog(
                                    title: "Alert",
                                    content: const Text(
                                      "Please select a reason for withdrawal before proceeding forward",
                                      textAlign: TextAlign.center,
                                    ),
                                    confirm: MaterialButton(
                                      onPressed: () {
                                        Get.back();
                                      },
                                      child: const Text("Okay"),
                                    ));
                                return;
                              }
                              Map<String,dynamic> _body={
                                "amount":amount,
                                "description":description
                              };
                              print("withdraw : $_body");
                             controller.getWithdrawalAmount(_body);

                            },
                            style: FarenowButtonStyleModel(
                                padding: EdgeInsets.zero),
                            type: BUTTONTYPE.rectangular)
                      ],
                    )
                  ]),
                )
              ]);
      }),
    );
  }
}
