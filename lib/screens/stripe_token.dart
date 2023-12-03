import 'package:fare_now_provider/util/app_colors.dart';
import 'package:fare_now_provider/util/widgest_utills.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StripeToken extends StatefulWidget {
  StripeToken({Key? key}) : super(key: key);

  @override
  _StripeTokenState createState() => _StripeTokenState();
}

class _StripeTokenState extends State<StripeToken> {
  @override
  void initState() {
    super.initState();
    //   StripePayment.setOptions(StripeOptions(
    //       publishableKey: publishKey,
    //       merchantId: merchantId,
    //       androidPayMode: paymentMode));
  }

  TextEditingController token = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: customContainer(
        width: Get.width,
        height: Get.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            customContainer(
              width: Get.width,
              child: TextFormField(
                controller: token,
              ),
              marginBottom: 24,
              marginLeft: 24,
              marginRight: 24,
            ),
            customContainer(
                width: Get.width,
                height: 50,
                color: Colors.cyan,
                marginLeft: 24,
                marginRight: 24,
                child: MaterialButton(
                  onPressed: () {
                    setState(() {
                      // final CreditCard _creditCard = CreditCard(
                      //   number: '4242424242424242',
                      //   expMonth: 02,
                      //   expYear: 30,
                      //   name: "test user",
                      //   cvc: "123",
                      // );
                      // StripePayment.createTokenWithCard(_creditCard)
                      //     .then((value) {
                      //   print(value.tokenId);
                      //   token.text = value.tokenId!;
                      // });
                    });
                  },
                  child: Text(
                    "Click Me",
                    style: TextStyle(color: Colors.white),
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
