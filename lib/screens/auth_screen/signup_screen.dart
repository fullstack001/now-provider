import 'dart:convert';

import 'package:fare_now_provider/controllers/auth_controller/social_network.dart';
import 'package:fare_now_provider/util/shared_reference.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../components/buttons-management/part_of_file/part.dart';
import '../../components/text_fields/farenow_text_field.dart';
import '../../controllers/profile_screen_controller/ProfileScreenController.dart';
import '../../util/api_utils.dart';
import '../../util/app_colors.dart';
import 'login_screen.dart';
import 'socail_network_widget.dart';

class SignupScreen extends StatefulWidget {
  static const id = 'signup_screen';
  String? userCountryIso2Code;
  SignupScreen({Key? key, required this.userCountryIso2Code}) : super(key: key);
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final SocialNetwork _socialNetwork = Get.put(SocialNetwork());
  final TextEditingController _email = TextEditingController();
  // final TextEditingController _phone = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final ProfileScreenController _controller = Get.find();
  SharedRefrence prefs = SharedRefrence();
  final _formKey = GlobalKey<FormState>();
  var argument;
  String countryCode = "";

  String numberError = "";
  String? userCountryIso2Code;
  String? findCurrencyCode;
  String? findCountryId;
  String? nameSocial;
  String? emailSocial;
  String? userType;
  String? socialId;
  String? socialType;
  bool init = false;
  bool hidePassword = true;

  dynamic getALlData;
  dynamic myCountryValue;
  List<String> iso2List = [];
  List<String> countryNameList = [];
  List<String> countryCurrency = [];
  List<String> countryId = [];
  String? findIso2code;
  String? countriesId;

  Future<String?> socialForCountryId(String? c) async {
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
        // findIso2code = "NG";
      }
      if (countryIdValues.contains(c)) {
        findCountryId = countryIdMap[c]!;
      } else {
        var defaultCountry =
            jsonData.firstWhere((country) => country['is_default'] == true);
        findCountryId = defaultCountry["id"].toString();
        // findCountryId = "161";
      }

      return findCountryId;
    } else {
      return "";
    }
  }

  Future<void> fetchAndStoreCountryIdWithRetry(String? countryIso2Code) async {
    int maxRetries = 3;
    int retryCount = 0;

    while (retryCount < maxRetries) {
      try {
        final countryId = await socialForCountryId(countryIso2Code);

        findCountryId = countryId;
        break;
      } catch (exception) {
        Logger().e(exception);
        retryCount++;
        await Future.delayed(Duration(seconds: 2));
      }
    }
  }

  @override
  void initState() {
    userCountryIso2Code = widget.userCountryIso2Code;

    if (userCountryIso2Code != null && userCountryIso2Code!.isNotEmpty) {
      fetchAndStoreCountryIdWithRetry(userCountryIso2Code!);
    }

    SharedRefrence().getIsocode(key: "IsoCode").then((userCountryIso2Code) {
      _controller
          .fetchDataForCountryId(userCountryIso2Code ?? "")
          .then((value) {
        findCountryId = value ?? "";
        SharedRefrence().saveCountryId(key: "countryId", data: findCountryId);
      });
    });

    //userCountryIso2Code= widget.userCountryIsoCode??"";

    super.initState();
  }

  /*void didChangeDependencies()async {
    userCountryIso2Code=await SharedRefrence().getIsocode(key: "IsoCode" );
    //userCountryIso2Code= widget.userCountryIsoCode??"";
    _controller.fetchDataForCountryId(userCountryIso2Code??"").then((value){
      findCountryId = value??"";
      print ("I got the Country Id ======$findCountryId");
    });
    super.didChangeDependencies();
  }*/
  String? validNumber(String? val) {
    if (val == null || val.isEmpty) {
      return "Field Empty";
    }

    RegExp regex =
        RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
    if (!regex.hasMatch(val)) {
      return "Your password must be at least 8 characters long,\ncontain at least one number and special characters and \nhave a mixture of uppercase and lowercase letters.";
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    argument = Get.arguments;
    if (argument != null && !init) {
      init = true;
      if (argument is GoogleSignInAccount) {
        nameSocial = argument.displayName;
        emailSocial = argument.email;
        userType = "PROVIDER";
        socialId = argument.id;
        socialType = "google";
      } else if (argument is Map<String, dynamic>) {
        nameSocial =
            "${argument['first_name'] ?? ''} ${argument['last_name'] ?? ''}";
        emailSocial = argument['email'];
        userType = "PROVIDER";
        socialId = argument['id'];
        socialType = "facebook";
      }
      _email.text = emailSocial ?? '';
    } else if (kDebugMode && argument == null) {
      _email.text = '';
      _password.text = '';
    }
    /*  argument = Get.arguments;
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
         nameSocial =  "${argument['first_name']} ${argument['last_name']}";
         emailSocial = argument['email'];
        userType = "PROVIDER";
        socialId = argument['id'];
        socialType = "facebook";
      }

      _email.text = emailSocial!;
    } else if (kDebugMode && argument == null) {
      _email.text = "";
      // // _phone.text = "+923008383976";
      // _phone.text = "3041628888";
      // // _phone.text = "+923338683301";
      _password.text = "Abc1234@";
    }*/
    return Scaffold(
      appBar: AppBar(
        backgroundColor: white,
        elevation: 0,
        iconTheme: IconTheme.of(context).copyWith(color: black),
      ),
      backgroundColor: Colors.white,
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              40.height,
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const FittedBox(
                      child: Text(
                        "Create your account",
                        style: TextStyle(
                            fontWeight: FontWeight.w700, fontSize: 32),
                      ),
                    ),
                    40.height,
                    FarenowTextField(
                      label: "Enter Address",
                      controller: _email,
                      type: TextInputType.emailAddress,
                      hint: "Enter your email address",
                      onValidation: (value) {
                        if (value!.isEmpty) {
                          return "Field required*";
                        }
                        return null;
                      },
                    ),
                    // if (numberError.isNotEmpty)
                    //   Container(
                    //     margin: const EdgeInsets.only(top: 8),
                    //     width: Get.width,
                    //     child: Text(
                    //       numberError,
                    //       style: const TextStyle(color: Colors.red),
                    //     ),
                    //   ),
                    10.height,
                    FarenowTextField(
                      label: "Password",
                      controller: _password,
                      hint: "Enter your password",
                      onSubmit: (String? value) {
                        Get.focusScope!.unfocus();
                        if (_formKey.currentState!.validate()) {
                          String email = _email.text.toString();
                          String password = _password.text.toString();
                          // if (argument != null) {
                          //   Map _body = <String, String>{
                          //     "name": nameSocial.toString(),
                          //     "email": emailSocial!,
                          //     // "phone": _phone.text,
                          //     "social_id": socialId!,
                          //     "social_type": socialType!,
                          //     "user_type": userType!,
                          //   };
                          //   _controller.socialSignUp(_body);
                          // } else {
                          Map _body = <dynamic, dynamic>{
                            "email": email,
                            "password": password,
                            "country_id": findCountryId.toString()
                          };

                          _controller.verifyUser(_body);
                          // }
                        }

                        setState(() {});
                      },
                      inputAction: TextInputAction.done,
                      /*onValidation:  ( value) {
                        if (value!.isEmpty) {
                          return "Field required*";
                        }
                        return null;
                      },*/
                      onValidation: (val) {
                        if (val!.isEmpty) {
                          return "Field Empty";
                        } else if (validNumber(val) != "valid") {
                          return validNumber(val);
                        }
                      },
                      isPassword: true,
                      type: TextInputType.visiblePassword,
                    ),
                  ],
                ),
              ),
              FarenowButton(
                  title: "Submit",
                  onPressed: () async {
                    Get.focusScope!.unfocus();
                    if (_formKey.currentState!.validate()) {
                      String email = _email.text.toString();
                      String password = _password.text.toString();
                      // if (argument != null) {
                      //   Map _body = <String, String>{
                      //     "name": nameSocial.toString(),
                      //     "email": emailSocial.toString(),
                      //     // "phone": _phone.text,
                      //     "social_id": socialId.toString(),
                      //     //"social_id": socialId!,
                      //     "social_type": socialType!,
                      //     "user_type": userType!,
                      //   };
                      //   _controller.socialSignUp(_body);
                      // } else {
                      Map _body = <String, String>{
                        "email": email,
                        "password": password,
                        "country_id": findCountryId.toString()
                      };
                      await _controller.verifyUser(_body);
                      // }
                    }

                    setState(() {});
                  },
                  type: BUTTONTYPE.rectangular),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 34, vertical: 12),
                child: Row(
                  children: [
                    Expanded(
                      child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(children: [
                          const TextSpan(
                              text:
                                  "By clicking submit, you affirm you have read and agree to the Farenow ",
                              style: TextStyle(
                                  color: black,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14)),
                          TextSpan(
                              text: "Terms of Use and Privacy",
                              recognizer: TapGestureRecognizer()
                                ..onTap = () async {
                                  await canLaunchUrl(Uri.parse(
                                      "https://www.farenow.com/page/Policy"));
                                  if (!await launchUrl(Uri.parse(
                                      "https://www.farenow.com/page/Policy"))) {
                                    throw 'Could not launch https://www.farenow.com/page/Policy';
                                  }
                                },
                              style: const TextStyle(
                                  color: AppColors.solidBlue,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400))
                        ]),
                      ),
                    ),
                  ],
                ),
              ),
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
              30.height,
              const FittedBox(child: FarenowSocialNetworkScreen()),
              30.height,
              Container(
                alignment: Alignment.center,
                child: FittedBox(
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
                          Get.toNamed(LoginScreen.id); //todo get to login
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
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _launchUrl(url) async {
    if (!await launchUrl(url)) throw 'Could not launch $url';
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
}
/*
import 'package:country_code_picker/country_code_picker.dart';
import 'package:fare_now_provider/controllers/auth_controller/social_network.dart';
import 'package:fare_now_provider/screens/auth_screen/pin_verification_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../components/buttons-management/part_of_file/part.dart';
import '../../controllers/profile_screen_controller/ProfileScreenController.dart';
import '../../custom_packages/keyboard_overlay/src/components/done_button_ios.dart';
import '../../custom_packages/keyboard_overlay/src/components/utils/top_keyboard_util.dart';
import '../../custom_packages/keyboard_overlay/src/handle_focus_nodes_overlay_mixin.dart';
import '../../components/text_fields/farenow_text_field.dart';
import '../../util/app_colors.dart';

import 'login_screen.dart';
import 'socail_network_widget.dart';

class SignupScreen extends StatefulWidget {
  static const id = 'signup_screen';

  String? userCountryIsoCode;
  SignupScreen({Key? key, required this.userCountryIsoCode})
      : super(key: key);



  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final SocialNetwork _socialNetwork = Get.put(SocialNetwork());
  final TextEditingController _email = TextEditingController();
  // final TextEditingController _phone = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final ProfileScreenController _controller = Get.find();
  final _formKey = GlobalKey<FormState>();
  var argument;
  String countryCode = "+92";

  String numberError = "";
  String nigeria= "NG";

  String? nameSocial;
  String? emailSocial;
  String? userType;
  String? socialId;
  String? socialType;
  bool init = false;
  bool hidePassword = true;
  dynamic dialCode;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
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
      _email.text = "";
      // // _phone.text = "+923008383976";
      // _phone.text = "3041628888";
      // // _phone.text = "+923338683301";
      //_password.text = "Abc1234@";
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: white,
        elevation: 0,
        iconTheme: IconTheme.of(context).copyWith(color: black),
      ),
      backgroundColor: Colors.white,
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              40.height,
              Padding(
                padding:
                const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const FittedBox(
                      child: Text(
                        "Create your account",
                        style: TextStyle(
                            fontWeight: FontWeight.w700, fontSize: 32),
                      ),
                    ),
                    40.height,
                    FarenowTextField(
                      label: "Enter Address",
                      controller: _email,
                      type: TextInputType.emailAddress,
                      hint: "Enter your email address",
                    ),
                    // if (numberError.isNotEmpty)
                    //   Container(
                    //     margin: const EdgeInsets.only(top: 8),
                    //     width: Get.width,
                    //     child: Text(
                    //       numberError,
                    //       style: const TextStyle(color: Colors.red),
                    //     ),
                    //   ),
                    10.height,
                    FarenowTextField(
                      label: "Password",
                      controller: _password,
                      hint: "Enter your password",
                      onSubmit: (String? value) {
                        Get.focusScope!.unfocus();
                        if (_formKey.currentState!.validate()) {
                          String email = _email.text.toString();
                          String password = _password.text.toString();
                          if (argument != null) {
                            Map _body = <String, String>{
                              "name": nameSocial!,
                              "email": emailSocial!,
                              // "phone": _phone.text,
                              "social_id": socialId!,
                              "social_type": socialType!,
                              "user_type": userType!,
                            };
                            _controller.socialSignUp(_body);
                          } else {
                            Map _body = <String, String>{
                              "email": email,
                              "password": password,
                            };
                            _controller.verifyUser(_body);
                          }
                        }

                        setState(() {});
                      },
                      inputAction: TextInputAction.done,
                      onValidation: (String? val) {
                        if (val!.isNotEmpty) {
                          if (val!.length < 8) {
                            return "Password must contain 8 characters long";
                          }
                        } else {
                          return "Feild required";
                        }
                      },
                      isPassword: true,
                      type: TextInputType.visiblePassword,
                    ),
                  ],
                ),
              ),
              FarenowButton(
                  title: "Submit",
                  onPressed: () {
                    Get.focusScope!.unfocus();
                    if (_formKey.currentState!.validate()) {
                      String email = _email.text.toString();
                      String password = _password.text.toString();
                      if (argument != null) {
                        Map _body = <String, String>{
                          "name": nameSocial!,
                          "email": emailSocial!,
                          // "phone": _phone.text,
                          "social_id": socialId!,
                          "social_type": socialType!,
                          "user_type": userType!,
                        };
                        _controller.socialSignUp(_body);
                      } else {
                        Map _body = <String, String>{
                          "email": email,
                          "password": password,
                          "country_id": dialCode
                        };
                        _controller.verifyUser(_body);
                      }
                    }

                    setState(() {});
                  },
                  type: BUTTONTYPE.rectangular),
              Padding(
                padding:
                const EdgeInsets.symmetric(horizontal: 34, vertical: 12),
                child: Row(
                  children: [
                    Expanded(
                      child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(children: [
                          const TextSpan(
                              text:
                              "By clicking submit, you affirm you have read and agree to the Farenow ",
                              style: TextStyle(
                                  color: black,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14)),
                          TextSpan(
                              text: "Terms of Use and Privacy",
                              recognizer: TapGestureRecognizer()
                                ..onTap = () async {
                                  await canLaunchUrl(Uri.parse(
                                      "https://www.farenow.com/page/Policy"));
                                  if (!await launchUrl(Uri.parse(
                                      "https://www.farenow.com/page/Policy"))) {
                                    throw 'Could not launch https://www.farenow.com/page/Policy';
                                  }
                                },
                              style: const TextStyle(
                                  color: AppColors.solidBlue,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400))
                        ]),
                      ),
                    ),
                  ],
                ),
              ),
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
              30.height,
              const FittedBox(child: FarenowSocialNetworkScreen()),
              30.height,
              Container(
                alignment: Alignment.center,
                child: FittedBox(
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
                          Get.toNamed(LoginScreen.id); //todo get to login
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
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _launchUrl(url) async {
    if (!await launchUrl(url)) throw 'Could not launch $url';
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

  Widget country(BuildContext context){

    return Column(
      children: [
        Container(
          alignment: Alignment.center,
          width: 77,
          //child: Text(countryCode),
          child:
          FutureBuilder(
              future: _controller.fetchData(
                  widget.userCountryIsoCode),
              builder: (context, snapshot) {
                countryCode = snapshot.data.toString();
                print("========${snapshot.data}");
                if (snapshot.hasData) {
                  return CountryCodePicker(

                    enabled: false,

                    dialogSize: Size(Get.width * 0.9,
                        Get.height * 0.35),
                    initialSelection: snapshot.data
                        .toString(),
                    onChanged: dialCodeFound,
                    onInit: (value) {
                      print(value);
                      */
/* print(
                                                  "=============================================================================");
                                              print(value?.dialCode.toString());
                                              print("countrycode==================${value?.code.toString()}");*/ /*

                      dialCode =
                          value?.dialCode ??
                              "abc";
                      countryCode= value?.dialCode?.toString() ??
                          "+234";
                    },



                    //countryFilter: snapshot.data?.map((e) => e.toString()).toList(),
                    //countryFilter:   snapshot.data?.map((e) => e.toString()).toList(),
                    showFlag: false,
                    showCountryOnly: false,
                    showOnlyCountryWhenClosed: false,
                    alignLeft: true,
                  );
                }
                return SizedBox();
              })
          ,
        ),
      ],
    );



  }
  void dialCodeFound( CountryCode countryCode) {
    setState(() {
      dialCode = countryCode.dialCode.toString();
    });
    print("=============================$dialCode");
  }


}*/
