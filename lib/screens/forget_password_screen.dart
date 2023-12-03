import 'package:fare_now_provider/components/buttons-management/part_of_file/part.dart';
import 'package:fare_now_provider/components/buttons-management/style_model.dart';
import 'package:fare_now_provider/components/text_fields/farenow_text_field.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';

import '../controllers/profile_screen_controller/ProfileScreenController.dart';
import '../util/app_colors.dart';

class ForgetPasswordScreen extends StatefulWidget {
  @override
  _ForgetPasswordScreenState createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  TextEditingController _email = TextEditingController();
  TextEditingController _phone = TextEditingController();
  bool _appear = false;
  final _formKey = new GlobalKey<FormState>();
  double numberHeight = 47;
  double confirmNumberHeight = 47;

  ProfileScreenController _controller = Get.put(ProfileScreenController());

  var mobileNode = FocusNode();

  String countryCode = "+1";

  String numberError = "";

  var passwordNode = FocusNode();
  bool isPhone = false;

  @override
  void initState() {
    // if (GetPlatform.isIOS) {
    //   mobileNode = GetFocusNodeOverlay(
    //       child: TopKeyboardUtil(
    //     DoneButtonIos(
    //       label: 'Done',
    //       onSubmitted: () => Get.focusScope!.unfocus(),
    //       platforms: const ['android', 'ios'],
    //     ),
    //   ));
    // }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double w = size.width;
    double h = size.height;
    if (kDebugMode) {
      _phone.text = "6506492638";
      // _email.text = "3338683485";
      // _email.text = "3041628668";
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
                  Expanded(
                    flex: 4,
                    child: Column(
                      children: [
                        Container(
                          alignment: Alignment.centerLeft,
                          width: Get.width,
                          height: 92,
                          child: const Text(
                            "Forgot Password",
                            style: TextStyle(
                                color: AppColors.black,
                                fontSize: 36,
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          width: w,
                          child: const Text(
                            "Enter your email or phone number to reset your account password.",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: Colors.black),
                          ),
                        ),
                        19.height,
                        //todo comment since only reset with email is required
                        // isPhone
                        //     ? Column(
                        //         children: [
                        //           Container(
                        //             alignment: Alignment.centerLeft,
                        //             width: Get.width,
                        //             // height: 92,
                        //             child: const Text(
                        //               "Phone Number",
                        //               style: TextStyle(
                        //                   color: Color(0xff151415),
                        //                   fontSize: 18,
                        //                   fontWeight: FontWeight.w400),
                        //             ),
                        //           ),
                        //           12.height,
                        //           Container(
                        //             width: Get.width,
                        //             // height: 55,
                        //             decoration: BoxDecoration(
                        //                 borderRadius: BorderRadius.circular(12),
                        //                 border: Border.all(
                        //                     color: Color(0xffBDBDBD))),
                        //             child: Row(
                        //               children: [
                        //                 Container(
                        //                   height: 55,
                        //                   // color: white,
                        //                   child: Row(
                        //                     children: [
                        //                       Container(
                        //                           alignment:
                        //                               Alignment.centerRight,
                        //                           child: Text(countryCode),
                        //                           // child: CountryCodePicker(
                        //                           //   onChanged: (value) {
                        //                           //     countryCode =
                        //                           //         value.dialCode!.toString();
                        //                           //     print("$countryCode");
                        //                           //   },
                        //                           //   dialogSize: Size(Get.width * 0.9,
                        //                           //       Get.height * 0.35),
                        //                           //   initialSelection: 'US',
                        //                           //   countryFilter: ["US", "PK", "NG"],
                        //                           //   showFlag: false,
                        //                           //   showCountryOnly: false,
                        //                           //   showOnlyCountryWhenClosed: false,
                        //                           //   alignLeft: true,
                        //                           // ),
                        //                           // width: 30,
                        //                           padding: EdgeInsets.only(
                        //                               left: 16)),
                        //                       Container(
                        //                         height: 30,
                        //                         width: 20,
                        //                         alignment:
                        //                             Alignment.centerRight,
                        //                         // color: Colors.grey.shade400,
                        //                         child:
                        //                             Icon(Icons.arrow_drop_down),
                        //                       ),
                        //                     ],
                        //                   ),
                        //                 ),
                        //                 Expanded(
                        //                     child: Container(
                        //                   width: Get.width,
                        //                   height: 55,
                        //                   child: TextFormField(
                        //                     focusNode: mobileNode,
                        //                     controller: _phone,
                        //                     keyboardType: TextInputType.phone,
                        //                     decoration: InputDecoration(
                        //                       border: OutlineInputBorder(
                        //                           borderSide: BorderSide.none),
                        //                       // fillColor: white,
                        //                       // filled: true,
                        //                       hintText: numberPlaceHolder,
                        //                       hintStyle: TextStyle(
                        //                           color: Colors.grey.shade700),
                        //                     ),
                        //                   ),
                        //                 ))
                        //               ],
                        //             ),
                        //           ),
                        //         ],
                        //       )
                        FarenowTextField(
                          hint: "Enter Email",
                          label: "Email Address",
                          controller: _email,
                          type: TextInputType.emailAddress,
                        ),
                        if (numberError.isNotEmpty)
                          Container(
                            margin: EdgeInsets.only(top: 8),
                            child: Text(
                              numberError,
                              style: TextStyle(color: Colors.red),
                            ),
                            width: Get.width,
                          ),
                        SizedBox(height: 20),
                        // GestureDetector(
                        //   onTap: () {
                        //     FocusScope.of(context).unfocus();
                        //     if (!_formKey.currentState!.validate()) {
                        //       return;
                        //     }
                        //     String number = countryCode + _email.text.toString();
                        //     print(number);
                        //     _controller.forgetPassword(
                        //       number,
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
                        //       "Reset Password",
                        //       style: TextStyle(
                        //           color:
                        //               _appear ? AppColors.white : AppColors.black,
                        //           fontSize: 20),
                        //     ),
                        //   ),
                        // ),
                        FarenowButton(
                            style: FarenowButtonStyleModel(
                                padding: EdgeInsets.zero),
                            title: "Submit",
                            onPressed: () async {
                              //todo added a network check and moved the api call under it
                              var connectivityResult =
                                  await (Connectivity().checkConnectivity());
                              if (connectivityResult ==
                                      ConnectivityResult.mobile ||
                                  connectivityResult ==
                                      ConnectivityResult.wifi) {
                                print(
                                    "connected to a mobile network or wifi network.");
                                //todo comment since only reset with email is required
                                // if (isPhone) {
                                //   FocusScope.of(context).unfocus();
                                //   if (!_formKey.currentState!.validate()) {
                                //     return;
                                //   }
                                //   String number =
                                //       countryCode + _phone.text.toString();
                                //   print(number);
                                //
                                //   if (_phone.text.isNotEmpty) {
                                //     _controller.forgetPassword(number,
                                //         isPhone: isPhone);
                                //   } else {
                                //     numberError = "Field Required";
                                //     setState(() {});
                                //   }
                                // }

                                FocusScope.of(context).unfocus();
                                if (!_formKey.currentState!.validate()) {
                                  return;
                                }
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
                                String number =
                                    _email.text.toString().replaceAll(' ', '');
                                print(number);
                                _controller.forgetPassword(number,
                                    isPhone: isPhone);
                              } else {
                                print(
                                    "not connected to a wifi network or mobile network.");
                                Get.snackbar("No Internet",
                                    "No internet connection.Please, retry after connecting to internet");
                              }
                            },
                            type: BUTTONTYPE.rectangular),
                        10.height,
                        //todo comment since only reset with email is required
                        // Row(
                        //   children: [
                        //     const Text(
                        //       "Reset with registered",
                        //       style: TextStyle(
                        //           color: Color(0xff555555),
                        //           fontSize: 16,
                        //           fontWeight: FontWeight.w400),
                        //     ),
                        //     TextButton(
                        //         onPressed: () {
                        //           setState(() {
                        //             isPhone = !isPhone;
                        //           });
                        //         },
                        //         child: Text(
                        //           !isPhone ? "Phone Number" : "Email",
                        //           style: TextStyle(
                        //               color: Color(0xff0068E1),
                        //               fontSize: 16,
                        //               fontWeight: FontWeight.w400),
                        //         ))
                        //   ],
                        // )
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
                  //               child: InkWell(
                  //                 onTap: () async {
                  //                   var canLaunch = await canLaunchUrl(Uri.parse(
                  //                       "https://www.farenow.com/page/Policy"));
                  //                   if (!await launchUrl(Uri.parse(
                  //                       "https://www.farenow.com/page/Policy"))) {
                  //                     throw 'Could not launch https://www.farenow.com/page/Policy';
                  //                   }
                  //                 },
                  //                 child: Container(
                  //                   alignment: Alignment.centerLeft,
                  //                   width: w,
                  //                   child: Text(
                  //                     "Terms of Use and Privacy",
                  //                     style: TextStyle(
                  //                         fontSize: 14,
                  //                         fontWeight: FontWeight.normal,
                  //                         color: AppColors.blue),
                  //                   ),
                  //                 ),
                  //               ),
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
