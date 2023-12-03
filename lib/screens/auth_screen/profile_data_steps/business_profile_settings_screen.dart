import 'dart:io';

import 'package:fare_now_provider/components/buttons-management/style_model.dart';
import 'package:fare_now_provider/components/text_fields/farenow_text_field.dart';
import 'package:fare_now_provider/controllers/profile_screen_controller/ProfileScreenController.dart';
import 'package:fare_now_provider/controllers/services/service_controller.dart';
import 'package:fare_now_provider/models/add_vehicle/add_vehicle_model.dart';
import 'package:fare_now_provider/models/location_detail/address_components.dart';
import 'package:fare_now_provider/screens/Controller/add_vehicle_controller.dart';
import 'package:fare_now_provider/screens/auth_screen/profile_data_steps/steps_appbar.dart';
import 'package:fare_now_provider/screens/auth_screen/profile_data_steps/steps_controller/step_controller.dart';
import 'package:fare_now_provider/util/api_utils.dart';
import 'package:fare_now_provider/util/app_dialog_utils.dart';
import 'package:fare_now_provider/util/widgest_utills.dart';
import 'package:fare_now_provider/widgets/custom_container.dart';
import 'package:fare_now_provider/widgets/delete_user.dart';
import 'package:fare_now_provider/widgets/text_with_icon.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:progressive_image/progressive_image.dart';

import '../../../components/buttons-management/enum/button_type.dart';
import '../../../components/buttons-management/farenow_button.dart';
import '../../../util/app_colors.dart';

//image_picker remove
class BusinessProfileSettingsScreen extends StatefulWidget {
  static const id = 'business_profile_settings_screen';
  final bool? fromApp;
  final bool? afterLogin;

  const BusinessProfileSettingsScreen(
      {Key? key, this.afterLogin = false, this.fromApp})
      : super(key: key);

  @override
  _BusinessProfileSettingsScreenState createState() =>
      _BusinessProfileSettingsScreenState();
}

class _BusinessProfileSettingsScreenState
    extends State<BusinessProfileSettingsScreen> {
  DateTime selectedDate = DateTime.now();

  ProfileScreenController _controller = Get.find();
  ServiceController _serviceController = Get.find();

  var selectedArea;
  TextEditingController dob = TextEditingController();
  TextEditingController searchBoxController = TextEditingController();

  TextEditingController businessNameController = TextEditingController();
  TextEditingController foundedYearController = TextEditingController();
  TextEditingController numberOfEmployeeController = TextEditingController();
  TextEditingController streetController = TextEditingController();
  TextEditingController suitController = TextEditingController();
  TextEditingController littleRockController = TextEditingController();
  TextEditingController zipCodeController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController _priceController = TextEditingController();
  TextEditingController _bioController = TextEditingController();

  var _formKey = GlobalKey<FormState>();

  getPostalCode(data, flag) {
    var list = data;
    // (data['result']['address_components'] as List<dynamic>)[7]['types'][0];
    for (int index = 0; index < list.length; index++) {
      AddressComponents components = list[index];
      String type = components.types[0];
      if (type.contains(flag)) {
        return list[index].longName;
      }
    }
    return ["n/a"];
  }



  var image;

  _imgFromCamera() async {
    var _image = await ImagePicker()
        .pickImage(source: ImageSource.camera, imageQuality: 50);
    print("");
    image = File(_image!.path);
    setState(() {});
  }

  _imgFromGallery() async {
    var _image = await ImagePicker()
        .pickImage(source: ImageSource.gallery, imageQuality: 50);
    print("");
    image = File(_image!.path);
    setState(() {});
  }

  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: Wrap(
                children: <Widget>[
                  ListTile(
                      leading: const Icon(Icons.photo_library),
                      title: const Text('Photo Library'),
                      onTap: () {
                        _imgFromGallery();
                        Navigator.of(context).pop();
                      }),
                  ListTile(
                    leading: const Icon(Icons.photo_camera),
                    title: const Text('Camera'),
                    onTap: () {
                      _imgFromCamera();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  bool firstInit = false;
  AddVehicleController _addVehicleController = Get.put(AddVehicleController());
  var selectedVehicleList = [AddVehicleModel(name: "Add button")];

  @override
  Widget build(BuildContext context) {
    // setDoneButton();
    bool fromApp = widget.fromApp ?? false;

    if (!firstInit) {
      firstInit = true;
      if (!fromApp) {
      } else {
        if (_controller.userData.value.providerType == "Business") {
          businessNameController.text =
              _controller.userData.value.providerProfile.businessName ?? "";
        } else {
          businessNameController.text =
              "${_controller.userData.value.firstName} ${_controller.userData.value.lastName}";
        }
        foundedYearController.text =
            "${_controller.userData.value.providerProfile.foundedYear}";
        numberOfEmployeeController.text =
            "${_controller.userData.value.providerProfile.numberOfEmployees}";
        _priceController.text =
            "${_controller.userData.value.providerProfile.hourlyRate ?? "0"}";
        streetController.text =
            "${_controller.userData.value.providerProfile.streetAddress}";
        suitController.text =
            "${_controller.userData.value.providerProfile.suiteNumber}";
        littleRockController.text =
            "${_controller.userData.value.providerProfile.city}";
        stateController.text =
            "${_controller.userData.value.providerProfile.state}";
        _bioController.text = "${_controller.userData.value.bio}";
        zipCodeController.text = "${_controller.userData.value.zipCode}";
        // if (_controller.userData.value.providerType == "Business") {
        //   businessNameController.text =
        //       _controller.userData.value.userProfileModel.businessName;
        // } else {
        //   businessNameController.text =
        //       "${_controller.userData.value.firstName} ${_controller.userData.value.lastName}";
        // }
        // foundedYearController.text =
        //     "${_controller.userData.value.userProfileModel.foundedYear}";
        // numberOfEmployeeController.text =
        //     "${_controller.userData.value.userProfileModel.numberOfEmployees}";
        // _priceController.text =
        //     "\$${_controller.userData.value.userProfileModel.hourlyRate ?? "0"}";
        // streetController.text =
        //     "${_controller.userData.value.userProfileModel.streetAddress}";
        // suitController.text =
        //     "${_controller.userData.value.userProfileModel.suiteNumber}";
        // littleRockController.text =
        //     "${_controller.userData.value.userProfileModel.city}";
        // stateController.text =
        //     "${_controller.userData.value.userProfileModel.state}";
        // _bioController.text = "${_controller.userData.value.bio}";
        // zipCodeController.text = "${_controller.userData.value.zipCode}";
      }
      if (fromApp) {
        _addVehicleController.selectedVehicle.clear();
        _serviceController.selectedServiceType = "";
      }
    }
    controllerSelection(businessNameController);
    controllerSelection(foundedYearController);
    controllerSelection(numberOfEmployeeController);
    controllerSelection(_priceController);
    controllerSelection(streetController);
    controllerSelection(suitController);
    controllerSelection(littleRockController);
    controllerSelection(stateController);
    controllerSelection(_bioController);
    controllerSelection(zipCodeController);

    return GetBuilder<StepsController>(
        init: StepsController(),
        builder: (stepController) {
          return Scaffold(
              resizeToAvoidBottomInset: true,
              backgroundColor: white,
              appBar: widget.afterLogin == true
                  ? AppBar(
                      backgroundColor: white,
                      title: const Text(
                        "Edit Profile",
                        style: TextStyle(color: black),
                      ),
                      iconTheme: IconTheme.of(context).copyWith(color: black),
                    )
                  : stepsAppBar(5),
              // appBar: AppBar(
              //   elevation: 2,
              //   centerTitle: true,
              //   backgroundColor: Colors.white,
              //   leading: IconButton(
              //     onPressed: () {
              //       Navigator.pop(context);
              //     },
              //     icon: const Icon(
              //       Icons.arrow_back,
              //       color: Colors.blue,
              //     ),
              //   ),
              //   title: const Text(
              //     "Business Profile Settings",
              //     style: TextStyle(
              //         fontSize: 20, fontWeight: FontWeight.w500, color: Colors.black),
              //   ),
              // ),
              body: SingleChildScrollView(
                // reverse: true,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        businessProfleText(),
                        const SizedBox(
                          height: 30.0,
                        ),
                        proFileImage(
                          imageWidget: _controller.userData.value.image != null
                              ? ProgressiveImage(
                                  placeholder: const AssetImage(
                                      'assets/images/img_profile_place_holder.jpg'),
                                  // size: 1.87KB
                                  thumbnail: NetworkImage(
                                      ApiUtills.imageBaseUrl +
                                          _controller.userData.value.image),
                                  // size: 1.29MB
                                  image: NetworkImage(ApiUtills.imageBaseUrl +
                                      _controller.userData.value.image),
                                  height: 300,
                                  width: 500,
                                )

                              /*Image.network(ApiUtills.imageBaseUrl +
                                _controller.userData.value.image)*/
                              : image != null
                                  ? Image.file(
                                      image,
                                      fit: BoxFit.cover,
                                    )
                                  : Image.asset(
                                      'assets/images/img_profile_place_holder.jpg',
                                      fit: BoxFit.cover,
                                    ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        FarenowTextField(
                            controller: businessNameController,
                            hint: "Business Name",
                            type: TextInputType.name,
                            onValidation: (value) {
                              if (value!.isEmpty) {
                                return "Field required*";
                              }
                              return null;
                            },
                            label: "Business Name"),
                        // const Align(
                        //   alignment: Alignment.topLeft,
                        //   child: Text(
                        //     "Year Founded",
                        //     style: TextStyle(
                        //         fontWeight: FontWeight.bold, fontSize: 20),
                        //   ),
                        // ),
                        const SizedBox(
                          height: 15,
                        ),
                        FarenowTextField(
                            controller: foundedYearController,
                            type: TextInputType.phone,
                            onValidation: (value) {
                              if (value!.isEmpty) {
                                return "Field required*";
                              }
                              return null;
                            },
                            hint: "Year Founded",
                            label: "Year Founded"),
                        // TextFormField(
                        // onFieldSubmitted: (value) {
                        //   numberOfEmployeeNode.requestFocus();
                        // },
                        // focusNode: founderYearNode,
                        //   textInputAction: TextInputAction.next,
                        //   controller: foundedYearController,
                        //   validator: (value) {
                        //     if (value!.isEmpty) {
                        //       return "Field required";
                        //     }
                        //     return null;
                        //   },
                        //   decoration: const InputDecoration(
                        //     filled: true,
                        //     fillColor: Color(0xffF3F4F4),
                        //     hintText: "e.g. 2002",
                        //     hintStyle: TextStyle(
                        //         fontWeight: FontWeight.w400,
                        //         color: Color(0xff757575),
                        //         fontSize: 16),
                        //     enabledBorder: OutlineInputBorder(
                        //         borderSide: BorderSide(
                        //       color: Color(0xffF3F4F4),
                        //     )),
                        //     focusedBorder: OutlineInputBorder(
                        //       borderSide: BorderSide(
                        //         color: Color(0xffF3F4F4),
                        //       ),
                        //     ),
                        //   ),
                        // ),

                        const SizedBox(
                          height: 15,
                        ),
                        // const Align(
                        //   alignment: Alignment.topLeft,
                        //   child: Text(
                        //     "Number of Employees",
                        //     style: TextStyle(
                        //         fontWeight: FontWeight.bold, fontSize: 20),
                        //   ),
                        // ),
                        FarenowTextField(
                            controller: numberOfEmployeeController,
                            type: TextInputType.phone,
                            onValidation: (value) {
                              if (value!.isEmpty) {
                                return "Field required*";
                              }
                              return null;
                            },
                            hint: "Number of Employees",
                            label: "Number of Employees"),
                        // TextFormField(
                        //   onFieldSubmitted: (value) {
                        //     if (checkFlag()) {
                        //       addressNode.requestFocus();
                        //     } else {
                        //       numberOfEmployeeNode.requestFocus();
                        //     }
                        //   },
                        //   focusNode: numberOfEmployeeNode,
                        //   textInputAction: TextInputAction.next,
                        //   controller: numberOfEmployeeController,
                        //   validator: (value) {
                        //     if (value!.isEmpty) {
                        //       return "Field required";
                        //     }
                        //     return null;
                        //   },
                        //   decoration: const InputDecoration(
                        //     filled: true,
                        //     fillColor: Color(0xffF3F4F4),
                        //     hintText: "e.g. 1",
                        //     hintStyle: TextStyle(
                        //         fontWeight: FontWeight.w400,
                        //         color: Color(0xff757575),
                        //         fontSize: 16),
                        //     enabledBorder: OutlineInputBorder(
                        //         borderSide: BorderSide(
                        //       color: Color(0xffF3F4F4),
                        //     )),
                        //     focusedBorder: OutlineInputBorder(
                        //       borderSide: BorderSide(
                        //         color: Color(0xffF3F4F4),
                        //       ),
                        //     ),
                        //   ),
                        // ),

                        if (checkFlag())
                          // Column(
                          //   children: [
                          //     SizedBox(
                          //       height: 20,
                          //     ),
                          //     Align(
                          //       alignment: Alignment.topLeft,
                          //       child: Text(
                          //         "Hourly Rate",
                          //         style: TextStyle(
                          //             fontWeight: FontWeight.bold,
                          //             fontSize: 20),
                          //       ),
                          //     ),
                          //     SizedBox(
                          //       height: 20,
                          //     ),
                          //     TextFormField(
                          //       onFieldSubmitted: (value) {
                          //         addressNode.requestFocus();
                          //       },
                          //       focusNode: hourlyRateNode,
                          //       textInputAction: TextInputAction.next,
                          //       keyboardType: TextInputType.number,
                          //       validator: (val) {
                          //         if (val!.isEmpty) {
                          //           return "Field required";
                          //         }
                          //         return null;
                          //       },
                          //       onChanged: (value) {
                          //         value = value.replaceAll("\$", "");
                          //         value = "\$$value";
                          //         _priceController.text = value;
                          //         _priceController.selection = TextSelection(
                          //             baseOffset: value.length,
                          //             extentOffset: value.length);
                          //       },
                          //       controller: _priceController,
                          //       decoration: InputDecoration(
                          //         filled: true,
                          //         fillColor: Color(0xffF3F4F4),
                          //         hintText: "\$10 per hour",
                          //         hintStyle: TextStyle(
                          //             fontWeight: FontWeight.w400,
                          //             color: Color(0xff757575),
                          //             fontSize: 16),
                          //         enabledBorder: new OutlineInputBorder(
                          //             borderSide: new BorderSide(
                          //           color: Color(0xffF3F4F4),
                          //         )),
                          //         focusedBorder: OutlineInputBorder(
                          //           borderSide: BorderSide(
                          //             color: Color(0xffF3F4F4),
                          //           ),
                          //         ),
                          //       ),
                          //     ),
                          //   ],
                          // ),

                          // const Align(
                          //   alignment: Alignment.topLeft,
                          //   child: Text(
                          //     "Business Address",
                          //     style: TextStyle(
                          //         fontWeight: FontWeight.bold, fontSize: 20),
                          //   ),
                          // ),
                          const SizedBox(
                            height: 15,
                          ),
                        FarenowTextField(
                            controller: streetController,
                            onValidation: (value) {
                              if (value!.isEmpty) {
                                return "Field required*";
                              }
                              return null;
                            },
                            hint: "Business Address",
                            label: "Business Address"),
                        // TextFormField(
                        //   onFieldSubmitted: (value) {
                        //     apartmentNode.requestFocus();
                        //   },
                        //   focusNode: addressNode,
                        //   textInputAction: TextInputAction.next,
                        //   controller: streetController,
                        //   decoration: InputDecoration(
                        //     filled: true,
                        //     fillColor: Color(0xffF3F4F4),
                        //     hintText: "Street Address",
                        //     hintStyle: TextStyle(
                        //         fontWeight: FontWeight.w400,
                        //         color: Color(0xff757575),
                        //         fontSize: 16),
                        //     enabledBorder: OutlineInputBorder(
                        //         borderSide: BorderSide(
                        //       color: Color(0xffF3F4F4),
                        //     )),
                        //     focusedBorder: OutlineInputBorder(
                        //       borderSide: BorderSide(
                        //         color: Color(0xffF3F4F4),
                        //       ),
                        //     ),
                        //   ),
                        // ),

                        const SizedBox(
                          height: 15,
                        ),
                        FarenowTextField(
                            controller: suitController,
                            hint: "Street",
                            onValidation: (value) {
                              if (value!.isEmpty) {
                                return "Field required*";
                              }
                              return null;
                            },
                            label: "Street"),
                        // TextFormField(
                        //   onFieldSubmitted: (value) {
                        //     cityNode.requestFocus();
                        //   },
                        //   focusNode: apartmentNode,
                        //   textInputAction: TextInputAction.next,
                        //   controller: suitController,
                        //   decoration: const InputDecoration(
                        //     filled: true,
                        //     fillColor: Color(0xffF3F4F4),
                        //     hintText: "Apartment",
                        //     hintStyle: TextStyle(
                        //         fontWeight: FontWeight.w400,
                        //         color: Color(0xff757575),
                        //         fontSize: 16),
                        //     enabledBorder: OutlineInputBorder(
                        //         borderSide: BorderSide(
                        //       color: Color(0xffF3F4F4),
                        //     )),
                        //     focusedBorder: OutlineInputBorder(
                        //       borderSide: BorderSide(
                        //         color: Color(0xffF3F4F4),
                        //       ),
                        //     ),
                        //   ),
                        // ),

                        const SizedBox(
                          height: 15,
                        ),
                        FarenowTextField(
                            controller: littleRockController,
                            onValidation: (value) {
                              if (value!.isEmpty) {
                                return "Field required*";
                              }
                              return null;
                            },
                            hint: "State",
                            label: "State/Region"),
                        // TextFormField(
                        //   onFieldSubmitted: (value) {
                        //     countryNode.requestFocus();
                        //   },
                        //   focusNode: cityNode,
                        //   textInputAction: TextInputAction.next,
                        //   controller: littleRockController,
                        //   decoration: const InputDecoration(
                        //     filled: true,
                        //     fillColor: Color(0xffF3F4F4),
                        //     hintText: "State",
                        //     hintStyle: TextStyle(
                        //         fontWeight: FontWeight.w400,
                        //         color: Color(0xff757575),
                        //         fontSize: 16),
                        //     enabledBorder: OutlineInputBorder(
                        //         borderSide: BorderSide(
                        //       color: Color(0xffF3F4F4),
                        //     )),
                        //     focusedBorder: OutlineInputBorder(
                        //       borderSide: BorderSide(
                        //         color: Color(0xffF3F4F4),
                        //       ),
                        //     ),
                        //   ),
                        // ),

                        const SizedBox(
                          height: 15,
                        ),
                        FarenowTextField(
                            controller: stateController,
                            onValidation: (value) {
                              if (value!.isEmpty) {
                                return "Field required*";
                              }
                              return null;
                            },
                            hint: "Country",
                            label: "Country"),
                        // TextFormField(
                        //   onFieldSubmitted: (value) {
                        //     zipCodeNode.requestFocus();
                        //   },
                        //   focusNode: countryNode,
                        //   validator: (value) {
                        //     if (value!.isEmpty) {
                        //       return "field required";
                        //     }
                        //   },
                        //   textInputAction: TextInputAction.next,
                        //   controller: stateController,
                        //   decoration: const InputDecoration(
                        //     filled: true,
                        //     fillColor: Color(0xffF3F4F4),
                        //     hintText: "Country",
                        //     hintStyle: TextStyle(
                        //         fontWeight: FontWeight.w400,
                        //         color: Color(0xff757575),
                        //         fontSize: 16),
                        //     enabledBorder: OutlineInputBorder(
                        //         borderSide: BorderSide(
                        //       color: Color(0xffF3F4F4),
                        //     )),
                        //     focusedBorder: OutlineInputBorder(
                        //       borderSide: BorderSide(
                        //         color: Color(0xffF3F4F4),
                        //       ),
                        //     ),
                        //   ),
                        // ),

                        /* const SizedBox(
                          height: 15,
                        ),
                        FarenowTextField(
                            controller: zipCodeController,
                            onValidation:  ( value) {
                              if (value!.isEmpty) {
                                return "Field required*";
                              }
                              return null;
                            },
                            hint: "Enter zip code",
                            label: "Zip Code"),*/
                        // TextFormField(
                        //   onFieldSubmitted: (value) {
                        //     bioNode.requestFocus();
                        //   },
                        //   focusNode: zipCodeNode,
                        //   textInputAction: TextInputAction.next,
                        //   controller: zipCodeController,
                        //   decoration: const InputDecoration(
                        //     filled: true,
                        //     fillColor: Color(0xffF3F4F4),
                        //     hintText: "Zip Code",
                        //     hintStyle: TextStyle(
                        //         fontWeight: FontWeight.w400,
                        //         color: Color(0xff757575),
                        //         fontSize: 16),
                        //     enabledBorder: OutlineInputBorder(
                        //         borderSide: BorderSide(
                        //       color: Color(0xffF3F4F4),
                        //     )),
                        //     focusedBorder: OutlineInputBorder(
                        //       borderSide: BorderSide(
                        //         color: Color(0xffF3F4F4),
                        //       ),
                        //     ),
                        //   ),
                        // ),

                        const SizedBox(
                          height: 20,
                        ),
                        if (_serviceController.selectedServiceType ==
                                "moving" &&
                            !fromApp)
                          Obx(() => Column(
                                children: [
                                  const Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Select Vehicle",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20),
                                      ),
                                    ],
                                  ),
                                  if (_serviceController.selectedServiceType ==
                                      "moving")
                                    const SizedBox(
                                      height: 6,
                                    ),
                                  // if (_serviceController.selectedServiceType ==
                                  //     "moving")
                                  CustomContainer(
                                    width: Get.width,
                                    alignment: Alignment.topLeft,
                                    child: vehicleList(),
                                  ),
                                  const SizedBox(
                                    height: 6,
                                  ),
                                ],
                              )),

                        FarenowTextField(
                            controller: _bioController,
                            onSubmit: (value) {},
                            inputAction: TextInputAction.done,
                            onValidation: (value) {
                              if (value!.isEmpty) {
                                return "Field required*";
                              }
                              return null;
                            },
                            maxLine: 5,
                            hint: "Enter Bio",
                            label: "Bio"),

                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Padding(
                            padding: const EdgeInsets.only(
                                top:
                                    20), //todo changed from bottom 24 to top 20
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                widget.afterLogin == true
                                    ? FarenowButton(
                                        style: FarenowButtonStyleModel(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 3)),
                                        title: "Submit",
                                        onPressed: () {
                                          if (!_formKey.currentState!
                                              .validate()) {
                                            return;
                                          }
                                          bool isMoving = _serviceController
                                                      .selectedServiceType ==
                                                  "moving"
                                              ? true
                                              : false;
                                          String businessName =
                                              businessNameController.text
                                                  .toString();
                                          String foundedYear =
                                              foundedYearController.text
                                                  .toString();
                                          String numberOfEmp =
                                              numberOfEmployeeController.text
                                                  .toString();
                                          String streetAddress =
                                              streetController.text.toString();
                                          String city = littleRockController
                                              .text
                                              .toString();
                                          String zipCode =
                                              zipCodeController.text.toString();
                                          String suit =
                                              suitController.text.toString();
                                          String type = "business";

                                          Map _body = <String, dynamic>{
                                            "type": type,
                                            "street_address": streetAddress,
                                            "suite_number": suit,
                                            "state": stateController.text,
                                            "city": city,
                                            // "zip_code": zipCode,
//first_name:nouman
//last_name:amin
//dob:10-10-2021
                                            // "zip_code":"",
                                            "business_name": businessName,
                                            "service_type":
                                                isMoving ? "MOVING" : "SERVICE",
                                            "founded": foundedYear,
                                            "number_of_employees": numberOfEmp,
                                            "hourly_rate": null,
                                            "bio":
                                                _bioController.text.toString()
                                          };

                                          var vehicleBody;
                                          if (isMoving) {
                                            removeAddButton();
                                            vehicleBody = _addVehicleController
                                                .selectedVehicle.value
                                                .map((v) => v.toJson())
                                                .toList();
                                          }
                                          print("");
                                          _serviceController.businessSignup(
                                              _body,
                                              image,
                                              isMoving,
                                              vehicleBody,
                                              widget.fromApp,
                                              false);
                                          stepController.nextstepCounter();
                                          /* if (image != null) {
                                            _serviceController.businessSignup(
                                                _body,
                                                image,
                                                isMoving,
                                                vehicleBody,
                                                widget.fromApp,
                                                false);
                                            stepController.nextstepCounter();
                                          } else {
                                            AppDialogUtils.errorDialog("Image is null. Please select an image.");
                                          }*/

                                          // Get.to(Step4.new);
                                        },
                                        type: BUTTONTYPE.rectangular)
                                    : Container(
                                        //todo added a container
                                        color: Colors.white,
                                        child: Column(
                                          children: [
                                            FarenowButton(
                                                style: FarenowButtonStyleModel(
                                                    padding:
                                                        const EdgeInsets.symmetric(
                                                            vertical: 3)),
                                                title: "Next",
                                                onPressed: () async {
                                                  if (!_formKey.currentState!
                                                      .validate()) {
                                                    return;
                                                  }
                                                  bool isMoving = _serviceController
                                                              .selectedServiceType ==
                                                          "moving"
                                                      ? true
                                                      : false;
                                                  String businessName =
                                                      businessNameController
                                                          .text
                                                          .toString();
                                                  String foundedYear =
                                                      foundedYearController.text
                                                          .toString();
                                                  String numberOfEmp =
                                                      numberOfEmployeeController
                                                          .text
                                                          .toString();
                                                  String streetAddress =
                                                      streetController.text
                                                          .toString();
                                                  String city =
                                                      littleRockController.text
                                                          .toString();
                                                  String zipCode =
                                                      zipCodeController.text
                                                          .toString();
                                                  String suit = suitController
                                                      .text
                                                      .toString();
                                                  String type = "business";

                                                  Map _body = <String, dynamic>{
                                                    "type": type,
                                                    "street_address":
                                                        streetAddress,
                                                    "suite_number": suit,
                                                    "state":
                                                        stateController.text,
                                                    "city": city,
                                                    // "zip_code": "",
//first_name:nouman
//last_name:amin
//dob:10-10-2021

                                                    "business_name":
                                                        businessName,
                                                    "service_type": isMoving
                                                        ? "MOVING"
                                                        : "SERVICE",
                                                    "founded": foundedYear,
                                                    "number_of_employees":
                                                        numberOfEmp,
                                                    "hourly_rate": null,
                                                    "bio": _bioController.text
                                                        .toString()
                                                  };

                                                  var vehicleBody;
                                                  if (isMoving) {
                                                    removeAddButton();
                                                    vehicleBody =
                                                        _addVehicleController
                                                            .selectedVehicle
                                                            .value
                                                            .map((v) =>
                                                                v.toJson())
                                                            .toList();
                                                  }
                                                  print("");
                                                  if(image==null){
                                                    AppDialogUtils.errorDialog("Image Is required");
                                                  }
                                                  else{
                                                    _serviceController
                                                        .businessSignup(
                                                        _body,
                                                        image,
                                                        isMoving,
                                                        vehicleBody,
                                                        widget.fromApp,
                                                        false);
                                                    stepController
                                                        .nextstepCounter();
                                                  }


                                                  /*  if (image != null) {
                                    _serviceController.businessSignup(
                                        _body,
                                        image,
                                        isMoving,
                                        vehicleBody,
                                        widget.fromApp,
                                        false);
                                    stepController.nextstepCounter();
                                  } else {
                                    AppDialogUtils.errorDialog("Image is null. Please select an image.");
                                  }
*/

                                                  // Get.to(Step4.new);
                                                },
                                                type: BUTTONTYPE.rectangular),
                                            FarenowButton(
                                                style: FarenowButtonStyleModel(
                                                    padding:
                                                        const EdgeInsets.symmetric(
                                                            vertical: 12)),
                                                title: "Previous",
                                                onPressed: () {
                                                  stepController
                                                      .previousstepCounter();
                                                  Get.back();
                                                },
                                                type: BUTTONTYPE.action),
                                          ],
                                        ),
                                      ),
                                widget.afterLogin == true
                                    ? FarenowButton(
                                        style: FarenowButtonStyleModel(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 12)),
                                        title: "Delete Provider",
                                        onPressed: () {
                                          Get.dialog(DeleteUser());
                                        },
                                        type: BUTTONTYPE.action)
                                    : Container(),
                                23.height,
                              ],
                            ),
                          ),
                        ),
                        Padding(
                            padding: EdgeInsets.only(
                                bottom:
                                    MediaQuery.of(context).viewInsets.bottom))
                      ],
                    ),
                  ),
                ),
              ));
        });
  }

  proFileImage({imageWidget}) {
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
          ),
          child: ClipOval(
            child: imageWidget,
          ),
        ),
        InkWell(
          onTap: () => _showPicker(context),
          child: Container(
            width: 27,
            height: 27,
            decoration: BoxDecoration(
                color: const Color(0xff00B181),
                borderRadius: BorderRadius.circular(20)),
            child: const Icon(
              Icons.edit,
              color: Colors.white,
              size: 15,
            ),
          ),
        )
      ],
    );
  }

  vehicleItem(int index, var selectedVehicle) {
    AddVehicleModel value = selectedVehicle[index];
    return value.name == "Add button"
        ? getWidget(value)
        : CustomContainer(
            color: Colors.white,
            shadowColor: Colors.black.withOpacity(0.5),
            shadowBlurRadius: 5,
            marginTop: 12,
            marginLeft: index == 0 ? 0 : 0,
            marginBottom: 12,
            shadowSpreadRadius: 3,
            shadowOffsetY: 3,
            shadowOffsetX: 3,
            allRadius: 12,
            marginRight: 12,
            paddingBottom: 6,
            child: Stack(
              alignment: Alignment.topRight,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 12,
                    ),
                    (value.image ?? "") == ""
                        ? Container(
                            width: 100,
                            height: 60,
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: AssetImage(
                                  "assets/img_vehicle.png",
                                ),
                              ),
                            ),
                          )
                        : cacheNetworkImage(
                            imageWidth: 70,
                            imageHeight: 60,
                            fit: BoxFit.fitWidth,
                            imageUrl: "${ApiUtills.imageBaseUrl}${value.image}",
                            placeHolder: "assets/img_vehicle.png"),
                    TextWithIcon(
                      width: 100,
                      title: value.name,
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                    TextWithIcon(
                      width: 100,
                      title: value.companyName,
                      fontSize: 14,
                      fontWeight: FontWeight.w300,
                    ),
                  ],
                ),
                CustomContainer(
                  borderColor: Colors.red,
                  borderWidth: 2,
                  allRadius: 20,
                  onTap: () {
                    alertDialog(
                      title: "Alert",
                      content: "Do you want to remove this item?",
                      confirm: MaterialButton(
                        child: const Text("Yes"),
                        onPressed: () {
                          _addVehicleController.selectedVehicle.removeAt(index);
                          Get.back();
                          setState(() {});
                        },
                      ),
                      cancel: MaterialButton(
                        child: const Text("No"),
                        onPressed: () {
                          Get.back();
                        },
                      ),
                    );
                  },
                  child: const Icon(
                    Icons.close_rounded,
                    color: Colors.red,
                    size: 20,
                  ),
                )
              ],
            ),
          );
  }

  check() {
    // if (_controller.userData.value.vehicles == null) {
    //   return false;
    // }
    // if (_controller.userData.value.providerType.toString().toLowerCase() ==
    //     "individual") {
    //   if (_controller.userData.value.vehicles.isNotEmpty &&
    //       _controller.userData.value.vehicles.length < 1) {
    //     return true;
    //   }
    //   return false;
    // }
    return false;
  }

  getImageUrl(cont) {
    if (cont.value.image == null) {
      return "";
    }
    var url = "${ApiUtills.imageBaseUrl + cont.value.image.toString()}";
    return url;
  }

  vehicleList() {
    var list = _addVehicleController.selectedVehicle.value;
    if (!exist(list)) {
      list.addAll(selectedVehicleList);
    }
    print("${list.length}");
    list = list.reversed.toList();
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          for (int index = 0; index < list.length; index++)
            vehicleItem(index, list)
        ],
      ),
    );
  }

  bool exist(List<dynamic> list) {
    for (int index = 0; index < list.length; index++) {
      if (list[index].name == "Add button") {
        return true;
      }
    }
    return false;
  }

  getWidget(AddVehicleModel value) {
    if (_addVehicleController.selectedVehicle.length < 6) {
      return CustomContainer(
        width: 100,
        height: 100,
        color: Colors.grey.shade400,
        marginTop: 12,
        allRadius: 12,
        marginBottom: 12,
        onTap: () {
          _addVehicleController.getTypes();
        },
        child: const Icon(
          Icons.add,
          size: 40,
          color: Colors.white,
        ),
      );
    }
    return emptyContainer();
  }

  void removeAddButton() {
    for (int index = 0;
        index < _addVehicleController.selectedVehicle.value.length;
        index++) {
      if (_addVehicleController.selectedVehicle.value[index].name ==
          "Add button") {
        _addVehicleController.selectedVehicle.value.removeAt(index);
      }
    }
  }

  checkFlag() {
    if (_controller.userData.value.serviceType == "MOVING") {
      return false;
    }
    return true;
  }

  Container businessProfleText() {
    return Container(
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 16),
      child: const Text(
        "Set up your company profile", //todo
        style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: AppColors.solidBlue),
      ),
    );
  }
}
