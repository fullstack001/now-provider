import 'dart:convert';

import 'package:fare_now_provider/api_service/service_repository.dart';
import 'package:fare_now_provider/controllers/location_controller/locaction_controller.dart';
import 'package:fare_now_provider/controllers/profile_screen_controller/ProfileScreenController.dart';
import 'package:fare_now_provider/models/verify_otp/provider_profile_detail.dart';
import 'package:fare_now_provider/screens/home_screen.dart';
import 'package:fare_now_provider/util/api_utils.dart';
import 'package:fare_now_provider/util/shared_reference.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';

import 'bottom_navigation.dart';
import 'profile_screen.dart';
import 'signup_or_login_screen.dart';

bool hasDocument = false;
bool hasSlots = false;

class SplashScreen extends StatefulWidget {
  static const id = 'splash_screen';

  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final ProfileScreenController _homeScreenController =
      Get.put(ProfileScreenController());

  final LocationController _locationController = Get.put(LocationController());

  allGood(ProviderProfileDetail usr) {
    if (usr.data!.provider == null || usr.data!.auth_token == null) {
      return false;
    }
    if (usr.data!.provider!.schedules!.isEmpty &&
        // usr.userData.user.document.isEmpty &&
        usr.data!.provider!.serviceType != "MOVING" &&
        usr.data!.provider!.status == "ACTIVE") {
      return true;
    } else if (usr.data!.provider!.schedules!.isEmpty &&
        usr.data!.provider!.serviceType != "MOVING" &&
        usr.data!.provider!.status == "ACTIVE") {
      return true;
    } else if (
        // usr.userData.user.document.isNotEmpty &&
        usr.data!.provider!.status == "ACTIVE") {
      return true;
    }
    // if (usr.userData.user.timeSlots &&
    //     usr.userData.user.document.isEmpty &&
    //     usr.userData.user.serviceType != "MOVING" &&
    //     usr.userData.user.status == "ACTIVE") {
    //   return true;
    // } else if (usr.userData.user.timeSlots &&
    //     usr.userData.user.serviceType != "MOVING" &&
    //     usr.userData.user.status == "ACTIVE") {
    //   return true;
    // } else if (usr.userData.user.document.isNotEmpty &&
    //     usr.userData.user.status == "ACTIVE") {
    //   return true;
    // }
    return false;
  }

  final serviceRepo = ServiceReposiotry();
  Future<String> checkToken() async {
    String? authToken =
        await SharedRefrence().getString(key: ApiUtills.authToken);
    String? userData =
        await SharedRefrence().getString(key: ApiUtills.userData);
    if (userData?.isNotEmpty == true) {
      var data = json.decode(userData ?? "");
      var resp = await serviceRepo.userAvailable(data['id'].toString());
      authToken = resp ? authToken : "";
      if (authToken?.isNotEmpty == true) {
        // VerifyOtpResponse usr = await ServiceReposiotry()
        //     .getProviderProfile(data['id'].toString(), authToken);
        ProviderProfileDetail usr = await serviceRepo.getProviderProfile(
            data['id'].toString(), authToken ?? "");
        hasSlots = usr.data.provider == null
            ? false
            : usr.data!.provider!.schedules!.isEmpty
                ? false
                : true;
        // hasSlots = usr.userData.user.timeSlots;
        if (usr.data.provider != null) {
          _homeScreenController.userData(usr.data!.provider!);
        }
        // hasDocument =
        //     (usr.data!.provider!.document ?? []).isEmpty ? false : true;
        if (allGood(usr)) {
          selectedIndex = 0;
          BottomNavigation.currentScreen = HomeScreen();
        } else {
          BottomNavigation.currentScreen = ProfileScreen();
        }
      }
      print(authToken);
    }

    return authToken?.isNotEmpty == true
        ? BottomNavigation.id
        : SignupOrLoginScreen.id;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      body: Stack(
        alignment: Alignment.center,
        fit: StackFit.expand,
        children: [
          Padding(
            padding: const EdgeInsets.all(50.0),
            child: Image.asset('assets/images/provider.png'),
          ),
          Obx(() {
            if (_locationController.isLocationLoading.value == false) {
              0.delay().then((value) async {
                String rout = await checkToken();
                Get.offNamedUntil(rout, (route) => false);
              });
            }
            return Positioned(
              bottom: 14,
              left: 0,
              right: 0,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (_locationController.isLocationServiceEnabled.value ==
                      false)
                    const Text(
                      "You need to enable your loaction service",
                    ),
                  if (_locationController.isLocationServiceEnabled.value ==
                      false)
                    const SizedBox(
                      height: 24,
                    ),
                  const SizedBox(),
                ],
              ),
            );
          })
        ],
      ),
    );
  }
}
/*
import 'dart:convert';

import 'package:fare_now_provider/api_service/service_repository.dart';
import 'package:fare_now_provider/controllers/profile_screen_controller/ProfileScreenController.dart';
import 'package:fare_now_provider/controllers/services_list_controller.dart';
import 'package:fare_now_provider/models/verify_otp/provider_profile_detail.dart';
import 'package:fare_now_provider/screens/home_screen.dart';
import 'package:fare_now_provider/util/api_utils.dart';
import 'package:fare_now_provider/util/shared_reference.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/src/extensions/num_extensions.dart';
import 'package:nb_utils/nb_utils.dart';

import '../models/signup_username/sign_up_username_respnse.dart';
import 'auth_screen/profile_data_steps/business_profile_settings_screen.dart';
import 'auth_screen/profile_data_steps/profile_settings_screen.dart';
import 'auth_screen/profile_data_steps/step_1.dart';
import 'auth_screen/profile_data_steps/step_2.dart';
import 'bottom_navigation.dart';
import 'profile_screen.dart';
import 'signup_or_login_screen.dart';

bool hasDocument = false;
bool hasSlots = false;
bool hasZipcode = false;

class SplashScreen extends StatefulWidget {
  static const id = 'splash_screen';

  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final ProfileScreenController _homeScreenController =
  Get.put(ProfileScreenController());
  // final ServicesListController _servicesListController =
  //     Get.put(ServicesListController());

  @override
  void initState() {

    0.delay().then((value) async {
      await Future.delayed(Duration(seconds: 3)); // Simulate async operation
      // Simulated success
      checkToken();
    });
    */
/*  0.delay().then((value) async {
      String rout = await checkToken();
      2.delay().then((value) => Get.offNamedUntil(rout, (route) => true));
    });*/ /*

    // allGood(ProviderProfileDetail as ProviderProfileDetail);

    super.initState();
  }

  allGood(ProviderProfileDetail usr) {
    if (usr.data!.provider == null || usr.data!.auth_token == null) {
      return false;
    }
    if(usr.data!.provider.spendEachMonth ==null &&
        usr.data!.provider.bio ==null &&
        usr.data!.provider.zipCode ==null){
      print("Heloo");

      return false;
    }
    else if (usr.data!.provider!.schedules!.isEmpty &&
        // usr.userData.user.document.isEmpty &&
        usr.data!.provider!.serviceType != "MOVING" &&
        usr.data!.provider!.status == "ACTIVE") {
      return true;
    } else if (usr.data!.provider!.schedules!.isEmpty &&
        usr.data!.provider!.serviceType != "MOVING" &&
        usr.data!.provider!.status == "ACTIVE") {
      return true;
    } else if (
    // usr.userData.user.document.isNotEmpty &&
    usr.data!.provider!.status == "ACTIVE") {
      return true;
    }

    // if (usr.userData.user.timeSlots &&
    //     usr.userData.user.document.isEmpty &&
    //     usr.userData.user.serviceType != "MOVING" &&
    //     usr.userData.user.status == "ACTIVE") {
    //   return true;
    // } else if (usr.userData.user.timeSlots &&
    //     usr.userData.user.serviceType != "MOVING" &&
    //     usr.userData.user.status == "ACTIVE") {
    //   return true;
    // } else if (usr.userData.user.document.isNotEmpty &&
    //     usr.userData.user.status == "ACTIVE") {
    //   return true;
    // }
    return false;
  }

  Future<String> checkToken() async {
    String? authToken =
    await SharedRefrence().getString(key: ApiUtills.authToken);
    String? userData = await SharedRefrence().getString(key: ApiUtills.userData);
    print('userdata===$authToken');


    if (userData?.isNotEmpty==true) {
      var data = json.decode(userData??"");
      print("ALLDataa=======$data");
      var resp = await ServiceReposiotry().userAvailable(data['id'].toString());


      authToken = resp ? authToken : "";
      if (authToken?.isNotEmpty==true) {
        // VerifyOtpResponse usr = await ServiceReposiotry()
        //     .getProviderProfile(data['id'].toString(), authToken);
        ProviderProfileDetail usr = await ServiceReposiotry()
            .getProviderProfile(data['id'].toString(), authToken??"");

        //SignUpUsernameResponse usr1 = await ServiceReposiotry().signUpUsrName(_body, token);


        print("abcde$userData");
        print(usr);
        hasSlots = usr.data.provider == null
            ? false
            : usr.data!.provider.spendEachMonth ==null &&
            usr.data!.provider.bio ==null &&
            usr.data!.provider.zipCode ==null
            ? false
            : true;
        // hasSlots = usr.userData.user.timeSlots;
        print("CaLLING===$hasSlots");
        if (usr.data.provider != null) {
          _homeScreenController.userData(usr.data!.provider!);
        }
        // hasDocument =
        //     (usr.data!.provider!.document ?? []).isEmpty ? false : true;
        if (allGood(usr)) {
          selectedIndex = 0;
          BottomNavigation.currentScreen = HomeScreen();
          print("Helloooo1");
        } else if(data['first_name']== null) {
          Get.offNamedUntil(Step1.id, (route) => true);
          print("Helloooo2");
        }else if(data['zip_code']== null) {
          Get.offNamedUntil(ProfileSettingsScreen.id, (route) => true);
          print("Helloooo3");
        }else if(authToken?.isNotEmpty==true ){
          Get.offNamedUntil(BottomNavigation.id, (route) => true);

          print("Helloooo4");
        }
        else{
          BottomNavigation.currentScreen = ProfileScreen();
          print("Helloooo5");
        }
      }

      print(authToken);
    }
    else{
      Get.offNamedUntil(SignupOrLoginScreen.id, (route) => true);
      print("Helloooo6");
    }



    return  "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(50.0),
            child: Image.asset('assets/images/provider.png'),
          )
        ],
      ),
    );
  }
}
*/
