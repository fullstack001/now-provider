import 'package:fare_now_provider/controllers/profile_screen_controller/ProfileScreenController.dart';
import 'package:fare_now_provider/controllers/auth_controller/social_network.dart';
import 'package:fare_now_provider/custom_packages/keyboard_overlay/keyboard_overlay.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_svg/svg.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:nb_utils/nb_utils.dart';
import '../../components/buttons-management/part_of_file/part.dart';
import '../../components/text_fields/farenow_text_field.dart';
import '../../util/app_colors.dart';
import '../forget_password_screen.dart';
import 'signup_screen.dart';
import 'socail_network_widget.dart';
import 'dart:io';

var numberPlaceHolder = "xxx xxx xxxx";

class LoginScreen extends StatefulWidget {
  static const id = 'login_screen';

  const LoginScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();

  var _formKey = GlobalKey<FormState>();

  ProfileScreenController _controller = Get.find();

  String countryCode = "";

  String numberError = "";
  bool hidePassword = true;

  @override
  Widget build(BuildContext context) {
    if (!kDebugMode) {
      // is Release Mode ??
    } else {
      print('debug mode');
      // _email.text = "3041628668";

      // _email.text = "fesed94535@chnlog.com";
      // _email.text = "testing@gmail.com";
      _email.text = "";
      // _email.text = "aurangzaibrana1@gmail.com";

      _password.text = "";
    }

    return Form(
        key: _formKey,
        child: Container(
          color: Colors.white,
          child: Scaffold(
              backgroundColor: white,
              appBar: AppBar(
                backgroundColor: white,
                iconTheme: IconTheme.of(context).copyWith(color: black),
                elevation: 0,
              ),
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    20.height,
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Column(
                        children: [
                          const Text(
                            "Log in to your Farenow Account",
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 35,
                            ),
                          ),
                          20.height,
                          FarenowTextField(
                            label: "Enter Email",
                            controller: _email,
                            hint: "Enter your email",
                            onValidation:  ( value) {
                              if (value!.isEmpty) {
                                return "Field required*";
                              }
                              return null;
                            },
                            type: TextInputType.emailAddress,
                          ),
                          if (numberError.isNotEmpty)
                            Container(
                              margin: const EdgeInsets.only(top: 8),
                              width: Get.width,
                              child: Text(
                                numberError,
                                style: const TextStyle(color: Colors.red),
                              ),
                            ),
                          30.height,
                          FarenowTextField(
                            label: "Enter Password",
                            controller: _password,
                            hint: "Enter your password",
                            onValidation:  ( value) {
                              if (value!.isEmpty) {
                                return "Field required*";
                              }
                              return null;
                            },
                            onSubmit: (v) async {
                              var connectivityResult =
                                  await (Connectivity().checkConnectivity());
                              if (connectivityResult ==
                                      ConnectivityResult.mobile ||
                                  connectivityResult ==
                                      ConnectivityResult.wifi) {
                                if (kDebugMode)
                                  print(
                                      "connected to a mobile network or wifi network.");
                                Get.focusScope!.unfocus();
                                if (!_formKey.currentState!.validate()) {
                                  return;
                                }
                                String number = countryCode +
                                    _email.text.replaceAll(' ', '');
                                if (_email.text.isEmpty) {
                                  numberError = "field required";
                                  setState(() {});
                                  return;
                                } else if (!GetUtils.isEmail(
                                    _email.text.replaceAll(' ', ''))) {
                                  numberError = "Invalid email";
                                  setState(() {});
                                  return;
                                }
                                numberError = "";
                                setState(() {});
                                // else if (!number.isPhoneNumber) {
                                //   numberError = "Please enter valid phone number";
                                //   setState(() {});
                                //   return;
                                // }
                                Map body = <String, String>{
                                  "password": _password.text.toString(),
                                  "user_name": number,
                                };
                                _controller.login(body);
                              } else {
                                if (kDebugMode)
                                  print(
                                      "not connected to a wifi network or mobile network.");
                                Get.snackbar("No Internet",
                                    "No internet connection.Please, retry after connecting to internet");
                              }
                            },
                            isPassword: true,
                            type: TextInputType.visiblePassword,

                          ),
                        ],
                      ),
                    ),
                    // TextFormField(
                    //   focusNode: passwordNode,
                    //   onFieldSubmitted: (value) {
                    //     Get.focusScope!.unfocus();
                    //   },
                    //   textInputAction: TextInputAction.done,
                    //   obscureText: hidePassword,
                    //   validator: (val) {
                    //     if (val!.isEmpty) {
                    //       return "Field Empty";
                    //     } else if (validNumber(val) != "valid") {
                    //       return validNumber(val);
                    //     }
                    //     return null;
                    //   },
                    //   controller: _password,
                    //   keyboardType: TextInputType.emailAddress,
                    //   decoration: InputDecoration(
                    //       suffixIcon: InkWell(
                    //         onTap: () {
                    //           hidePassword = !hidePassword;
                    //           setState(() {});
                    //         },
                    //         child: Icon(hidePassword
                    //             ? Icons.remove_red_eye_outlined
                    //             : Icons.visibility_off_outlined),
                    //       ),
                    //       border: const OutlineInputBorder(
                    //           borderSide: BorderSide.none),
                    //       fillColor: const Color(0xffF3F4F4),
                    //       filled: true,
                    //       hintText: "Password",
                    //       hintStyle: TextStyle(color: Colors.grey.shade700),
                    //       prefixIcon: Icon(Icons.lock,
                    //           size: 30, color: Colors.grey.shade600)),
                    // ),

                    FarenowButton(
                        title:
                            "Forgot password", //todo changed text from forget to forgot
                        onPressed: () => Get.to(() => ForgetPasswordScreen()),
                        type: BUTTONTYPE.text),

                    FarenowButton(
                        title: "Login",
                        onPressed: () async {
                          //todo added a network check and moved the api call under it & added an email validity check so if the email format is not correct it does not result in internal server error instead lets the user know they typed an invalid email
                          var connectivityResult =
                              await (Connectivity().checkConnectivity());
                          if (connectivityResult == ConnectivityResult.mobile ||
                              connectivityResult == ConnectivityResult.wifi) {
                            if (kDebugMode)
                              print(
                                  "connected to a mobile network or wifi network.");
                            Get.focusScope!.unfocus();
                            if (!_formKey.currentState!.validate()) {
                              return;
                            }
                            String number =
                                countryCode + _email.text.replaceAll(' ', '');
                            if (_email.text.isEmpty) {
                              numberError = "field required";
                              setState(() {});
                              return;
                            } else if (!GetUtils.isEmail(
                                _email.text.replaceAll(' ', ''))) {
                              numberError = "Invalid email";
                              setState(() {});
                              return;
                            }
                            numberError = "";
                            setState(() {});
                            // else if (!number.isPhoneNumber) {
                            //   numberError = "Please enter valid phone number";
                            //   setState(() {});
                            //   return;
                            // }
                            Map body = <String, String>{
                              "password": _password.text.toString(),
                              "user_name": number,
                            };
                            _controller.login(body);
                          } else {
                            if (kDebugMode)
                              print(
                                  "not connected to a wifi network or mobile network.");
                            Get.snackbar("No Internet",
                                "No internet connection.Please, retry after connecting to internet");
                          }
                        },
                        type: BUTTONTYPE.rectangular),
                    20.height,
                    Container(
                      width: Get.width,
                      alignment: Alignment.center,
                      child: const Text(
                        "or continue with",
                        style: TextStyle(
                            color: Color(0xff555555),
                            fontSize: 18,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                    20.height,
                    const FittedBox(child: FarenowSocialNetworkScreen()),
                    20.height,

                    Container(
                      alignment: Alignment.center,
                      child: FittedBox(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Don't have an account?",
                              style: TextStyle(
                                  color: Color(0xff151415),
                                  fontSize: 18,
                                  fontWeight: FontWeight.w400),
                            ),
                            GestureDetector(
                              onTap: () {
                                Get.toNamed(SignupScreen.id);
                              },
                              child: const Text(
                                " Sign Up",
                                style: TextStyle(
                                    color: AppColors.solidBlue,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              )),
        ));
  }
}
