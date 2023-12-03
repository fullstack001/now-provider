import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../controllers/auth_controller/social_network.dart';

class FarenowSocialNetworkScreen extends StatelessWidget {
  const FarenowSocialNetworkScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final va = Get.put(SocialNetwork());
    return GetBuilder<SocialNetwork>(
        init: SocialNetwork(),
        builder: (socialNetwork) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              if (GetPlatform.isIOS) const SizedBox(height: 10),
              if (GetPlatform.isIOS)
                socialButton("assets/providerImages/svg/apple.svg", () {
                  socialNetwork.appleLogin();
                }),
              10.width,
              GestureDetector(
                onTap: () {
                  socialNetwork.facebookLogin();
                },
                child: Container(
                    width: Get.width * 0.25,
                    height: Get.width * 0.15,
                    decoration: BoxDecoration(
                        color: const Color(0xffF5F5F5),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(width: 1, color: Colors.black38)),
                    padding: const EdgeInsets.all(6),
                    child: const Image(
                      image:
                          AssetImage("assets/providerImages/png/Facebook.png"),
                    )),
              ),
              10.width,
              socialButton("assets/providerImages/svg/google.svg", () async{
               await socialNetwork.googleLogin();
              }),
            ],
          );
        });
  }

  socialButton(String url, VoidCallback onPressed) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: Get.width * 0.25,
        height: Get.width * 0.15,
        decoration: BoxDecoration(
            color: const Color(0xffF5F5F5),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(width: 1, color: Colors.black38)),
        padding: const EdgeInsets.all(6),
        child: SvgPicture.asset(
          url,
          width: 97,
          height: 56,
        ),
      ),
    );
  }
}
