import 'dart:convert';

import 'package:fare_now_provider/screens/signup_or_login_screen.dart';
import 'package:fare_now_provider/util/api_utils.dart';
import 'package:fare_now_provider/util/app_colors.dart';
import 'package:fare_now_provider/util/app_dialog_utils.dart';
import 'package:fare_now_provider/util/shared_reference.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:nb_utils/nb_utils.dart';

class DeleteUser extends StatefulWidget {
  @override
  State<DeleteUser> createState() => _DeleteUserState();
}

class _DeleteUserState extends State<DeleteUser> {
  TextEditingController _pass = TextEditingController();

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Container(
          margin: EdgeInsets.only(left: 24, right: 24),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(12))),
          width: Get.width,
          child: Column(
            children: [
              SizedBox(
                height: 24,
              ),
              Text(
                "Confirm Your Password:",
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(
                height: 24,
              ),
              Container(
                margin: EdgeInsets.only(left: 24, right: 24),
                child: TextFormField(
                  controller: _pass,
                  decoration: InputDecoration(
                    hintText: "Enter your password",
                  ),
                ),
              ),
              SizedBox(
                height: 24,
              ),
              Row(
                children: [
                  SizedBox(
                    width: 24,
                  ),
                  Expanded(
                    child: Container(
                      width: Get.width,
                      height: 44,
                      decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.all(Radius.circular(12))),
                      child: MaterialButton(
                        onPressed: () {
                          Get.back();
                        },
                        child: Text(
                          "Cancel",
                          style: TextStyle(color: Colors.white, fontSize: 17),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 12,
                  ),
                  Expanded(
                    child: Container(
                      width: Get.width,
                      height: 44,
                      decoration: BoxDecoration(
                          color: AppColors.appBlue,
                          borderRadius: BorderRadius.all(Radius.circular(12))),
                      child: MaterialButton(
                        onPressed: () async {
                          String pass = _pass.text.toString();
                          if (pass.isNotEmpty) {
                            try {
                              String? authToken = await SharedRefrence()
                                  .getString(key: ApiUtills.authToken);
                              print(authToken);
                              String url = baseUrl + "provider/delete";
                              setState(() {
                                isLoading = true;
                              });

                              var response = await http.delete(Uri.parse(url),
                                  headers: {
                                    "Authorization": authToken??""
                                  },
                                  body: {
                                    "password": pass,
                                    "password_confirmation": pass
                                  });
                              print(response);
                              if (response.statusCode == 200) {
                                final json = jsonDecode(response.body);
                                SharedRefrence()
                                    .clearPrefs(key: ApiUtills.authToken);
                                SharedRefrence()
                                    .clearPrefs(key: ApiUtills.userData);
                                SharedRefrence()
                                    .clearPrefs(key: ApiUtills.firstName);
                                SharedRefrence()
                                    .clearPrefs(key: ApiUtills.image);
                                SharedRefrence()
                                    .clearPrefs(key: ApiUtills.lastName);
                                SharedRefrence().clearPrefs(key: "userId");
                                Get.back();
                                Get.offNamedUntil(
                                    SignupOrLoginScreen.id, (route) => false);
                                AppDialogUtils.successDialog(json["message"]);
                              } else if (response.statusCode == 403) {
                                final json = jsonDecode(response.body);
                                Get.back();
                                AppDialogUtils.errorDialog(json["message"]);
                              } else {
                                final json = jsonDecode(response.body);
                                Get.back();
                                AppDialogUtils.errorDialog(json["message"]);
                              }
                              setState(() {
                                isLoading = false;
                              });
                            } catch (e) {
                              print(e.toString());
                            }
                          } else {
                            Get.back();
                          }
                        },
                        child: isLoading
                            ? Center(
                                child: CupertinoActivityIndicator(
                                color: white,
                              ))
                            : Text(
                                "Delete",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 17),
                              ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 24,
                  ),
                ],
              ),
              SizedBox(
                height: 24,
              ),
            ],
          ),
        )
      ]),
    );
  }
}
//3S4S4Q26L9