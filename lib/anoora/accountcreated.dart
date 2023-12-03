import 'package:fare_now_provider/components/buttons-management/part_of_file/part.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AccountCreatedScreen extends StatelessWidget {
  const AccountCreatedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Padding(
        padding:  EdgeInsets.symmetric(vertical: 10.h),
        child: FarenowButton(
            title: 'Login',
            onPressed: () {},
            type: BUTTONTYPE.rectangular),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 40.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/Group 52.png'),
                  SizedBox(
                    height: 40.h,
                  ),
                  Text(
                    'Account created',
                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 24.sp,letterSpacing: 2,color: const Color(0xff151415)),
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  Text(
                    'Your account was created successfully. Login to access your account.',
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 16.sp,
                        color: const Color(0xff555555)),
                      textAlign:TextAlign.center
                  ),
                ],
          ),
        )
      ),
    );
  }
}
