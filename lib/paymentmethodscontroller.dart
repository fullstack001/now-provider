import 'package:fare_now_provider/api_service/service_repository.dart';
import 'package:fare_now_provider/components/buttons-management/part_of_file/part.dart';

import 'package:fare_now_provider/util/app_dialog_utils.dart';

import '../../../paymentmethodsmodel.dart';

import '../../../util/api_utils.dart';
import '../../../util/shared_reference.dart';

class PMController extends GetxController {
  List<PaymentMethodsModel> paymentMethods = [];

  @override
  void onInit() {
    getPaymentMethods();
    super.onInit();
  }

  getPaymentMethods() async {
    AppDialogUtils.dialogLoading();
    String? tok = await SharedRefrence().getString(key: ApiUtills.authToken);
    await ServiceReposiotry().getPaymentMethods(tok??"").then((value) {
      AppDialogUtils.dismiss();
      paymentMethods.clear();
      if (!value.error) {
        // AppDialogUtils.successDialog(value.message);
        print(value.message);
        paymentMethods.add(value);
      } else {
        AppDialogUtils.errorDialog(value.message);
      }
    });
    update();
  }

  addOrRemovePaymentMethods(Map<String, dynamic> _body, {updateStatus}) async {
    AppDialogUtils.dialogLoading();
    String? tok = await SharedRefrence().getString(key: ApiUtills.authToken);
    await ServiceReposiotry()
        .addOrRemovePaymentMethods(tok??"", _body)
        .then((value) {
      AppDialogUtils.dismiss();
      if (!value.error) {
        // AppDialogUtils.successDialog(value.message.toString());
        if (updateStatus != null) {
          updateStatus();
        }
        update();
      } else {
        AppDialogUtils.errorDialog(value.message.toString());
      }
    });
  }
}
