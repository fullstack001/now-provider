import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:fare_now_provider/models/active_orders_resp/active_orders_response.dart';
import 'package:fare_now_provider/models/available_services/available_service_response.dart';
import 'package:fare_now_provider/models/calender_events/timing_dates_response.dart';
import 'package:fare_now_provider/models/chat/user_chat_response.dart';
import 'package:fare_now_provider/models/credit/buy_credit_response.dart';
import 'package:fare_now_provider/models/credit/get_credit.dart';
import 'package:fare_now_provider/models/documents/documet_response.dart';
import 'package:fare_now_provider/models/order_status/order_status_response.dart';
import 'package:fare_now_provider/models/payment_model/payment_model_response.dart';
import 'package:fare_now_provider/models/postal_code/Postal_code_response.dart';
import 'package:fare_now_provider/models/prediction/prediction_respnse.dart';
import 'package:fare_now_provider/models/prortfolio/portfio_response.dart';
import 'package:fare_now_provider/models/provider_zipcodes/provider_zipcode_response.dart';
import 'package:fare_now_provider/models/service_update/service_update_model.dart';
import 'package:fare_now_provider/models/services_list/user_service_model.dart';
import 'package:fare_now_provider/models/signup_username/sign_up_username_respnse.dart';
import 'package:fare_now_provider/models/start_service/start_service_response.dart';
import 'package:fare_now_provider/models/transaction/transation_response.dart';
import 'package:fare_now_provider/models/user_profile_numer_verify/user_signup_model.dart';
import 'package:fare_now_provider/models/vehicle_add/vehicle_add_response.dart';
import 'package:fare_now_provider/models/vehicle_type/vehicle_type_response.dart';
import 'package:fare_now_provider/models/verify_otp/provider_profile_detail.dart';
import 'package:fare_now_provider/models/verify_otp/verify_otp_ressponse.dart';
import 'package:fare_now_provider/util/api_utils.dart';
import 'package:fare_now_provider/util/shared_reference.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

import '../models/main_service_response/main_service_response.dart';
import '../models/notifications/All_notifications_response.dart';
import '../models/wallet/subscribe_package_model.dart';
import '../models/wallet/subscription_plan_model.dart';
import '../paymentmethodsmodel.dart';
import '../pmmodel.dart';
import '../screens/fare_now_pakages/models/pacakge_plan_model.dart';
import '../screens/signup_or_login_screen.dart';
import '../subscriberslistmodel.dart';
import '../util/app_dialog_utils.dart';
import '../withdrawalmodel.dart';

class ServiceReposiotry extends GetConnect {
  static var client = GetHttpClient(baseUrl: baseUrl);

  String tok =
      "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiNWFiMmI4MzUyNjUzY2U0NjJkMzQ1OGUyMTk1NzQ3MmVkZmRlMWVkOTFlZTdlN2I4YjU1NTNiMmQ5NmQ3NzZiYjMxMzEwYmUxZGIzNjk5ZTUiLCJpYXQiOjE2NDE5Njk3ODgsIm5iZiI6MTY0MTk2OTc4OCwiZXhwIjoxNjczNTA1Nzg4LCJzdWIiOiIyMTkiLCJzY29wZXMiOltdfQ.jWoCjRjv9a24ianSZx1AaEvtP3Q1NUJ9IksdBhcQSGZPArtd2pQIachptGiUjwUe43z-nirhJEaHBDxQ7gmt8fF4BjRBw2Z-r4WOliwoSjIOr_mxh28RDOwfFLIHH8BWY_SLplHt3q_R2UUwOElPioiMqdjKPsxq4V3YQd0kgiQiCz8UEMNDOmqyqKvSUP3ppjurym9-VHXbDPAIuRScc1t_CX9TCivY2vd7ze0y0aJ3Hs9KJ7gCbB0K_DIqZlV5-zAe86K-3eZpGq-D8HRKSdqRp8TuOSbZJy-L0Le_NDoQzUsLVQk5ekPu1eIBQTEVhKNZ-baC2lvskjBDhPOD2kEvwi5-aBHxo27JsWEzBSvsGrfQ69cZ50mfsxXWurWIQ9ihsXxMW9TCLYP148jgBp6jbl3ioiBy8tMgB7yAioKxeEF9wCc0YkeyHe8v7gb7Z6zjL6VWIOCCQv4ouMPtMH42zXqP3Vw4qK0Ywxsfrtlz-VtxxlBRvS0j7MpRnevz_ZT3VBig8XFMx8m_zKjq1KUJqzu1t_zECZstPvLYB6LS0jz99upvLcZtGEEAe4G01jA2gn2VQaY3n6JW9pSt0JukOvODqSZi-qxo9ujhAh7Mcl99FbX6G5j4e2VrWHrI3BDxgNvJbilnJFXZMKf9nmIFAcJh0GOKYKw2chT7OJw";
  Map<String, String> requestHeaders = {
    'Content-type': 'application/json',
    'Accept': 'application/json',
  };

  Future<UserSignupModel> verifyUser(Map<dynamic, dynamic> _body,
      {count = 0}) async {
    String url = baseUrl + ApiUtills.verifyUser;
    print("OTP API:" + url);
    var response = await client
        .post(ApiUtills.verifyUser, body: _body)
        .timeout(const Duration(seconds: 10)); //todo added a timeout
    UserSignupModel parseData;
    if (response.body == null) {
      if (count < 2) {
        count = count + 1;
        return await verifyUser(_body, count: count);
      }
    }
    if (response.body['error']) {
      parseData = UserSignupModel.errorJson(response.body);
    } else {
      parseData = UserSignupModel.fromJson(response.body);
    }
    // Future.delayed(Duration(seconds: 3)).then((value) {
    //   if (response.body["opt"] != null) {
    //     Get.defaultDialog(
    //         title: "OTP",
    //         content: Text("Your otp ${response.body["opt"]}"),
    //         confirm: MaterialButton(
    //           onPressed: () {
    //             Get.back();
    //           },
    //           child: Text("Okay"),
    //         ));
    //   }
    // });
    print("Otp is : ${response.body}");
    return parseData;
  }

  Future<SignUpUsernameResponse> signUpUsrName(
      Map<dynamic, dynamic> _body, RxString token) async {
    String url = baseUrl + ApiUtills.signupName;
    print("OTP API:" + url);

    requestHeaders['Authorization'] = token.value;
    var response = await client.post(ApiUtills.signupName,
        body: _body, headers: requestHeaders);

    SignUpUsernameResponse parseData;

    parseData = SignUpUsernameResponse.fromJson(response.body);

    print("body ${response.body}");
    return parseData;
  }

  Future<ProviderProfileDetail> verifyOtp(Map<dynamic, dynamic> _body,
      {phone}) async {
    String filter;
    if (phone != null) {
      filter = ApiUtills.otpVerify;
    } else {
      filter = ApiUtills.otpVerifybyemail;
    }
    String url = baseUrl + filter;
    print(" API:" + url);
    var response = await client
        .post(filter, body: _body)
        .timeout(const Duration(seconds: 30)); //todo added a timeout

    ProviderProfileDetail parseData;
    if (response.body['error']) {
      parseData = ProviderProfileDetail.fromJson(response.body);
    } else {
      parseData = ProviderProfileDetail.fromJson(response.body);
    }
    print("body ${response.body}");
    return parseData;
  }

  Future<MainServiceResponse> getMainServices(
      RxString token, Map<dynamic, dynamic> body, String countryId) async {
    String filter = ApiUtills.mainService + "?country_id=$countryId";
    String url = baseUrl + filter;
    print(" API:" + url);

    requestHeaders['Authorization'] = token.value;

    // print(token);
    var response = await client.get(filter, headers: requestHeaders);

    MainServiceResponse parseData;
    if (response.body['error']) {
      parseData = MainServiceResponse.fromJson(response.body);
    } else {
      parseData = MainServiceResponse.fromJson(response.body);
    }
    print(response.body);
    return parseData;
  }

//todo
  Future<SubscribersListModel> getSubscribersList(String token) async {
    String filter = ApiUtills.subscribersList;
    String url = baseUrl + filter;
    print(" API:" + url);
    requestHeaders['Authorization'] = token;
    var response = await client.get(filter, headers: requestHeaders);

    SubscribersListModel parseData;

    parseData = SubscribersListModel.fromMap(response.body);

    print("body ${response.body}");
    return parseData;
  }

  //todo
  Future<PaymentMethodsModel> getPaymentMethods(String token) async {
    String filter = ApiUtills.paymentMethods;
    String url = baseUrl + filter;
    print(" API:" + url);
    requestHeaders['Authorization'] = token;
    var response = await client.get(filter, headers: requestHeaders);

    PaymentMethodsModel parseData;

    parseData = PaymentMethodsModel.fromJson(response.body);

    print("body ${response.body}");
    return parseData;
  }

  //todo
  Future<PmModel> addOrRemovePaymentMethods(
      String token, Map<dynamic, dynamic> _body) async {
    PmModel? parseData;
    try {
      String url = baseUrl + ApiUtills.paymentMethods;
      print("OTP API:" + url);

      requestHeaders['Authorization'] = token;
      // 'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiODgxMDFmMDU3ZDJiYzgzOWZiMTlmNzEyYmQwZDk1OWFkYTEyOWU1ZmM5MTBiOTdjYjU2NjFhNTJmMjJiNTQwYzViYzM2NGNhMWJiZjY1ODgiLCJpYXQiOjE2NzIwNzc5NDgsIm5iZiI6MTY3MjA3Nzk0OCwiZXhwIjoxNzAzNjEzOTQ4LCJzdWIiOiI3ODkiLCJzY29wZXMiOltdfQ.fpWQ-qx_bM2_9CUuPqkcu1WpMHGKrV5JlugEJOAyc-oATO1Xm0OSMiVqKgPYBu0ialrWuWnvduzkGtvYrJWSmntyl7-N7jfIbhL-CZ2mpMAXSZxsRyWr_4ABccW6D-T-h6gi90cthv3WqAauF8-_QL7D8W2LtvmOFRns035M-oTu60Mn68yHulXerUzGOmAPGZxzkotPnLKwNCyN0a1_jQu2xXPE6yWwuOA3bPfdgwRtTCPYbMHGnbOddmMfP-HiyCHqcqh4HCjli6dqLWD-MWNBnbCB2xLirr8erI3WYOFcZU7eQeltg5Ck9YJi0WUjKPBERQ7tsKOBXkQ1gCLzlRAr_e1_9K_A5O2CUiObZ2lZbZHpEuwh7Up22t0mFuwDTxgrDJkp52bPgJcnrn3f1xbR3B_dyjdi-r1BbsdMdynLMaGZ3CGQt1Iuhj4oyJH1m2wkiDlZgvj-jRKjLq7LOLYV_uLGEVOVmmwiM_vWqZUMACQ-MVN_ZFl6nLQl2Q3SH2AQWBq0ZwYqV8aR1--qBrD2a1o-WOS4FIS9_Aw746V6o4rG70xCFG390FxXr61mIZfcrPvg05k7xmklT-UKCOmkJQx5zCxq8G8zOpyF00XRkkQZGt_MA7E3smOsa1gKe8suNsxadTBzmAZu77PvN48OgflWVHXf81vXV7Kyo04';
      var response = await client.post(ApiUtills.paymentMethods,
          body: _body, headers: requestHeaders);

      parseData = PmModel.fromJson(response.body);
    } catch (exception) {
      Logger().e(exception);
      AppDialogUtils.dismiss();
      AppDialogUtils.errorDialog(exception.toString());
    }

    return parseData!;
  }

  //todo
  // Future test(index) async {
  //   var headers = {
  //     'Authorization':
  //         'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiODgxMDFmMDU3ZDJiYzgzOWZiMTlmNzEyYmQwZDk1OWFkYTEyOWU1ZmM5MTBiOTdjYjU2NjFhNTJmMjJiNTQwYzViYzM2NGNhMWJiZjY1ODgiLCJpYXQiOjE2NzIwNzc5NDgsIm5iZiI6MTY3MjA3Nzk0OCwiZXhwIjoxNzAzNjEzOTQ4LCJzdWIiOiI3ODkiLCJzY29wZXMiOltdfQ.fpWQ-qx_bM2_9CUuPqkcu1WpMHGKrV5JlugEJOAyc-oATO1Xm0OSMiVqKgPYBu0ialrWuWnvduzkGtvYrJWSmntyl7-N7jfIbhL-CZ2mpMAXSZxsRyWr_4ABccW6D-T-h6gi90cthv3WqAauF8-_QL7D8W2LtvmOFRns035M-oTu60Mn68yHulXerUzGOmAPGZxzkotPnLKwNCyN0a1_jQu2xXPE6yWwuOA3bPfdgwRtTCPYbMHGnbOddmMfP-HiyCHqcqh4HCjli6dqLWD-MWNBnbCB2xLirr8erI3WYOFcZU7eQeltg5Ck9YJi0WUjKPBERQ7tsKOBXkQ1gCLzlRAr_e1_9K_A5O2CUiObZ2lZbZHpEuwh7Up22t0mFuwDTxgrDJkp52bPgJcnrn3f1xbR3B_dyjdi-r1BbsdMdynLMaGZ3CGQt1Iuhj4oyJH1m2wkiDlZgvj-jRKjLq7LOLYV_uLGEVOVmmwiM_vWqZUMACQ-MVN_ZFl6nLQl2Q3SH2AQWBq0ZwYqV8aR1--qBrD2a1o-WOS4FIS9_Aw746V6o4rG70xCFG390FxXr61mIZfcrPvg05k7xmklT-UKCOmkJQx5zCxq8G8zOpyF00XRkkQZGt_MA7E3smOsa1gKe8suNsxadTBzmAZu77PvN48OgflWVHXf81vXV7Kyo04',
  //     'Content-Type': 'application/json'
  //   };
  //   var request = http.Request('POST',
  //       Uri.parse('https://api.farenow.com/api/provider/payment-method'));
  //   request.body = json.encode({"payment_method_id": index});
  //   request.headers.addAll(headers);

  //   http.StreamedResponse response = await request.send();

  //   if (response.statusCode == 200) {
  //     // print(await response.stream.bytesToString());
  //     AppDialogUtils.successDialog(await response.stream.bytesToString());
  //   } else {
  //     AppDialogUtils.errorDialog(response.reasonPhrase.toString());
  //     // print(response.reasonPhrase);
  //   }
  // }

  //todo
  Future<WithdrawalModel> withdrawAmount(
      String token, Map<dynamic, dynamic> _body) async {
    String url = baseUrl + ApiUtills.withdrawal;
    print("OTP API:" + url);

    requestHeaders['Authorization'] = token;
    var response = await client.post(ApiUtills.withdrawal,
        body: _body, headers: requestHeaders);

    WithdrawalModel parseData;

    parseData = WithdrawalModel.fromMap(response.body);

    print("body ${response.body}");
    return parseData;
  }

  // Future<SignUpUsernameResponse> signUpservice(
  //     RxString token, Map<dynamic, dynamic> body) async {
  //   String filter = ApiUtills.singUpService;
  //   String url = baseUrl + filter;
  //   print(" API:" + url);
  //   // var formData = getFormData(body);
  //   Dio dio = Dio();
  //   requestHeaders['Authorization'] = token.value;
  //   Options options = Options();
  //   options.headers = requestHeaders;
  //   // options.headers.remove("Host")
  //   var response = await dio.post(url, data: body, options: options);
  //   print(response.data);
  //   SignUpUsernameResponse parseData;
  //
  //   parseData = SignUpUsernameResponse.fromJson(response.data);
  //
  //   return parseData;
  // }
  Future<SignUpUsernameResponse> signUpservice(
      RxString token, Map<String, dynamic> body) async {
    // AppDialogUtils.dialogLoading();

    // await Future.delayed(Duration(seconds: 5));
    String filter = ApiUtills.singUpService;
    String url = baseUrl + filter;

    print(" API:" + url);
    // var formData = getFormData(body);
    Dio dio = Dio();
    requestHeaders['Authorization'] = token.value;
    Options options = Options();
    options.headers = requestHeaders;
    print(jsonEncode(body));
    // options.headers.remove("Host")
    var response = await dio.post(url, data: body, options: options);
    // if(response.statusCode==401){
    //   Get.to(()=>SignupOrLoginScreen());
    // }
    SignUpUsernameResponse parseData;
    parseData = SignUpUsernameResponse.fromJson(response.data);

    return parseData;
  }

  Future getToken() async {
    String? authToken =
        await SharedRefrence().getString(key: ApiUtills.authToken);
    if (authToken?.isNotEmpty == true) {
      requestHeaders['Authorization'] = authToken ?? "";
    }
  }

  Future<SignUpUsernameResponse> bProfileSignup(
      RxString token, Map<dynamic, dynamic> body) async {
    await getToken();
    String filter = ApiUtills.profileSignUp;
    String url = baseUrl + filter;
    print(" API:" + url);

    Options options = Options();
    options.headers = requestHeaders;
    var formData = getFormData(body);
    Dio dio = Dio();
    // var response = await dio.post(url, data: formData, options: options);
    var response =
        await client.post(filter, headers: requestHeaders, body: body);

    SignUpUsernameResponse parseData;

    parseData = SignUpUsernameResponse.fromJson(response.body);
    return parseData;
  }

  Future<ProviderProfileDetail> login(Map<dynamic, dynamic> body) async {
    String filter = ApiUtills.login;
    String url = baseUrl + filter;
    print(" API:" + url);
    print(" BODY:" + body.toString());
    var response = await client
        .post(filter, body: body)
        .timeout(const Duration(seconds: 30)); //todo added a timeout
    // if (response.body == null) {
    //   return await login(_body);
    // }

    print(response.body);
    // if(response.body["error"]==true){
    //   print("er ture");
    //   Get.snackbar("Invalid Credentials",response.body["message"]);
    // }
    // VerifyOtpResponse parseData;
    ProviderProfileDetail parseData;

    parseData = ProviderProfileDetail.fromJson(response.body);

    // print("body ${response.bodyString}");
    return parseData;
  }

  Future<PostalCodeResponse> searchPlaceByZip(String query) async {
    // String places =
    //     "https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$query&key=${ApiUtills.mapKey}&sessiontoken=1234567890";
    String places =
        "${dotenv.env['GOOGLE_PLACE_API']}?address=$query&key=${ApiUtills.mapKey}";
    Dio dio = Dio();
    var response = await dio.post(places);
    // var response = await client.get(places);

    PostalCodeResponse parse = PostalCodeResponse.fromJson(response.data);

    return parse;
  }

  Future<PredictionResponse> searchCities(String query) async {
    String city =
        "${dotenv.env['GOOGLE_CITY_API']}?input=$query&types=(cities)&key=${ApiUtills.mapKey}";

    // requestHeaders["Host"] = "";
    // var response = await client.get(places, headers: requestHeaders);

    Dio dio = Dio();
    var response = await dio.post(city);
    // var response = await client.get(places);

    PredictionResponse parse = PredictionResponse.fromJson(response.data);

    return parse;
  }

  Future<bool> resendOtp(String mobile) async {
    Map body = <String, String>{"email": mobile};

    String filter = ApiUtills.resendOtp;
    String url = baseUrl + filter;
    print(" API:" + url);
    var response = await client
        .post(filter, body: body)
        .timeout(const Duration(seconds: 30)); //todo added a timeout
    print(response.body);

    bool flag = false;
    if (!response.body['error']) {
      flag = true;
    }
    return flag;
  }

  Future<TimingDatesResponse> getServiceTimmings(String authToken) async {
    // var re = await scheduleTimes(authToken);
    String filter = ApiUtills.timmings;
    String url = baseUrl + filter;
    requestHeaders['Authorization'] = authToken;
    print(" API:" + url);
    var response = await client.get(
      filter,
      headers: requestHeaders,
    );
    TimingDatesResponse parseData;
    var resp = json.encode(response.body);
    parseData = TimingDatesResponse.fromJson(response.body);

    print("body ${response.body}");
    return parseData;
  }

  Future<dynamic> deleteBlockSlot({authToken, id}) async {
    String url = baseUrl + "provider/blocked-slot/$id/delete";
    requestHeaders['Authorization'] = authToken;
    print(" API:" + url);
    var response = await client.delete("provider/blocked-slot/$id/delete",
        headers: requestHeaders);

    print("body ${response.body}");

    return response.body;
  }

  Future<dynamic> getScheduleTiming({authToken}) async {
    String filter = ApiUtills.scheduletiming;
    String url = baseUrl + filter;
    requestHeaders['Authorization'] = authToken;
    print(" API:" + url);
    var response = await client.get(filter, headers: requestHeaders);
    print("body ${response.body}");

    return response.body;
  }

  Future<dynamic> updateBlockSLot({authToken, body, id}) async {
    String url = baseUrl + "provider/blocked-slot/$id/update";
    requestHeaders['Authorization'] = authToken;
    print(" API:" + url);
    var response = await client.put("provider/blocked-slot/$id/update",
        headers: requestHeaders, body: body);
    print("body ${response.body}");

    return response.body;
  }

  Future<dynamic> createBlockSLot({authToken, body}) async {
    String filter = ApiUtills.createBlockSlot;
    String url = baseUrl + filter;
    requestHeaders['Authorization'] = authToken;
    print(" API:" + url);
    var response =
        await client.post(filter, headers: requestHeaders, body: body);
    print("body ${response.body}");

    return response.body;
  }

  Future<dynamic> storeScheduleTimes({authToken, body}) async {
    String filter = ApiUtills.dayTimeSchedule;
    String url = baseUrl + filter;
    requestHeaders['Authorization'] = authToken;
    print(" API:" + url);
    var response =
        await client.post(filter, headers: requestHeaders, body: body);
    print("body ${response.body}");

    return response.body;
  }

  Future<dynamic> scheduleTimes({authToken, body}) async {
    // SlotsResponse _slotsResponse = SlotsResponse();
    // _slotsResponse.year = 2021;
    // _slotsResponse.month = 8;
    // List<Dates> dates = [
    //   Dates(date: 11, slots: [
    //     Slots(start: "00:00", end: "01:00"),
    //     Slots(start: "14:00", end: "03:00"),
    //   ]),
    //   Dates(date: 12, slots: [
    //     Slots(start: "00:00", end: "01:00"),
    //     Slots(start: "14:00", end: "03:00"),
    //   ]),
    // ];
    // _slotsResponse.dates = dates;

    // var data = _slotsResponse.toJson();

    String filter = ApiUtills.timmingsSchedule;
    String url = baseUrl + filter;
    requestHeaders['Authorization'] = authToken;
    print(" API:" + url);
    var response =
        await client.post(filter, headers: requestHeaders, body: body);
    print("body ${response.body}");

    // VerifyOtpResponse parseData;§
    // var resp = json.encode(response.body);
    // if (response.body['error'] && response.body['data'] == null) {
    //   parseData = VerifyOtpResponse.fromJson(response.body);
    // } else {
    //   parseData = VerifyOtpResponse.fromJson(response.body);
    // }
    //
    return response.body;
  }

  Future<AvailableServiceResponse> getAvailableJobs(String authToken) async {
    String filter = ApiUtills.availableServices;
    String url = baseUrl + filter;
    requestHeaders['Authorization'] = authToken;
    print(" API:" + url);
    print(" Token: " + authToken);
    var response = await client.get(
      filter,
      headers: requestHeaders,
    );
    if (response.unauthorized) {
      //todo
      print("unauthorized logging out");
      logout();
      Get.offNamedUntil(SignupOrLoginScreen.id, (route) => false);
    }
    AvailableServiceResponse parseData;
    var resp = json.encode(response.body);
    if (response.body == null) {
      return await getAvailableJobs(authToken);
    }
    parseData = AvailableServiceResponse.fromJson(response.body);

    print("body ${response.bodyString}");
    return parseData;
  }

  Future<dynamic> updateStatus(String authToken, int id, String status) async {
    String filter = ApiUtills.orderStatus + id.toString();
    String url = baseUrl + filter;
    requestHeaders['Authorization'] = authToken;
    print("Token ${authToken.replaceAll("Bearer ", "")}");
    print(" API:" + url);
    Map _body = <String, String>{"status": status};
    // Map _body = <String, String>{"status": "REJECTED"};

    var response = await client.post(
      filter,
      headers: requestHeaders,
      body: _body,
    );

    AvailableServiceResponse parseData;
    var resp = json.encode(response.body);
    parseData = AvailableServiceResponse.fromJson(response.body);

    print("body ${response.body}");
    return response.bodyString;
  }

  Future<dynamic> sendQuotation(
      String authToken, id, Map<dynamic, dynamic> body) async {
    String filter = ApiUtills.sendQuotation + id.toString();
    String url = baseUrl + filter;
    requestHeaders['Authorization'] = authToken;
    print("Token $authToken");
    print(" API:" + url);
    // Map _body = <String, String>{"status": "REJECTED"};

    var response = await client.post(
      filter,
      headers: requestHeaders,
      body: body,
    );

    var parseData;
    var resp = json.encode(response.body);
    // parseData = AvailableServiceResponse.fromJson(response.body);

    print("body ${response.body}");
    return response.bodyString;
  }

  Future<PaymentModelResponse> updatePaymentMehtod(authToken, body) async {
    String filter = ApiUtills.paymentUpdate;
    String url = baseUrl + filter;
    requestHeaders['Authorization'] = authToken;
    print("Token $authToken");
    print(" API:" + url);

    var response = await client.post(
      filter,
      headers: requestHeaders,
      body: body,
    );

    PaymentModelResponse parseData;
    var resp = json.encode(response.body);
    parseData = PaymentModelResponse.fromJson(response.body);

    print("body ${response.body}");
    return parseData;
  }

  Future<String> uploadImage(token, image) async {
    String filter = ApiUtills.profileImage;
    String url = baseUrl + filter;

    Map body = <String, dynamic>{"image": image};
    var formData = getFormData(body);
    requestHeaders['Authorization'] = token;

    //create multipart request for POST or PATCH method
    var request = http.MultipartRequest("POST", Uri.parse(url));
    //add text fields
    //create multipart using filepath, string or bytes
    var pic = await http.MultipartFile.fromPath("image", image.path);
    //add multipart to request
    Map<String, String> headers = {"Authorization": token};
    request.files.add(pic);
    request.headers.addAll(headers);
    var response = await request.send();

    //Get the response from the server
    // if(response.statusCode==401){
    //   logout();
    //   Get.to(()=>SignupOrLoginScreen());
    // }
    var responseData = await response.stream.toBytes();
    var responseString = String.fromCharCodes(responseData);
    print(responseString);
    var imagePath;
    if (!responseString.toLowerCase().contains("<!doctype")) {
      var object = json.decode(responseString);

      if (!object['error']) {
        imagePath = object['data'];
      }
    }

    return imagePath ?? "";
  }

  Future<ProviderProfileDetail> getProviderProfile(id, String authToken) async {
    String filter = ApiUtills.userProfile;
    String url = baseUrl + filter;
    requestHeaders['Authorization'] = authToken;
    Logger().d("test calll");
    var response = await getRequest(filter);
    if (response.unauthorized) {
      print("unauthorized logging out");
      logout();
      Get.offNamedUntil(SignupOrLoginScreen.id, (route) => false);
    }
    // VerifyOtpResponse parseData;
    ProviderProfileDetail parseData;
    if (response.body['error'] && response.body['data'] == null) {
      // parseData = VerifyOtpResponse.fromJson(response.body);
      parseData = ProviderProfileDetail.fromJson(response.body);
    } else {
      // parseData = VerifyOtpResponse.fromJson(response.body);
      parseData = ProviderProfileDetail.fromJson(response.body);
    }
    //print("=================BODY======================");

    //dynamic data = response.body;
    //print("body ${jsonEncode(response.body)}");
    // print("only data ============ ");
    //print(data["data"]["provider"]["provider_profile"]);
    AppDialogUtils.dismiss();
    return parseData;
  }

  Future<ProviderZipcodeResponse> getProviderZipCodes({authToken}) async {
    String filter = ApiUtills.providerZipCodes;
    String url = baseUrl + filter;
    print(" APIiiiii:" + url);
    requestHeaders['Authorization'] = authToken;
    print("Token $authToken");
    print(" API:" + url);
    var response = await client.get(filter, headers: requestHeaders);
    ProviderZipcodeResponse parseData;

    parseData = ProviderZipcodeResponse.fromJson(response.body);
    print("body ${response.body}");
    return parseData;
  }

  Future<bool> deleteZipCode({authToken, id}) async {
    String filter = ApiUtills.deleteZipCode + id.toString();
    String url = baseUrl + filter;
    print(" API:" + url);
    requestHeaders['Authorization'] = authToken;
    print("Token $authToken");
    print(" API:" + url);
    var response = await client.delete(filter, headers: requestHeaders);

    bool check = false;

    if (!response.body['error'] && response.body['message'] == 'success') {
      check = true;
    }
    return check;
  }

  Future<bool> uploadDocs({authToken, formData}) async {
    String filter = ApiUtills.uploadDocs;
    String url = baseUrl + filter;
    requestHeaders['Authorization'] = authToken;
    print("Token $authToken");
    print(" API:" + url);
    // var response =
    //     await client.post(filter, headers: requestHeaders, body: formData);

    Dio dio = Dio();
    requestHeaders['Authorization'] = authToken;
    Options options = Options();
    options.headers = requestHeaders;
    // options.headers.remove("Host")
    var response = await dio.post(url, data: formData, options: options);
    print(response);
    bool check = false;

    if (!response.data['error'] && response.data['message'] == 'success') {
      check = true;
    }
    return check;
  }

  Future<bool> upDateZipCodes(
      RxString token, Map<dynamic, dynamic> body) async {
    String upDate = "provider/services/zip-code";
    String filter = upDate;
    await getToken();
    String url = baseUrl + filter;
    print(" API:" + url);
    var formData = getFormData(body);
    Dio dio = Dio();
    Options options = Options();
    // options.headers = requestHeaders;
    // options.headers.remove("Host")
    // var response = await dio.post(url, data: body, options: options);

    var response =
        await client.post(filter, headers: requestHeaders, body: body);
    bool check = false;
    if (response.body == null) {
      return await upDateZipCodes(token, body);
    }

    if (!response.body["error"] && response.body["message"] == "success") {
      check = true;
    }

    return check;
  }

  Future<DocumentResponse> getDocuments({authToken}) async {
    String filter = ApiUtills.documents;
    String url = baseUrl + filter;
    print(" API:" + url);
    requestHeaders['Authorization'] = authToken;
    var response = await client.get(filter, headers: requestHeaders);
    DocumentResponse parseData;

    parseData = DocumentResponse.fromJson(response.body);

    print("body ${response.body}");
    return parseData;
  }

  Future<BuyCreditResponse> purchaseCredit({authToken, body, amount}) async {
    String filter = ApiUtills.payment;
    String url = baseUrl + filter;
    print(" API:" + url);
    requestHeaders['Authorization'] = authToken;
    print("Token $authToken");
    print(" API:" + url);
    Map _body = <String, String>{"token": "$body", "amount": amount};
    var response =
        await client.post(filter, body: _body, headers: requestHeaders);
    BuyCreditResponse parseDate = BuyCreditResponse.fromJson(response.body);
    print("result ${response.bodyString}");

    return parseDate;
  }

  uploadToken(String token, authToken, platform) async {
    print("upload token called");
    String filter = ApiUtills.deviceToken;
    String url = baseUrl + filter;
    print(" API:" + url);
    requestHeaders['Authorization'] = authToken;
    print("auth token: $authToken");
    print(" API:" + url);
    print("device token: ${token}");
    print("device platform: ${platform}");
    Map _body = <String, String>{
      "device_token": "$token",
      "os_platform": "$platform",
    };
    print("body $_body");
    var response =
        await client.post(filter, body: _body, headers: requestHeaders);
    print("response : ${response}");
    print("status : ${response.statusCode}");
    if (response.body == null) {
      return await uploadToken(token, authToken, platform);
    }

    print("result: ${response.bodyString}");
  }

  Future<GetCredit> getCredit({authToken}) async {
    String filter = ApiUtills.getCredit;
    String url = baseUrl + filter;
    print(" API:" + url);
    requestHeaders['Authorization'] = authToken;
    print("Token $authToken");
    print(" API:" + url);
    var response = await client.get(filter, headers: requestHeaders);
    GetCredit parseData = GetCredit.fromJson(response.body);

    print("result ${response.bodyString}");
    return parseData;
  }

  sendMessage({authToken, body}) async {
    String filter = ApiUtills.messageSent;
    String url = baseUrl + filter;
    print(" API:" + url);
    requestHeaders['Authorization'] = authToken;
    print("Token $authToken");
    print(" API:" + url);
    var response =
        await client.post(filter, body: body, headers: requestHeaders);

    print("result ${response.bodyString}");
  }

  Future<ActiveOrdersResponse> getInboxList({authToken}) async {
    String filter = "provider/message/active-order-chat";
    String url = baseUrl + filter;
    print(" API:" + url);
    requestHeaders['Authorization'] = authToken;
    print("Token $authToken");
    print(" API:" + url);
    var response = await client.get(filter, headers: requestHeaders);
    if (response.unauthorized) {
      //todo
      print("unauthorized logging out");
      logout();
      Get.offNamedUntil(SignupOrLoginScreen.id, (route) => false);
    }
    print("result ${response.bodyString}");
    ActiveOrdersResponse parseData =
        ActiveOrdersResponse.fromJson(response.body);

    return parseData;
  }

  Future<TransationResponse> getTransactionHistory({authToken, page}) async {
    String filter = ApiUtills.transactionHistory;

    if (page != null) {
      filter = filter + "?page=$page";
    }
    String url = baseUrl + filter;
    print(" API:" + url);
    requestHeaders['Authorization'] = authToken;
    print("Token $authToken");
    print(" API:" + url);
    var response = await client.get(filter, headers: requestHeaders);
    print("result ${response.bodyString}");

    TransationResponse parseData = TransationResponse.fromJson(response.body);
    return parseData;
  }

  Future<UserChatResponse> getUserChat({
    authToken,
    id,
    page,
    orderId,
    isAdmin = false,
  }) async {
    String filter = "provider/message/chat/$id?service_request_id=$orderId";

    if (isAdmin) {
      filter = "provider/message/chat/$id?is_admin=1";
    }

    if (page != null) {
      filter = filter + "&page=$page";
    }
    String url = baseUrl + filter;
    print(" API:" + url);
    requestHeaders['Authorization'] = authToken;
    print("Token $authToken");
    print(" API:" + url);
    var response = await client.get(filter, headers: requestHeaders);
    print(response.body);
    if (response.unauthorized) {
      //todo
      print("unauthorized logging out");
      logout();
      Get.offNamedUntil(SignupOrLoginScreen.id, (route) => false);
    }
    print("result ${response.bodyString}");
    UserChatResponse parseData = UserChatResponse.fromJson(response.body);
    return parseData;
  }

  Future<dynamic> acceptOrRejectChat(authToken, id, body) async {
    String filter = "provider/order/chat-request/$id";

    String url = baseUrl + filter;
    print(" API:" + url);
    requestHeaders['Authorization'] = authToken;
    print("Token $authToken");
    print(" API:" + url);
    var response =
        await client.post(filter, headers: requestHeaders, body: body);
    print("result ${response.bodyString}");

    bool flag = false;

    return response.body;
  }

  Future<StartServiceResponse> startService(
      authToken, Map<dynamic, dynamic> body) async {
    String filter = "provider/order/start-end";

    String url = baseUrl + filter;
    print(" API:" + url);
    requestHeaders['Authorization'] = authToken;
    print("Token $authToken");
    print(" API:" + url);
    var response =
        await client.post(filter, headers: requestHeaders, body: body);

    print("result ${response.bodyString}");
    StartServiceResponse parseData =
        StartServiceResponse.fromJson(response.body);
    return parseData;
  }

  Future<OrderStatusResponse> getOrderStatus(authToken, id) async {
    String filter = "provider/order/worked-status";

    Map body = <String, dynamic>{"service_request_id": id};
    String url = baseUrl + filter;
    print(" API:" + url);
    requestHeaders['Authorization'] = authToken;
    print("Token $authToken");
    print(" API:" + url);
    var response =
        await client.post(filter, headers: requestHeaders, body: body);

    print("result ${response.bodyString}");
    OrderStatusResponse parseData = OrderStatusResponse.fromJson(response.body);
    return parseData;
  }

  Future<dynamic> sendFeedback({authToken, body}) async {
    String filter = "provider/feedback/create";

    String url = baseUrl + filter;
    print(" API:" + url);
    requestHeaders['Authorization'] = authToken;
    print("Token $authToken");
    print(" API:" + url);
    var response =
        await client.post(filter, headers: requestHeaders, body: body);

    return response;
  }

  Future<VehicleTypeResponse> getTypes() async {
    String filter = "provider/vehicle/types";

    String url = baseUrl + filter;
    print(" API:" + url);
    print(" API:" + url);
    var response = await client.get(filter, headers: requestHeaders);
    print("result ${response.bodyString}");
    VehicleTypeResponse parseData = VehicleTypeResponse.fromJson(response.body);
    return parseData;
  }

  Future<VehicleAddResponse> store(body, authToken) async {
    await getToken();

    String filter = "provider/vehicle/store";

    String url = baseUrl + filter;
    print(" API:" + url);
    print("Token $authToken");
    print(" API:" + url);
    List<Map> newMap = [];
    for (int index = 0; index < body.length; index++) {
      if (body[index]['vehicle_type_id'] != null) {
        newMap.add(body[index]);
      }
    }
    var response =
        await client.post(filter, headers: requestHeaders, body: newMap);

    VehicleAddResponse parseData = VehicleAddResponse.fromJson(response.body);
    return parseData;
  }

  Future<dynamic> deleteVehicle(id, authToken) async {
    String filter = "provider/vehicle/delete/$id";

    String url = baseUrl + filter;
    print(" API:" + url);
    requestHeaders['Authorization'] = authToken;
    print("Token $authToken");
    print(" API:" + url);
    var response = await client.get(filter, headers: requestHeaders);

    print(response.bodyString);
    return response.body;
  }

  Future<AllNotificationsResponse> getAllNotifications() async {
    await getToken();
    String filter = "provider/notification";
    String url = baseUrl + filter;
    print(" API:" + url);

    print(" API:" + url);
    var response = await client.get(filter, headers: requestHeaders);
    if (response.body == null) {
      return await getAllNotifications();
    }
    if (response.unauthorized) {
      //todo
      print("unauthorized logging out");
      logout();
      Get.offNamedUntil(SignupOrLoginScreen.id, (route) => false);
    }

    AllNotificationsResponse parseData =
        AllNotificationsResponse.fromJson(response.body);
    return parseData;
    // var response = await getRequest(filter);
  }

  Future<VehicleAddResponse> updateVehicle(id, body, authToken) async {
    String filter = "provider/vehicle/update/$id";

    String url = baseUrl + filter;
    print(" API:" + url);
    requestHeaders['Authorization'] = authToken;
    print("Token $authToken");
    print(" API:" + url);
    var response =
        await client.patch(filter, headers: requestHeaders, body: body);

    VehicleAddResponse parseData = VehicleAddResponse.singObject(response.body);
    return parseData;
  }

  getRequest(String filter, {count = 0}) async {
    await getToken();
    String url = baseUrl + filter;
    print(" API:" + url);
    var response = await client.get(filter, headers: requestHeaders);
    if (count == 2) {
      return;
    }
    if (response.body == null) {
      count = count + 1;
      return await getRequest(filter, count: count);
    }
    return response;
  }

  Future<PortfioResponse> postPortfolio({body}) async {
    await getToken();
    String filter = "provider/portfolio/store";
    String url = baseUrl + filter;
    print(" API:" + url);

    Dio dio = Dio();
    Options options = Options();
    options.headers = requestHeaders;
    // options.headers.remove("Host")
    var response = await dio.post(url, data: body, options: options);
    print("portfolio data Showing ===== ${body.toString()}");

    PortfioResponse? parseData;

    if (response.data.length > 0) {
      parseData = await getPortfolio();
    }

    return parseData!;
  }

  Future<PortfioResponse> getPortfolio() async {
    await getToken();
    String filter = "provider/portfolio";
    String url = baseUrl + filter;
    print(" API:" + url);

    Dio dio = Dio();
    Options options = Options();
    options.headers = requestHeaders;
    // options.headers.remove("Host")
    var response = await getRequest(filter);

    PortfioResponse parseData;

    parseData = PortfioResponse.fromJson(response.body);
    print("parse ataaaaaaaaaaaaaaaaaaaaaa ${jsonEncode(parseData)}");

    return parseData;
  }

  postRequest(String filter, body, {count = 0}) async {
    await getToken();
    String url = baseUrl + filter;
    print(" API:" + url);
    var response =
        await client.post(filter, body: body, headers: requestHeaders);

    if (count == 2) {
      return;
    }
    if (response.body == null) {
      count = count + 1;
      return await postRequest(filter, body, count: count);
    }
    return response;
  }

  deleteRequestDio(String filter, {body, count = 0}) async {
    await getToken();
    String url = baseUrl + filter;
    print(" API:" + url);

    Dio dio = Dio();
    Options options = Options();
    options.headers = requestHeaders;
    // options.headers.remove("Host")
    var response;
    if (body == null) {
      response = await dio.delete(url, options: options);
    } else {
      response = await dio.delete(url, data: body, options: options);
    }

    if (count == 2) {
      return;
    }
    if (response == null) {
      count = count + 1;
      return await postRequest(filter, body, count: count);
    }
    return response;
  }

  Future<String> deleteImagePort(var id) async {
    String filter = "provider/portfolio/delete/$id";
    var response = await deleteRequestDio(filter);

    if (!response.data['error'] &&
        response.data["message"] == "Portfolio deleted successfully") {
      return "Images deleted successfully";
    }
    return "abc";
  }

  Future<PortfioResponse> updatePortfolio({body, id}) async {
    await getToken();
    String filter = "provider/portfolio/update/$id";
    String url = baseUrl + filter;
    print(" API:" + url);

    Dio dio = Dio();
    Options options = Options();
    options.headers = requestHeaders;
    // options.headers.remove("Host")
    var response = await dio.post(url, data: body, options: options);

    PortfioResponse parseData;

    parseData = PortfioResponse.fromJson(response.data);
    if (parseData.message == "Portfolio retrieved successfully.") {
      parseData = await getPortfolio();
    }

    return parseData;
  }

  Future<bool> userAvailable(String id) async {
    String filter = "is-user/$id";
    print("${baseUrl}$filter");
    var response = await getRequest(filter);
    // check = true;

    if (response == null) {
      return false;
    }
    if (!response.body['error'] && response.body['message'] == "User found") {
      return true;
    }
    return false;
  }

  Future<dynamic> forgetPassword({body}) async {
    String filter = "provider/forgot-password";
    print("${baseUrl}$filter");

    var response = await postRequest(filter, body);
    print("${response.body}");

    return response.body;
  }

//todo
  Future<dynamic> getServicesList() async {
    String filter = "provider/services";
    print("${baseUrl}$filter");
    var response = await getRequest(filter);
    if (response.unauthorized) {
      print("unauthorized logging out");
      logout();
      Get.offNamedUntil(SignupOrLoginScreen.id, (route) => false);
    }
    print("${response.bodyString}");
    if (response.statusText == "OK" &&
        response.statusCode == 200 &&
        response.body != null) {
      UserServiceModel model = UserServiceModel.fromJson(response.body);
      return model;
    }
    return "failed";
  }

  Future<dynamic> changePassword(
      String password, String confirmPassword, number, token) async {
    String filter = "provider/change-password";
    print("${baseUrl}$filter");
    Map<String, dynamic> body = {
      "token": token,
      "email": number,
      "password": password,
      "password_confirmation": confirmPassword,
    };
    var response = await postRequest(filter, body);

    return response.body;
  }

  Future<dynamic> updateUserService(body) async {
    await getToken();
    String filter = "provider/services/status";
    var response = await postRequest(filter, body);
    if (response.statusCode == 200 ||
        response.statusCode == 201 && response.statusText == "OK" ||
        response.statusText == "Created") {
      bool flag = response.body['data'] is Map;
      if (!flag) {
        return response.body['error'];
      }
      print(response.bodyString);
      ServiceUpdateModel model = ServiceUpdateModel.fromJson(response.body);
      return model;
    }
    return "failed to update";
  }

  Future<VerifyOtpResponse> socialLogin(Map<dynamic, dynamic> body) async {
    String filter = "provider/social-login";
    var response = await postRequest(filter, body);
    print("res ${response.body}");
    VerifyOtpResponse parseData;

    parseData = VerifyOtpResponse.fromJson(response.body);

    print("sdfs ${parseData.userData.user.socialType}");
    return parseData;
  }

  //todo
  Future<ProviderProfileDetail> socialInfoLogin(
      Map<dynamic, dynamic> body) async {
    String filter = "provider/social-login";
    print('my required body:$body');
    var response = await postRequest(filter, body);
    print("res ${response.body}");
    // SocialsInfoModel parseData;

    ProviderProfileDetail parseData;
    parseData = ProviderProfileDetail.fromJson(response.body);

    // print("${parseData.data!.provider.deviceToken}");
    return parseData;
  }

// TODO create pacakge api calling

  Future<String> createPackagePlan({body}) async {
    String? authToken =
        await SharedRefrence().getString(key: ApiUtills.authToken);

    String filter = "provider/plan";
    String url = baseUrl + filter;
    requestHeaders['Authorization'] = authToken ?? "";
    print(" API:" + url);
    var response = await client.post(
      filter,
      body: body,
      headers: requestHeaders,
    );

    print(response.body);
    return response.bodyString!;
  }

  //TODO get Package plan list

  Future<PackagePlanDetails> getPlanLIst() async {
    String? authToken =
        await SharedRefrence().getString(key: ApiUtills.authToken);

    String filter = "provider/plan";
    String url = baseUrl + filter;
    requestHeaders['Authorization'] = authToken ?? "";
    print(" API:" + url);
    var response = await client.get(
      filter,
      headers: requestHeaders,
    );
    PackagePlanDetails packagePlanDetailsFromJson =
        PackagePlanDetails.fromJson(response.body);
    return packagePlanDetailsFromJson;
  }

  //TODO update plan list
  Future<String> updatePackagePlan({body, id}) async {
    String? authToken =
        await SharedRefrence().getString(key: ApiUtills.authToken);

    String filter = "provider/plan/$id";
    String url = baseUrl + filter;
    requestHeaders['Authorization'] = authToken ?? "";
    print(" API:" + url);
    var response = await client.put(
      filter,
      body: body,
      headers: requestHeaders,
    );

    return response.bodyString!;
  }

  Future<String> deletePackagePlan({id}) async {
    String? authToken =
        await SharedRefrence().getString(key: ApiUtills.authToken);

    String filter = "provider/plan/$id";
    String url = baseUrl + filter;
    requestHeaders['Authorization'] = authToken ?? "";
    print(" API:" + url);
    var response = await client.delete(
      filter,
      headers: requestHeaders,
    );

    return response.bodyString!;
  }

  Future<SubscriptionPlan> getPackagePlan() async {
    String? authToken =
        await SharedRefrence().getString(key: ApiUtills.authToken);

    String filter = "provider/subscription";
    String url = baseUrl + filter;
    requestHeaders['Authorization'] = authToken ?? "";
    print(" API:" + url);
    var response = await client.get(
      filter,
      headers: requestHeaders,
    );
    print(response);
    SubscriptionPlan subscriptionPlanFromJson =
        SubscriptionPlan.fromJson(response.body);

    return subscriptionPlanFromJson;
  }

  Future<SubscribePackageResponse> subscribePackage({body}) async {
    String? authToken =
        await SharedRefrence().getString(key: ApiUtills.authToken);

    String filter = "provider/subscription/buy";
    String url = baseUrl + filter;
    requestHeaders['Authorization'] = authToken ?? "";
    print(" API:" + url);
    var response = await client.post(
      filter,
      body: body,
      headers: requestHeaders,
    );
    SubscribePackageResponse subscribePackageResponseFromJson =
        SubscribePackageResponse.fromJson(response.body);
    return subscribePackageResponseFromJson;
  }
}

void logout() async {
  SharedRefrence().clearPrefs(key: ApiUtills.authToken);
  SharedRefrence().clearPrefs(key: ApiUtills.userData);
  SharedRefrence().clearPrefs(key: ApiUtills.firstName);
  SharedRefrence().clearPrefs(key: ApiUtills.image);
  SharedRefrence().clearPrefs(key: ApiUtills.lastName);
  SharedRefrence().clearPrefs(key: "userId");

  Get.clearRouteTree();
}
