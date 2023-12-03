import 'package:get/get.dart';

class ViewBusinessController extends GetxController {
  var _currentTab = 0.obs;
  int get currentTab => _currentTab.value;
  setCurrentTab(int a) {
    _currentTab.value = a;
  }
}