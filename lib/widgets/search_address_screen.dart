import 'package:dio/dio.dart';
import 'package:fare_now_provider/controllers/services/service_controller.dart';
import 'package:fare_now_provider/models/location_detail/location_detail_response.dart';
import 'package:fare_now_provider/models/prediction/predictions.dart';
import 'package:fare_now_provider/util/api_utils.dart';
import 'package:fare_now_provider/util/app_dialog_utils.dart';
import 'package:fare_now_provider/widgets/custom_container.dart';
import 'package:fare_now_provider/widgets/text_with_icon.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchAddressScreen extends StatelessWidget {
  var onAddressSelect;
  var zipCode;

  SearchAddressScreen({this.onAddressSelect, this.zipCode});

  ServiceController _controller = Get.find();

  @override
  Widget build(BuildContext context) {
    bool zip = zipCode ?? false;
    return Scaffold(
      backgroundColor: Color(0xffE5E5E5).withOpacity(0.5),
      body: SafeArea(
        child: Column(
          children: [
            CustomContainer(
              allRadius: 0,
              width: Get.width,
              height: 45,
              paddingLeft: 12,
              color: Colors.white,
              child: Row(
                children: [
                  Container(
                    child: InkWell(
                        onTap: () {
                          Get.back();
                        },
                        child: Icon(Icons.arrow_back)),
                  ),
                  SizedBox(
                    width: 12,
                  ),
                  Text(
                    "Select City",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              ),
            ),
            CustomContainer(
              width: Get.width,
              height: 45,
              color: Colors.white,
              marginTop: 12,
              marginLeft: 24,
              marginRight: 24,
              allRadius: 12,
              shadowColor: Colors.black45.withOpacity(0.5),
              shadowSpreadRadius: 2,
              shadowBlurRadius: 6,
              shadowOffsetX: 3,
              shadowOffsetY: 3,
              paddingLeft: 12,
              paddingRight: 12,
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Enter city name",
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.transparent)),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.transparent),
                  ),
                  border: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.transparent),
                  ),
                ),
                onChanged: (value) {
                  if (value.isEmpty) {
                    _controller.citiesResult.clear();
                    _controller.citiesResult.refresh();
                  } else {
                    _controller.searchCities(value);
                  }
                },
              ),
            ),
            Expanded(
              child: Obx(
                () => ListView.builder(
                  itemCount: _controller.citiesResult.length,
                  itemBuilder: (BuildContext context, int index) {
                    Predictions value = _controller.citiesResult[index];
                    return TextWithIcon(
                      containerClick: () async {
                        Get.focusScope!.unfocus();
                        print("${value.toJson()}");
                      },
                      marginLeft: 24,
                      marginTop: index == 0 ? 24 : 16,
                      marginBottom:
                          index == _controller.citiesResult.length - 1 ? 12 : 0,
                      marginRight: 24,
                      flex: 1,
                      fontSize: 14,
                      width: Get.width,
                      alignment: MainAxisAlignment.start,
                      title: value.description,
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
