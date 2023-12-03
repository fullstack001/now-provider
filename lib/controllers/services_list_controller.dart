import 'package:fare_now_provider/api_service/service_repository.dart';
import 'package:fare_now_provider/models/service_update/service_update_model.dart';
import 'package:fare_now_provider/models/services_list/user_service_model.dart';
import 'package:fare_now_provider/util/app_dialog_utils.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

class ServicesListController extends GetxController {
  ServiceReposiotry _reposiotry = ServiceReposiotry();

  var servicesList = [].obs;

  ServicesListController() {
    getServiceList();
  }

  getServiceList({loading = false}) {
    if (servicesList.isEmpty) {
      if (loading) {
        AppDialogUtils.dialogLoading();
      }
    }
    _reposiotry.getServicesList().then((value) async {
      try {
        if (value is UserServiceModel) {
          print("sdf");
          servicesList(value.userServiceData);
          servicesList.refresh();

          if (loading) {
            AppDialogUtils.dismiss();
          }
        }
      } catch (exception) {
        Logger().e(exception);
      }
    });
  }

  updateService({required serviceUpDate, required body}) {
    _reposiotry.updateUserService(body).then((value) {
      if (value is ServiceUpdateModel) {
        if (!value.error!) {
          serviceUpDate(value);
        }
      } else if (!value) {
        serviceUpDate(null);
      }
      print("");
    });
  }
}
