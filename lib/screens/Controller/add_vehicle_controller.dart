import 'package:fare_now_provider/api_service/service_repository.dart';
import 'package:fare_now_provider/controllers/profile_screen_controller/ProfileScreenController.dart';
import 'package:fare_now_provider/models/vehicle_add/vehicle_add_response.dart';
import 'package:fare_now_provider/models/vehicle_type/vehicle_type_data.dart';
import 'package:fare_now_provider/models/vehicle_type/vehicle_type_response.dart';
import 'package:fare_now_provider/models/verify_otp/vehicle_type.dart';
import 'package:fare_now_provider/models/verify_otp/vehicles.dart';
import 'package:fare_now_provider/screens/add_vehicle_screen.dart';
import 'package:fare_now_provider/screens/auth_screen/zipcode/select_zipcode.dart';
import 'package:fare_now_provider/util/api_utils.dart';
import 'package:fare_now_provider/util/app_dialog_utils.dart';
import 'package:fare_now_provider/util/shared_reference.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

class AddVehicleController extends GetxController {
  var selectedVehicle = [].obs;
  var _list = [].obs;
  var typeResponse = [].obs;

  var selectedType = VehicleTypeData().obs;

  ServiceReposiotry _reposiotry = ServiceReposiotry();

  void getTypes({move}) async {
    bool moveTo = move ?? false;
    try {
      AppDialogUtils.dialogLoading();
      VehicleTypeResponse response = await _reposiotry.getTypes();

      if (!response.error!) {
        typeResponse(response.vehicleTypeData);
        if (!moveTo) {
          Get.to(() => AddVehicleScreen());
        }
      }
      AppDialogUtils.dismiss();
    } catch (exception) {
      Logger().e(exception);
      AppDialogUtils.dismiss();
    }
  }

  void store(List<Map<String, dynamic>> body, VehicleType type) async {
    AppDialogUtils.dialogLoading();
    try {
      String? authToken =
          await SharedRefrence().getString(key: ApiUtills.authToken);
      VehicleAddResponse response = await _reposiotry.store(body, authToken);
      if (!response.error) {
        ProfileScreenController controller = Get.find();
        if (type != null) {
          Vehicles obj = response.data[0];
          obj.vehicleType = type;
          // controller.userData.value.vehicles.add(obj);
          controller.userData(controller.userData.value);
          controller.userData.refresh();
          Get.back();
        } else {
          // controller.userData.value.vehicles.addAll(response.data);
          controller.userData(controller.userData.value);
          controller.userData.refresh();
          Get.back();
        }
      }
      print("");
      AppDialogUtils.dismiss();
    } catch (exception) {
      Logger().e(exception);
      AppDialogUtils.dismiss();
      // AppDialogUtils.dismiss();
    }
  }

  void deleteVehicle(id, {onDlete}) async {
    AppDialogUtils.dialogLoading();
    try {
      String? authToken =
          await SharedRefrence().getString(key: ApiUtills.authToken);
      var response = await _reposiotry.deleteVehicle(id, authToken);
      if (!response['error']) {
        onDlete();
      }
      AppDialogUtils.dismiss();
    } catch (exception) {
      Logger().e(exception);
      AppDialogUtils.dismiss();
    }
  }

  void updateVehicle(id, var body) async {
    AppDialogUtils.dialogLoading();
    try {
      String? authToken =
          await SharedRefrence().getString(key: ApiUtills.authToken);
      VehicleAddResponse response =
          await _reposiotry.updateVehicle(id, body, authToken);
      if (!response.error) {
        ProfileScreenController controller = Get.find();
        // for (int index = 0;
        //     index < controller.userData.value.vehicles.length;
        //     index++) {
        //   Vehicles value = controller.userData.value.vehicles[index];
        //   if (value.id == id) {
        //     controller.userData.value.vehicles[index] = response.data[0];
        //     break;
        //   }
        // }
        controller.userData(controller.userData.value);
        controller.userData.refresh();
        Get.back();
      }
      print("");
      AppDialogUtils.dismiss();
    } catch (exception) {
      Logger().e(exception);
      AppDialogUtils.dismiss();
      // AppDialogUtils.dismiss();
    }
  }

  void addVehicles(List<dynamic> vehicleBody) {
    AppDialogUtils.dialogLoading();
    try {
      _reposiotry.store(vehicleBody, "").then((value) {
        print("sf");
        if (value.data != null && value.message == "OK") {
          // Get.offNamedUntil(
          //     BottomNavigation.id, ModalRoute.withName('/bottom_navigation'));
          Get.toNamed(SelectZipcodeScreen.id);
        }
        AppDialogUtils.dismiss();
      }, onError: (ex) {
        AppDialogUtils.dismiss();
      });
    } on Exception catch (exception) {
      Logger().e(exception);
      AppDialogUtils.dismiss();
    }
  }
}
