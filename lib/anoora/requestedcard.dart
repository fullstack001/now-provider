import 'package:fare_now_provider/components/buttons-management/part_of_file/part.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class RequestedCard extends StatelessWidget {
  const RequestedCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 350.h,
      width: 330.w,
      decoration:  BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(24.r),),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 10.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ListTile(
              leading: CircleAvatar(
                backgroundColor: const Color(0xffE0E0E0)
                ,child: SvgPicture.asset('assets/providerImages/svg/profile_tab.svg'),),
              title:Text(
                'Godwin Benson',
                style: TextStyle(color:const Color(0xff151415),fontStyle: FontStyle.normal,fontWeight: FontWeight.w500, fontSize: 18.sp,),
              ),
              trailing: Container(
                height: 35.h,
                width: 80.w,
                decoration:  BoxDecoration(
                  color: const Color(0xffE0E0E0),
                  borderRadius: BorderRadius.all(Radius.circular(16.r),),
              ),
                child: Center(
                  child: Text(
                    '00:00:00',
                    style: TextStyle(color:const Color(0xff151415),fontStyle: FontStyle.normal,fontWeight: FontWeight.w400, fontSize: 12.sp,),
                  ),
                ),
            ),),
            SizedBox(height: 15.h,),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.w),
              child: Text(
                'Refrigerator Repair Service',
                style: TextStyle(color:const Color(0xff151415),fontStyle: FontStyle.normal,fontWeight: FontWeight.w500, fontSize: 16.sp,),
              ),
            ),
            SizedBox(height: 5.h,),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.w),
              child: Wrap(
                children: [
                  Image.asset('assets/calendar.png'),
                  SizedBox(width: 10.w,),
                  Text(
                    'Mon, 3rd Sep 2022, 10:30:48 PM',
                    style: TextStyle(color:const Color(0xff757575),fontStyle: FontStyle.normal,fontWeight: FontWeight.w400, fontSize: 12.sp,),
                  ),
                ],
              ),
            ),
            SizedBox(height: 5.h,),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.w),
              child: Wrap(
                children: [
                  Image.asset('assets/location.png'),
                  SizedBox(width: 10.w,),
                  Text(
                    'New York University, New York, NY, USA',
                    style: TextStyle(color:const Color(0xff757575),fontStyle: FontStyle.normal,fontWeight: FontWeight.w400, fontSize: 12.sp,),
                  ),
                ],
              ),
            ),
            SizedBox(height: 15.h,),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.w),
              child: Row(
                children: [
                  SizedBox(
                    width:150.w,
                    child: FarenowButton(title: 'Reject', onPressed: () {  }, type: BUTTONTYPE.text,),),
                  SizedBox(
                    width:150.w,
                    child: FarenowButton(title: 'Accept', onPressed: () {  }, type: BUTTONTYPE.outline,),),
                ],
              ),
            ),
            SizedBox(height: 15.h,),
            FarenowButton(title: 'View details', onPressed: () {  }, type: BUTTONTYPE.rectangular,),
          ],
        ),
      ),
    );
  }
}
