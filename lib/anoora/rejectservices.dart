import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../components/buttons-management/enum/button_type.dart';
import '../components/buttons-management/farenow_button.dart';

class RejectServicesCard extends StatelessWidget {
  const RejectServicesCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15.w,vertical: 15.h),
      height: 370.h,
      width: 330.w,
      decoration:  BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(24.r),),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset('assets/Frame 12093.png'),
          Text(
            'Reject Service',
            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 24.sp,letterSpacing: 2,color: const Color(0xff0068E1)),
          ),
          Text(
              'This action will remove this order from your job request list. Click confirm to complete action.',
              style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 16.sp,
                  color: const Color(0xff555555)),
              textAlign:TextAlign.center
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
                  title: 'Confirm',
                  onPressed: () {},
                  type: BUTTONTYPE.rectangular,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
