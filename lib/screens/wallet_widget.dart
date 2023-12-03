import 'package:fare_now_provider/controllers/profile_screen_controller/ProfileScreenController.dart';
import 'package:fare_now_provider/custom_packages/keyboard_overlay/keyboard_overlay.dart';
import 'package:fare_now_provider/screens/payment/stripe.dart';
import 'package:fare_now_provider/screens/wallet_screens/controller/wallet_controller.dart';
import 'package:fare_now_provider/util/api_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class WalletWidget extends StatefulWidget {
  @override
  _WalletWidgetState createState() => _WalletWidgetState();
}

class _WalletWidgetState extends State<WalletWidget>
    with HandleFocusNodesOverlayMixin {
  List<String> rate = ["1", "5", "10", "100", "1000"];

  var _priceController = TextEditingController();
  WalletController _walletController = Get.find();
  ProfileScreenController _controller = Get.find();
  FocusNode amount = FocusNode();
  void setDoneButton() {
    if (GetPlatform.isIOS) {
      amount = GetFocusNodeOverlay(
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
    // TODO: implement initState
    super.initState();
    _walletController.getCredit();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 50,
        ),
        Container(
          width: 150,
          height: 150,
          child: SvgPicture.asset(
            "assets/ic_digital_wallet.svg",
            height: 14,
            width: 14,
            fit: BoxFit.fill,
          ),
        ),
        SizedBox(
          height: 50,
        ),
        Container(
          margin: EdgeInsets.only(
            left: 12,
            right: 12,
          ),
          width: Get.width,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(12)),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 7,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ]),
          child: Obx(() => Column(
                children: [
                  SizedBox(
                    height: 12,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 24,
                      ),
                      Text(
                        "Wallet",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        width: 4,
                      ),
                      Text(
                        "( ${(double.parse(_walletController.getUserCredit.value.data ?? "0.00")).toString()} ) \$",
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.normal),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 24,
                      ),
                      Text(
                        "\$",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 8),
                        alignment: Alignment.centerLeft,
                        width: 80,
                        height: 40,
                        decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.all(Radius.circular(8))),
                        child: TextFormField(
                          focusNode: amount,
                          controller: _priceController,
                          onChanged: (val) {},
                          validator: (val) {
                            if (val!.isEmpty || val == "\$") {
                              return "Field required";
                            }
                            return null;
                          },
                          keyboardType: TextInputType.number,
                          style: TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                            isDense: true,
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                            hintText: "0",
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 32,
                      ),
                      Expanded(
                          child: Container(
                        height: 40,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: [
                            for (int index = 0; index < rate.length; index++)
                              InkWell(
                                onTap: () {
                                  _priceController.text = rate[index];
                                  setSelection(_priceController);
                                  setState(() {});
                                },
                                child: Container(
                                  padding: EdgeInsets.all(12),
                                  margin: EdgeInsets.only(
                                      left: index == 0 ? 0 : 6,
                                      right: index == rate.length - 1 ? 12 : 0),
                                  alignment: Alignment.center,
                                  height: 40,
                                  decoration: BoxDecoration(
                                      color: Color(0xff1B80F5),
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(8))),
                                  child: Text(
                                    "\$${rate[index]}",
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ))
                    ],
                  ),
                  SizedBox(
                    height: 12,
                  ),
                ],
              )),
        ),
        Expanded(
            child: SizedBox(
          height: 10,
        )),
        Container(
          width: Get.width,
          height: 40,
          alignment: Alignment.center,
          margin: EdgeInsets.only(left: 24, right: 24),
          decoration: BoxDecoration(
              color: Color(0xff1B80F5),
              borderRadius: BorderRadius.all(Radius.circular(32))),
          child: MaterialButton(
            onPressed: () {
              String price = _priceController.text.toString();
              if (price.isEmpty) {
                Get.defaultDialog(
                    title: "Alert",
                    content: Text(
                      "Please select amount before proceed next",
                      textAlign: TextAlign.center,
                    ),
                    confirm: MaterialButton(
                      onPressed: () {
                        Get.back();
                      },
                      child: Text("Okay"),
                    ));
                return;
              }
              print("wallet");

              Get.to(() => StripeModel(
                    isPackage: false,
                    totalAmount: price,
                    onPageChange: () {
                      _priceController.text = "";
                      _controller.getProviderProfile(
                          id: _controller.userData.value.id, flag: true);
                      _walletController.getTransactionHistory();
                      print("");
                      setState(() {});
                    },
                  ));
            },
            child: Text(
              "Add Amount",
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
          ),
        ),
        SizedBox(
          height: 24,
        ),
      ],
    );
  }
}
