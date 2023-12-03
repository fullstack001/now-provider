import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NotificationCard extends StatelessWidget {
  const NotificationCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return   Container(
      height: 293.h,
      width:327.w ,
      decoration:  BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(24.r),),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Image.asset('assets/notification icon.png'),
          Text(
            'No Notification Available',
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 24.sp,
              color: const Color(0xff151415),
            ),
          ),
          Text(
            'New notifications will appear here.',
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 14.sp,
              color: const Color(0xff555555),
            ),
          ),
        ],
      ),
    );
  }
}
