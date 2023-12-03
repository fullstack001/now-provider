import 'dart:io';

import 'package:fare_now_provider/components/buttons-management/part_of_file/part.dart';
import 'package:fare_now_provider/screens/wallet_screens/controller/wallet_controller.dart';
import 'package:fare_now_provider/util/app_dialog_utils.dart';
import 'package:flutter_credit_card/credit_card_form.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../custom_packages/card_ui/credit_card.dart';

class StripeModel extends StatefulWidget {
  final totalAmount;
  final onPageChange;
  final isPackage;
  String? stripeName;
  StripeModel(
      {Key? key,
      required this.totalAmount,
      this.onPageChange,
      required this.isPackage,
      this.stripeName})
      : super(key: key);
  static const routeName = 'stipeScreen';

  @override
  _StripeModelState createState() => _StripeModelState();
}

class _StripeModelState extends State<StripeModel> {
  // String cardNumber = '4242424242424242';
  // String expiryDate = '11/23';
  // String cardHolderName = 'abc';
  // String cvvCode = '314';
  String cardNumber = '';
  String expiryDate = '';
  String cardHolderName = '';
  String cvvCode = '';
  bool isCvvFocused = false;
  bool _isLoading = false;
  WalletController _walletController = Get.find();

  @override
  void initState() {
    super.initState();

    // StripePayment.setOptions(StripeOptions(
    //     publishableKey: publishKey,
    //     merchantId: merchantId,
    //     androidPayMode: paymentMode));
  }

  //function to check if card is valid or not
  void _showErrorDialog(String message) {
    showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
              title: const Text('An Error Occured'),
              content: Text(message),
              actions: <Widget>[
                TextButton(
                    onPressed: () => Navigator.of(ctx).pop(),
                    child: const Text('Okay'))
              ],
            ));
  }

  Future<void> _submitCard() async {
    Get.focusScope!.unfocus();

    try {
      AppDialogUtils.dialogLoading();
      Map<String, dynamic> _body = {
        "card[number]": cardNumber,
        "card[exp_month]": "${int.parse(expiryDate.split("/")[0])}",
        "card[exp_year]": "${int.parse(expiryDate.split("/")[1])}",
        "card[cvc]": cvvCode
      };

      await _walletController.getCardToken(body: _body).then((value) {
        if (value != null) {
          if (widget.isPackage) {
            Map _body = {"stripe_name": widget.stripeName, "token": value};
            _walletController.subscribePackage(body: _body);
          } else {
            _walletController.purchaseCredit(
                token: value,
                amount: widget.totalAmount,
                onPageChange: widget.onPageChange);
          }
        }
      });
    } on HttpException catch (error) {
      AppDialogUtils.dismiss();
      print('this is error');
      print(error);
      print('this is error');
      var errorMessage = 'Authentication Failed';
      if (error.toString().contains('EMAIL_EXISTS')) {
        errorMessage = 'This email already in use.';
      } else if (error.toString().contains('INVALID_EMAIL')) {
        errorMessage = 'This is not a valid email';
      } else if (error.toString().contains('WEAK_PASSWORD')) {
        errorMessage = 'This password is too weak';
      } else if (error.toString().contains('EMAIL_NOT_FOUND')) {
        errorMessage = 'Could not find a user with that email';
      } else if (error.toString().contains('INVALID_PASSWORD')) {
        errorMessage = 'Invalid Password';
      }
      _showErrorDialog(error.toString());
    } catch (error) {
      const errorMessage = 'Could not authenticate you. Please try again later';
      print('this is error');
      print(error);
      print('this is error');

      _showErrorDialog(errorMessage);
    }

    setState(() {
      _isLoading = false;
    });
  }

  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        elevation: 0,
        iconTheme: IconTheme.of(context).copyWith(color: black),
        backgroundColor: Colors.white,
        title: const Text(
          "Payment",
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.w500, color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            20.height,
            CreditCard(
              cardNumber: cardNumber,

              cardExpiry: expiryDate,
              cardHolderName: cardHolderName,
              backBackground: Container(
                decoration: const BoxDecoration(
                    gradient: LinearGradient(
                        colors: [Color(0xff3EB0E5), Color(0xff0050AD)])),
              ),
              frontBackground: Container(
                decoration: const BoxDecoration(
                    gradient: LinearGradient(
                        colors: [Color(0xff3EB0E5), Color(0xff0050AD)])),
              ),
              showBackSide: false,
              backTextColor: white,
              cvv: cvvCode,

              // onCreditCardWidgetChange: (CreditCardBrand) {},
            ),
            Column(
              children: <Widget>[
                CreditCardForm(
                  formKey: formKey,
                  themeColor: Colors.cyan,
                  onCreditCardModelChange: onCreditCardModelChange,
                  cardHolderName: cardHolderName,
                  cardNumber: cardNumber,
                  expiryDate: expiryDate,
                  cvvCode: cvvCode,
                  cardNumberDecoration: InputDecoration(
                      alignLabelWithHint: true,
                      labelText: "Card Number",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide:
                              const BorderSide(color: Color(0xffBDBDBD)))),
                  expiryDateDecoration: InputDecoration(
                      alignLabelWithHint: true,
                      labelText: "Expiry Date",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide:
                              const BorderSide(color: Color(0xffBDBDBD)))),
                  cvvCodeDecoration: InputDecoration(
                      alignLabelWithHint: true,
                      labelText: "CVV",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide:
                              const BorderSide(color: Color(0xffBDBDBD)))),
                  cardHolderDecoration: InputDecoration(
                      labelText: "Card Holder Name",
                      alignLabelWithHint: true,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide:
                              const BorderSide(color: Color(0xffBDBDBD)))),
                ),
                100.height,
                FarenowButton(
                    title: "Pay",
                    onPressed: _submitCard,
                    type: BUTTONTYPE.rectangular)
              ],
            ),
          ],
        ),
      ),
    );
  }

  void onCreditCardModelChange(creditCardModel) {
    setState(() {
      cardNumber = creditCardModel.cardNumber;
      expiryDate = creditCardModel.expiryDate;
      cardHolderName = creditCardModel.cardHolderName;
      cvvCode = creditCardModel.cvvCode;
      isCvvFocused = creditCardModel.isCvvFocused;
    });
  }
}
