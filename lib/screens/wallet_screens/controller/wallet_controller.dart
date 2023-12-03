import 'dart:convert';

import 'package:fare_now_provider/api_service/service_repository.dart';
import 'package:fare_now_provider/controllers/profile_screen_controller/ProfileScreenController.dart';
import 'package:fare_now_provider/models/credit/get_credit.dart';
import 'package:fare_now_provider/models/transaction/transation_response.dart';
import 'package:fare_now_provider/util/api_utils.dart';
import 'package:fare_now_provider/util/app_colors.dart';
import 'package:fare_now_provider/util/app_dialog_utils.dart';
import 'package:fare_now_provider/util/shared_reference.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../models/wallet/subscription_plan_model.dart';
import '../desposit_success_dialog.dart';

class WalletController extends GetxController {
  ServiceReposiotry _serviceReposiotry = ServiceReposiotry();

  var getUserCredit = GetCredit().obs;
  var transactionData = TransationResponse().obs;
  String currencyValue = "";
  void subscribePackage({body}) async {
    try {
      var response = await _serviceReposiotry.subscribePackage(body: body);
      if (!response.error!) {
        Get.to(DepositScreen());
      } else {
        AppDialogUtils.dismiss();
        AppDialogUtils.errorDialog(response.message!);
      }
    } catch (e) {
      print(e.toString());
    }
  }

  //todo
  getWithdrawalAmount(Map<String, dynamic> _body) async {
    AppDialogUtils.dialogLoading();
    String? tok = await SharedRefrence().getString(key: ApiUtills.authToken);
    try {
      var response = await _serviceReposiotry.withdrawAmount(tok ?? "", _body);
      if (!response.error!) {
        AppDialogUtils.successDialog(response.message);
      } else {
        AppDialogUtils.dismiss();
        AppDialogUtils.errorDialog(response.message.toString());
      }
    } catch (e) {
      print(e.toString());
    }
  }

  void purchaseCredit({token, amount, onPageChange}) async {
    // AppDialogUtils.dialogLoading();
    try {
      String? authToken =
          await SharedRefrence().getString(key: ApiUtills.authToken);
      var response = await _serviceReposiotry.purchaseCredit(
          authToken: authToken, body: token, amount: amount);
      if (response.error) {
        AppDialogUtils.dismiss();
        AppDialogUtils.errorDialog(response.message);
        // AppDialogUtils.errorDialog("Something Wrong");
      } else {
        AppDialogUtils.dismiss();
        GetCredit obj = getUserCredit.value;
        obj.data = obj.data ?? "0";
        obj.data = (double.parse(obj.data) +
                double.parse(response.buyCreditData.amount))
            .toString();
        await Get.find<ProfileScreenController>().getProfile();
        Get.to(DepositScreen.new);
        getUserCredit(obj);
        // update();
        print(obj.data);

        if (onPageChange != null) {
          onPageChange();
        }
        // AppDialogUtils.errorDialog("Failed to resend OTP");
      }
    } catch (e) {
      AppDialogUtils.dismiss();
      print("error");
    }
  }

  void getCredit() async {
    String credit = getUserCredit.value.data ?? "";
    // if (credit.isEmpty) {
    //   AppDialogUtils.dialogLoading();
    // }
    try {
      String? authToken =
          await SharedRefrence().getString(key: ApiUtills.authToken);
      var response = await _serviceReposiotry.getCredit(authToken: authToken);
      if (response.error) {
        AppDialogUtils.dismiss();
        // AppDialogUtils.successDialog("Internal Server Error");
      } else {
        AppDialogUtils.dismiss();
        getUserCredit(response);
        // AppDialogUtils.errorDialog("Failed to resend OTP");
      }
    } catch (e) {
      AppDialogUtils.dismiss();
      print("error");
    }
  }

  void getTransactionHistory() async {
    // if (transactionData.value.transationData == null) {
    //   AppDialogUtils.dialogLoading();
    // }
    try {
      String? authToken =
          await SharedRefrence().getString(key: ApiUtills.authToken);
      TransationResponse response =
          await _serviceReposiotry.getTransactionHistory(authToken: authToken);
      if (response.error!) {
        AppDialogUtils.dismiss();
        AppDialogUtils.successDialog("Internal Server Error");
      } else {
        AppDialogUtils.dismiss();
        transactionData(response);
        // Get.snackbar("Transaction history", response.message);
        // AppDialogUtils.errorDialog("Failed to resend OTP");
      }
    } catch (e) {
      AppDialogUtils.dismiss();
      print("error");
    }
  }

  Future getCardToken({body}) async {
    try {
      var respone =
          await http.post(Uri.parse("https://api.stripe.com/v1/tokens"),
              body: body,
              headers: {
                "Authorization": "Bearer $publicTestKey",
                "Accept": "application/json",
                "Content-Type": "application/x-www-form-urlencoded"
              },
              encoding: Encoding.getByName("utf-8"));

      var jsonData = jsonDecode(respone.body);
      if (jsonData["id"] != null) {
        if (respone.reasonPhrase!.toLowerCase() == "Ok".toLowerCase()) {
          AppDialogUtils.dismiss();
          return jsonData["id"];
        }
      } else if (jsonData["error"] != null) {
        AppDialogUtils.dismiss();
        AppDialogUtils.errorDialog(jsonData["error"]["message"]);
        return null;
      } else {
        AppDialogUtils.dismiss();
        return null;
      }
    } catch (e) {
      print(e.toString());
      AppDialogUtils.dismiss();
      return null;
    }
  }

  @override
  void onInit() {
    getPackages();
    super.onInit();
  }

  var isLoading = false.obs;
  bool isShow = false;
  updateIsShow(bool value) {
    isShow = value;
    update();
  }

  List<SubscriptionPlanData> subscriptionPlanData = [];
  updatesubscriptionPlanData(List<SubscriptionPlanData> data) {
    subscriptionPlanData.assignAll(data);
  }

  RefreshController refreshController =
      RefreshController(initialRefresh: false);
  getPackages() async {
    isLoading(true);

    await ServiceReposiotry().getPackagePlan().then((value) {
      if (!value.error!) {
        refreshController.loadComplete();
        isLoading(false);
        updatesubscriptionPlanData(value.data!);
        refreshController.refreshCompleted();
      } else {
        isLoading(false);
      }
    });
  }
}
