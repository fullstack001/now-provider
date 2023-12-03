import 'package:fare_now_provider/components/buttons-management/part_of_file/part.dart';
import 'package:fare_now_provider/components/buttons-management/style_model.dart';
import 'package:fare_now_provider/components/text_fields/farenow_text_field.dart';
import 'package:fare_now_provider/controllers/profile_screen_controller/ProfileScreenController.dart';
import 'package:fare_now_provider/screens/wallet_screens/controller/wallet_controller.dart';
import 'package:fare_now_provider/util/app_colors.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../payment/stripe.dart';

class AddCreditScreen extends GetView<WalletController> {
  WalletController _walletController = Get.find();
  ProfileScreenController _controller = Get.find();
  final amountController = TextEditingController();

  void _onRefresh() async {
    // monitor network fetch
    await _walletController.getPackages();
    // if failed,use refreshFailed()
  }

  // void _onLoading() async {
  //   // monitor network fetch

  //   _refreshController.loadComplete();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: white,
        elevation: 1,
        iconTheme: IconTheme.of(context).copyWith(color: black),
        title: const Text(
          "Deposit",
          style: TextStyle(color: black),
        ),
      ),
      body: Obx(() {
        return _walletController.isLoading.value
            ? Container()
            : GetBuilder<WalletController>(
                init: WalletController(),
                builder: (controller) {
                  return SmartRefresher(
                    controller: _walletController.refreshController,
                    onRefresh: _onRefresh,
                    child: ListView(children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24, vertical: 12),
                        child: Row(children: [
                          AppButton(
                            padding: const EdgeInsets.symmetric(horizontal: 23),
                            shapeBorder: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30)),
                            color: controller.isShow
                                ? AppColors.grey
                                : AppColors.solidBlue,
                            onTap: () {
                              controller.updateIsShow(false);
                            },
                            child: Text(
                              "Packages",
                              style: TextStyle(
                                  color: controller.isShow ? black : white),
                            ),
                          ),
                          12.width,
                          AppButton(
                            padding: const EdgeInsets.symmetric(horizontal: 23),
                            shapeBorder: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30)),
                            color: controller.isShow
                                ? AppColors.solidBlue
                                : AppColors.grey,
                            onTap: () {
                              controller.updateIsShow(true);
                            },
                            child: Text(
                              "Buy Credit",
                              style: TextStyle(
                                  color: controller.isShow ? white : black),
                            ),
                          ),
                        ]),
                      ),
                      20.height,
                      !controller.isShow
                          ? Wrap(
                              alignment: WrapAlignment.center,
                              children: List.generate(
                                  controller.subscriptionPlanData.length,
                                  (index) {
                                return Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 8),
                                  child: Container(
                                    width: Get.width * 0.45,
                                    height: Get.width * 0.65,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12),
                                        border: Border.all(
                                            color: AppColors.solidBlue)),
                                    child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Container(
                                            child: Text(controller
                                                .subscriptionPlanData[index]
                                                .stripeName
                                                .toString()),
                                          ),
                                          Container(
                                            child: Text(
                                              "${_walletController.currencyValue}${controller.subscriptionPlanData[index].price}",
                                              style: const TextStyle(
                                                  color: AppColors.solidBlue,
                                                  fontFamily: "Roboto",
                                                  fontSize: 26,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ),
                                          Container(
                                            child: Text(
                                                "${controller.subscriptionPlanData[index].credit} Leads"),
                                          ),
                                          Container(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 3),
                                            child: ReadMoreText(
                                                "${controller.subscriptionPlanData[index].description}",
                                                textAlign: TextAlign.center,
                                                style: const TextStyle(
                                                    color: AppColors.black,
                                                    fontSize: 12,
                                                    fontWeight:
                                                        FontWeight.w400)),
                                          ),
                                          // Container(
                                          //   child: Text(
                                          //       "${controller.subscriptionPlanData[index].description}",
                                          //       textAlign: TextAlign.center,
                                          //       style: TextStyle(
                                          //           color: AppColors.black,
                                          //           fontSize: 12,
                                          //           fontWeight: FontWeight.w400)),
                                          // ),
                                          FarenowButton(
                                              title: "PAY NOW",
                                              onPressed: () {
                                                Get.to(() => StripeModel(
                                                      stripeName: controller
                                                          .subscriptionPlanData[
                                                              index]
                                                          .stripeName,
                                                      isPackage: true,
                                                      totalAmount: controller
                                                          .subscriptionPlanData[
                                                              index]
                                                          .price,
                                                      onPageChange: () {
                                                        amountController.text =
                                                            "";
                                                        _controller
                                                            .getProviderProfile(
                                                                id: _controller
                                                                    .userData
                                                                    .value
                                                                    .id,
                                                                flag: true);
                                                        _walletController
                                                            .getTransactionHistory();
                                                        print("");
                                                        // setState(() {});
                                                      },
                                                    ));
                                              },
                                              type: BUTTONTYPE.rectangular)
                                        ]),
                                  ),
                                );
                              }),
                            )
                          : Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 24),
                              child: Stack(children: [
                                // Column(
                                //   children: [

                                //   ],
                                // ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Container(
                                      alignment: Alignment.centerLeft,
                                      child: const Text(
                                        "Deposit Amount",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 32),
                                      ),
                                    ),
                                    12.height,
                                    FarenowTextField(
                                        controller: amountController,
                                        hint: "Enter deposit amount",
                                        label:
                                            "How much do you want to deposit"),
                                    SizedBox(
                                      height: Get.width * 0.85,
                                    ),
                                    // Card(
                                    //   shape: RoundedRectangleBorder(
                                    //       borderRadius:
                                    //           BorderRadius.circular(18)),
                                    //   child: Padding(
                                    //     padding: const EdgeInsets.symmetric(
                                    //         horizontal: 24, vertical: 12),
                                    //     child: Column(children: [
                                    //       Row(
                                    //         mainAxisAlignment:
                                    //             MainAxisAlignment.spaceBetween,
                                    //         children: const [
                                    //           Text(
                                    //             "Available Balance",
                                    //             style: TextStyle(
                                    //                 fontWeight: FontWeight.w400,
                                    //                 fontSize: 14),
                                    //           ),
                                    //           Text(
                                    //             "1000.00\$",
                                    //             style: TextStyle(
                                    //                 fontWeight: FontWeight.w700,
                                    //                 fontSize: 18),
                                    //           ),
                                    //         ],
                                    //       ),
                                    //       const Divider(),
                                    //       Row(
                                    //         mainAxisAlignment:
                                    //             MainAxisAlignment.spaceBetween,
                                    //         children: const [
                                    //           Text(
                                    //             "Total Deposit",
                                    //             style: TextStyle(
                                    //                 fontWeight: FontWeight.w400,
                                    //                 fontSize: 14),
                                    //           ),
                                    //           Text(
                                    //             "500.00\$",
                                    //             style: TextStyle(
                                    //                 fontWeight: FontWeight.w700,
                                    //                 fontSize: 18),
                                    //           ),
                                    //         ],
                                    //       ),
                                    //     ]),
                                    //   ),
                                    // ),
                                  ],
                                ),
                                Container(
                                  height: Get.height * 0.73,
                                  width: Get.width,
                                  alignment: Alignment.bottomCenter,
                                  child: FarenowButton(
                                      title: "Continue",
                                      onPressed: () {
                                        String price =
                                            amountController.text.toString();
                                        if (price.isEmpty) {
                                          Get.defaultDialog(
                                              title: "Alert",
                                              content: const Text(
                                                "Please select amount before proceed next",
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
                                        print("wallet");

                                        Get.to(() => StripeModel(
                                              isPackage: false,
                                              totalAmount: price,
                                              onPageChange: () {
                                                amountController.text = "";
                                                _controller.getProviderProfile(
                                                    id: _controller
                                                        .userData.value.id,
                                                    flag: true);
                                                _walletController
                                                    .getTransactionHistory();
                                                print("");
                                                // setState(() {});
                                              },
                                            ));
                                      },
                                      style: FarenowButtonStyleModel(
                                          padding: EdgeInsets.zero),
                                      type: BUTTONTYPE.rectangular),
                                )
                              ]),
                            )
                    ]),
                  );
                });
      }),
    );
  }
}
