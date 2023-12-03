import 'package:fare_now_provider/components/buttons-management/part_of_file/part.dart';
import 'package:flutter/material.dart';

class MyServicesController extends GetxController{
  // var active=[true,false].obs;
  // handleSwitch(index){
  //   active[index].toggle();
  //   // active.containsValue(index)?active.remove(index):active.addIf();
  // }
  var isIndivisualChecked=false.obs;
  var isBusinessChecked=false.obs;
  onIndivisualChanged(val){
    isIndivisualChecked.value=val;
  }
  onBusinessChanged(val){
    isBusinessChecked.value=val;
  }

  Set active = {};

  void handleTap(index) {

      active.contains(index) ? active.remove(index) : active.add(index);
    update();
  }

}