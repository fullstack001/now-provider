import 'dart:convert';

import 'package:fare_now_provider/api_service/service_repository.dart';
import 'package:fare_now_provider/models/payment_model/payment_model_response.dart';
import 'package:fare_now_provider/util/api_utils.dart';
import 'package:fare_now_provider/util/app_dialog_utils.dart';
import 'package:fare_now_provider/util/shared_reference.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

class PaymentMethodController extends GetxController {
  ServiceReposiotry _serviceReposiotry = ServiceReposiotry();

  void updatePaymentMethod(body, {update}) async {
    AppDialogUtils.dialogLoading();
    try {
      String? authToken =
          await SharedRefrence().getString(key: ApiUtills.authToken);
      PaymentModelResponse response =
          await _serviceReposiotry.updatePaymentMehtod(authToken, body);
      if (!response.error) {
        if (update != null) {
          var data = json.encode(response.paymentModelData.toJson());
          update(data);
        }
      }
      print("response ");
      AppDialogUtils.dismiss();
    } catch (exception) {
      Logger().e(exception);
      AppDialogUtils.dismiss();
    }
  }
}
