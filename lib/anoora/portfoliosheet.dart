import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import '../components/buttons-management/enum/button_type.dart';
import '../components/buttons-management/farenow_button.dart';
import '../components/text_fields/farenow_text_field.dart';


class PortfolioBottomSheet extends StatelessWidget {
   PortfolioBottomSheet({Key? key}) : super(key: key);
  final titleController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.lightBlueAccent,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(
              child: const Text('bottom sheet'),
              onPressed: () {
                Get.bottomSheet(
                  SingleChildScrollView(
                    child: Container(
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: 10.h, horizontal: 20.w),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Center(
                              child: Text(
                                'Add Portfolio',
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 28.sp,
                                  letterSpacing: 1,
                                  color: const Color(0xff151415),
                                ),
                              ),
                            ),
                            FarenowTextField(controller: titleController,
                              onValidation:  ( value) {
                                if (value!.isEmpty) {
                                  return "Field required*";
                                }
                                return null;
                              },
                              hint: 'Enter your portfolio title',
                              label: 'Title',),
                            SizedBox(
                              height: 5.h,
                            ),
                            Text(
                              'Description',
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 16.sp,
                                color: const Color(0xff151415),
                              ),
                            ),
                            SizedBox(
                              height: 5.h,
                            ),
                            TextField(
                              maxLines: 4,
                              decoration: InputDecoration(
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(16.r),
                                      borderSide: const BorderSide(
                                          color: Color(0xffF5F5F5), width: 1)),
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(16.r),
                                      borderSide: const BorderSide(
                                          color: Color(0xffF5F5F5), width: 1)),
                                  filled: true,
                                  fillColor: const Color(0xffF5F5F5),
                                  hintText: 'Enter portfolio description here',
                                  hintStyle: TextStyle(
                                    color: const Color(0xff555555),
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16.sp,
                                  )),
                            ),
                            SizedBox(
                              height: 15.h,
                            ),
                            Center(child: Image.asset('assets/Upload image.png'),),
                            SizedBox(
                              height: 15.h,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: 150.w,
                                  child: FarenowButton(
                                    title: 'Cancel',
                                    onPressed: () {},
                                    type: BUTTONTYPE.text,
                                  ),
                                ),
                                SizedBox(
                                  width: 150.w,
                                  child: FarenowButton(
                                    title: 'Submit',
                                    onPressed: () {},
                                    type: BUTTONTYPE.rectangular,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20.r),
                        topRight: Radius.circular(20.r)),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
