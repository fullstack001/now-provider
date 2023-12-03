import 'package:fare_now_provider/controllers/profile_screen_controller/ProfileScreenController.dart';
import 'package:fare_now_provider/models/add_vehicle/add_vehicle_model.dart';
import 'package:fare_now_provider/screens/Controller/add_vehicle_controller.dart';
import 'package:fare_now_provider/screens/add_vehicle_screen.dart';
import 'package:fare_now_provider/util/api_utils.dart';
import 'package:fare_now_provider/util/app_colors.dart';
import 'package:fare_now_provider/util/app_dialog_utils.dart';
import 'package:fare_now_provider/util/widgest_utills.dart';
import 'package:fare_now_provider/widgets/custom_container.dart';
import 'package:fare_now_provider/widgets/custom_toolbar.dart';
import 'package:fare_now_provider/widgets/text_with_icon.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MovingListScreen extends StatelessWidget {
  MovingListScreen({Key? key}) : super(key: key);
  AddVehicleController _addVehicleController = Get.find();

  ProfileScreenController _screenController = Get.find();

  int limit = 1;

  @override
  Widget build(BuildContext context) {
    // limit = -1;
    return Obx(() {
      limit =
          _screenController.userData.value.providerType == "Business" ? 5 : 1;
      List list = _addVehicleController.selectedVehicle.value;
      return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          elevation: 2,
          centerTitle: true,
          flexibleSpace: CustomToolbar(
            title: "Vehicle List",
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back,
                color: Colors.blue,
              ),
            ),
            trailing: list.isEmpty || list.length > limit - 1
                ? SizedBox(
                    width: 44,
                  )
                : Row(
                    children: [
                      InkWell(
                        onTap: () {
                          _addVehicleController.getTypes();
                        },
                        child: Icon(
                          Icons.add_circle_outline_outlined,
                          size: 32,
                        ),
                      ),
                      SizedBox(
                        width: 12,
                      )
                    ],
                  ),
          ),
          backgroundColor: Colors.white,
        ),
        body: Container(
          width: Get.width,
          height: Get.height,
          child: Column(
            children: [
              list.isEmpty
                  ? Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Container(
                              width: Get.width,
                              height: Get.height,
                              child: InkWell(
                                onTap: () {
                                  _addVehicleController.getTypes();
                                },
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.add_circle_outline_outlined,
                                      size: 48,
                                    ),
                                    SizedBox(
                                      height: 12,
                                    ),
                                    Text(
                                      "Add Vehicle",
                                      style: TextStyle(fontSize: 18),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  : Expanded(
                      child: Container(
                        width: Get.width,
                        height: Get.height,
                        child: ListView(
                          children: [
                            Wrap(
                              alignment: WrapAlignment.start,
                              children: [
                                for (int index = 0;
                                    index < list.length;
                                    index++)
                                  // vehicleItem(1, 99, list)
                                  Container(
                                    child: vehicleItem(
                                        index, list.length - 1, list),
                                    width: Get.width,
                                    alignment: Alignment.center,
                                    margin: EdgeInsets.only(top: 12),
                                  )
                              ],
                            ),
                            SizedBox(
                              height: 12,
                            ),
                          ],
                        ),
                      ),
                    ),
              if (list.isNotEmpty)
                InkWell(
                  onTap: () {
                    var vehicleBody = _addVehicleController
                        .selectedVehicle.value
                        .map((v) => v.toJson())
                        .toList();
                    print("Vechile Result==========${vehicleBody.toString()}");
                    _addVehicleController.addVehicles(vehicleBody);
                  },
                  child: Container(
                    width: Get.width,
                    height: 50,
                    margin: EdgeInsets.all(12),
                    child: Material(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                      elevation: 12,
                      shadowColor: AppColors.appBlue.withOpacity(0.5),
                      child: Container(
                          width: Get.width,
                          height: 50,
                          alignment: Alignment.center,
                          child: Text(
                            "Next",
                            style: TextStyle(
                              color: AppColors.white,
                              fontSize: 16,
                            ),
                          )),
                      color: AppColors.appBlue,
                    ),
                  ),
                )
            ],
          ),
        ),
      );
    });
  }

  vehicleItem(int index, int size, List<dynamic> list) {
    AddVehicleModel value = list[index];
    var type = getVehicleType(value.vehicleTypeId);
    return CustomContainer(
      width: Get.width,
      marginLeft: 12,
      marginRight: 12,
      marginTop: index == 0 ? 0 : 12,
      marginBottom: index == size - 1 ? 0 : 0,
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
            height: 80,
            width: 100,
            paddingAll: 12,
            child: cacheNetworkImage(
              imageUrl: ApiUtills.imageBaseUrl + value.image,
              fit: BoxFit.fill,
              imageWidth: 120,
              imageHeight: 100,
              placeHolder: "assets/img_vehicle.png",
            ),
          ),
          Expanded(
              child: Column(
            children: [
              // TextWithIcon(
              //   title:
              //   "${getTitleVeh(vehicle.vehicleType == null ? "" : vehicle.vehicleType.title)}: ${vehicle.name}",
              //   marginTop: 12,
              //   fontSize: 18,
              //   fontWeight: FontWeight.w700,
              // ),
              Container(
                width: Get.width,
                height: 1,
              ),
              getRow("Company:", value.companyName),
              getRow("Model Number:", value.model),
              getRow("Condition:", value.condition),
              SizedBox(
                height: 12,
              )
            ],
          )),
          Container(
            height: 70,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CustomContainer(
                  child: Icon(Icons.delete_rounded,size: 28,),
                  marginRight: 12,
                  onTap: () {
                    alertDialog(
                        title: "Alert",
                        content: "Do you want to delete this item from list?",
                        confirm: MaterialButton(
                          child: Text("Yes"),
                          onPressed: () {
                            _addVehicleController.selectedVehicle.removeAt(index);
                            Get.back();
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
              ],
            ),
          ),
        ],
      ),
    );
    //   Container(
    //   width: Get.width,
    //   child: Row(
    //     children: [
    //       Text("${value.name}"),
    //     ],
    //   ),
    // );
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

  getVehicleType(vehicleTypeId) {
    List list = _addVehicleController.typeResponse.value;
    print("sdf");
    for (int index = 0; index < list.length; index++) {
      if (_addVehicleController.typeResponse.value[index].id == vehicleTypeId) {
        return _addVehicleController.typeResponse.value[index].type;
      }
    }
    return "N/A";
  }
}
