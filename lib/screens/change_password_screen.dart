import 'package:fare_now_provider/components/buttons-management/part_of_file/part.dart';
import 'package:fare_now_provider/components/buttons-management/style_model.dart';
import 'package:fare_now_provider/components/text_fields/farenow_text_field.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';

import '../controllers/profile_screen_controller/ProfileScreenController.dart';
import '../custom_packages/keyboard_overlay/src/components/done_button_ios.dart';
import '../custom_packages/keyboard_overlay/src/components/utils/top_keyboard_util.dart';
import '../custom_packages/keyboard_overlay/src/handle_focus_nodes_overlay_mixin.dart';
import '../util/app_colors.dart';

class ChangePasswordScreen extends StatefulWidget {
  final token;
  final userNumber;

  ChangePasswordScreen({
    Key? key,
    this.token,
    this.userNumber,
  }) : super(key: key);

  @override
  _ChangePasswordScreenState createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen>
    with HandleFocusNodesOverlayMixin {
  TextEditingController _password = TextEditingController();
  TextEditingController _confirmPassword = TextEditingController();
  bool _appear = false;
  bool hidePassword = true;
  bool hidePasswordConfirm = true;
  final _formKey = new GlobalKey<FormState>();
  double numberHeight = 47;
  double ConfirmNumberHeight = 47;

  ProfileScreenController _controller = Get.find();

  var password = FocusNode();
  var confirmPassword = FocusNode();

  @override
  void initState() {
    if (GetPlatform.isIOS) {
      password = GetFocusNodeOverlay(
          child: TopKeyboardUtil(
        DoneButtonIos(
          label: 'Done',
          onSubmitted: () => Get.focusScope!.unfocus(),
          platforms: ['android', 'ios'],
        ),
      ));
      confirmPassword = GetFocusNodeOverlay(
          child: TopKeyboardUtil(
        DoneButtonIos(
          label: 'Done',
          onSubmitted: () => Get.focusScope!.unfocus(),
          platforms: ['android', 'ios'],
        ),
      ));
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double w = size.width;
    double h = size.height;
    if (kDebugMode) {
      // _password.text = "Abc12312@";
      // _confirmPassword.text = "Abc12312@";
      // _password.text = "";
    }
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        iconTheme: IconTheme.of(context).copyWith(color: black),
        backgroundColor: white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: IntrinsicHeight(
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    alignment: Alignment.bottomCenter,
                    child: Column(
                      children: [
                        20.height,
                        Container(
                          alignment: Alignment.centerLeft,
                          child: const Text(
                            "Change Password",
                            style: TextStyle(
                                color: AppColors.black,
                                fontSize: 38,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        10.height,
                        Container(
                          alignment: Alignment.centerLeft,
                          child: const Text(
                            "Enter your email or phone number to reset your account password.",
                            style: TextStyle(
                                color: AppColors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                        30.height,

                        Container(
                          alignment: Alignment.centerLeft,
                          child: const Text(
                            "Password",
                            style: TextStyle(
                                color: AppColors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                        10.height,
                        TextFormField(
                          textInputAction: TextInputAction.next,
                          onFieldSubmitted: (value) {
                            confirmPassword.requestFocus();
                          },
                          focusNode: password,
                          validator: (val) {
                            if (val!.isEmpty) {
                              setState(() {
                                numberHeight = 67;
                              });
                              return "Field Empty";
                            } else if (validNumber(val) != "valid") {
                              setState(() {
                                numberHeight = 97;
                              });
                              return validNumber(val);
                            } else {
                              setState(() {
                                numberHeight = 47;
                              });
                            }
                            return null;
                          },
                          controller: _password,
                          onChanged: (val) {
                            print(val);
                            if (val.isNotEmpty) {
                              setState(() {
                                _appear = true;
                              });
                            } else {
                              setState(() {
                                _appear = false;
                              });
                            }
                          },
                          obscureText: hidePassword,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                              suffixIcon: InkWell(
                                onTap: () {
                                  hidePassword = !hidePassword;
                                  setState(() {});
                                },
                                child: Icon(hidePassword
                                    ? Icons.remove_red_eye_outlined
                                    : Icons.visibility_off_outlined),
                              ),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(18),
                                  borderSide:
                                      BorderSide(color: Color(0xffBDBDBD))),
                              fillColor: AppColors.white,
                              filled: true,
                              hintText: "Enter your password",
                              hintStyle: TextStyle(
                                fontSize: 16,
                              ),
                              // prefixIcon: Icon(Icons.phone_android,
                              //     size: 24, color: Colors.grey),
                              contentPadding: EdgeInsets.all(8)),
                        ),
                        20.height,
                        Container(
                          alignment: Alignment.centerLeft,
                          child: const Text(
                            "Confirm Password",
                            style: TextStyle(
                                color: AppColors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                        10.height,
                        TextFormField(
                          textInputAction: TextInputAction.done,
                          focusNode: confirmPassword,
                          validator: (val) {
                            String password = _password.text.toString();
                            String confirmPassword =
                                _confirmPassword.text.toString();

                            if (val!.isEmpty) {
                              setState(() {
                                ConfirmNumberHeight = 67;
                              });
                              return "Field Empty";
                            } else if (password != confirmPassword) {
                              setState(() {
                                ConfirmNumberHeight = 67;
                              });
                              return "Password and Conform Password not matched";
                            } else if (validNumber(val) != "valid") {
                              setState(() {
                                ConfirmNumberHeight = 97;
                              });
                              return validNumber(val);
                            } else {
                              setState(() {
                                ConfirmNumberHeight = 47;
                              });
                            }
                            return null;
                          },
                          controller: _confirmPassword,
                          onChanged: (val) {
                            print(val);
                            if (val.isNotEmpty) {
                              setState(() {
                                _appear = true;
                              });
                            } else {
                              setState(() {
                                _appear = false;
                              });
                            }
                          },
                          obscureText: hidePasswordConfirm,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                              suffixIcon: InkWell(
                                onTap: () {
                                  hidePasswordConfirm = !hidePasswordConfirm;
                                  setState(() {});
                                },
                                child: Icon(hidePasswordConfirm
                                    ? Icons.remove_red_eye_outlined
                                    : Icons.visibility_off_outlined),
                              ),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(18),
                                  borderSide:
                                      BorderSide(color: Color(0xffBDBDBD))),
                              fillColor: AppColors.white,
                              filled: true,
                              hintText: "Confirm Password",
                              hintStyle: TextStyle(
                                fontSize: 16,
                              ),
                              // prefixIcon: Icon(Icons.phone_android,
                              //     size: 24, color: Colors.grey),
                              contentPadding: EdgeInsets.all(8)),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        FarenowButton(
                            style: FarenowButtonStyleModel(
                                padding: EdgeInsets.zero),
                            title: "Submit",
                            onPressed: () {
                              FocusScope.of(context).unfocus();
                              if (!_formKey.currentState!.validate()) {
                                return;
                              }
                              String password = _password.text.toString();
                              String confirmPassword =
                                  _confirmPassword.text.toString();
                              print(password);
                              print(confirmPassword);
                              print(widget.userNumber);
                              print(widget.token);
                              _controller.changePassword(
                                password,
                                confirmPassword,
                                widget.userNumber,
                                widget.token,
                              );
                            },
                            type: BUTTONTYPE.rectangular),
                        // GestureDetector(
                        //   onTap: () {
                        //     FocusScope.of(context).unfocus();
                        //     if (!_formKey.currentState!.validate()) {
                        //       return;
                        //     }
                        //     String password = _password.text.toString();
                        //     String confirmPassword =
                        //         _confirmPassword.text.toString();
                        //     _controller.changePassword(
                        //       password,
                        //       confirmPassword,
                        //       widget.userNumber,
                        //       widget.token,
                        //     );
                        //     // Get.to(PinCodeVerificationScreen("123456"));
                        //   },
                        //   child: Container(
                        //     decoration: BoxDecoration(
                        //         color: _appear ? AppColors.green : AppColors.grey,
                        //         borderRadius: BorderRadius.circular(8)),
                        //     alignment: Alignment.center,
                        //     width: w,
                        //     height: 47,
                        //     child: Text(
                        //       "Submit",
                        //       style: TextStyle(
                        //           color:
                        //               _appear ? AppColors.white : AppColors.black,
                        //           fontSize: 20),
                        //     ),
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                  // Expanded(
                  //   child: Container(
                  //       width: w / 1.16,
                  //       height: h * 0.186,
                  //       child: Column(
                  //           mainAxisAlignment: MainAxisAlignment.end,
                  //           crossAxisAlignment: CrossAxisAlignment.end,
                  //           children: [
                  //             Container(
                  //               alignment: Alignment.centerLeft,
                  //               width: w,
                  //               child: Text(
                  //                 "By tapping Continue with Facebook or Continue with Google, you agree to the",
                  //                 style: TextStyle(
                  //                     fontSize: 14,
                  //                     fontWeight: FontWeight.normal,
                  //                     color: Colors.black),
                  //               ),
                  //             ),
                  //             SizedBox(
                  //               height: 10,
                  //             ),
                  //             GestureDetector(
                  //               child: Container(
                  //                 alignment: Alignment.centerLeft,
                  //                 width: w,
                  //                 child: Text(
                  //                   "Terms of Use and Privacy",
                  //                   style: TextStyle(
                  //                       fontSize: 14,
                  //                       fontWeight: FontWeight.normal,
                  //                       color: AppColors.blue),
                  //                 ),
                  //               ),
                  //             ),
                  //             SizedBox(
                  //               height: 10,
                  //             ),
                  //           ])),
                  // ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

validNumber(val) {
  RegExp regex =
      RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
  if (!regex.hasMatch(val)) {
    return "Your password must be at least 8 characters long,\ncontain at least one number and have a\nmixture of uppercase and lowercase letters.";
  }
  return "valid";
}
