/*
import 'package:fare_now_provider/components/buttons-management/part_of_file/part.dart';
import 'package:fare_now_provider/custom_packages/keyboard_overlay/keyboard_overlay.dart';
import 'package:fare_now_provider/screens/auth_screen/profile_data_steps/step_2.dart';
import 'package:fare_now_provider/screens/auth_screen/profile_data_steps/steps_appbar.dart';
import 'package:fare_now_provider/screens/auth_screen/profile_data_steps/steps_controller/step_controller.dart';
import 'package:fare_now_provider/components/text_fields/farenow_text_field.dart';
import 'package:flutter/foundation.dart';

import 'package:nb_utils/nb_utils.dart';

import '../../../util/app_colors.dart';

class Step1 extends StatefulWidget {
  @override
  State<Step1> createState() => _Step1State();
}

class _Step1State extends State<Step1> {
  final formKey = GlobalKey<FormState>();

  bool init = false;

  @override
  void initState() {
    super.initState();

  }

  var argument;
  @override
  Widget build(BuildContext context) {
    return GetBuilder<StepsController>(
        init: StepsController(),
        builder: ((controller) {
          if ((controller.profileController.userData.value.socialType ?? "")
                  .toString()
                  .isNotEmpty &&
              !init) {
            init = true;
            controller.firstNameCtlr.text = controller
                .profileController.userData.value.firstName!
                .toString()
                .splitBefore(" ");
            controller.lastNameCtlr.text = controller
                .profileController.userData.value.lastName!
                .toString()
                .splitAfter(" ");
            // controller.firstNameCtlr.text = controller
            //     .profileController.userData.value.firstName!
            //     .split(" ")
            //     .first;
            // List list = controller.profileController.userData.value.firstName!
            //     .split("${controller.firstNameCtlr.text} ");
            // var join = list.join(" ");
            // controller.lastNameCtlr.text = join.toString().trim();
          } else if (!kReleaseMode && !init) {}
          return Scaffold(
            resizeToAvoidBottomInset:
                false, //todo added this to avoid bottom resizing when keyboard is active
            appBar: stepsAppBar(1),
            body: Form(
              key: formKey,
              child: Stack(
                children: [
                  SingleChildScrollView(
                      child: Column(
                    children: [
                      businessProfleText(),
                      boldHeaderText(),
                      blackProfleText(),
                      getTextFields(controller),
                      SizedBox(
                        height: Get.width * 0.45,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 24),
                        child: FarenowButton(
                            title: "Next",
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                formKey.currentState!.save();
                                controller.nextstepCounter();
                                Get.to(Step2.new);
                              } else {
                                print(" not active");
                              }
                            },
                            type: BUTTONTYPE.rectangular),
                      ),
                    ],
                  )),
                ],
              ),
            ),
          );
        }));
  }

  Padding getTextFields(StepsController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
      child: Column(
        children: [
          FarenowTextField(
              readonly: false,
              // (controller.profileController.userData.value.socialType ?? "")
              // (controller.profileController.userData.value.socialType ?? "")
              //         .isNotEmpty
              //     ? true
              //     : false,
              controller: controller.firstNameCtlr,
              hint: "Enter your first name",
              label: "First name"),
          20.height,
          FarenowTextField(
              readonly: false,
              // (controller.profileController.userData.value.socialType ?? "")
              // (controller.profileController.userData.value.socialType ?? "")
              //         .isNotEmpty
              //     ? true
              //     : false,
              controller: controller.lastNameCtlr,
              hint: "Enter your last name",
              inputAction: TextInputAction.done,
              onSubmit: (v) {
                if (formKey.currentState!.validate()) {
                  formKey.currentState!.save();
                  controller.nextstepCounter();
                  Get.to(Step2.new);
                } else {
                  print(" not active");
                }
              },
              label: "Last name"),
        ],
      ),
    );
  }

  Container boldHeaderText() {
    return Container(
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: const Text(
        "Complete your account settings to get started.",
        style: TextStyle(
            fontSize: 28, fontWeight: FontWeight.w700, color: AppColors.black),
      ),
    );
  }

  Container blackProfleText() {
    return Container(
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: const Text(
        "These information are confidential and will help our team to customize your experience. ",
        style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: Color(0xff555555)),
      ),
    );
  }

  Container businessProfleText() {
    return Container(
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: const Text(
        "Set up your business profile",
        style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: AppColors.solidBlue),
      ),
    );
  }
}
*/
import 'dart:convert';

import 'package:country_code_picker/country_code_picker.dart';
import 'package:fare_now_provider/components/buttons-management/part_of_file/part.dart';
import 'package:fare_now_provider/components/text_fields/farenow_text_field.dart';
import 'package:fare_now_provider/screens/auth_screen/profile_data_steps/step_2.dart';
import 'package:fare_now_provider/screens/auth_screen/profile_data_steps/steps_appbar.dart';
import 'package:fare_now_provider/screens/auth_screen/profile_data_steps/steps_controller/step_controller.dart';
import 'package:flutter/foundation.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../controllers/profile_screen_controller/ProfileScreenController.dart';
import '../../../util/app_colors.dart';
import '../../../util/shared_reference.dart';

class Step1 extends StatefulWidget {
  @override
  State<Step1> createState() => _Step1State();
}

class _Step1State extends State<Step1> {
  final formKey = GlobalKey<FormState>();
  var numberPlaceHolder = "xxx xxx xxxx";
  bool init = false;
  String countryCode = "";
  dynamic dialCode;
  ProfileScreenController _controller = Get.find();

  String? findIso2code;

  String? getisoCode;
  String phoneNumberError = "";
  bool isPhoneNumberValid = false;

  @override
  void didChangeDependencies() async {
    /*  getisoCode= await SharedRefrence().getIsocode(key: "IsoCode" );
    dialCodeFound(dialCode);
    _controller.fetchData(getisoCode ?? "").then((value) {
      findIso2code = value;
      print("Dataahddshfdsfjsdhf;sdj============${jsonEncode(findIso2code)}");
    });*/

    countcode();
    super.didChangeDependencies();
  }

  /* void didChangeDependencies()async{
    setState(() async{
      getisoCode= await SharedRefrence().getIsocode(key: "IsoCode" );


      _controller.fetchData(getisoCode ?? "").then((value) {
        findIso2code = value;
        print("Getisocodeeeeeeee===$getisoCode");
        print("Dataahddshfdsfjsdhf;sdj============${jsonEncode(findIso2code)}");
      });
    });
    super.didChangeDependencies();


  }*/

  void countcode() async {
    getisoCode = await SharedRefrence().getIsocode(key: "IsoCode");
    print("==========a=$getisoCode");
    _controller.fetchData(getisoCode ?? "").then((value) {
      findIso2code = value;
      print("Dataahddshfdsfjsdhf;sdj============${jsonEncode(findIso2code)}");
    });

    print("objectsssssssssssssssss======$findIso2code");
    setState(() {
      findIso2code;
      print("object======$findIso2code");
    });
  }

  dialCodeFound(CountryCode countryCode) async {
    setState(() {
      dialCode = countryCode.dialCode.toString();
    });
    /*update();*/
    /*await  SharedRefrence().saveDialcode(key:"DialCode",data: dialCode);
    print("==================================");
    print(await SharedRefrence().getDialcode(key: "DialCode"));*/
  }

  var argument;
  @override
  Widget build(BuildContext context) {
    return GetBuilder<StepsController>(
        init: StepsController(),
        builder: ((controller) {
          if ((controller.profileController.userData.value.socialType ?? "")
                  .toString()
                  .isNotEmpty &&
              !init) {
            init = true;
            controller.firstNameCtlr.text = controller
                .profileController.userData.value.firstName!
                .toString()
                .splitBefore(" ");
            controller.lastNameCtlr.text = controller
                .profileController.userData.value.lastName!
                .toString()
                .splitAfter(" ");
            // controller.firstNameCtlr.text = controller
            //     .profileController.userData.value.firstName!
            //     .split(" ")
            //     .first;
            // List list = controller.profileController.userData.value.firstName!
            //     .split("${controller.firstNameCtlr.text} ");
            // var join = list.join(" ");
            // controller.lastNameCtlr.text = join.toString().trim();
          } else if (!kReleaseMode && !init) {}
          return Scaffold(
            resizeToAvoidBottomInset:
               true, //todo added this to avoid bottom resizing when keyboard is active
            appBar: stepsAppBar(1),
            body: Form(
              key: formKey,
              child: Stack(
                children: [
                  SingleChildScrollView(
                      child: Column(
                    children: [
                      businessProfleText(),
                      boldHeaderText(),
                      blackProfleText(),
                      getTextFields(controller),
                      SizedBox(
                        height: Get.width * 0.04,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 24),
                        child: FarenowButton(
                            title: "Next",
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                formKey.currentState!.save();
                                controller.nextstepCounter();
                                Get.to(Step2(
                                  dialCodeFound: dialCode.toString(),
                                ));
                              } else if (!phoneNumberError.isEmpty) {
                                phoneNumberError = "Field required*";
                                setState(() {
                                  isPhoneNumberValid = true;
                                });
                                return;
                              } else {
                                print(" not active");
                              }
                            },
                            type: BUTTONTYPE.rectangular),
                      ),
                    ],
                  )),
                ],
              ),
            ),
          );
        }));
  }

  Padding getTextFields(StepsController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FarenowTextField(
              readonly: false,
              // (controller.profileController.userData.value.socialType ?? "")
              // (controller.profileController.userData.value.socialType ?? "")
              //         .isNotEmpty
              //     ? true
              //     : false,
              controller: controller.firstNameCtlr,
              onValidation: (value) {
                if (value!.isEmpty) {
                  return "Field required*";
                }
                return null;
              },
              hint: "Enter your first name",
              label: "First name"),
          SizedBox(
            height: 20,
          ),
          FarenowTextField(
              readonly: false,
              // (controller.profileController.userData.value.socialType ?? "")
              // (controller.profileController.userData.value.socialType ?? "")
              //         .isNotEmpty
              //     ? true
              //     : false,
              controller: controller.lastNameCtlr,
              onValidation: (value) {
                if (value!.isEmpty) {
                  return "Field required*";
                }
                return null;
              },
              hint: "Enter Your Last Name",
              label: "Last Name"),
          SizedBox(
            height: 20,
          ),

          /* Row(
            children: [

              FutureBuilder(
                  future: _controller.fetchData(
                      widget.userCountryIsoCode),
                  builder: (context, snapshot) {
                    countryCode = snapshot.data.toString();
                    print(snapshot.data);
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
                          print(
                              "=============================================================================");
                          print(value?.dialCode.toString());
                          print("countrycode==================${value?.code.toString()}");
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
                  }),
              FarenowTextField(
                  readonly: false,
                  // (controller.profileController.userData.value.socialType ?? "")
                  // (controller.profileController.userData.value.socialType ?? "")
                  //         .isNotEmpty
                  //     ? true
                  //     : false,
                  controller: controller.phoneCtlr,
                  hint: "xxx xxx xxxx",
                  inputAction: TextInputAction.done,
                  onSubmit: (v) {
                    if (formKey.currentState!.validate()) {
                      formKey.currentState!.save();
                      controller.nextstepCounter();
                      Get.to(Step2.new);
                    } else {
                      print(" not active");
                    }
                  },
                  label: "Phone Number"),
            ],

          ),*/

          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Phone Number",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
              ),
              const SizedBox(
                height: 15,
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(
                      color: isPhoneNumberValid ? Colors.red : Colors.black38,
                      width: 1),
                ),
                width: Get.width,
                height: 55,
                child: Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(color: Colors.white, width: 1),
                      ),
                      height: 55,
                      child: Row(
                        children: [
                          Container(
                            alignment: Alignment.center,
                            width: 77,
                            //child: Text(countryCode),
                            child: FutureBuilder(
                                future: _controller.fetchData(getisoCode),
                                builder: (context, snapshot) {
                                  countryCode = snapshot.data.toString();
                                  print(snapshot.data);
                                  if (snapshot.hasData) {
                                    return CountryCodePicker(
                                      enabled: false,

                                      dialogSize: Size(
                                          Get.width * 0.9, Get.height * 0.35),
                                      initialSelection:
                                          snapshot.data.toString(),
                                      onChanged: dialCodeFound,
                                      onInit: (value) {
                                        /* print(value);
                                        print(
                                            "=============================================================================");
                                        print(value?.dialCode.toString());
                                        print(
                                            "countrycode==================${value?.code.toString()}");*/
                                        dialCode = value?.dialCode ?? "abc";
                                        countryCode =
                                            value?.dialCode?.toString() ??
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
                                }),
                          ),
                          Container(
                            height: 30,
                            width: 1,
                            color: Colors.white,
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                        child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(color: Colors.white, width: 1),
                      ),
                      width: Get.width,
                      height: 50,
                      child: TextFormField(
                        textAlignVertical: TextAlignVertical.center,
                        controller: controller.phoneCtlr,
                        keyboardType: TextInputType.phone,
                        textInputAction: TextInputAction.done,
                        validator: (value) {
                          if (value!.length < 8 || value!.length > 12) {
                            return "";
                          }
                          return null;
                        },
                        onChanged: (value) {
                          setState(() {
                            phoneNumberError = controller
                                .validateNumber()!; // Call your validation function here
                          });
                        },
                        /* onFieldSubmitted: (v) {
                          if (formKey.currentState!.validate()) {
                            formKey.currentState!.save();
                            controller.nextstepCounter();
                             Get.to(Step2.new);
                            Get.to(() => Step2(
                                  dialCodeFound: dialCode.toString(),
                                ));
                          } else {
                            print(" not active");
                          }
                        },*/
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: BorderSide.none),
                          fillColor: Colors.white,
                          filled: true,
                          hintText: numberPlaceHolder,
                          hintStyle: TextStyle(color: Colors.grey.shade700),
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 10),
                          helperText: null,
                          counterText: "",
                          errorText: null,
                          errorStyle: TextStyle(height: 0),
                        ),
                      ),
                    ))
                  ],
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          if (phoneNumberError != null)
            Padding(
              padding: const EdgeInsets.only(top: 4.0, left: 14.0),
              child: Text(
                phoneNumberError!,
                style: TextStyle(color: Color(0xffD10000), fontSize: 12),
              ),
            ),
        ],
      ),
    );
  }

  Container boldHeaderText() {
    return Container(
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: const Text(
        "Complete your account settings to get started.",
        style: TextStyle(
            fontSize: 28, fontWeight: FontWeight.w700, color: AppColors.black),
      ),
    );
  }

  Container blackProfleText() {
    return Container(
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: const Text(
        "These information are confidential and will help our team to customize your experience. ",
        style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: Color(0xff555555)),
      ),
    );
  }

  Container businessProfleText() {
    return Container(
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: const Text(
        "Set up your business profile",
        style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: AppColors.solidBlue),
      ),
    );
  }
}
