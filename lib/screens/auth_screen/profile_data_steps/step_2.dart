/*import 'package:fare_now_provider/components/buttons-management/part_of_file/part.dart';
import 'package:fare_now_provider/custom_packages/keyboard_overlay/keyboard_overlay.dart';
import 'package:fare_now_provider/screens/auth_screen/profile_data_steps/step_3.dart';
import 'package:fare_now_provider/screens/auth_screen/profile_data_steps/steps_appbar.dart';
import 'package:fare_now_provider/screens/auth_screen/profile_data_steps/steps_controller/step_controller.dart';
import 'package:fare_now_provider/util/app_dialog_utils.dart';

import 'package:nb_utils/nb_utils.dart';

import '../../../components/radio_buttons/fare_now_radio_button.dart';
import '../../../util/app_colors.dart';
import '../../brand_or_service_provider_screen.dart';

class Step2 extends StatefulWidget {
  const Step2({Key? key}) : super(key: key);

  @override
  State<Step2> createState() => _Step2State();
}

class _Step2State extends State<Step2> with HandleFocusNodesOverlayMixin {
  String marketValueStr = "";
 late StepsController _controller;
  @override
  void initState() {
    _controller=Get.find();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return GetBuilder<StepsController>(
        init: StepsController(),
        builder: ((controller) {
          return Scaffold(
            resizeToAvoidBottomInset: false, //todo added this
            backgroundColor: white,
            appBar: stepsAppBar(2),
            body: Stack(
              children: [
                SingleChildScrollView(
                  child: Column(
                    children: [
                      12.height,
                      businessProfleText(),
                      boldHeaderText(),
                      FarenowRadioButtons(
                        onSelected: (p0, p1, p2) {
                          marketValueStr = p0[0];
                          print(marketValueStr);
                          setState(() {});
                        },

                        list: controller.stepTwolist,
                        isRadio: true,
                      ),
                      120.height,
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: FittedBox(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 20), //todo
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          FarenowButton(
                              title: "Next",
                              onPressed: () {
                                if (marketValueStr.isNotEmpty) {
                                  String firstName =
                                      controller.firstNameCtlr.text.toString();
                                  String lastName =
                                      controller.lastNameCtlr.text.toString();

                                  Map _body = <String, String>{
                                    "first_name": firstName,
                                    "last_name": lastName,
                                    "phone": "+12372496972",
                                    "spend_each_month": marketValueStr
                                  };
                                  controller.servicesListController
                                      .getServiceList();
                                  print("Hello");
                                  controller.profileController
                                      .signUpName(_body);
                                  controller.nextstepCounter();
                                } else {
                                  AppDialogUtils.errorDialog(
                                      "Please Select One");
                                }

                                // Navigator.pushNamed(
                                //     context, BrandOrServiceProviderScreen.id);
                              },
                              type: BUTTONTYPE.rectangular),
                          FarenowButton(
                              title: "Previous",
                              onPressed: () {
                                controller.previousstepCounter();
                                Get.back();
                              },
                              type: BUTTONTYPE.outline),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        }));
  }

  Container boldHeaderText() {
    return Container(
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: const FittedBox(
        child: Text(
          "How much do you \n spend each month on \n online marketing",
          style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w700,
              color: AppColors.black),
        ),
      ),
    );
  }

  Container businessProfleText() {
    return Container(
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: const FittedBox(
        child: Text(
          "Set up your business profile",
          style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: AppColors.solidBlue),
        ),
      ),
    );
  }
}*/
import 'package:fare_now_provider/components/buttons-management/part_of_file/part.dart';
import 'package:fare_now_provider/custom_packages/keyboard_overlay/keyboard_overlay.dart';
import 'package:fare_now_provider/screens/auth_screen/profile_data_steps/step_3.dart';
import 'package:fare_now_provider/screens/auth_screen/profile_data_steps/steps_appbar.dart';
import 'package:fare_now_provider/screens/auth_screen/profile_data_steps/steps_controller/step_controller.dart';
import 'package:fare_now_provider/util/app_dialog_utils.dart';

import 'package:nb_utils/nb_utils.dart';

import '../../../components/radio_buttons/fare_now_radio_button.dart';
import '../../../util/app_colors.dart';
import '../../../util/shared_reference.dart';
import '../../brand_or_service_provider_screen.dart';

class Step2 extends StatefulWidget {
  final String? dialCodeFound;
  const Step2({Key? key, this.dialCodeFound}) : super(key: key);

  @override
  State<Step2> createState() => _Step2State();
}

class _Step2State extends State<Step2> with HandleFocusNodesOverlayMixin {
  SharedRefrence preferences = SharedRefrence();
  String marketValueStr = "";
  String? getdialCode;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    setState(() {
      getdialCode = widget.dialCodeFound /*??"+234"*/;
    });
    print(
        "Gettttttttttttttttt dial codeeeeeeeeeeeeeee in inittttttttttttttttt$getdialCode");
  }
  /*void didChangeDependencies()  async{
    getdialCode= await SharedRefrence().getDialcode(key: "DialCode" );

    super.didChangeDependencies();


  }*/

  Widget build(BuildContext context) {
    return GetBuilder<StepsController>(
        init: StepsController(),
        builder: ((controller) {
          return Scaffold(
            resizeToAvoidBottomInset: false, //todo added this
            backgroundColor: white,
            appBar: stepsAppBar(2),
            body: Stack(
              children: [
                SingleChildScrollView(
                  child: Column(
                    children: [
                      12.height,
                      businessProfleText(),
                      boldHeaderText(),
                      FarenowRadioButtons(
                        onSelected: (p0, p1, p2) {
                          marketValueStr = p0[0];
                          print(marketValueStr);
                          setState(() {});
                        },
                        list: controller.stepTwolist,
                        isRadio: true,
                      ),
                      120.height,
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: FittedBox(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 20), //todo
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          FarenowButton(
                              title: "Next",
                              onPressed: () async {
                                if (marketValueStr.isNotEmpty) {
                                  String firstName =
                                      controller.firstNameCtlr.text.toString();
                                  String lastName =
                                      controller.lastNameCtlr.text.toString();
                                  print(
                                      "===================------------------");
                                  print(widget.dialCodeFound);
                                  print(
                                      "Gettttttttttttttttt dial codeeeeeeeeeeeeeee$getdialCode");
                                  String dialCode =
                                      widget.dialCodeFound ?? "+234";

                                  String phoneNumber = getdialCode.toString() +
                                      controller.phoneCtlr.text.toString();

                                  /*       await preferences.saveFirstName(key:"firstName",firstName: firstName );
                                  await preferences.saveLastName(key:"lastName",lastName: lastName );*/
                                  await preferences.savephoneNumber(
                                      key: "phoneNumber",
                                      phoneNumber: phoneNumber);
                                  await preferences.saveSpendEachMonth(
                                      key: "spendEachMonth",
                                      spendEachMonth: marketValueStr);

                                  Map _body = <String, dynamic>{
                                    "first_name": firstName,
                                    "last_name": lastName,
                                    "spend_each_month": marketValueStr,
                                    /* "spend_each_month": "1000",
                                    "phone":"+12345678912"*/
                                    "phone": phoneNumber
                                  };
                                  print("FinallllllR:$_body");
                                  controller.profileController
                                      .signUpName(_body);
                                  controller.servicesListController
                                      .getServiceList();
                                  controller.nextstepCounter();
                                } else {
                                  AppDialogUtils.errorDialog(
                                      "Please Select One");
                                }

                                // Navigator.pushNamed(
                                //     context, BrandOrServiceProviderScreen.id);
                              },
                              type: BUTTONTYPE.rectangular),
                          FarenowButton(
                              title: "Previous",
                              onPressed: () {
                                controller.previousstepCounter();
                                Get.back();
                              },
                              type: BUTTONTYPE.outline),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        }));
  }

  Container boldHeaderText() {
    return Container(
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: const FittedBox(
        child: Text(
          "How much do you \nspend each month on\nonline marketing",
          style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w700,
              color: AppColors.black),
        ),
      ),
    );
  }

  Container businessProfleText() {
    return Container(
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: const FittedBox(
        child: Text(
          "Set up your business profile",
          style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: AppColors.solidBlue),
        ),
      ),
    );
  }
}
