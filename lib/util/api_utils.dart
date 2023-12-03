import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

bool chatOpen = false;
String baseUrl = dotenv.env['API_URL'] ?? "";

class ApiUtills {
  static final String imageBaseUrl = dotenv.env['BASE_URL'] ?? "";
  static const String subscribersList = "provider/users-plan";
  static const String paymentMethods = "provider/payment-method";
  static const String withdrawal = "provider/transaction/withdrawal";

  static const String verifyUser = "provider/signup";
  static const String signupName = "provider/signup/name";
  static const String otpVerify = "provider/signup/phone/verify";
  static const String otpVerifybyemail = "provider/signup/email/verify";

  static const String mainService = "provider/services/main";
  static const String profileSignUp = "provider/signup/profile";
  static const String login = "provider/login";
  static const String singUpService = "provider/signup/my-services";
  static const String resendOtp = "provider/signup/email/verify/resend";
  static const String timmings = "provider/services/schedule";
  static const String timmingsSchedule = "provider/services/store-schedule";
  static const String dayTimeSchedule = "provider/schedule/store";
  static const String scheduletiming = "provider/schedule";
  static const String availableServices = "provider/order";
  static const String orderStatus = "provider/order/status/";
  static const String sendQuotation = "provider/order/quotation/";
  static const String paymentUpdate = "provider/payment-update";
  static const String profileImage = "provider/profile-image";
  static const String userProfile = "provider/profile";
  static const String providerZipCodes = "provider/services/zip-code-list";
  static const String deleteZipCode = "provider/services/zip-code/";
  static const String uploadDocs = "provider/media/store";
  static const String documents = "provider/media/list";
  static const String payment = "provider/transaction/payment";
  static const String deviceToken = "provider/device-token";
  static const String getCredit = "provider/show-credit";
  static const String messageSent = "provider/message/send";
  static const String inboxList = "provider/message";
  static const String transactionHistory = "provider/transaction/history";
  static const String singleUserChat = "provider/message/chat/";
  static const String createBlockSlot = "provider/blocked-slot/store";

  String upDate = "provider/services/zip-code";
  static final String countryList = 'countries';

  //shared preferences keys

  static const String userData = "user_data";
  static const String socialData = "social_data";
  static const String introData = "introData";
  static const String authToken = "authToken";
  static const String firstName = "firstName";
  static const String image = "image";
  static const String lastName = "lastName";

  //map keys
  static String mapKey = dotenv.env['GOOGLE_MAP_KEY'] ?? "";
}

FormData getFormData(body) {
  return FormData.fromMap(body);
}

Future<MultipartFile> getMultiPart(File image) async {
  var file = await MultipartFile.fromFile(image.path, filename: "image.path");
  return file;
}

void setSelection(TextEditingController controller) {
  controller.selection = TextSelection(
      baseOffset: controller.text.length, extentOffset: controller.text.length);
}

controllerSelection(TextEditingController controller) {
  controller.selection = TextSelection(
      baseOffset: controller.text.length, extentOffset: controller.text.length);
}
