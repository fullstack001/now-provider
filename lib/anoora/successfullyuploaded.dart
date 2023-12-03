import 'package:fare_now_provider/components/buttons-management/part_of_file/part.dart';
import 'package:fare_now_provider/util/shared_reference.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_core/src/get_main.dart';

import '../components/buttons-management/enum/button_type.dart';
import '../components/buttons-management/farenow_button.dart';
import '../screens/auth_screen/login_screen.dart';
import '../util/api_utils.dart';


class SuccessScreen extends StatelessWidget {
  SuccessScreen({Key? key,required this.buttonLabel,required this.imagePath,required this.detailText,required this.imageText}) : super(key: key);
  final imagePath;
  final buttonLabel;
  final imageText;
  final detailText;
  SharedRefrence pref = SharedRefrence();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Padding(
        padding:  EdgeInsets.symmetric(vertical: 10),
        child: FarenowButton(
            title: buttonLabel,
            onPressed: () async{
              SharedRefrence pref = await SharedRefrence();
              pref.clearPrefs(key:ApiUtills.authToken);
              Get.offNamedUntil(
                  LoginScreen.id, (route) => false);
            },
            type: BUTTONTYPE.rectangular),
      ),
      body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 40),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(child: Image.asset(imagePath)),
                SizedBox(
                  height: 40,
                ),
                Text(
                  imageText,
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 24,letterSpacing: 2,color: const Color(0xff151415)),
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                    detailText,
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
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
