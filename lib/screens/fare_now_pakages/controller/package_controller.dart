import 'dart:convert';

import 'package:fare_now_provider/api_service/service_repository.dart';
import 'package:fare_now_provider/components/buttons-management/part_of_file/part.dart';
import 'package:fare_now_provider/screens/fare_now_pakages/models/pacakge_plan_model.dart';
import 'package:fare_now_provider/util/app_dialog_utils.dart';

import '../../../paymentmethodsmodel.dart' as pms;
import '../../../subscriberslistmodel.dart' as slm;
import '../../../util/api_utils.dart';
import '../../../util/shared_reference.dart';
import '../show_all_packages.dart';

class PackageController extends GetxController {
  List<slm.SubscribersListModel> subscribersList = [];
  bool isPaused = false;

  updateIsPaused(bool val) {
    isPaused = val;
    update();
  }

  var subscribersStatus = "Active".obs;

  updateSubscribersStatus(String val) {
    subscribersStatus.value = val;
    update();
  }

  bool isShow = true;

  updateIsShow(bool value) {
    isShow = value;
    update();
  }

  bool isLoading = false;

  List<Datum> planListData = [];
  updatePlanList(List<Datum> data) {
    planListData.assignAll(data);
    update();
  }
// {error: true, message: {title: The title has already been taken.}}
  createPackages({body}) async {
    AppDialogUtils.dialogLoading();
    await ServiceReposiotry().createPackagePlan(body: body).then((value) {
      var json = jsonDecode(value);
      AppDialogUtils.dismiss();
      if (!json["error"]) {
        AppDialogUtils.dismiss();
        planList();
        Get.back();
        AppDialogUtils.successDialog(json["message"]);
      } else {
        print(json);
        AppDialogUtils.errorDialog("Something Wrong");
      }
    });
  }
  getSubscribersList() async {
    AppDialogUtils.dialogLoading();
    String? tok = await SharedRefrence().getString(key: ApiUtills.authToken);
    await ServiceReposiotry().getSubscribersList(tok ?? "").then((value) {
      AppDialogUtils.dismiss();
      if (!value.error) {
        // AppDialogUtils.successDialog(value.message);
        print(value.message);
        subscribersList.add(value);
      } else {
        // AppDialogUtils.errorDialog(value.message);
      }
    });
    calculateTotalPayment();
  }

  var totalPayement = 0.0.obs;

  calculateTotalPayment() {
    totalPayement.value = 0.0;
    for (int i = 0; i < subscribersList.single.data.length; i++) {
      totalPayement.value = totalPayement.value +
          num.parse(
              subscribersList.single.data[i].serviceRequest.paidAmount ?? 0.0);
      print(totalPayement.runtimeType);
      // assert(totalPayement is double);
    }
    update();
    print(totalPayement.value);
  }

  @override
  void onInit() {
    planList();
    getSubscribersList();
    // getPaymentMethods();
    super.onInit();
  }

  updatePackages({body, id}) async {
    AppDialogUtils.dialogLoading();
    await ServiceReposiotry()
        .updatePackagePlan(body: body, id: id)
        .then((value) {
      var json = jsonDecode(value);

      if (!json["error"]) {
        planList();

        Get.back();
      } else {
        print(json);
        AppDialogUtils.errorDialog("Somethng went wrong");
      }
    });
    AppDialogUtils.dismiss();
  }

  deletePackage({id}) async {
    AppDialogUtils.dialogLoading();
    await ServiceReposiotry().deletePackagePlan(id: id).then((value) {
      var json = jsonDecode(value);

      AppDialogUtils.dismiss();
      if (!json["error"]) {
        planList();
        Get.back();
        AppDialogUtils.successDialog(json["message"]);
      } else {
        AppDialogUtils.errorDialog(json["message"]["title"]);
      }
    });
    AppDialogUtils.dismiss();
  }

  planList() async {
    planListData.clear();
    AppDialogUtils.dialogLoading();
    await ServiceReposiotry().getPlanLIst().then((value) {
      if (!value.error!) {
        print(value);
        updatePlanList(value.data!);
        // Get.back();
      } else {
        updatePlanList([]);
      }
      AppDialogUtils.dismiss();
    });
  }

  void getPackages() {
    AppDialogUtils.dialogLoading();

    Future.delayed(Duration(seconds: 1)).then((value) {
      Get.to(() => const ShowAllPackages());
      AppDialogUtils.dismiss();
    });
  }
}