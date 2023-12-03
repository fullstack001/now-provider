import 'package:fare_now_provider/components/buttons-management/part_of_file/part.dart';
import 'package:fare_now_provider/screens/wallet_screens/wallet_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nb_utils/nb_utils.dart';

import '../service_settings.dart';

class DepositScreen extends StatelessWidget {
  const DepositScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
          Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        10.height,
        Column(
          children: [
            SvgPicture.asset("assets/providerImages/svg/celebrate_deposit.svg"),
            10.height,
            const Text(
              "Deposit successful",
              style: TextStyle(
                  color: Color(0xff151415),
                  fontWeight: FontWeight.w700,
                  fontSize: 24),
            ),
            14.height,
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 80),
              child: Text(
                "Your amount deposit was successfully",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Color(0xff151415),
                    fontWeight: FontWeight.w400,
                    fontSize: 16),
              ),
            ),
          ],
        ),
        FarenowButton(
            title: "Done",
            onPressed: () {
              Get.offNamedUntil(ServiceSettings.id,(route) => false);
            },
            type: BUTTONTYPE.rectangular)
      ]),
    );
  }
}
