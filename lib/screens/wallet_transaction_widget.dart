import 'package:fare_now_provider/api_service/service_repository.dart';
import 'package:fare_now_provider/models/transaction/transation_data.dart';
import 'package:fare_now_provider/models/transaction/transation_list_data.dart';
import 'package:fare_now_provider/models/transaction/transation_response.dart';
import 'package:fare_now_provider/screens/wallet_screens/controller/wallet_controller.dart';
import 'package:fare_now_provider/util/api_utils.dart';
import 'package:fare_now_provider/util/date_time_utills.dart';
import 'package:fare_now_provider/util/shared_reference.dart';
import 'package:fare_now_provider/util/widgest_utills.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WalletTransactionWidget extends StatefulWidget {
  WalletTransactionWidget({Key? key}) : super(key: key);

  @override
  _WalletTransactionWidgetState createState() =>
      _WalletTransactionWidgetState();
}

class _WalletTransactionWidgetState extends State<WalletTransactionWidget> {
  WalletController _walletController = Get.find();
  ScrollController _controller = ScrollController();
  String? currencyValue;
  Future countryCurrency()async{
    await SharedRefrence().getCurrencyCode(key: "CurrencyCode").then((value) {
      setState(() {
        currencyValue = value;
        print("valueeeeeeeeeeeee of currency ====$currencyValue");
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _walletController.getTransactionHistory();
    setPagination();
countryCurrency();
    // ControllerInit().init();
  }

  bool firstInit = false;
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => _walletController.transactionData.value.transationData == null
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 100,
                  height: 100,
                  child: Image.asset(
                    "assets/ic_transaction.png",
                    color: Colors.black,
                    fit: BoxFit.fill,
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                const Text(
                  "No Transaction Found",
                  style: TextStyle(fontSize: 16),
                ),
              ],
            )
          : _walletController.transactionData.value.transationData
                  .transationListData.isEmpty
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 100,
                      height: 100,
                      child: Image.asset(
                        "assets/ic_transaction.png",
                        color: Colors.black,
                        fit: BoxFit.fill,
                      ),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    const Text(
                      "No Transaction Found",
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                )
              : Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      width: Get.width,
                      height: 30,
                      child: const Text(
                        "Transaction History",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w700),
                      ),
                    ),
                    SizedBox(
                      width: Get.width,
                      height: Get.height,
                      child: ListView.builder(
                        controller: _controller,
                        itemCount: _walletController.transactionData.value
                            .transationData.transationListData.length,
                        itemBuilder: (BuildContext context, int index) {
                          int size = (_walletController
                                      .transactionData
                                      .value
                                      .transationData
                                      .transationListData
                                      .length -
                                  1) -
                              index;
                          TransationListData value = _walletController
                              .transactionData
                              .value
                              .transationData
                              .transationListData[size];
                          List list = _walletController.transactionData.value
                              .transationData.transationListData;
                          return Column(
                            children: [
                              loading && index == list.length - 1
                                  ? const Column(
                                      children: [
                                        SizedBox(
                                          height: 12,
                                        ),
                                        CircularProgressIndicator(),
                                        SizedBox(
                                          height: 12,
                                        ),
                                      ],
                                    )
                                  : customContainer(
                                      width: Get.width,
                                      height: 70,
                                      color: Colors.white,
                                      marginRight: 24,
                                      marginLeft: 24,
                                      paddingRight: 12,
                                      marginTop: index == 0 ? 12 : 6,
                                      marginBottom:
                                          index == list.length - 1 ? 12 : 0,
                                      paddingLeft: 12,
                                      alignment: Alignment.centerLeft,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Text(
                                                value.amount
                                                        .toString()
                                                        .contains("-")
                                                    ? "Deduct Amount"
                                                    : "Purchased Balance:",
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 16),
                                              ),
                                              Text(
                                                " $currencyValue${getAmount(value.amount)}",
                                                style: const TextStyle(
                                                  fontFamily: "Roboto",
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    fontSize: 14),
                                              ),
                                              const Expanded(
                                                  child: SizedBox(
                                                width: 10,
                                              )),
                                              Text(
                                                "${DateTimeUtils().checkSince(DateTimeUtils().onlyDate(value.createdAt))}",
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.normal,
                                                  fontSize: 14,
                                                  color: Colors.grey,
                                                ),
                                              )
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 6,
                                          ),
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Visibility(
                                                child: const Text(
                                                  "Payment Method:",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 16),
                                                ),
                                                visible:
                                                    value.paymentMethod != null,
                                              ),
                                              Visibility(
                                                visible:
                                                    value.paymentMethod != null,
                                                child: Text(
                                                  " ${value.paymentMethod.toString().capitalizeFirst}",
                                                  style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.normal,
                                                      fontSize: 14),
                                                ),
                                              ),
                                              const Expanded(
                                                  child: SizedBox(
                                                width: 10,
                                              )),
                                              Text(
                                                "${getStatus(value.status)}",
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.normal,
                                                  fontSize: 14,
                                                  color: Colors.green,
                                                ),
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                            ],
                          );
                        },
                      ),
                    ),
                  ],
                ),
    );
  }

  void setPagination() {
    _controller.addListener(() async {
      if (_controller.position.atEdge && _controller.position.pixels != 0) {
        print("pagination");
        TransationData data =
            _walletController.transactionData.value.transationData;
        if (data.nextPageUrl != null) {
          loading = true;
          setState(() {});
          String page = data.nextPageUrl.split("page=")[1];
          ServiceReposiotry _repo = ServiceReposiotry();
          String? authToken =
              await SharedRefrence().getString(key: ApiUtills.authToken);
          TransationResponse response = await _repo.getTransactionHistory(
              authToken: authToken, page: page);
          _walletController.transactionData.value.transationData.nextPageUrl =
              response.transationData.nextPageUrl;

          _walletController
              .transactionData.value.transationData.transationListData
              .addAll(response.transationData.transationListData);
          loading = false;
          setState(() {});
          print("");
        }
      }
    });
  }

  getAmount(amount) {
    if (amount.toString().contains("+")) {
      amount = amount.toString().replaceAll("+", "");
    }
    if (amount.toString().contains("-")) {
      amount = amount.toString().replaceAll("-", "");
    }
    return amount;
  }

  getStatus(status) {
    if (status == null) {
      return "Succeeded";
    }
    return "$status".capitalizeFirst;
  }
}
