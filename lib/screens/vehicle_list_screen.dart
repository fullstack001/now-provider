import 'package:fare_now_provider/controllers/profile_screen_controller/ProfileScreenController.dart';
import 'package:fare_now_provider/models/verify_otp/vehicles.dart';
import 'package:fare_now_provider/screens/Controller/add_vehicle_controller.dart';
import 'package:fare_now_provider/screens/add_vehicle_screen.dart';
import 'package:fare_now_provider/util/api_utils.dart';
import 'package:fare_now_provider/util/app_colors.dart';
import 'package:fare_now_provider/util/app_dialog_utils.dart';
import 'package:fare_now_provider/util/widgest_utills.dart';
import 'package:fare_now_provider/widgets/custom_container.dart';
import 'package:fare_now_provider/widgets/text_with_icon.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VehicleListScreen extends StatelessWidget {
  ProfileScreenController _controller = Get.find();
  AddVehicleController _addVehicleController = Get.put(AddVehicleController());

  @override
  Widget build(BuildContext context) {
    if (_addVehicleController.typeResponse.isEmpty) {
      _addVehicleController.getTypes(move: true);
    }
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        centerTitle: false,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.blue,
          ),
        ),
        title: Text(
          "Vehicles",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
        ),
      ),
      body: Obx(() => Column(
            children: [
              // TODO important vahical
              // Expanded(
              //     child: _controller.userData.value.vehicles.isNotEmpty
              //         ? getVehicleList(_controller.userData.value.vehicles)
              //         : addVehicleWidget()),
              if (check())
                TextWithIcon(
                  width: Get.width,
                  height: 45,
                  bgColor: AppColors.appGreen,
                  marginRight: 12,
                  marginBottom: 12,
                  marginLeft: 12,
                  allRadius: 12,
                  fontSize: 18,
                  containerClick: () {
                    Get.to(() => AddVehicleScreen(
                          postSignup: true,
                        ));
                  },
                  fontWeight: FontWeight.w700,
                  fontColor: Colors.white,
                  title: "Add Vehicle",
                )
            ],
          )),
    );
  }

  getVehicleList(List vehicles) {
    int size = vehicles.length;
    return Container(
      width: Get.width,
      child: ListView.builder(
        itemCount: size,
        itemBuilder: (BuildContext context, int index) {
          Vehicles vehicle = vehicles[index];
          return CustomContainer(
            width: Get.width,
            marginLeft: 12,
            marginRight: 12,
            marginTop: index == 0 ? 24 : 12,
            marginBottom: index == size - 1 ? 24 : 0,
            allRadius: 12,
            shadowColor: Colors.black12,
            shadowBlurRadius: 2,
            shadowOffsetX: 2,
            shadowOffsetY: 2,
            shadowSpreadRadius: 2,
            color: Colors.white,
            child: Row(
              children: [
                CustomContainer(
                  height: 100,
                  width: 120,
                  child: cacheNetworkImage(
                      imageUrl:
                          "${vehicle.vehicleType == null ? "" : ApiUtills.imageBaseUrl + (vehicle.vehicleType.image ?? "")}",
                      fit: BoxFit.fill,
                      placeHolder: "assets/img_vehicle.png"),
                ),
                Expanded(
                    child: Column(
                  children: [
                    TextWithIcon(
                      title:
                          "${getTitleVeh(vehicle.vehicleType == null ? "" : vehicle.vehicleType.title)}: ${vehicle.name}",
                      marginTop: 12,
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
                    getRow("Company:", vehicle.companyName),
                    getRow("Model Number:", vehicle.model),
                    getRow("Condition:", vehicle.condition),
                    SizedBox(
                      height: 12,
                    )
                  ],
                )),
                Column(
                  children: [
                    CustomContainer(
                      child: Icon(Icons.delete_rounded),
                      height: 50,
                      marginRight: 12,
                      onTap: () {
                        alertDialog(
                            title: "Alert",
                            content:
                                "Do you want to delete this item from list?",
                            confirm: MaterialButton(
                              child: Text("Yes"),
                              onPressed: () {
                                _addVehicleController.deleteVehicle(vehicle.id,
                                    onDlete: () {
                                  // _controller.userData.value.vehicles
                                  //     .removeAt(index);
                                  _controller.userData.refresh();
                                  Get.back();
                                });
                              },
                            ),
                            cancel: MaterialButton(
                              child: Text("No"),
                              onPressed: () {
                                Get.back();
                              },
                            ));
                      },
                    ),
                    CustomContainer(
                      child: Icon(Icons.edit),
                      height: 50,
                      marginRight: 12,
                      onTap: () {
                        Get.to(() => AddVehicleScreen(
                              postSignup: true,
                              vehicle: vehicle,
                            ));
                      },
                    )
                  ],
                )
              ],
            ),
          );
        },
      ),
    );
  }

  getRow(String label, String value) {
    return Row(
      children: [
        TextWithIcon(
          title: "$label",
          fontWeight: FontWeight.w700,
          fontSize: 14,
          marginRight: 4,
          marginTop: 4,
        ),
        TextWithIcon(
          title: "$value",
          fontWeight: FontWeight.normal,
          fontSize: 14,
          marginTop: 4,
        ),
      ],
    );
  }

  getTitleVeh(String title) {
    var list = title.split(" ");
    String temp = "";
    for (int index = 0; index < list.length; index++) {
      temp = temp + "${list[index].toString().capitalizeFirst} ";
    }
    return temp.trim();
  }

  addVehicleWidget() {
    return CustomContainer(
      width: Get.width,
      height: Get.height,
      onTap: () {
        Get.to(() => AddVehicleScreen(
              postSignup: true,
            ));
      },
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            Icons.add_circle_outline,
            size: 48,
            color: AppColors.appBlue,
          ),
          SizedBox(
            height: 20,
          ),
          TextWithIcon(
            width: Get.width,
            fontSize: 20,
            fontColor: AppColors.appBlue,
            fontWeight: FontWeight.w700,
            title: "Add to click Vehicle",
          )
        ],
      ),
    );
  }

  check() {
    // if (_controller.userData.value.providerType.toString().toLowerCase() ==
    //     "individual") {
    //   if (_controller.userData.value.vehicles.isNotEmpty &&
    //       _controller.userData.value.vehicles.length < 1) {
    //     return true;
    //   }
    //   return false;
    // }

    // if (_controller.userData.value.vehicles.isNotEmpty &&
    //     _controller.userData.value.vehicles.length <= 4) {
    //   return true;
    // }
    return false;
  }
}
