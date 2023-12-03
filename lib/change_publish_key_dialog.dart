import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'util/api_utils.dart';
import 'util/shared_reference.dart';

class ChangePublishKeyDialog extends StatelessWidget {
  TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        width: Get.width,
        height: Get.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
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
                  SizedBox(
                    height: 24,
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 24, right: 24),
                    child: TextFormField(
                      controller: _controller,
                      decoration: InputDecoration(
                        hintText: "Please enter your key",
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
                              color: Colors.red,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12))),
                          child: MaterialButton(
                            onPressed: () {
                              Get.back();
                            },
                            child: Text(
                              "Cancel",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 17),
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
                              color: Colors.green,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12))),
                          child: MaterialButton(
                            onPressed: () {
                              String publishKey =
                                  _controller.text.toString().trim();
                              if (publishKey.isNotEmpty) {
                                SharedRefrence().saveString(
                                    key: "publishKey", data: publishKey);
                              }
                              Get.back();
                            },
                            child: Text(
                              "Save",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 17),
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
            ),
          ],
        ),
      ),
    );
  }
}
