import 'dart:async';

import 'package:fare_now_provider/controllers/profile_screen_controller/ProfileScreenController.dart';
import 'package:fare_now_provider/custom_packages/keyboard_overlay/keyboard_overlay.dart';
import 'package:fare_now_provider/screens/auth_screen/login_screen.dart';
import 'package:fare_now_provider/util/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../components/buttons-management/enum/button_type.dart';
import '../../components/buttons-management/farenow_button.dart';
import '../../custom_packages/pin_code_fields/part_of_import.dart';
import '../../util/shared_reference.dart';

class PinCodeVerificationScreen extends StatefulWidget {
  static const id = 'pin_code_verification_screen';
  final phoneNumber;
  final forgetPassword;

  PinCodeVerificationScreen({this.phoneNumber, this.forgetPassword = false});

  @override
  _PinCodeVerificationScreenState createState() =>
      _PinCodeVerificationScreenState();
}

class _PinCodeVerificationScreenState extends State<PinCodeVerificationScreen>
    with HandleFocusNodesOverlayMixin {
  TextEditingController textEditingController = TextEditingController();

  // ..text = "123456";

  // ignore: close_sinks
  StreamController<ErrorAnimationType>? errorController;

  ProfileScreenController controller = Get.find();

  bool hasError = false;
  String currentText = "";
  final formKey = GlobalKey<FormState>();

  var otpNode = FocusNode();

  @override
  void initState() {
    if (GetPlatform.isIOS) {
      otpNode = GetFocusNodeOverlay(
          child: TopKeyboardUtil(
        DoneButtonIos(
          label: 'Done',
          onSubmitted: () => Get.focusScope!.unfocus(),
          platforms: const ['android', 'ios'],
        ),
      ));
    }
    errorController = StreamController<ErrorAnimationType>();
    super.initState();
  }

  @override
  void dispose() {
    errorController!.close();

    super.dispose();
  }

  // snackBar Widget
  snackBar(String message) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  String? mobile;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double w = size.width;

    if (Get.arguments is String) {
      mobile = Get.arguments;
    }
    if (widget.forgetPassword) {
      mobile = widget.phoneNumber;
      print("mobile $mobile");
    }
    final hiderPlaceholder = "****";

    final censuredEmail = mobile
        .toString()
        .replaceRange(1, mobile.toString().indexOf("@") - 1, hiderPlaceholder);
    return Container(
      color: Colors.white,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: white,
          elevation: 0,
          iconTheme: IconTheme.of(context).copyWith(color: black),
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                      alignment: Alignment.center,
                      width: w,
                      child: FittedBox(
                        child: Text(
                          "Enter OTP".toUpperCase(),
                          style: const TextStyle(
                              color: Colors.black,
                              fontSize: 36,
                              fontWeight: FontWeight.w700),
                        ),
                      )),
                  const SizedBox(
                    height: 15,
                  ),
                  Container(
                      alignment: Alignment.center,
                      width: w,
                      child: Text(
                        "We have sent a verification code to your email at ${censuredEmail}", //todo dynamic email instead of static
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Color(0xff555555),
                            fontSize: 16,
                            fontWeight: FontWeight.w400),
                      )),
                  const SizedBox(
                    height: 20,
                  ),
                  Form(
                    key: formKey,
                    child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 30),
                        child: PinCodeTextField(
                          obscuringCharacter: '●e',
                          focusNode: otpNode,
                          textStyle: const TextStyle(
                              color: Colors.white, fontSize: 29),
                          appContext: context,
                          pastedTextStyle: TextStyle(
                            color: Colors.green.shade600,
                            fontWeight: FontWeight.bold,
                          ),
                          length: 4,
                          obscureText: false,
                          blinkWhenObscuring: true,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          animationType: AnimationType.fade,
                          pinTheme: PinTheme(
                            // errorBorderColor: Colors.redAccent,

                            borderRadius: BorderRadius.circular(13),
                            borderWidth: 1,
                            shape: PinCodeFieldShape.box,
                            activeColor: AppColors.solidBlue,
                            selectedColor: AppColors.solidBlue,
                            inactiveColor: const Color(0xffBDBDBD),
                            inactiveFillColor: white,
                            selectedFillColor: AppColors.solidBlue,
                            fieldHeight: 70,
                            fieldWidth: 70,
                            activeFillColor: hasError
                                ? AppColors.solidBlue
                                : AppColors.solidBlue,
                          ),
                          cursorColor: Colors.white,
                          animationDuration: const Duration(milliseconds: 300),
                          enableActiveFill: true,
                          errorAnimationController: errorController,
                          controller: textEditingController,
                          keyboardType: TextInputType.number,
                          boxShadows: const [
                            BoxShadow(
                              offset: Offset(0, 1),
                              color: Colors.black12,
                              blurRadius: 10,
                            )
                          ],
                          onCompleted: (v) {
                            print("Completed");
                          },
                          onChanged: (value) {
                            print(value);
                            setState(() {
                              currentText = value;
                            });
                          },
                          beforeTextPaste: (text) {
                            print("Allowing to paste $text");
                            //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                            //but you can show anything you want here, like your pop up saying wrong paste format or etc
                            return true;
                          },
                        )),
                  ),
                  FarenowButton(
                      title: "Resend Code",
                      onPressed: () {
                        controller.resendOtp(mobile);
                        // mobile = "";
                      },
                      type: BUTTONTYPE.text),
                  hasError
                      ? Center(
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 30.0),
                            child: Text(
                              hasError
                                  ? "*Please fill up all the cells properly"
                                  : "",
                              style: const TextStyle(
                                  color: Colors.red,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                        )
                      : Container(),
                ],
              ),

              FarenowButton(
                  title: "Submit",
                  onPressed: () async{

                    // Get.toNamed(BusinessCredentials.id);
                    // Get.to(Step1());
                    formKey.currentState!.validate();
                    // conditions for validating

                    if (currentText.length != 4 || currentText == "") {
                      errorController!.add(ErrorAnimationType
                          .shake); // Triggering error shake animation
                      setState(() {
                        hasError = true;
                      });
                    } else {
                      if(mobile!.isNotEmpty){
                        await SharedRefrence()
                            .saveString(key: "email", data: mobile.toString());
                      }
                      setState(
                        () {
                          hasError = false;
                          // snackBar("OTP Verified!!");
                          // BottomNavigation.selectedIndex = 3;

                          Map _body = {};
                          if (mobile!.isNotEmpty) {
                            _body = <String, dynamic>{
                              "email": mobile.toString(),
                              "otp": textEditingController.text.toString(),
                              "for_password": widget.forgetPassword
                            };

                            // } else {
                            //   bool flag = widget.forgetPassword;
                            //   var number = getNumber(
                            //       flag, mobile, controller.number.value);
                            //   _body = <String, dynamic>{
                            //     // "phone": controller.number.value,
                            //     "phone": number.toString(),
                            //     "otp": textEditingController.text.toString(),
                            //     "for_password": widget.forgetPassword
                            //   };
                          }

                          controller.otpVerify(
                              body: _body,
                              // phoneOrEmail: widget.phoneNumber,
                              forgetPassword: widget.forgetPassword);
                        },
                      );
                    }
                  },
                  type: BUTTONTYPE.rectangular),
              const SizedBox(
                height: 20,
              ),
              Container(
                alignment: Alignment.centerRight,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Already have an account?",
                      style: TextStyle(
                          color: Color(0xff151415),
                          fontSize: 18,
                          fontWeight: FontWeight.w400),
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.toNamed(LoginScreen.id);
                      },
                      child: const Text(
                        " Login",
                        style: TextStyle(
                            color: AppColors.solidBlue,
                            fontSize: 18,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                  ],
                ),
              )
              // Container(
              //   margin:
              //       const EdgeInsets.symmetric(vertical: 16.0, horizontal: 22),
              //   decoration: BoxDecoration(
              //     color: Color(0xff1B80F5),
              //     borderRadius: BorderRadius.circular(5),
              //   ),
              //   child: ButtonTheme(
              //     height: 50,
              //     child: TextButton(
              //       onPressed: () {
              //         formKey.currentState!.validate();
              //         // conditions for validating

              //         if (currentText.length != 4 || currentText == "") {
              //           errorController!.add(ErrorAnimationType
              //               .shake); // Triggering error shake animation
              //           setState(() {
              //             hasError = true;
              //           });
              //         } else {
              //           setState(
              //             () {
              //               hasError = false;
              //               // snackBar("OTP Verified!!");
              //               // BottomNavigation.selectedIndex = 3;
              //               bool flag = widget.forgetPassword;

              //               var number = getNumber(
              //                   flag, mobile, controller.number.value);
              //               Map _body = <String, dynamic>{
              //                 // "phone": controller.number.value,
              //                 "phone": number.toString(),
              //                 "otp": textEditingController.text.toString(),
              //                 "for_password": widget.forgetPassword
              //               };
              //               controller.otpVerify(
              //                   body: _body,
              //                   forgetPassword: widget.forgetPassword);
              //             },
              //           );
              //         }
              //       },
              //       child: Center(
              //           child: Text(
              //         "Next".toUpperCase(),
              //         style: TextStyle(
              //             color: Colors.white,
              //             fontSize: 18,
              //             fontWeight: FontWeight.bold),
              //       )),
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }

  String getNumber(bool flag, mobile, number) {
    if (flag) {
      return mobile;
    }
    return number;
  }
}
