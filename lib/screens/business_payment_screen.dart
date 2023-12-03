import 'package:fare_now_provider/util/app_colors.dart';
import 'package:fare_now_provider/widgets/custom_container.dart';
import 'package:fare_now_provider/widgets/text_with_icon.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/weekly_budget_model.dart';

class BusinessPaymentScreen extends StatefulWidget {
  const BusinessPaymentScreen({Key? key}) : super(key: key);

  @override
  State<BusinessPaymentScreen> createState() => _BusinessPaymentScreenState();
}

class _BusinessPaymentScreenState extends State<BusinessPaymentScreen> {
  List<WeeklyBudgetModel> list = [];

  @override
  void initState() {
    WeeklyBudgetModel modelTypeOne = WeeklyBudgetModel(
      title: "Recommended",
      price: "\$70",
      description: "This allows you to get up to 24 leads weekly",
      click: true,
    );
    WeeklyBudgetModel modelTypeTwo = WeeklyBudgetModel(
      title: "Unlimited budget",
      price: "",
      description:
          "You'll get the most leads you can, without a spending limit.",
      click: false,
    );
    WeeklyBudgetModel modelTypeThree = WeeklyBudgetModel(
      title: "Choose your own fixed amount",
      price: "",
      description: "",
      click: false,
    );
    list.add(modelTypeOne);
    list.add(modelTypeTwo);
    list.add(modelTypeThree);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: Get.width,
        height: Get.height,
        child: Column(
          children: [
            TextWithIcon(
              title: "Your weekly budget",
              fontWeight: FontWeight.bold,
              fontSize: 20,
              marginTop: 12,
              marginLeft: 12,
            ),
            TextWithIcon(
              title:
                  "You won't spend more han this on direct leads for all of your services",
              width: Get.width,
              flex: 1,
              fontSize: 16,
              marginRight: 12,
              marginTop: 12,
              marginLeft: 12,
            ),
            Divider(),
            Row(
              children: [
                TextWithIcon(
                  title: "Currently weekly budget:",
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  marginTop: 12,
                  marginLeft: 12,
                ),
                TextWithIcon(
                  title: "\$18",
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  fontColor: Colors.red,
                  marginTop: 12,
                  marginLeft: 5,
                ),
              ],
            ),
            CustomContainer(
              width: Get.width,
              child: Column(
                children: [
                  for (int index = 0; index < list.length; index++)
                    radioItem(index, list[index])
                ],
              ),
            ),
            SizedBox(
              height: 32,
            ),
            Container(
              margin: EdgeInsets.only(left: 24),
              child: TextWithIcon(
                title: "New pro Discount",
                bgColor: Colors.green,
                allRadius: 40,
                paddingLeft: 12,
                paddingTop: 6,
                paddingBottom: 6,
                paddingRight: 12,
                fontSize: 16,
                fontColor: Colors.white,
                marginTop: 12,
                marginLeft: 5,
              ),
            ),
            TextWithIcon(
              width: Get.width,
              flex: 1,
              marginRight: 24,
              marginLeft: 24,
              fontSize: 16,
              marginTop: 12,
              title:
                  "For 4 weeks, get 25% off up to 12 leads. This discount is activated on you first contact.",
            ),
            Divider(),
            Expanded(
                child: SizedBox(
              height: 12,
            )),
            Material(
              elevation: 16,
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 12,vertical: 16),
                child: TextWithIcon(
                  width: Get.width,
                  bgColor: AppColors.appBlue,
                  fontColor: Colors.white,
                  paddingAll: 14,
                  fontSize: 18,
                  title: "Save weekly budget",
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  radioItem(int index, WeeklyBudgetModel value) {
    return CustomContainer(
      width: Get.width,
      marginRight: 12,
      marginLeft: 12,
      marginTop: index == 0 ? 12 : 24,
      child: InkWell(
        onTap: () {
          for (int indexI = 0; indexI < list.length; indexI++) {
            list[indexI].click = false;
          }
          list[index].click = true;
          setState(() {});
        },
        child: Container(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                value.click!
                    ? Icons.radio_button_checked
                    : Icons.radio_button_off,
                color: value.click! ? AppColors.appBlue : Colors.black,
              ),
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      TextWithIcon(
                        title:
                            "${value.title}${value.price!.isEmpty ? "" : ": "}",
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        fontColor: Colors.black,
                        marginLeft: 5,
                      ),
                      TextWithIcon(
                        title: "${value.price}",
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        fontColor: AppColors.appGreen,
                        marginLeft: 5,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 6,
                  ),
                  TextWithIcon(
                    width: Get.width,
                    flex: 1,
                    title: value.description,
                    fontSize: 16,
                    maxLine: 3,
                    marginRight: 12,
                    fontColor: Colors.grey,
                    marginLeft: 5,
                  ),
                ],
              ))
            ],
          ),
        ),
      ),
    );
  }
}
/*
import 'package:fare_now_provider/util/app_colors.dart';
import 'package:fare_now_provider/widgets/custom_container.dart';
import 'package:fare_now_provider/widgets/text_with_icon.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/weekly_budget_model.dart';

class BusinessPaymentScreen extends StatefulWidget {
  const BusinessPaymentScreen({Key? key}) : super(key: key);

  @override
  State<BusinessPaymentScreen> createState() => _BusinessPaymentScreenState();
}

class _BusinessPaymentScreenState extends State<BusinessPaymentScreen> {
  List<WeeklyBudgetModel> list = [];

  @override
  void initState() {
    WeeklyBudgetModel modelTypeOne = WeeklyBudgetModel(
      title: "Recommended",
      price: "\$70",
      description: "This allows you to get up to 24 leads weekly",
      click: true,
    );
    WeeklyBudgetModel modelTypeTwo = WeeklyBudgetModel(
      title: "Unlimited budget",
      price: "",
      description:
          "You'll get the most leads you can, without a spending limit.",
      click: false,
    );
    WeeklyBudgetModel modelTypeThree = WeeklyBudgetModel(
      title: "Choose your own fixed amount",
      price: "",
      description: "",
      click: false,
    );
    list.add(modelTypeOne);
    list.add(modelTypeTwo);
    list.add(modelTypeThree);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: Get.width,
        height: Get.height,
        child: Column(
          children: [
            TextWithIcon(
              title: "Your weekly budget",
              fontWeight: FontWeight.bold,
              fontSize: 20,
              marginTop: 12,
              marginLeft: 12,
            ),
            TextWithIcon(
              title:
                  "You won't spend more han this on direct leads for all of your services",
              width: Get.width,
              flex: 1,
              fontSize: 16,
              marginRight: 12,
              marginTop: 12,
              marginLeft: 12,
            ),
            Divider(),
            Row(
              children: [
                TextWithIcon(
                  title: "Currently weekly budget:",
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  marginTop: 12,
                  marginLeft: 12,
                ),
                TextWithIcon(
                  title: "\$18",
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  fontColor: Colors.red,
                  marginTop: 12,
                  marginLeft: 5,
                ),
              ],
            ),
            CustomContainer(
              width: Get.width,
              child: Column(
                children: [
                  for (int index = 0; index < list.length; index++)
                    radioItem(index, list[index])
                ],
              ),
            ),
            SizedBox(
              height: 32,
            ),
            Container(
              margin: EdgeInsets.only(left: 24),
              child: TextWithIcon(
                title: "New pro Discount",
                bgColor: Colors.green,
                allRadius: 40,
                paddingLeft: 12,
                paddingTop: 6,
                paddingBottom: 6,
                paddingRight: 12,
                fontSize: 16,
                fontColor: Colors.white,
                marginTop: 12,
                marginLeft: 5,
              ),
            ),
            TextWithIcon(
              width: Get.width,
              flex: 1,
              marginRight: 24,
              marginLeft: 24,
              fontSize: 16,
              marginTop: 12,
              title:
                  "For 4 weeks, get 25% off up to 12 leads. This discount is activated on you first contact.",
            ),
            Divider(),
            Expanded(
                child: SizedBox(
              height: 12,
            )),
            Material(
              elevation: 16,
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 12,vertical: 16),
                child: TextWithIcon(
                  width: Get.width,
                  bgColor: AppColors.appBlue,
                  fontColor: Colors.white,
                  paddingAll: 14,
                  fontSize: 18,
                  title: "Save weekly budget",
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  radioItem(int index, WeeklyBudgetModel value) {
    return CustomContainer(
      width: Get.width,
      marginRight: 12,
      marginLeft: 12,
      marginTop: index == 0 ? 12 : 24,
      child: InkWell(
        onTap: () {
          for (int indexI = 0; indexI < list.length; indexI++) {
            list[indexI].click = false;
          }
          list[index].click = true;
          setState(() {});
        },
        child: Container(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                value.click!
                    ? Icons.radio_button_checked
                    : Icons.radio_button_off,
                color: value.click! ? AppColors.appBlue : Colors.black,
              ),
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      TextWithIcon(
                        title:
                            "${value.title}${value.price!.isEmpty ? "" : ": "}",
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        fontColor: Colors.black,
                        marginLeft: 5,
                      ),
                      TextWithIcon(
                        title: "${value.price}",
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        fontColor: AppColors.appGreen,
                        marginLeft: 5,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 6,
                  ),
                  TextWithIcon(
                    width: Get.width,
                    flex: 1,
                    title: value.description,
                    fontSize: 16,
                    maxLine: 3,
                    marginRight: 12,
                    fontColor: Colors.grey,
                    marginLeft: 5,
                  ),
                ],
              ))
            ],
          ),
        ),
      ),
    );
  }
}

 */