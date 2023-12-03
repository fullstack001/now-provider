import 'package:fare_now_provider/controllers/services/service_controller.dart';
import 'package:fare_now_provider/screens/Controller/add_vehicle_controller.dart';
import 'package:fare_now_provider/screens/auth_screen/profile_data_steps/business_profile_settings_screen.dart';
import 'package:fare_now_provider/screens/auth_screen/profile_data_steps/profile_settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Service {
  String name;
  bool selected = false;

  Service(this.name);
}

class BrandOrServiceProviderScreen extends StatefulWidget {
  static const id = 'brand_or_service_provider_screen';

  @override
  _BrandOrServiceProviderScreenState createState() =>
      _BrandOrServiceProviderScreenState();
}

class _BrandOrServiceProviderScreenState
    extends State<BrandOrServiceProviderScreen> {
  ServiceController _controller = Get.find();
  List<Service> services = [
    Service('I\'m a Service Provider'),
    Service('We are Company/Brand'),
  ];
  Service selectedName = Service('I\'m a Service Provider');

  AddVehicleController _addVehicleController = Get.put(AddVehicleController());

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Container(
          color: Colors.white,
          child: SafeArea(
            child: Scaffold(
              backgroundColor: Colors.white,
              body: Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 50,
                    ),
                    InkWell(
                      onTap: () {
                        Get.back();
                      },
                      child: Icon(Icons.arrow_back),
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Text(
                      "Select To Continue",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 24,
                          fontWeight: FontWeight.w700),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Please select your desired option to continue next.",
                      style: TextStyle(
                          color: Color(0xffBDBDBD),
                          fontWeight: FontWeight.w500,
                          fontSize: 16),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Expanded(
                      child: ListView.builder(
                          itemCount: services.length,
                          itemBuilder: (BuildContext context, int index) {
                            String name = services[index].name;
                            return GestureDetector(
                              onTap: () {
                                var value = services[index];
                                print("abc");
                                _addVehicleController.selectedVehicle.clear();
                                setState(() {
                                  services[index].selected = !value.selected;
                                  services[index == 0 ? 1 : 0].selected =
                                      !value.selected;
                                  _controller.type(services[index].name);
                                });
                              },
                              child: Container(
                                alignment: Alignment.centerLeft,
                                width: Get.width,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                        vertical: 8,
                                      ),
                                      child: Row(
                                        children: [
                                          Icon(
                                            services[index].selected
                                                ? Icons.radio_button_checked
                                                : Icons.radio_button_off,
                                            color: services[index].selected
                                                ? Color(0xff1B80F5)
                                                : Colors.black,
                                          ),
                                          SizedBox(
                                            width: 12,
                                          ),
                                          Expanded(
                                            child: Text(
                                              services[index].name,
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w400,
                                                color: const Color(0xff757575),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Divider()
                                  ],
                                ),
                              ),
                            );
                          }),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(
                          vertical: 16, horizontal: 22),
                      child: ButtonTheme(
                        height: 50,
                        child: TextButton(
                          onPressed: () {
                            _addVehicleController.selectedVehicle.clear();
                            if (_controller.type.isNotEmpty) {
                              if (_controller.type.value == services[0].name) {
                                Navigator.pushNamed(
                                  context,
                                  ProfileSettingsScreen.id,
                                  arguments: true,
                                );
                              } else {
                                Navigator.pushNamed(
                                    context, BusinessProfileSettingsScreen.id,
                                    arguments: true);
                              }
                            } else {
                              Get.defaultDialog(
                                  title: "Alert",
                                  content: Text("You didn't select any option"),
                                  confirm: MaterialButton(
                                    onPressed: () {
                                      Get.back();
                                    },
                                    child: Text("Okay"),
                                  ));
                            }
                          },
                          child: Center(
                              child: Text(
                            "Next",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          )),
                        ),
                      ),
                      decoration: BoxDecoration(
                        color: Color(0xff1B80F5),
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        onWillPop: () async {
          Get.back();
          return true;
        });
  }
}
