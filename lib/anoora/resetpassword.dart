import 'package:fare_now_provider/components/buttons-management/part_of_file/part.dart';
import 'package:fare_now_provider/anoora/sucessfulreset.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../components/text_fields/farenow_text_field.dart';

class ResetPasswordScreen extends StatelessWidget {
  ResetPasswordScreen({Key? key}) : super(key: key);
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 20.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                onTap: () {
                  Get.back();
                },
                child: Image.asset('assets/arrow-left.png'),
              ),
              SizedBox(
                height: 25.h,
              ),
              Text(
                'Forget Password',
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 30.sp,letterSpacing: 2),
              ),
              SizedBox(
                height: 15.h,
              ),
              Text(
                'Enter your email or phone number to reset your account password.',
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 16.sp,
                    color: const Color(0xff555555)),
              ),
              SizedBox(
                height: 30.h,
              ),
              FarenowTextField(
                controller: passwordController,
                hint: 'Enter your password',
                label: 'Password',
              ),
              SizedBox(
                height: 25.h,
              ),
              FarenowTextField(
                controller: confirmPasswordController,
                hint: 'Confirm your password',
                label: 'Confirm Password',
              ),
              SizedBox(
                height: 25.h,
              ),
              FarenowButton(
                  title: 'Reset Password',
                  onPressed: (){Get.to(()=>const SuccessfulResetScreen());},
                  type: BUTTONTYPE.rectangular),
              SizedBox(
                height: 30.h,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
