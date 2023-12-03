import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../models/selected_zips_list.dart';

class ZipcodeController extends GetxController {
  List<String> items = [];
  List<SelectedZipList> newList = [];
  List<SelectedZipList> _list = [];
  var searchController = TextEditingController();
}
