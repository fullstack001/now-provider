import 'package:fare_now_provider/controllers/profile_screen_controller/ProfileScreenController.dart';
import 'package:fare_now_provider/controllers/services_list_controller.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../custom_packages/keyboard_overlay/keyboard_overlay.dart';

enum Market { current, $1, $100, $400 }

class BusinessCredentials extends StatefulWidget {
  static const String id = 'business_credentials';

  @override
  _BusinessCredentialsState createState() => _BusinessCredentialsState();
}

class _BusinessCredentialsState extends State<BusinessCredentials>
    with HandleFocusNodesOverlayMixin {
  Market _marketValue = Market.current;
  final firstNameCtlr = TextEditingController();
  final lastNameCtlr = TextEditingController();

  String spend = "I don’t currently spend on online marketing";

  ProfileScreenController _controller = Get.find();
  ServicesListController _servicesListController = Get.find();
  final _formKey = new GlobalKey<FormState>();
  var firstName = FocusNode();
  var lastName = FocusNode();
  bool init = false;

  setDoneButton() {
    if (GetPlatform.isIOS) {
      firstName = GetFocusNodeOverlay(
          child: TopKeyboardUtil(
        DoneButtonIos(
          label: 'Done',
          onSubmitted: () => Get.focusScope!.unfocus(),
          platforms: ['android', 'ios'],
        ),
      ));
      lastName = GetFocusNodeOverlay(
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

  @override
  Widget build(BuildContext context) {
    // init = false;
    // if ((_controller.userData.value.socialType ?? "").toString().isNotEmpty &&
    if ((_controller.userData.value.accountType ?? "").toString().isNotEmpty &&
        !init) {
      init = true;
      firstNameCtlr.text =
          _controller.userData.value.firstName!.split(" ").first;
      List list =
          _controller.userData.value.firstName!.split("${firstNameCtlr.text} ");
      var join = list.join(" ");
      lastNameCtlr.text = join.toString().trim();
      _marketValue = Market.$1;
    } else if (!kReleaseMode && !init) {
      _marketValue = Market.$1;
    }
    return Container(
      color: Colors.white,
      child: SafeArea(
          child: Scaffold(
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 15,
                  ),
                  InkWell(
                      onTap: () {
                        Get.back();
                      },
                      child: const Icon(Icons.arrow_back)),
                  const SizedBox(
                    height: 15,
                  ),
                  const Text(
                    "To start, help us get to know you and your business.",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  const Text(
                    "This info helps our team to provide customized support it won’t be public.",
                    style: TextStyle(
                        color: Color(0xffBDBDBD),
                        fontWeight: FontWeight.w500,
                        fontSize: 16),
                  ),
                  const SizedBox(
                    height: 45,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            const Text(
                              "What's your name?",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 18),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        TextFormField(
                          readOnly:
                              // (_controller.userData.value.socialType ?? "")
                              (_controller.userData.value.accountType ?? "")
                                      .isNotEmpty
                                  ? true
                                  : false,
                          focusNode: firstName,
                          onFieldSubmitted: (value) {
                            lastName.requestFocus();
                          },
                          textInputAction: TextInputAction.next,
                          validator: (val) {
                            if (val!.isEmpty) {
                              return "Field Empty";
                            }
                            return null;
                          },
                          controller: firstNameCtlr,
                          decoration: const InputDecoration(
                            filled: true,
                            fillColor: Color(0xffF3F4F4),
                            hintText: "First Name",
                            hintStyle: TextStyle(
                                fontWeight: FontWeight.w400,
                                color: Color(0xff757575),
                                fontSize: 16),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                              color: Color(0xffF3F4F4),
                            )),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0xffF3F4F4),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        TextFormField(
                          readOnly:
                              // (_controller.userData.value.socialType ?? "")
                              (_controller.userData.value.accountType ?? "")
                                      .isNotEmpty
                                  ? true
                                  : false,
                          focusNode: lastName,
                          onFieldSubmitted: (value) {
                            Get.focusScope!.unfocus();
                          },
                          textInputAction: TextInputAction.done,
                          validator: (val) {
                            if (val!.isEmpty) {
                              return "Field Empty";
                            }
                            return null;
                          },
                          controller: lastNameCtlr,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: const Color(0xffF3F4F4),
                            hintText: "Last Name",
                            hintStyle: const TextStyle(
                                fontWeight: FontWeight.w400,
                                color: Color(0xff757575),
                                fontSize: 16),
                            enabledBorder: new OutlineInputBorder(
                                borderSide: new BorderSide(
                              color: const Color(0xffF3F4F4),
                            )),
                            focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0xffF3F4F4),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        const Text(
                          "How much do you spend each month on online marketing?",
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              color: Colors.black),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        // RadioListTile(
                        //   title: const Text(
                        //     'I don’t currently spend on online marketing',
                        //     style: TextStyle(
                        //         fontWeight: FontWeight.w400,
                        //         fontSize: 16,
                        //         color: Color(0xff757575)),
                        //   ),
                        //   contentPadding: EdgeInsets.zero,
                        //   value: Market.current,
                        //   groupValue: _marketValue,
                        //   onChanged: (Market value) {
                        //     setState(() {
                        //       _marketValue = value;
                        //     });
                        //   },
                        // ),
                        const Divider(
                          color: Color(
                            0xffE0E0E0,
                          ),
                        ),
                        RadioListTile(
                          title: const Text(
                            "\$1 - \$100",
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 16,
                                color: Color(0xff757575)),
                          ),
                          contentPadding: EdgeInsets.zero,
                          value: Market.$1,
                          groupValue: _marketValue,
                          onChanged: (Market? value) {
                            setState(() {
                              _marketValue = value!;
                            });
                          },
                        ),
                        const Divider(
                          color: Color(
                            0xffE0E0E0,
                          ),
                        ),
                        RadioListTile(
                          title: const Text(
                            "\$100 - \$400",
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 16,
                                color: Color(0xff757575)),
                          ),
                          contentPadding: EdgeInsets.zero,
                          value: Market.$100,
                          groupValue: _marketValue,
                          onChanged: (Market? value) {
                            setState(() {
                              _marketValue = value!;
                            });
                          },
                        ),
                        const Divider(
                          color: Color(
                            0xffE0E0E0,
                          ),
                        ),
                        RadioListTile(
                          title: const Text(
                            "\$400 - \$600",
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 16,
                                color: Color(0xff757575)),
                          ),
                          contentPadding: EdgeInsets.zero,
                          value: Market.$400,
                          groupValue: _marketValue,
                          onChanged: (Market? value) {
                            setState(() {
                              _marketValue = value!;
                            });
                          },
                        ),
                        const SizedBox(
                          height: 33,
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(
                              vertical: 16, horizontal: 0),
                          decoration: BoxDecoration(
                            color: const Color(0xff1B80F5),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: ButtonTheme(
                            height: 50,
                            child: TextButton(
                              onPressed: () {
                                if (!_formKey.currentState!.validate()) {
                                  return;
                                }
                                String firstName =
                                    firstNameCtlr.text.toString();
                                String lastName = lastNameCtlr.text.toString();
                                String marketValueStr =
                                    getStringValue(_marketValue);

                                Map _body = <String, String>{
                                  "first_name": firstName,
                                  "last_name": lastName,
                                  "spend_each_month": marketValueStr
                                };
                                _servicesListController.getServiceList();
                                _controller.signUpName(_body);
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
                        const SizedBox(
                          height: 30,
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      )),
    );
  }

  String getStringValue(Market marketValue) {
    if (marketValue.index == Market.$1.index) {
      return "\$1 - \$100";
    } else if (marketValue.index == Market.$100.index) {
      return "\$100 - \$400";
    } else if (marketValue.index == Market.$400.index) {
      return "\$400 - \$600";
    }
    return "I don’t currently spend on online marketing";
  }
}
