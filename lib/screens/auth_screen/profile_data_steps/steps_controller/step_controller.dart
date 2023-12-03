/*
import 'package:fare_now_provider/controllers/profile_screen_controller/ProfileScreenController.dart';
import 'package:fare_now_provider/controllers/services_list_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../util/shared_reference.dart';

class StepsController extends GetxController {
  final firstNameCtlr = TextEditingController();
  final lastNameCtlr = TextEditingController();
  List<int> elctricityIndex = [];
  List<String> elctricity = [];

  List<int> handymanIndex = [];
  List<String> handyman = [];

  List<int> homeCleaningIndex = [];
  List<String> homeCleaning = [];

  List<int> movingIndex = [];
  List<String> moving = [];

  List selectedSubServices=[];

  int stepFiveButtonIndex = 0;
  setStepFiveButtonIndex(int index) {
    stepFiveButtonIndex = index;
    update();
  }

  late ProfileScreenController profileController;
  late ServicesListController servicesListController;
  String?  findCurrencyCode;
  @override
  void onInit()async {
    profileController = Get.find();
    servicesListController = Get.put(ServicesListController());
    profileController.fetchDataForCurrency(await SharedRefrence().getIsocode(key: "IsoCode" )).then((value) {
    findCurrencyCode = value;
    print("Dataahddshfdsfjsdhf;sdj============${ findCurrencyCode}");
    });
    super.onInit();

  }

  int stepCounter = 1;
  nextstepCounter() {
    stepCounter++;
    update();
  }

  previousstepCounter() {
    stepCounter--;
    update();
  }

  final List<String> stepTwolist = <String>[
    "${findCurrencyCode}1 - \$100",
    "\$100 - \$500",
    "\$500 - \$1000",
    "\$100 and above"
  ];
  final List<String> stepThreelist = <String>[
    "Individual",
    "Business", //todo changed from company to Business
  ];
  final List<String> stepFourlist = <String>[
    "Quotation based",
    "Hourly based",
  ];

  final servicesList = <List<String>>[
    <String>[
      "Electrician",
      "Refrigerator Repair",
      "TV Wall Mount",
      "Smart Home Services",
      "Indoor Lighting",
      "Outdoor Lighting",
    ],
    <String>[
      "Plumbing",
      "Lawn Care Service",
      "HVAC Repair Company",
      "Ceiling Fan Installation",
      "Home Furniture & Assembly",
    ],
    <String>[
      "Home Cleaning",
      "Commercial Cleaning",
    ],
    <String>[
      "Residential Moving",
      "House Moving",
      "Office Moving",
      "Furniture Rearrangement",
      "Junk Removal",
      "Packing",
    ],
  ];

  //todo
}
*/
import 'package:fare_now_provider/controllers/profile_screen_controller/ProfileScreenController.dart';
import 'package:fare_now_provider/controllers/services_list_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../util/shared_reference.dart';

class StepsController extends GetxController {
  final firstNameCtlr = TextEditingController();
  final lastNameCtlr = TextEditingController();
  final TextEditingController phoneCtlr = TextEditingController();

  var numberPlaceHolder = "xxx xxx xxxx";
  List<int> elctricityIndex = [];
  List<String> elctricity = [];

  List<int> handymanIndex = [];
  List<String> handyman = [];

  List<int> homeCleaningIndex = [];
  List<String> homeCleaning = [];

  List<int> movingIndex = [];
  List<String> moving = [];

  List selectedSubServices = [];

  int stepFiveButtonIndex = 0;
  setStepFiveButtonIndex(int index) {
    stepFiveButtonIndex = index;
    update();
  }

  late ProfileScreenController profileController;
  late ServicesListController servicesListController;
  String? findCurrencyCode;

  @override
  void onInit() async {
    profileController = Get.find();
    servicesListController = Get.put(ServicesListController());
    findCurrencyCode = await profileController.fetchDataForCurrency(
        await SharedRefrence().getIsocode(key: "IsoCode"));
    /*stepTwolist = [
      "${findCurrencyCode}10 - ${findCurrencyCode}100",
      "${findCurrencyCode}100 - ${findCurrencyCode}500",
      "${findCurrencyCode}500 - ${findCurrencyCode}1000",
      "${findCurrencyCode}1000 and above"
    ];*/
    stepTwolist = [
      "${findCurrencyCode}2,000 - ${findCurrencyCode}10,999",
      "${findCurrencyCode}11,000 - ${findCurrencyCode}20,999",
      "${findCurrencyCode}21,000 - ${findCurrencyCode}30,999",
      "${findCurrencyCode}40,000 and above"
    ];
    print(stepTwolist);
    super.onInit();
  }

  String? validateNumber() {
    String? phoneNumber = phoneCtlr.text.trim();
    if (phoneNumber.isEmpty) {
      return 'Please Enter Valid Phone Number';
    } else if (phoneNumber.length < 9 || phoneNumber.length > 10) {
      return 'Please Enter Valid Phone Number';
    } else {
      return "";
    }
  }

  int stepCounter = 1;
  nextstepCounter() {
    stepCounter++;
    update();
  }

  previousstepCounter() {
    stepCounter--;
    update();
  }

  List<String> stepTwolist = [];

  final List<String> stepThreelist = <String>[
    "Individual",
    "Business",
  ];
  final List<String> stepFourlist = <String>[
    /*  "Quotation based",*/
    "Hourly based",
  ];

  final List<String> stepFourQutationlist = <String>[
    "Quotation based",
  ];

  final servicesList = <List<String>>[
    <String>[
      "Electrician",
      "Refrigerator Repair",
      "TV Wall Mount",
      "Smart Home Services",
      "Indoor Lighting",
      "Outdoor Lighting",
    ],
    <String>[
      "Plumbing",
      "Lawn Care Service",
      "HVAC Repair Company",
      "Ceiling Fan Installation",
      "Home Furniture & Assembly",
    ],
    <String>[
      "Home Cleaning",
      "Commercial Cleaning",
    ],
    <String>[
      "Residential Moving",
      "House Moving",
      "Office Moving",
      "Furniture Rearrangement",
      "Junk Removal",
      "Packing",
    ],
  ];

//todo
}
