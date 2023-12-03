import 'package:fare_now_provider/components/buttons-management/part_of_file/part.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nb_utils/nb_utils.dart';

class CelebrateScreen extends StatelessWidget {
  String imageUrl;
  String buttonText;
  String successMsg;
  Function()? onTap;
  String detail;

  CelebrateScreen(
      {required this.imageUrl,
      required this.buttonText,
      required this.onTap,
      required this.successMsg,
      required this.detail});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              0.height,
              Column(
                children: [
                  SvgPicture.asset(imageUrl),
                  20.height,
                  Text(
                    successMsg,
                    style: const TextStyle(
                        color: Color(0xff151415),
                        fontSize: 24,
                        fontWeight: FontWeight.w700),
                  ),
                  20.height,
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 50),
                    child: Text(
                      detail,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          color: Color(0xff151415),
                          fontSize: 16,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                ],
              ),
              FarenowButton(
                  title: buttonText,
                  onPressed: onTap,
                  type: BUTTONTYPE.rectangular)
            ]),
      ),
    );
  }
}
