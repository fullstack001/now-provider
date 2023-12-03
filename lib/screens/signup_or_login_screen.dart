import 'package:fare_now_provider/change_baseurl_dialog.dart';
import 'package:fare_now_provider/change_publish_key_dialog.dart';
import 'package:fare_now_provider/screens/auth_screen/login_screen.dart';
import 'package:fare_now_provider/screens/auth_screen/signup_screen.dart';
import 'package:fare_now_provider/util/app_colors.dart';
import 'package:fare_now_provider/util/shared_reference.dart';
import 'package:flutter/foundation.dart';

import '../components/buttons-management/part_of_file/part.dart';
import '../util/api_utils.dart';
import '../util/app_dialog_utils.dart';

bool flagBuild = kDebugMode || kProfileMode;

class SignupOrLoginScreen extends StatefulWidget {
  static const id = 'signup_or_login_screen';

  const SignupOrLoginScreen({super.key});

  @override
  SignupOrLoginScreenState createState() => SignupOrLoginScreenState();
}

class SignupOrLoginScreenState extends State<SignupOrLoginScreen> {
  int count = 0;
  int upperCounter = 0;
  String? findCountryId;
  String? countryCode;
  bool isSignUpButtonDisabled = false;
  void handleSignUpButtonClick() async {
    if (!isSignUpButtonDisabled) {
      setState(() {
        isSignUpButtonDisabled = true;
      });
      AppDialogUtils.dialogLoading();
      await Future.delayed(const Duration(milliseconds: 200));
      AppDialogUtils.dismiss();

      Get.toNamed(SignupScreen.id);

      setState(() {
        isSignUpButtonDisabled = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            flex: 8, //todo changed the flex from 4 to 3
            fit: FlexFit.tight,
            child: Stack(
              children: [
                GestureDetector(
                  onTap: () async {
                    if (flagBuild) {
                      upperCounter += 1;
                      if (upperCounter % 5 == 0) {
                        String? paymentKey =
                            await SharedRefrence().getString(key: "publishKey");
                        if (paymentKey?.isNotEmpty == true) {
                          publicTestKey = paymentKey ?? "";
                        }
                        Get.dialog(ChangePublishKeyDialog(),
                            barrierDismissible: false);
                      }
                    }
                  },
                  child: FittedBox(
                    child: SizedBox(
                      width: Get.width,
                      height: Get.height - Get.width * 0.9,
                      child: const Image(
                          image: AssetImage(
                              "assets/providerImages/png/auth_toggle.png"),
                          fit: BoxFit.fill),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // SizedBox(
                      //   height: Get.height * 0.35,
                      // ),
                      Container(
                        width: Get.width,
                        padding: const EdgeInsets.only(right: 120),
                        // height: 120,
                        child: const FittedBox(
                          fit: BoxFit.fill,
                          child: Text(
                            "Farenow \nProvider",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () async {
                          if (flagBuild) {
                            count += 1;
                            if (count % 7 == 0) {
                              String? url =
                                  await SharedRefrence().getString(key: "URL");
                              if (url?.isNotEmpty == true) {
                                baseUrl = url ?? "";
                              }
                              Get.dialog(ChangeBaseurlDialog(),
                                  barrierDismissible: false);
                            }
                          }
                        },
                        child: const FittedBox(
                          child: Text(
                            'Helps you to connect with real \n time clients around you',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                fontSize: 24, fontWeight: FontWeight.w400),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Flexible(
              flex: 3,
              fit: FlexFit.tight,
              child: FittedBox(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FarenowButton(
                        title: "Sign Up",
                        onPressed: handleSignUpButtonClick,
                        type: BUTTONTYPE.rectangular),
                    FarenowButton(
                        title: "Login",
                        onPressed: () => Get.toNamed(LoginScreen.id),
                        type: BUTTONTYPE.outline),
                  ],
                ),
              )),
        ],
      ),
    );
  }
}
