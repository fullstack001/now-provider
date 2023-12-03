import 'package:fare_now_provider/controllers/profile_screen_controller/ProfileScreenController.dart';
import 'package:fare_now_provider/custom_packages/keyboard_overlay/keyboard_overlay.dart';
import 'package:fare_now_provider/screens/change_password_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SetProfileScreen extends StatefulWidget {
  static const id = 'set_profile_screen';

  SetProfileScreen();

  @override
  _SetProfileScreenState createState() => _SetProfileScreenState();
}

class _SetProfileScreenState extends State<SetProfileScreen>
    with HandleFocusNodesOverlayMixin {
  TextEditingController _email = TextEditingController();
  TextEditingController _phone = TextEditingController();
  TextEditingController _password = TextEditingController();

  ProfileScreenController _controller = Get.find();

  String countryCode = "+92";

  var emailNode = FocusNode();
  var phoneNode = FocusNode();
  var passwordNode = FocusNode();

  String numberError = "";

  String? nameSocial;
  String? emailSocial;
  String? userType;
  String? socialId;
  String? socialType;
  bool init = false;
  bool hidePassword = true;

  void setDoneButton() {
    if (GetPlatform.isIOS) {
      emailNode = GetFocusNodeOverlay(
          child: TopKeyboardUtil(
        DoneButtonIos(
          label: 'Done',
          onSubmitted: () => Get.focusScope!.unfocus(),
          platforms: ['android', 'ios'],
        ),
      ));
      phoneNode = GetFocusNodeOverlay(
          child: TopKeyboardUtil(
        DoneButtonIos(
          label: 'Done',
          onSubmitted: () => Get.focusScope!.unfocus(),
          platforms: ['android', 'ios'],
        ),
      ));
      passwordNode = GetFocusNodeOverlay(
          child: TopKeyboardUtil(
        DoneButtonIos(
          label: 'Done',
          onSubmitted: () => Get.focusScope!.unfocus(),
          platforms: ['android', 'ios'],
        ),
      ));
    }
  }

  @override
  void initState() {
    setDoneButton();
    super.initState();
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

  final _formKey = new GlobalKey<FormState>();
  var argument;

  @override
  Widget build(BuildContext context) {
    // init = false;
    argument = Get.arguments;
    if (argument != null && !init) {
      init = true;
      if (argument is GoogleSignInAccount) {
        print("arguments");
        nameSocial = argument.displayName;
        emailSocial = argument.email;
        userType = "PROVIDER";
        socialId = argument.id;
        socialType = "google";
      } else {
        print("arguments");
        nameSocial = "${argument['first_name']} ${argument['last_name']}";
        emailSocial = argument['email'];
        userType = "PROVIDER";
        socialId = argument['id'];
        socialType = "facebook";
      }

      _email.text = emailSocial!;
    } else if (kDebugMode && argument == null) {
      // _email.text = "developer12@gmail.com";
      // // _phone.text = "+923008383976";
      // _phone.text = "3041628888";
      // // _phone.text = "+923338683301";
      // _password.text = "Abc123123@";
    }

    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          body: ListView(
            children: [
              Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.fromLTRB(15, 12, 15, 27),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Set up your business profile.",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          IconButton(
                              icon: const Icon(
                                Icons.clear,
                                color: Colors.grey,
                              ),
                              onPressed: () {
                                Navigator.pop(context);
                              })
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(15, 0, 40, 0),
                      child: Row(
                        children: [
                          const Expanded(
                            child: Text(
                              "How would you like customers to contact you?",
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(25, 30, 25, 0),
                      child: TextFormField(
                        focusNode: emailNode,
                        onFieldSubmitted: (value) {
                          phoneNode.requestFocus();
                        },
                        textInputAction: TextInputAction.next,
                        validator: (val) {
                          if (val!.isEmpty) {
                            return "Field Empty";
                          } else if (!GetUtils.isEmail(val)) {
                            return "Please valid email address";
                          } else
                            return null;
                        },
                        readOnly: (emailSocial ?? '').isNotEmpty ? true : false,
                        controller: _email,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                            border: const OutlineInputBorder(
                                borderSide: BorderSide.none),
                            fillColor: const Color(0xffF3F4F4),
                            filled: true,
                            hintText: "Email address",
                            hintStyle: TextStyle(color: Colors.grey.shade700),
                            prefixIcon: Icon(Icons.email,
                                size: 30, color: Colors.grey.shade600)),
                      ),
                    ),
                    // Container(
                    //   margin: const EdgeInsets.fromLTRB(25, 30, 25, 0),
                    //   width: Get.width,
                    //   height: 55,
                    //   color: Color(0xffF3F4F4),
                    //   child: Row(
                    //     children: [
                    //       Container(
                    //         height: 55,
                    //         color: Color(0xffF3F4F4),
                    //         child: Row(
                    //           children: [
                    //             Container(
                    //               alignment: Alignment.center,
                    //               child: Text(countryCode),
                    //               // child: CountryCodePicker(
                    //               //   onChanged: (value) {
                    //               //     countryCode = value.dialCode!.toString();
                    //               //     print("$countryCode");
                    //               //   },
                    //               //   dialogSize: Size(
                    //               //       Get.width * 0.9, Get.height * 0.35),
                    //               //   initialSelection: 'US',
                    //               //   countryFilter: ["US", "PK", "NG"],
                    //               //   showFlag: false,
                    //               //   showCountryOnly: false,
                    //               //   showOnlyCountryWhenClosed: false,
                    //               //   alignLeft: true,
                    //               // ),
                    //               width: 77,
                    //             ),
                    //             Container(
                    //               height: 30,
                    //               width: 1,
                    //               color: Colors.grey.shade400,
                    //             ),
                    //           ],
                    //         ),
                    //       ),
                    //       Expanded(
                    //           child: Container(
                    //         width: Get.width,
                    //         height: 55,
                    //         child: TextFormField(
                    //           focusNode: phoneNode,
                    //           onFieldSubmitted: (value) {
                    //             passwordNode.requestFocus();
                    //           },
                    //           controller: _phone,
                    //           keyboardType: TextInputType.phone,
                    //           decoration: InputDecoration(
                    //             border: OutlineInputBorder(
                    //                 borderSide: BorderSide.none),
                    //             fillColor: Color(0xffF3F4F4),
                    //             filled: true,
                    //             hintText: numberPlaceHolder,
                    //             hintStyle:
                    //                 TextStyle(color: Colors.grey.shade700),
                    //           ),
                    //         ),
                    //       ))
                    //     ],
                    //   ),
                    // ),
                    // if (numberError.isNotEmpty)
                    //   Container(
                    //     margin: const EdgeInsets.fromLTRB(25, 8, 25, 0),
                    //     child: Text(
                    //       numberError,
                    //       style: TextStyle(color: Colors.red),
                    //     ),
                    //     width: Get.width,
                    //   ),
                    /*Padding(
                      padding: const EdgeInsets.fromLTRB(25, 30, 25, 0),
                      child: TextFormField(
                        focusNode: phoneNode,
                        onFieldSubmitted: (value){
                          passwordNode.requestFocus();
                        },
                        textInputAction: TextInputAction.next,
                        validator: (val) {
                          if (val!.isEmpty) {
                            return "Field Empty";
                          } else if (!GetUtils.isPhoneNumber(val)) {
                            return "Please enter valid phone number";
                          } else
                            return null;
                        },
                        controller: _phone,
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                            border:
                                OutlineInputBorder(borderSide: BorderSide.none),
                            fillColor: Color(0xffF3F4F4),
                            filled: true,
                            hintText: numberPlaceHolder,
                            hintStyle: TextStyle(color: Colors.grey.shade700),
                            prefixIcon: Icon(Icons.lock,
                                size: 30, color: Colors.grey.shade600)),
                      ),
                    ),*/
                    Padding(
                      padding: const EdgeInsets.fromLTRB(25, 30, 40, 0),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Checkbox(
                                value: true,
                                onChanged: (val) {},
                              ),
                              Text(
                                'Enable text messages',
                                style: TextStyle(
                                    fontSize: 16, color: Colors.grey.shade700),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 15.0),
                            child: Text(
                              '\t\t\t\t\t',
                              style: TextStyle(
                                  fontSize: 16, color: Colors.grey.shade700),
                            ),
                          ),
                        ],
                      ),
                    ),
                    if ((emailSocial ?? '').isEmpty)
                      Padding(
                        padding: const EdgeInsets.fromLTRB(25, 30, 25, 0),
                        child: TextFormField(
                          focusNode: passwordNode,
                          onFieldSubmitted: (value) {
                            Get.focusScope!.unfocus();
                          },
                          textInputAction: TextInputAction.done,
                          validator: (val) {
                            if (val!.isEmpty) {
                              return "Field Empty";
                            } else if (validNumber(val) != "valid") {
                              return validNumber(val);
                            }
                          },
                          controller: _password,
                          obscureText: hidePassword,
                          keyboardType: TextInputType.emailAddress,
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
                              border: const OutlineInputBorder(
                                  borderSide: BorderSide.none),
                              fillColor: const Color(0xffF3F4F4),
                              filled: true,
                              hintText: "Password",
                              hintStyle: TextStyle(color: Colors.grey.shade700),
                              prefixIcon: Icon(Icons.vpn_key,
                                  size: 30, color: Colors.grey.shade600)),
                        ),
                      ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(25, 30, 75, 2),
                      child: Row(
                        children: [
                          const Expanded(
                            child: Text(
                              "By tapping Continue with Facebook or Continue with Google, you agree to the",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(25, 0, 25, 30),
                      child: Row(
                        children: [
                          const Text(
                            "Term of Use and Privacy Policy",
                            style: TextStyle(
                              color: Color(0xff1B80F5),
                              fontSize: 12,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(
                          vertical: 16, horizontal: 22),
                      decoration: BoxDecoration(
                        color: const Color(0xff1B80F5),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: ButtonTheme(
                        height: 50,
                        child: TextButton(
                          onPressed: () async {
                            print("tapped");
                            Get.focusScope!.unfocus();
                            if (!_formKey.currentState!.validate()) {
                              return;
                            }
                            String email = _email.text.toString();
                            String password = _password.text.toString();
                            String phone = countryCode + _phone.text.toString();
                            print("email ${_email.text.toString()}");
                            // print("password ${_password.text.toString()}");
                            // if (_phone.text.isEmpty) {
                            //   numberError = "field required";
                            //   setState(() {});
                            //   return;}
                            // } else if (!phone.isPhoneNumber) {
                            //   numberError = "Please enter valid phone number";
                            //   setState(() {});
                            //   return;
                            // }
                            // numberError = "";
                            // setState(() {});

                            if (argument != null) {
                              Map _body = <String, String>{
                                "name": nameSocial!,
                                "email": emailSocial!,
                                "phone": _phone.text,
                                "social_id": socialId!,
                                "social_type": socialType!,
                                "user_type": userType!,
                              };

                              _controller.socialSignUp(_body);
                            } else {
                              Map _body = <dynamic, dynamic>{
                                "email": email,
                                "password": "password",
                                "phone": phone
                              };

                              _controller.verifyUser(_body);
                            }
                          },
                          child: const Center(
                              child: Text(
                            "Next",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          )),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
