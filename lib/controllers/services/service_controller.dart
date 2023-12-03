import 'dart:convert';

import 'package:fare_now_provider/api_service/service_repository.dart';
import 'package:fare_now_provider/controllers/profile_screen_controller/ProfileScreenController.dart';
import 'package:fare_now_provider/models/location_detail/address_components.dart';
import 'package:fare_now_provider/models/main_service_response/main_service_response.dart';
import 'package:fare_now_provider/models/main_service_response/sub_service.dart';
import 'package:fare_now_provider/models/postal_code/Postal_code_response.dart';
import 'package:fare_now_provider/models/prediction/prediction_respnse.dart';
import 'package:fare_now_provider/models/response_errors.dart';
import 'package:fare_now_provider/models/selected_zips_list.dart';
// import 'package:fare_now_provider/models/services_model/main/main_servvice_response.dart';
// import 'package:fare_now_provider/models/services_model/main/sub_services.dart';
import 'package:fare_now_provider/models/signup_username/sign_up_username_respnse.dart';
import 'package:fare_now_provider/models/verify_otp/user.dart';
import 'package:fare_now_provider/screens/bottom_navigation.dart';
import 'package:fare_now_provider/screens/build_profile_steps.dart';
import 'package:fare_now_provider/util/api_utils.dart';
import 'package:fare_now_provider/util/app_dialog_utils.dart';
import 'package:fare_now_provider/util/shared_reference.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

import '../../models/main_service_response/datum.dart';
// import '../../models/services_model/main/main_servvice_response.dart';
// import '../../models/services_model/main/sub_services.dart';
import '../../screens/select_work.dart';

class ServiceController extends GetxController {
  final ServiceReposiotry _serviceRepository = ServiceReposiotry();
  SharedRefrence pref = SharedRefrence();
  final logger = Logger();
  // final ProfileScreenController _controller =
  //     Get.put(ProfileScreenController());
  var serviceIndex = 0.obs;
  var imageResponse;
  var userData = User().obs;
  var token = "".obs;
  var zipCode = "".obs;
  var serviceList = <MainServiceModel>[].obs;
  var subServiceList = <MainSubService>[].obs;
  var predictions = [].obs;
  var citiesResult = [].obs;
  var type = "".obs;
  var commaList = [].obs;
  var components = [].obs;
  RxBool isUpdated = false.obs;
  RxBool isPopUpCanceled = false.obs;

  var indexOuter = 0;
  var indexInner = 0;

  var address = "".obs;
  var selectedServiceType = "";
  var selectedSubServiceId = "";
  var selectedMainService = MainServiceModel().obs;
  var selectedMainSubService = const MainSubService().obs;
  @override
  void onInit() async {
    getToken().then((value) => null);
    // await Future.delayed(const Duration(seconds: 2));

    super.onInit();
  }

  @override
  void onReady() async {
    await getToken();
    await getServiceList();
  }

  getSelectedMainService(MainServiceModel mainServiceModel) {
    selectedMainService.value = mainServiceModel;
  }

  getSelectedMainSubService(MainSubService subService) {
    selectedMainSubService.value = subService;
  }

  getSubServices() {
    subServiceList.value = selectedMainService.value.subServices ?? [];
  }

  Future<void> getServiceList({flag}) async {
    String findCountryId =
        await SharedRefrence().getCountryId(key: "countryId");

    // bool show = flag ?? false;
    if (serviceList.isEmpty) {
      await AppDialogUtils.dialogLoading();
    }
    logger.d("Showing loader");
    try {
      // Map _body = <String, String>{
      //   "first_name": userData.value.firstName,
      //   "last_name": userData.value.lastName,
      //   "spend_each_month": userData.value.spendEachMonth
      // };
      MainServiceResponse response = await _serviceRepository.getMainServices(
          token,
          <String, String>{
            "first_name": userData.value.firstName ?? "",
            "last_name": userData.value.lastName ?? "",
            "spend_each_month": userData.value.spendEachMonth ?? ""
          },
          findCountryId);

      AppDialogUtils.dismiss();
      serviceList.value = response.data ?? [];
    } catch (exception) {
      Logger().e(exception);
      AppDialogUtils.dismiss();
      logger.e(exception);
    }
  }

  Future<void> getToken() async {
    String? authToken =
        await SharedRefrence().getString(key: ApiUtills.authToken);
    if (authToken?.isNotEmpty == true) {
      String? userStr =
          await SharedRefrence().getString(key: ApiUtills.userData);
      if (userStr?.isNotEmpty == true) {
        User user = User.fromJson(json.decode(userStr ?? ""));
        userData(user);
      }
      token(authToken);
    }
  }

  void updateList(int index, int indexObj, MainSubService service) {
    serviceList[indexObj].subServices?[index] = service;
    update();
  }

  // void signUpService({list}) async {
  //   AppDialogUtils.dialogLoading();
  //   // Navigator.pushNamed(context, BuildProfileStepsScreen.id);
  //   try {
  //     List<Map<String, dynamic>> zipCodes = [];
  //     for (int index = 0; index < list.length; index++) {
  //       SelectedZipList value = list[index];
  //       Map<String, dynamic> body = {
  //         "zipCode": value.zipCode,
  //         "city": value.city,
  //         "country": value.country,
  //         "state": value.state,
  //         "place_id": value.placeid
  //       };
  //       zipCodes.add(body);
  //     }
  //
  //     var map = <String, dynamic>{};
  //
  //     Map _body = <String, dynamic>{
  //         "services" : [
  //           {
  //             "serviceId": 1,
  //             "subServiceIds": [1,2,3]
  //           }
  //         ],
  //         "zip_code" : [
  //           {
  //             "zipCode": 1773,
  //             "city": "lahore",
  //             "state": "punjab",
  //             "country": "pakistan",
  //             "place_id": "aaaaaaaa"
  //           },
  //           {
  //             "zipCode": 1775,
  //             "city": "multan",
  //             "state": "punjab",
  //             "country": "pakistan",
  //             "place_id": "sjdksdhfksjd"
  //           },
  //           {
  //             "zipCode": 1776,
  //             "city": "faisalabad",
  //             "state": "punjab",
  //             "country": "pakistan",
  //             "place_id": "sjdksdhfksjdsdkljflsdk"
  //           }
  //         ]
  //       };
  //     // var id = serviceList.value[indexOuter].id;
  //     // _body["service_id"] = id;
  //     // print("");
  //     var response = await _serviceReposiotry.signUpservice(token, _body);
  //     if (!response.error) {
  //       // Get.toNamed(BottomNavigation.id);
  //       Get.offNamedUntil(
  //           BottomNavigation.id, ModalRoute.withName('/bottom_navigation'));
  //       // Get.back();
  //     }
  //
  //     print("");
  //     AppDialogUtils.dismiss();
  //     // serviceList(response.data);
  //   } catch (ex) {
  //     print("error : $ex");
  //     AppDialogUtils.dismiss();
  //   }
  // }

  // void signUpService({list}) async {
  //   AppDialogUtils.dialogLoading();
  //   // Navigator.pushNamed(context, BuildProfileStepsScreen.id);
  //   try {
  //     List<Map<String, dynamic>> zipCodes = [];
  //     for (int index = 0; index < list.length; index++) {
  //       SelectedZipList value = list[index];
  //
  //       print(list);
  //       Map<String, dynamic> body = {
  //         "zipCode": value.zipCode,
  //         "city": value.city,
  //         "country": value.country,
  //         "state": value.state,
  //         "place_id": value.placeid
  //       };
  //       zipCodes.add(body);
  //       print("body $body");
  //       print("zipCodes $zipCodes");
  //     }
  //
  //     // var map = <String, dynamic>{};
  //     print(await serviceList);
  //     // print(serviceList.value[0].subServices);
  //     print([zipCodes]);
  //     Map _body = <String, dynamic>{
  //       "services" : [
  //         {
  //           "serviceId": 1,
  //           "subServiceIds": [1,2,3]
  //         }
  //       ],
  //       "zip_code" : [
  //         {
  //           "zipCode": 1773,
  //           "city": "lahore",
  //           "state": "punjab",
  //           "country": "pakistan",
  //           "place_id": "aaaaaaaa"
  //         },
  //         {
  //           "zipCode": 1775,
  //           "city": "multan",
  //           "state": "punjab",
  //           "country": "pakistan",
  //           "place_id": "sjdksdhfksjd"
  //         },
  //         {
  //           "zipCode": 1776,
  //           "city": "faisalabad",
  //           "state": "punjab",
  //           "country": "pakistan",
  //           "place_id": "sjdksdhfksjdsdkljflsdk"
  //         }
  //       ]
  //     };
  //     //
  //     // var id = serviceList.value[indexOuter].id;
  //     // _body["service_id"] = id;
  //     // print("body:$_body");
  //     print("token $token");
  //     var response = await _serviceReposiotry.signUpservice(token, _body);
  //     if (!response.error) {
  //       // Get.toNamed(BottomNavigation.id);
  //       Get.offNamedUntil(
  //           BottomNavigation.id, ModalRoute.withName('/bottom_navigation'));
  //       // Get.back();
  //     }
  //
  //     print("");
  //     AppDialogUtils.dismiss();
  //     // serviceList(response.data);
  //   } catch (ex) {
  //     print("error: $ex");
  //     AppDialogUtils.dismiss();
  //   }
  // }
  Future<void> signUpService({List<SelectedZipList>? list}) async {
    AppDialogUtils.dialogLoading();
    // Navigator.pushNamed(context, BuildProfileStepsScreen.id);
    try {
      List<Map<String, dynamic>> zipCodes = [];
      for (int index = 0; index < (list?.length ?? 0); index++) {
        SelectedZipList value = list![index];
        Map<String, dynamic> body = {
          "zipCode": value.zipCode,
          "city": value.city,
          "country": value.country,
          "state": value.state,
          "place_id": value.placeid
        };
        print(body);
        zipCodes.add(body);
      }

      // var map = <String, dynamic>{};
      String firstName = await pref.getFirstName(key: "firstName");
      String lastName = await pref.getLastName(key: "lastName");
      String phoneNumber = await pref.getphoneNumber(key: "phoneNumber");
      String spendEachMonth =
          await pref.getSpendEachMonth(key: "spendEachMonth");
      Map<String, dynamic> _body = <String, dynamic>{
        /*   "sub_services": getSubServiceId(),
        "service_id": serviceList.value.first.id,*/
        "first_name": firstName,
        "last_name": lastName,
        "phone": phoneNumber,
        "spend_each_month": spendEachMonth,
        "zip_code": zipCodes,
      };

      if (serviceList.isNotEmpty) _body["service_id"] = serviceList.first.id;

      await _serviceRepository.signUpservice(token, _body);

      Get.offNamedUntil(
          BottomNavigation.id, ModalRoute.withName('/bottom_navigation'));
      /*  Get.to(() => SuccessScreen(
            imagePath: 'assets/Group 52.png',
            imageText: 'Account Created',
            detailText:
                'Your account was created successfully. Login to access your account.',
            buttonLabel: 'Login',
          ))*/

      // print(response);
      // if (!response.error) {
      // await _controller.getProfile();
      // Get.toNamed(LoginScreen.id);
      // Get.toNamed(SuccessfullyUploadedScreen.id);

      // Get.offNamedUntil(
      //     BottomNavigation.id, ModalRoute.withName('/bottom_navigation'));
      // Get.back();
      // }

      AppDialogUtils.dismiss();
      // serviceList(response.data);
    } catch (exception) {
      Logger().e(exception);
      AppDialogUtils.dismiss();
    }
  }

  getSubServiceId() {
    List<String> list = [];
    for (int index = 0; index < serviceList.value.length; index++) {
      var subCat = serviceList.value[index];
      for (int indexx = 0;
          indexx < (subCat.subServices?.length ?? 0);
          indexx++) {
        MainSubService services = subCat.subServices?[indexx] as MainSubService;
        if (services.isSelected == true) {
          indexOuter = index;
          indexInner = indexx;
          list.add(services.id.toString());
        }
      }
    }
    return list;
  }

  void businessSignup(Map<dynamic, dynamic> body, image, bool isMoving,
      vehicles, afterLogin, isIndivisual) async {
    AppDialogUtils.dialogLoading();
    afterLogin = afterLogin ?? false;
    ProfileScreenController _cont = Get.put(ProfileScreenController());
    // Navigator.pushNamed(context, BuildProfileStepsScreen.id);
    try {
      var imageResponse;
      String? tok = await SharedRefrence().getString(key: ApiUtills.authToken);
      if (image != null) {
        imageResponse = await _serviceRepository.uploadImage(tok, image);
      }
      if (imageResponse != null) {
        if (imageResponse.toString().isNotEmpty) {
          body["image"] = imageResponse;
        }
      }
      SignUpUsernameResponse response =
          await _serviceRepository.bProfileSignup(token, body);
      if (!response.error) {
        // Get.toNamed(BuildProfileStepsScreen.id);
        _cont.getProfile();
        if (afterLogin) {
          Get.offNamedUntil(
              BottomNavigation.id, ModalRoute.withName('/bottom_navigation'));
        } else if (isMoving) {
          var responses = await _serviceRepository.store(vehicles, tok);
          if (!responses.error) {
            // Get.toNamed(FindCustomersScreen.id);
            Get.toNamed(SelectWorkScreen.id);
            // Get.toNamed(Updated5.id);
            // Get.to(Step5.new);
            // Get.to(()=>Step5(isIndivisual:isIndivisual));
            // Get.offNamedUntil(
            //     BottomNavigation.id, ModalRoute.withName('/bottom_navigation'));
          }
        } else {
          // Get.toNamed(FindCustomersScreen.id);
          Get.toNamed(SelectWorkScreen.id);
          // Get.to(()=>Step5(isIndivisual:isIndivisual));
          // Get.toNamed(Updated5.id);
          // Get.offNamedUntil(
          //     BottomNavigation.id, ModalRoute.withName('/bottom_navigation'));
        }
      } else {
        print("");
        print(getMessage(response.profileErrors));
        AppDialogUtils.dismiss();
        AppDialogUtils.errorDialog(getMessage(response.profileErrors));
      }

      print("");
      AppDialogUtils.dismiss();
      // serviceList(response.data);
    } catch (exception) {
      Logger().e(exception);
      AppDialogUtils.dismiss();
    }
  }

  void individualProfile(Map<dynamic, dynamic> body, image) async {
    AppDialogUtils.dialogLoading();
    // Navigator.pushNamed(context, BuildProfileStepsScreen.id);
    try {
      String? tok = await SharedRefrence().getString(key: ApiUtills.authToken);
      if (image != null && imageResponse == null) {
        imageResponse = await _serviceRepository.uploadImage(tok, image);
      }
      if (imageResponse != null) {
        if (imageResponse.toString().isNotEmpty) {
          body["image"] = imageResponse;
        }
      }
      SignUpUsernameResponse response =
          await _serviceRepository.bProfileSignup(token, body);
      if (!response.error) {
        if (imageResponse != null) {
          userData.value.image = imageResponse;
          SharedRefrence().saveString(
              key: ApiUtills.userData,
              data: json.encode(userData.value.toJson()));
        }
        Get.toNamed(BuildProfileStepsScreen.id);
        Get.offNamedUntil(
            BottomNavigation.id, ModalRoute.withName('/bottom_navigation'));
        print("");
        AppDialogUtils.dismiss();
      } else {
        print("");
        AppDialogUtils.dismiss();
        AppDialogUtils.errorDialog(getMessage(response.profileErrors));
      }

      // serviceList(response.data);
    } catch (exception) {
      Logger().e(exception);
      AppDialogUtils.dismiss();
    }
  }

  void searchResult(String body) async {
    // Navigator.pushNamed(context, BuildProfileStepsScreen.id);
    try {
      PostalCodeResponse response =
          await _serviceRepository.searchPlaceByZip(body);
      print("");

      predictions(response.results);
      // if (!response.error) {
      //   // Get.toNamed(BuildProfileStepsScreen.id);
      // }
      predictions.refresh();
      print("");
      // serviceList(response.data);
    } catch (exception) {
      Logger().e(exception);
    }
  }

  searchCities(String value) async {
    try {
      PredictionResponse response =
          await _serviceRepository.searchCities(value);
      print("");
      citiesResult(response.predictions);
      citiesResult.refresh();
    } catch (exception) {
      Logger().e(exception);
    }
  }

  getPostalCode(data) {
    var list = data;
    // (data['result']['address_components'] as List<dynamic>)[7]['types'][0];
    for (int index = 0; index < list.length; index++) {
      AddressComponents components = list[index];
      String type = components.types[0];
      if (type.contains("postal_code_suffix") || type.contains("postal_code")) {
        zipCode(list[index].longName);
        return list[index].longName;
      }
    }
    return "n/a";
  }

  String getMessage(ResponseErrors profileErrors) {
    if (profileErrors.image != null) {
      return profileErrors.image;
    } else if (profileErrors.bio != null) {
      return profileErrors.bio;
    } else if (profileErrors.type != null) {
      return profileErrors.type;
    } else if (profileErrors.streetAddress != null) {
      return profileErrors.streetAddress;
    } else if (profileErrors.suiteNumber != null) {
      return profileErrors.suiteNumber;
    } else if (profileErrors.state != null) {
      return profileErrors.state;
    } else if (profileErrors.city != null) {
      return profileErrors.city;
    } else if (profileErrors.zipCode != null) {
      return profileErrors.zipCode;
    }

    return "";
  }

  void updateZipCodes(List<SelectedZipList> newList, {onSuccess}) async {
    AppDialogUtils.dialogLoading();
    // Navigator.pushNamed(context, BuildProfileStepsScreen.id);
    try {
      List zipCodes = [];
      for (int index = 0; index < newList.length; index++) {
        // zipCodes.add(newList[index].zipCode!);
        Map<String, dynamic> body = {
          "zipCode": newList[index].zipCode,
          "state": newList[index].state,
          "country": newList[index].country,
          "place_id": newList[index].placeid
        };
        zipCodes.add(body);
      }

      var map = <String, dynamic>{};

      Map _body = <String, dynamic>{
        "data": zipCodes,
      };
      var response = await _serviceRepository.upDateZipCodes(token, _body);
      print("");
      AppDialogUtils.dismiss();
      if (response) {
        AppDialogUtils.successDialog("Location updated successfully");
        if (onSuccess != null) {
          onSuccess();
        }
      }

      // serviceList(response.data);
    } catch (exception) {
      Logger().e(exception);
      AppDialogUtils.dismiss();
    }
  }
}
