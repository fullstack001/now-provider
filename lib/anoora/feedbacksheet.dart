import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import 'package:get/get.dart';

import '../components/buttons-management/enum/button_type.dart';
import '../components/buttons-management/farenow_button.dart';


class FeedbackBottomSheet extends StatelessWidget {
  const FeedbackBottomSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  Container(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: 10.h, horizontal: 20.w),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: Text(
                              'Add Feedback',
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 28.sp,
                                letterSpacing: 1,
                                color: const Color(0xff151415),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                          Text(
                            'Add Comment',
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
                            maxLines: 5,
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
                                hintText: 'Enter feedback here',
                                hintStyle: TextStyle(
                                  color: const Color(0xff555555),
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16.sp,
                                )),
                          ),
                          SizedBox(
                            height: 15.h,
                          ),
                          Text(
                            'Add Rating',
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 14.sp,
                              color: const Color(0xff151415),
                            ),
                          ),
                          SizedBox(
                            height: 5.h,
                          ),
                          RatingBar.builder(
                            initialRating: 0,
                            minRating: 0,
                            direction: Axis.horizontal,
                            allowHalfRating: true,
                            itemCount: 5,
                            itemSize: 25,
                            itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                            itemBuilder: (context, _) => const Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                            onRatingUpdate: (rating) {
                            },
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
