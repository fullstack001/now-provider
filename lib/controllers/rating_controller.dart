import 'package:fare_now_provider/api_service/service_repository.dart';
import 'package:fare_now_provider/util/api_utils.dart';
import 'package:fare_now_provider/util/app_dialog_utils.dart';
import 'package:fare_now_provider/util/shared_reference.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

class RatingController extends GetxController {
  ServiceReposiotry _serviceReposiotry = ServiceReposiotry();

  sendFeedback({body, onSendFeedback}) async {
    AppDialogUtils.dialogLoading();
    try {
      String? authToken =
          await SharedRefrence().getString(key: ApiUtills.authToken);
      var response = await _serviceReposiotry.sendFeedback(
          authToken: authToken, body: body);
      print("");
      if (onSendFeedback != null) {
        onSendFeedback();
      }
      AppDialogUtils.dismiss();
    } catch (exception) {
      Logger().e(exception);
      AppDialogUtils.dismiss();
    }
  }
}
