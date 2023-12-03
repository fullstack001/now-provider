import 'dart:convert';
import 'dart:io';

import 'package:fare_now_provider/api_service/service_repository.dart';
import 'package:fare_now_provider/models/calender_events/timing_data.dart';
import 'package:fare_now_provider/models/calender_events/timing_dates_response.dart';
import 'package:fare_now_provider/models/documents/documet_data.dart';
import 'package:fare_now_provider/models/documents/documet_response.dart';
import 'package:fare_now_provider/models/provider_zipcodes/provider_zipcode_response.dart';
import 'package:fare_now_provider/models/signup_username/sign_up_username_respnse.dart';
import 'package:fare_now_provider/models/user_profile_numer_verify/user_signup_model.dart';
import 'package:fare_now_provider/models/verify_otp/login_error.dart';
import 'package:fare_now_provider/models/verify_otp/provider_profile_detail.dart';
import 'package:fare_now_provider/models/verify_otp/verify_otp_ressponse.dart';
import 'package:fare_now_provider/screens/Servicearea.dart';
import 'package:fare_now_provider/screens/auth_screen/pin_verification_screen.dart';
import 'package:fare_now_provider/screens/auth_screen/profile_data_steps/business_profile_settings_screen.dart';
import 'package:fare_now_provider/screens/auth_screen/profile_data_steps/profile_settings_screen.dart';
import 'package:fare_now_provider/screens/auth_screen/profile_data_steps/step_1.dart';
import 'package:fare_now_provider/screens/bottom_navigation.dart';
import 'package:fare_now_provider/screens/change_password_screen.dart';
import 'package:fare_now_provider/screens/liscense_doc_screen.dart';
import 'package:fare_now_provider/screens/service_timings/new_servie_timing/serive_timing_screen.dart';
import 'package:fare_now_provider/util/api_utils.dart';
import 'package:fare_now_provider/util/app_dialog_utils.dart';
import 'package:fare_now_provider/util/shared_reference.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

import '../../screens/auth_screen/profile_data_steps/step_3.dart';
import '../../screens/signup_or_login_screen.dart';
import '../../socialsInfomodel.dart' as sInfo;

class ProfileScreenController extends GetxController {
  ServiceReposiotry _serviceReposiotry = ServiceReposiotry();

  ProfileScreenController({flag}) {
    bool check = flag ?? false;
    if (check) {
      Future.delayed(Duration(milliseconds: 100)).then((value) async {
        await getToken();
      });
    }
  }

  var number = "".obs;
  var email = "".obs;

  // var userData = User().obs;
  var userData = Provider().obs;
  var socialData = sInfo.SocialsInfoModel().obs;
  var socialDatas = sInfo.User().obs;

  var token = "".obs;
  var firstName = "".obs;
  var lastName = "".obs;
  var providerTiming = TimingData().obs;
  int verifyOtp = 0;
  var zipCodes = [].obs;
  var documents = [].obs;
  var otp = "".obs;
  var isMover = false.obs;
  var setSlots = false.obs;
  var zipcodeAvalaible = false.obs;
  dynamic getALlData;
  dynamic myCountryValue;
  List<String> iso2List = [];
  List<String> countryNameList = [];
  List<String> countryCurrency = [];
  List<String> countryId = [];
  String? findIso2code;
  String? findCurrencyCode;
  String? findCountryId;
  @override
  void onInit() {
    SharedRefrence().getIsocode(key: "IsoCode").then((userCountryIso2Code) {
      fetchDataForCountryId(userCountryIso2Code ?? "").then((value) {
        findCountryId = value ?? "";
      });
    });

    setSlots.value = false;
    super.onInit();
  }

  Future<String?> fetchData(String? c) async {
    var headers = {
      'Accept': 'application/json',
      'verif-hash': '12345678',
    };

    var request =
        http.Request('GET', Uri.parse(baseUrl + ApiUtills.countryList));
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String jsonDataString = await response.stream.bytesToString();
      dynamic jsonData = jsonDecode(jsonDataString);
      getALlData = jsonData;
      //this is for iso2code from country api
      iso2List = jsonData
          .map((country) => country['iso2'].toString())
          .toList()
          .cast<String>();
      //this is for countryNameList from country api
      countryNameList = jsonData
          .map((country) => country['name'].toString())
          .toList()
          .cast<String>();
      //this is for countryCurrencyList from country api
      countryCurrency = jsonData
          .map((country) => country['currency_symbol'].toString())
          .toList()
          .cast<String>();
      //this map for country and iso2
      Map<String, String> countryMap = {};
      for (int i = 0; i < countryNameList.length; i++) {
        countryMap[countryNameList[i]] = iso2List[i];
      }
      //this map for iso2 and currency
      Map<String, String> currencyMap = {};
      for (int i = 0; i < iso2List.length; i++) {
        currencyMap[iso2List[i]] = countryCurrency[i];
      }
      List<String> currencykeys = currencyMap.keys.toList();
      String currencyValues = jsonEncode(currencykeys);

      List<String> values = countryMap.values.toList();
      String newValues = jsonEncode(values);
      if (newValues.contains(c!)) {
        findIso2code = c;
      } else {
        var defaultCountry =
            jsonData.firstWhere((country) => country['is_default'] == true);
        findIso2code = defaultCountry["iso2"].toString();
        // findIso2code = "NG";
      }
      if (currencyValues.contains(c)) {
        findCurrencyCode = currencyMap[c]!;
      } else {
        var defaultCountry =
            jsonData.firstWhere((country) => country['is_default'] == true);
        findCurrencyCode = defaultCountry["currency_symbol"].toString();
        //findCurrencyCode = "₦";
        //print("value not contain====> $findCurrencyCode");
      }

      return findIso2code;
    } else {
      print(response.reasonPhrase);
      return "";
    }
  }

  Future<String?> fetchDataForCurrency(String? c) async {
    var headers = {
      'Accept': 'application/json',
      'verif-hash': '12345678',
    };

    var request =
        http.Request('GET', Uri.parse(baseUrl + ApiUtills.countryList));
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String jsonDataString = await response.stream.bytesToString();
      dynamic jsonData = jsonDecode(jsonDataString);
      getALlData = jsonData;
      //this is for iso2code from country api
      iso2List = jsonData
          .map((country) => country['iso2'].toString())
          .toList()
          .cast<String>();
      //this is for countryNameList from country api
      countryNameList = jsonData
          .map((country) => country['name'].toString())
          .toList()
          .cast<String>();
      //this is for countryCurrencyList from country api
      countryCurrency = jsonData
          .map((country) => country['currency_symbol'].toString())
          .toList()
          .cast<String>();
      //this map for country and iso2
      Map<String, String> countryMap = {};
      for (int i = 0; i < countryNameList.length; i++) {
        countryMap[countryNameList[i]] = iso2List[i];
      }
      //this map for iso2 and currency
      Map<String, String> currencyMap = {};
      for (int i = 0; i < iso2List.length; i++) {
        currencyMap[iso2List[i]] = countryCurrency[i];
      }
      List<String> currencykeys = currencyMap.keys.toList();
      String currencyValues = jsonEncode(currencykeys);

      List<String> values = countryMap.values.toList();
      String newValues = jsonEncode(values);
      if (newValues.contains(c!)) {
        findIso2code = c;
      } else {
        var defaultCountry =
            jsonData.firstWhere((country) => country['is_default'] == true);
        findIso2code = defaultCountry["iso2"].toString();
        // findIso2code = "NG";
      }
      if (currencyValues.contains(c)) {
        findCurrencyCode = currencyMap[c]!;
      } else {
        var defaultCountry =
            jsonData.firstWhere((country) => country['is_default'] == true);
        findCurrencyCode = defaultCountry["currency_symbol"].toString();
        //findCurrencyCode = "₦";
      }

      return findCurrencyCode;
    } else {
      print(response.reasonPhrase);
      return "";
    }
  }

  Future<String?> fetchDataForCountryId(String? c) async {
    var headers = {
      'Accept': 'application/json',
      'verif-hash': '12345678',
    };

    var request =
        http.Request('GET', Uri.parse(baseUrl + ApiUtills.countryList));
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String jsonDataString = await response.stream.bytesToString();
      dynamic jsonData = jsonDecode(jsonDataString);
      getALlData = jsonData;
      //this is for iso2code from country api
      iso2List = jsonData
          .map((country) => country['iso2'].toString())
          .toList()
          .cast<String>();
      //this is for countryNameList from country api
      countryNameList = jsonData
          .map((country) => country['name'].toString())
          .toList()
          .cast<String>();
      //this is for countryCurrencyList from country api
      countryId = jsonData
          .map((country) => country['id'].toString())
          .toList()
          .cast<String>();
      //this map for country and iso2
      Map<String, String> countryMap = {};
      for (int i = 0; i < countryNameList.length; i++) {
        countryMap[countryNameList[i]] = iso2List[i];
      }
      Map<String, String> countryIdMap = {};
      for (int i = 0; i < iso2List.length; i++) {
        countryIdMap[iso2List[i]] = countryId[i];
      }
      List<String> countryIdkeys = countryIdMap.keys.toList();
      String countryIdValues = jsonEncode(countryIdkeys);

      List<String> values = countryMap.values.toList();
      String newValues = jsonEncode(values);
      if (newValues.contains(c!)) {
        findIso2code = c;
      } else {
        var defaultCountry =
            jsonData.firstWhere((country) => country['is_default'] == true);
        findIso2code = defaultCountry["iso2"].toString();
        //findIso2code = "NG";
      }
      if (countryIdValues.contains(c)) {
        findCountryId = countryIdMap[c];
      } else {
        var defaultCountry =
            jsonData.firstWhere((country) => country['is_default'] == true);
        findCountryId = defaultCountry["id"].toString();
        //findCountryId = "161";
      }

      return findCountryId;
    } else {
      print(response.reasonPhrase);
      return "";
    }
  }

  Future<void> verifyUser(Map map) async {
    AppDialogUtils.dialogLoading();
    try {
      UserSignupModel response = await _serviceReposiotry.verifyUser(map);
      if (response.error!) {
        AppDialogUtils.errorDialog(getMessage(response.message));
      } else {
        email(map["email"]);
        String? mobile = map['email'];
        Get.toNamed(PinCodeVerificationScreen.id, arguments: mobile);
      }
      // String? mobile = map['phone'];
    } catch (exception) {
      Logger().e(exception);
      AppDialogUtils.errorDialog(getMessage(exception.toString()));
    } finally {
      AppDialogUtils.dismiss();
    }
  }
  /* void verifyUser(Map map, {flag}) async {

   */ /* if (!(flag ?? false)) {
      print("1111111111111111showCircular");
      AppDialogUtils.dialogLoading();
    }*/ /*
    AppDialogUtils.dialogLoading();
    try {
     // print("try1sttttttttttttt");
      UserSignupModel response = await _serviceReposiotry.verifyUser(map);
      print("");
      print(response);
      if (response.error!) {
       // print("errorrrr");
        AppDialogUtils.dismiss();
        AppDialogUtils.errorDialog(getMessage(response.message));
      } else {
       // print("workingggggggggggggggggggggggggggggggggg");
        // number(map["phone"]);
        email(map["email"]);
       */ /* AppDialogUtils.dismiss();*/ /*
        // Get.toNamed(BusinessCredentials.id);
        String? mobile = map['email'];
        AppDialogUtils.dismiss();
        Get.toNamed(PinCodeVerificationScreen.id, arguments: mobile);
      }
      String? mobile = map['phone'];
      // Get.toNamed(PinCodeVerificationScreen.id, arguments: mobile);
    } catch (ex) {
      String? mobile = map['phone'];
      // Get.toNamed(PinCodeVerificationScreen.id, arguments: mobile);
      AppDialogUtils.errorDialog(getMessage(ex.toString()));
      AppDialogUtils.dismiss();
      print("errorrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrr");
      print("exception $ex");
    }
  }*/

  void otpVerify({
    body,
    forgetPassword = false,
  }) async {
    SharedRefrence().saveString(key: ApiUtills.authToken, data: "");
    token("");
    AppDialogUtils.dialogLoading();
    try {
      ProviderProfileDetail response = await _serviceReposiotry.verifyOtp(body);

      if (response.error) {
        AppDialogUtils.dismiss();

        AppDialogUtils.errorDialog("Wrong OTP");
      } else {
        if (!forgetPassword) {
          AppDialogUtils.dismiss();
          // userData(response.data.provider);
          // String userStr = jsonEncode(response.data.provider.toJson());
          // SharedRefrence().saveString(key: ApiUtills.userData, data: userStr);
          // print(response.data.provider);
          token(response.data.auth_token);
          userData((response.data as Data).provider);
          await SharedRefrence()
              .saveString(key: ApiUtills.authToken, data: token.value);

          // await getToken();
          // Get.toNamed(BusinessCredentials.id);
          Get.to(Step1.new);
        } else {
          String? phoneOrEmail = await SharedRefrence().getString(key: "email");
          AppDialogUtils.dismiss();
          Get.to(() => ChangePasswordScreen(
                token: response.token,
                userNumber: phoneOrEmail,
              ));
        }
        // Get.toNamed(PinCodeVerificationScreen.id);
        // Navigator.pushNamed(
        //     context, BottomNavigation.id);
      }
    } catch (exception) {
      Logger().e(exception);
    }
  }

  dynamic getMessage(message) {
    if (message.password != null) {
      return message.password;
    } else if (message.email != null) {
      return message.email;
    } else if (message.phone != null) {
      return message.phone;
    }
    return "Server error";
  }

  void signUpName(Map<dynamic, dynamic> body) async {
    AppDialogUtils.dialogLoading();
    try {
      SignUpUsernameResponse response =
          await _serviceReposiotry.signUpUsrName(body, token);
      if (!response.error) {
        userData.value.firstName = body['first_name'];
        userData.value.lastName = body['last_name'];
        userData.value.email = email.value;

        String userStr = jsonEncode(userData.value.toJson());
        await SharedRefrence()
            .saveString(key: ApiUtills.userData, data: userStr);
        await getToken();

        AppDialogUtils.dismiss();
        Get.to(Step3.new);
      } else {
        AppDialogUtils.dismiss();
        Fluttertoast.showToast(
          msg: "Sign-up failed. Please try again.",
          toastLength: Toast.LENGTH_SHORT,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      }
    } catch (exception) {
      Logger().e(exception);
      AppDialogUtils.dismiss();
    }
  }

/*  void signUpName(Map<dynamic, dynamic> body) async {
    AppDialogUtils.dialogLoading();
    try {
      SignUpUsernameResponse response =
          await _serviceReposiotry.signUpUsrName(body, token);
      if (!response.error) {
        userData.value.firstName = body['first_name'];
        userData.value.lastName = body['last_name'];
        // userData.value.spendEachMonth = body['spend_each_month'];
        userData.value.email = email.value;
        String userStr = jsonEncode(userData.value.toJson());
       await SharedRefrence().saveString(key: ApiUtills.userData, data: userStr);
       */ /*String tokk= await getToken();*/ /*
        await getToken();
         Future.delayed(Duration(seconds: 2)).then((value) {
           AppDialogUtils.dismiss();
           Get.to(Step3.new);
           */ /*if(tokk.isNotEmpty ){
             Get.to(Step3.new);

           }else{
             Fluttertoast.showToast(
               msg: "Data not Found",
               toastLength: Toast.LENGTH_SHORT,
               timeInSecForIosWeb: 1,
               backgroundColor: Colors.black,
               textColor: Colors.white,
               fontSize: 16.0,
             );
           }*/ /*

           */ /* AppDialogUtils.dismiss();*/ /*
           // Get.toNamed(FindCustomersScreen.id);
           // Get.toNamed(BuildProfileStepsScreen.id);

           // Get.to(Step3.new);
         }
         );



      }
    } catch (ex) {

      Fluttertoast.showToast(
        msg: ex.toString(),
        */ /*msg: "Try Not found",*/ /*
        toastLength: Toast.LENGTH_SHORT,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      print(ex);
    }

  }*/
  Future getToken() async {
    try {
      String? authToken =
          await SharedRefrence().getString(key: ApiUtills.authToken);
      if (authToken?.isEmpty == true) {
        return;
      }

      String? userStr =
          await SharedRefrence().getString(key: ApiUtills.userData);
      if (userStr?.isEmpty == true) {
        return;
      }

      Provider user = Provider.fromJson(jsonDecode(userStr ?? ""));
      userData(user);
      token(authToken);
      print(token);
    } catch (exception) {
      Logger().e(exception);
    }
  }
/*  Future getToken() async {
    try{
      String authToken =
      await SharedRefrence().getString(key: ApiUtills.authToken);
      if (authToken.isNotEmpty) {
        String userStr =
        await SharedRefrence().getString(key: ApiUtills.userData);
        // User user = User.fromJson(json.decode(userStr));
        if (userStr.isNotEmpty) {
          Provider user = Provider.fromJson(jsonDecode(userStr));
          userData(user);
        }
        token(authToken);
      }
    }catch(e){
      Fluttertoast.showToast(
        msg: e.toString(),
        toastLength: Toast.LENGTH_SHORT,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    */ /*  AppDialogUtils.errorDialog(e.toString());*/ /*
    }

  }*/

  void login(Map<dynamic, dynamic> body) async {
    SharedRefrence().saveString(key: ApiUtills.authToken, data: "");
    token("");
    AppDialogUtils.dialogLoading();
    try {
      ProviderProfileDetail response = await _serviceReposiotry.login(body);
      if (response.error) {
        if (response.data != null) {
          AppDialogUtils.errorDialog(response.message.toString());
        } else {
          AppDialogUtils.dismiss();
          // Get.snackbar("Invalid Credentials",response.message["user_name"].toString());

          if (response.message.runtimeType == String) {
            AppDialogUtils.errorDialog(response.message.toString());
          } else {
            AppDialogUtils.errorDialog(
                response.message["user_name"].toString());
          }

          //   String error = response.message is String && response.message != null
          //       ? response.message
          //       : getLoginMessage(response.message);
        }
      } else {
        AppDialogUtils.dismiss();

        // if (response.data.provider.phoneVerification == 1) {
        userData(response.data.provider);
        String userStr = jsonEncode(response.data.provider.toJson());
        SharedRefrence().saveString(key: ApiUtills.userData, data: userStr);
        print(userData.value.status);
        token(response.data.auth_token.toString());
        SharedRefrence().saveString(
            key: "userId", data: response.data.provider.id.toString());
        SharedRefrence()
            .saveString(key: ApiUtills.authToken, data: token.value);
        if (response.data.provider.status == "ACTIVE") {
          await getProfile();
          await getToken();
        }

        Get.offNamedUntil(
            BottomNavigation.id, ModalRoute.withName('/bottom_navigation'));
        // } else
        if (response.data.provider.emailVerifiedAt == null) {
          String mobile = body['user_name'];
          number.value = mobile;
          var res = await _serviceReposiotry.resendOtp(mobile);
          if (res) {
            Get.toNamed(PinCodeVerificationScreen.id, arguments: mobile);
          }
        }

        print("ok");
      }
    } catch (exception) {
      Logger().e(exception);
    }
  }

  void resendOtp(mobile) async {
    AppDialogUtils.dialogLoading();
    try {
      var response = await _serviceReposiotry.resendOtp(mobile);
      if (response) {
        AppDialogUtils.dismiss();
        AppDialogUtils.successDialog("OTP resend successfully");
      } else {
        AppDialogUtils.dismiss();
        AppDialogUtils.errorDialog("Failed to resend OTP");
      }
    } catch (exception) {
      Logger().e(exception);
      AppDialogUtils.dismiss();
    }
  }

  void getServiceTimmings() async {
    AppDialogUtils.dialogLoading();
    try {
      String? authToken =
          await SharedRefrence().getString(key: ApiUtills.authToken);
      token(authToken);
      TimingDatesResponse response =
          await _serviceReposiotry.getServiceTimmings(authToken ?? "");
      if (!response.error!) {
        AppDialogUtils.dismiss();
        // AppDialogUtils.successDialog("OTP resend successfully");
        providerTiming(response.timingData);
        // BottomNavigation.changeProfileWidget(ServiceTimings());
        // Get.to(ServiceTimings());
        Get.to(ServiceTimingScreen.new);
      } else {
        AppDialogUtils.dismiss();
        // AppDialogUtils.errorDialog("Failed to resend OTP");
      }
    } catch (exception) {
      Logger().e(exception);
      AppDialogUtils.dismiss();
    }
  }

  void setTimes({body, controller}) async {
    AppDialogUtils.dialogLoading();
    try {
      String? authToken =
          await SharedRefrence().getString(key: ApiUtills.authToken);
      token(authToken);
      var response = await _serviceReposiotry.scheduleTimes(
          authToken: authToken, body: body);
      if (!response['error']) {
        AppDialogUtils.dismiss();
        controller.userData.value.timeSlots = true;
        controller.userData.refresh();
        AppDialogUtils.successDialog("Time slot updated successfully");
      } else {
        AppDialogUtils.dismiss();
        // AppDialogUtils.errorDialog("Failed to resend OTP");
      }
    } catch (exception) {
      Logger().e(exception);
      AppDialogUtils.dismiss();
    }
  }

  void logout() async {
    Get.offNamedUntil(SignupOrLoginScreen.id, (route) => false);
    Get.clearRouteTree();

    1.delay(() {
      SharedRefrence().clearPrefs(key: ApiUtills.authToken);
      SharedRefrence().clearPrefs(key: ApiUtills.userData);
      SharedRefrence().clearPrefs(key: ApiUtills.firstName);
      SharedRefrence().clearPrefs(key: ApiUtills.image);
      SharedRefrence().clearPrefs(key: ApiUtills.lastName);
      SharedRefrence().clearPrefs(key: "userId");
      number("");
      email("");

      // var userData = User().obs;
      userData(Provider());

      token.value = "";
      firstName.value = "";
      lastName.value = "";
      providerTiming.value = TimingData();
      verifyOtp = 0;
      zipCodes.value = [];
      documents.value = [];
      otp.value = "";
      isMover.value = false;
    });
  }

  getProfile() async {
    Logger().f("Caalling get profile");
    String? authToken =
        await SharedRefrence().getString(key: ApiUtills.authToken);
    // VerifyOtpResponse response =
    //     await _serviceReposiotry.getProviderProfile("", authToken);
    ProviderProfileDetail response =
        await _serviceReposiotry.getProviderProfile("", authToken ?? "");
    try {
      if (response.data.provider != null) {
        userData(response.data.provider);
        String userStr = jsonEncode(response.data.provider.toJson());

        SharedRefrence().saveString(
            key: "userId", data: response.data.provider.id.toString());
        SharedRefrence().saveString(key: ApiUtills.userData, data: userStr);
        SharedRefrence().saveString(
            key: ApiUtills.firstName, data: response.data.provider.firstName);
        SharedRefrence().saveString(
            key: ApiUtills.lastName, data: response.data.provider.lastName);
        SharedRefrence().saveString(
            key: ApiUtills.image, data: response.data.provider.image ?? "");
        // userData(response.userData.user);
        // String userStr = jsonEncode(response.userData.user.toJson());
        // SharedRefrence().saveString(
        //     key: "userId", data: response.userData.user.id.toString());
        // // SharedRefrence().saveString(key: ApiUtills.userData, data: userStr);
        // SharedRefrence().saveString(
        //     key: ApiUtills.firstName, data: response.userData.user.firstName);
        // SharedRefrence().saveString(
        //     key: ApiUtills.lastName, data: response.userData.user.lastName);
        // SharedRefrence().saveString(
        //     key: ApiUtills.image, data: response.userData.user.image ?? "");
        userData.refresh();
      }
    } catch (exception) {
      Logger().e(exception);
    }
  }

  Future<void> getProviderProfile({id, flag, upDate}) async {
    Logger().e("inside profile controller");
    bool hide = flag ?? false;
    if (!hide) {
      AppDialogUtils.dialogLoading();
    }
    try {
      String? authToken =
          await SharedRefrence().getString(key: ApiUtills.authToken);
      // VerifyOtpResponse response =
      //     await _serviceReposiotry.getProviderProfile("", authToken);
      ProviderProfileDetail response =
          await _serviceReposiotry.getProviderProfile("", authToken ?? "");
      if (response.error!) {
        AppDialogUtils.dismiss();

        // AppDialogUtils.errorDialog(response.message);
      } else {
        AppDialogUtils.dismiss();
        if (response.data.provider.id != null) {
          print("provider id ${response.data.provider.id}");
          if ((response.data.provider.serviceType ?? "")
              .toLowerCase()
              .contains("moving")) {
            isMover(true);
          } else {
            isMover(false);
          }
          // userData(response.userData.user);
          // String userStr = jsonEncode(response.userData.user.toJson());
          SharedRefrence().saveString(
              key: "userId", data: response.data.provider.id.toString());
          // SharedRefrence().saveString(key: ApiUtills.userData, data: userStr);
          SharedRefrence().saveString(
              key: ApiUtills.firstName, data: response.data.provider.firstName);
          SharedRefrence().saveString(
              key: ApiUtills.lastName, data: response.data.provider.lastName);
          SharedRefrence().saveString(
              key: ApiUtills.image, data: response.data.provider.image);
          if (upDate != null) {
            update();
          }

          await getToken();
          if (!hide) {
            if (response.data.provider.providerType.toLowerCase() ==
                "business") {
              Get.to(BusinessProfileSettingsScreen(
                fromApp: true,
                afterLogin: true,
              ));
            } else {
              Get.to(ProfileSettingsScreen(
                afterLogin: true,
                postLogin: true,
              ));
            }
          }
        }
        // if (response.userData.user.id != null) {
        //   if ((response.userData.user.serviceType ?? "")
        //       .toLowerCase()
        //       .contains("moving")) {
        //     isMover(true);
        //   } else {
        //     isMover(false);
        //   }
        //   // userData(response.userData.user);
        //   // String userStr = jsonEncode(response.userData.user.toJson());
        //   SharedRefrence().saveString(
        //       key: "userId", data: response.userData.user.id.toString());
        //   // SharedRefrence().saveString(key: ApiUtills.userData, data: userStr);
        //   SharedRefrence().saveString(
        //       key: ApiUtills.firstName, data: response.userData.user.firstName);
        //   SharedRefrence().saveString(
        //       key: ApiUtills.lastName, data: response.userData.user.lastName);
        //   SharedRefrence().saveString(
        //       key: ApiUtills.image, data: response.userData.user.image);
        //   if (upDate != null) {
        //     update();
        //   }

        //   await getToken();
        //   if (!hide) {
        //     if (response.userData.user.providerType.toLowerCase() ==
        //         "business") {
        //       Get.to(BusinessProfileSettingsScreen(
        //         fromApp: true,
        //         afterLogin: true,
        //       ));
        //     } else {
        //       Get.to(ProfileSettingsScreen(
        //         afterLogin: true,
        //         postLogin: true,
        //       ));
        //     }
        //   }
        // }
      }
    } catch (exception) {
      Logger().e(exception);
    }
  }

  getProviderZipCodes({icon = false}) async {
    if (!icon) {
      AppDialogUtils.dialogLoading();
    }
    try {
      String? authToken =
          await SharedRefrence().getString(key: ApiUtills.authToken);

      token(authToken);
      ProviderZipcodeResponse response =
          await _serviceReposiotry.getProviderZipCodes(authToken: authToken);
      if (!response.error) {
        zipCodes(response.providerZipcodeData);
        if (zipCodes.value.isEmpty) {
          zipcodeAvalaible(true);
        } else {
          zipcodeAvalaible(false);
        }

        if (!icon) {
          AppDialogUtils.dismiss();
          zipCodes(response.providerZipcodeData);
          print(zipCodes.length == 0);
          Get.to(ServicesArea());
        }
      } else {
        AppDialogUtils.dismiss();
        // AppDialogUtils.errorDialog("Failed to resend OTP");
      }
    } catch (exception) {
      Logger().e(exception);
      AppDialogUtils.dismiss();
    }
  }

  void deleteZipCode(id, {onSuccess}) async {
    AppDialogUtils.dialogLoading();
    await Future.delayed(Duration(seconds: 5));
    try {
      String? authToken =
          await SharedRefrence().getString(key: ApiUtills.authToken);
      token(authToken);
      bool response =
          await _serviceReposiotry.deleteZipCode(authToken: authToken, id: id);
      if (response) {
        AppDialogUtils.dismiss();
        await getProviderZipCodes(icon: true);
        onSuccess();
        // BottomNavigation.changeProfileWidget(ServicesArea());
      } else {
        AppDialogUtils.dismiss();
        // AppDialogUtils.errorDialog("Failed to resend OTP");
      }
    } catch (exception) {
      Logger().e(exception);
      AppDialogUtils.dismiss();
    }
  }

  void upLoadDocs(List<File> image, {onSuccess, controller}) async {
    AppDialogUtils.dialogLoading();
    try {
      List imagesList = [];
      for (int index = 0; index < image.length; index++) {
        var multiPart = await getMultiPart(image[index]);
        imagesList.add(multiPart);
      }
      Map body = <String, dynamic>{
        "docs[]": imagesList,
      };
      var formData = getFormData(body);

      String? authToken =
          await SharedRefrence().getString(key: ApiUtills.authToken);
      token(authToken);
      print(authToken);
      bool response = await _serviceReposiotry.uploadDocs(
          authToken: authToken, formData: formData);
      print("psc $response");
      if (response) {
        AppDialogUtils.dismiss();
        DocumetData documetData = DocumetData();
        controller.userData.value.status = "ACTIVE";
        // controller.userData.value.document.add(documetData); //todo commented this
        controller.userData.refresh();
        //   AppDialogUtils.successDialog("Docs uploaded successfully");
        onSuccess();
        // BottomNavigation.changeProfileWidget(ServicesArea());
      } else {
        AppDialogUtils.dismiss();
        AppDialogUtils.errorDialog("Your account is not active");
      }
    } on Exception catch (exception) {
      Logger().e(exception);
      AppDialogUtils.dismiss();
    }
  }

  String getLoginMessage(LoginError loginError) {
    if (loginError.userName != null) {
      return loginError.userName!;
    }

    return "Server Error";
  }

  void getDocumentList() async {
    //

    AppDialogUtils.dialogLoading();
    try {
      String? authToken =
          await SharedRefrence().getString(key: ApiUtills.authToken);
      token(authToken);
      DocumentResponse response =
          await _serviceReposiotry.getDocuments(authToken: authToken);
      if (!response.error) {
        AppDialogUtils.dismiss();

        documents(response.documetData?.documetListData);
        Get.to(LiscenseDocsScreen());

        // BottomNavigation.changeProfileWidget(ServicesArea());
      } else {
        AppDialogUtils.dismiss();
        Get.to(LiscenseDocsScreen());
        // AppDialogUtils.errorDialog("Failed to resend OTP");
      }
    } on Exception catch (exception) {
      Logger().e(exception);
    }
  }

  void getUsrName() async {
    String? first = await SharedRefrence().getString(key: ApiUtills.firstName);
    String? last = await SharedRefrence().getString(key: ApiUtills.lastName);

    firstName(first);
    lastName(last);
    update();
  }

  void forgetPassword(String number, {isPhone}) {
    AppDialogUtils.dialogLoading();
    Map<String, dynamic> body = {};
    // if (isPhone) {
    body = {
      "email": number,
    };
    // } else {
    //   body = {
    //     "email": number,
    //   };
    // }
    ServiceReposiotry().forgetPassword(body: body).then((value) {
      print("$value");
      if (value['message'] == 'Otp has been sent on your email.') {
        3.delay().then((value) {
          AppDialogUtils.dismiss();
          Get.to(() => PinCodeVerificationScreen(
                phoneNumber: number,
                forgetPassword: true,
              ));
        });
      } else if (value["error"] == true) {
        AppDialogUtils.dismiss();
        AppDialogUtils.errorDialog(value["message"]);
      } else {
        AppDialogUtils.dismiss();
      }
    });
  }

  void changePassword(
      String password, String confirmPassword, userNumber, token) {
    AppDialogUtils.dialogLoading();
    ServiceReposiotry()
        .changePassword(password, confirmPassword, userNumber, token)
        .then((value) {
      print("");
      if (value['message'] == "OK") {
        3.delay().then((value) {
          AppDialogUtils.dismiss();
          AppDialogUtils.successDialog("Password updated successfully");

          Get.offNamedUntil(SignupOrLoginScreen.id, (route) => false);
        });
      } else {
        AppDialogUtils.dismiss();
        print("failed");
        print(value["message"]);
        AppDialogUtils.errorDialog(value["message"]);
      }
    });
  }

  bool checkUser() {
    if (userData.value.providerType == "Individual") {
      return false;
    }
    return true;
  }

  void socialSignUp(
    Map<dynamic, dynamic> body,
  ) async {
    AppDialogUtils.dialogLoading();
    try {
      _serviceReposiotry.socialInfoLogin(body).then((response) async {
        // if (response is VerifyOtpResponse) {

        if (!response.error) {
          if (response.data!.provider.providerProfile == null ||
              response.data!.provider.zipCodes.isEmpty) {
            await saveData(response);

            Get.to(Step1());
          } else {
            await saveData(response);
            Get.offNamedUntil(
                BottomNavigation.id, ModalRoute.withName('/bottom_navigation'));
          }
        } else {
          AppDialogUtils.errorDialog(response.message);
        }
        // }
      });
    } on Exception catch (exception) {
      Logger().e(exception);
      AppDialogUtils.dismiss();
    }
  }

  void socialLogin(Map<dynamic, dynamic> body) async {
    AppDialogUtils.dialogLoading();
    try {
      _serviceReposiotry.socialLogin(body).then((response) async {
        if (response is VerifyOtpResponse) {
          userData(response.userData.user);
          String userStr = jsonEncode(response.userData.user.toJson());
          SharedRefrence().saveString(key: ApiUtills.userData, data: userStr);

          token(response.userData.authToken);
          SharedRefrence().saveString(
              key: "userId", data: response.userData.user.id.toString());
          SharedRefrence()
              .saveString(key: ApiUtills.authToken, data: token.value);
          await getToken();
          AppDialogUtils.dismiss();
          Get.offNamedUntil(
              BottomNavigation.id, ModalRoute.withName('/bottom_navigation'));
        }
      });
    } on Exception catch (exception) {
      Logger().e(exception);
      AppDialogUtils.dismiss();
    }
  }

  void socialInfoLogin(Map<dynamic, dynamic> body) {
    AppDialogUtils.dialogLoading();
    try {
      _serviceReposiotry.socialInfoLogin(body).then((response) async {
        // if (response is VerifyOtpResponse) {
        // socialData(response);
        String userStr = jsonEncode(response.data!.provider!.toJson());
        SharedRefrence().saveString(key: ApiUtills.userData, data: userStr);

        token(response.data!.auth_token);
        SharedRefrence().saveString(
            key: "userId", data: response.data!.provider!.id.toString());
        SharedRefrence()
            .saveString(key: ApiUtills.authToken, data: token.value);
        await getToken();
        AppDialogUtils.dismiss();

        if (!response.error) {
          if (response.data!.provider.providerProfile == null ||
              response.data!.provider.zipCodes.isEmpty) {
            Get.to(Step1());
          } else {
            Get.offNamedUntil(
                BottomNavigation.id, ModalRoute.withName('/bottom_navigation'));
          }
        }

        // }
      });
    } on Exception catch (exception) {
      Logger().e(exception);
      AppDialogUtils.dismiss();
    }
  }

  saveData(response) async {
    // socialDatas(response.data!.provider);
    String userStr = jsonEncode(response.data!.provider.toJson());
    SharedRefrence().saveString(key: ApiUtills.userData, data: userStr);
    // userData(response.data!.provider);
    // userData.refresh();
    token(response.data!.auth_token);
    SharedRefrence()
        .saveString(key: "userId", data: response.data!.provider.id.toString());
    SharedRefrence().saveString(key: ApiUtills.authToken, data: token.value);
    await getToken();
    await getProfile();
    AppDialogUtils.dismiss();
  }
}
