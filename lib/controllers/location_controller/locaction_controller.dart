import 'package:get/get.dart';

class LocationController extends GetxController {
  RxBool isLocationLoading = false.obs;
  RxBool isLocationServiceEnabled = false.obs;

  void getIsLoading(bool isLoading) {
    isLocationLoading.value = isLoading;
  }

  void getIsLocationServiceEnabled(bool isLoading) {
    isLocationServiceEnabled.value = isLoading;
  }
}
