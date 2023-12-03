import 'dart:io';

import 'package:fare_now_provider/components/buttons-management/style_model.dart';
import 'package:fare_now_provider/components/text_fields/farenow_text_field.dart';
import 'package:fare_now_provider/controllers/profile_screen_controller/ProfileScreenController.dart';
import 'package:fare_now_provider/controllers/services/service_controller.dart';
import 'package:fare_now_provider/custom_packages/keyboard_overlay/keyboard_overlay.dart';
import 'package:fare_now_provider/models/add_vehicle/add_vehicle_model.dart';
import 'package:fare_now_provider/models/location_detail/address_components.dart';
import 'package:fare_now_provider/screens/Controller/add_vehicle_controller.dart';
import 'package:fare_now_provider/screens/auth_screen/profile_data_steps/steps_appbar.dart';
import 'package:fare_now_provider/screens/auth_screen/profile_data_steps/steps_controller/step_controller.dart';
import 'package:fare_now_provider/screens/bottom_navigation.dart';
import 'package:fare_now_provider/screens/profile_screen.dart';
import 'package:fare_now_provider/util/api_utils.dart';
import 'package:fare_now_provider/util/app_dialog_utils.dart';
import 'package:fare_now_provider/util/date_time_utills.dart';
import 'package:fare_now_provider/util/widgest_utills.dart';
import 'package:fare_now_provider/widgets/custom_container.dart';
import 'package:fare_now_provider/widgets/delete_user.dart';
import 'package:fare_now_provider/widgets/text_with_icon.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../components/buttons-management/part_of_file/part.dart';
import '../../../util/app_colors.dart';
import '../../../util/shared_reference.dart';

//image_picker remove
class ProfileSettingsScreen extends StatefulWidget {
  static const id = 'profile_settings_screen';

  final bool? afterLogin;
  final bool? postLogin;

  const ProfileSettingsScreen(
      {Key? key, this.afterLogin = false, this.postLogin})
      : super(key: key);

  @override
  _ProfileSettingsScreenState createState() => _ProfileSettingsScreenState();
}

class _ProfileSettingsScreenState extends State<ProfileSettingsScreen>
    with HandleFocusNodesOverlayMixin {
  SharedRefrence preferences = SharedRefrence();
  final double maxHeight = 1200;
  final double maxWidth = 1200;
  var image;
  final AddVehicleController _addVehicleController =
      Get.put(AddVehicleController());

  Future<bool> getContactsPermission() async {
    return await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Requires Contacts Permission'),
            content: const SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text('This application requires access to your contacts'),
                  Text('Please allow access'),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('Allow'),
                onPressed: () async {
                  final response = await Permission.camera.request().isGranted;
                  if (response != PermissionStatus.granted) {
                    Navigator.of(context).pop();
                    return;
                  }
                },
              ),
              TextButton(
                child: const Text('Cancel'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }

  _imgFromCamera() async {
    var _image = await ImagePicker().pickImage(
      source: ImageSource.camera,
      imageQuality: 85,
      maxWidth: maxWidth,
      maxHeight: maxHeight,
    );
    print("");
    image = File(_image!.path);
    setState(() {});
  }

  _imgFromGallery() async {
    var _image = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      imageQuality: 85,
      maxWidth: maxWidth,
      maxHeight: maxHeight,
    );
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

  DateTime selectedDate = DateTime(2002, 2, 26, 9, 0,
      0); //todo changed this from current time since user is not allowed to be able to select the present time so need to reduce the last date they can select fromso it must not be the current time
  var selectedArea;
  final ProfileScreenController _controller = Get.find();
  final ServiceController _serviceController = Get.find();

  String? isoCode;
  String? findCurrencyCode;

  TextEditingController dob = TextEditingController();
  TextEditingController searchBoxController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController zipController = TextEditingController(text: "");
  TextEditingController streetController = TextEditingController();
  TextEditingController suitController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _bioController = TextEditingController(text: "");

  Future<void> _selectDate(BuildContext context) async {
    print(DateTime.now());
    final picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(1900, 8),
        lastDate: DateTime(
            2022, 11, 30)); //todo changed it so user can't select current time
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        String date = DateTimeUtils().parseDateTime(selectedDate, "dd/MM/yyyy");
        dob.text = date;
        print("Date ${dob.text}");
      });
    }
  }

 final _formKey = GlobalKey<FormState>();

  // final bool _isLoading = false;
  // var _pickedImage;

  getPostalCode(data, flag) {
    if (data.length == 0) {
      return "N/A";
    }
    var list = data;
    // (data['result']['address_components'] as List<dynamic>)[7]['types'][0];
    for (int index = 0; index < list.length; index++) {
      AddressComponents components = list[index];
      String type = components.types[0];
      if (type.contains(flag)) {
        return list[index].longName;
      }
    }
    return "n/a";
  }

  String? currencyValue;
  bool firstInit = false;
  var selectedVehicleList = [AddVehicleModel(name: "Add button")];
  countryCurrency() async {
    _controller
        .fetchDataForCurrency(await SharedRefrence().getIsocode(key: "IsoCode"))
        .then((value) async {
      findCurrencyCode = value;
      print("Dataahddshfdsfjsdhf;sdj============${findCurrencyCode}");
      await SharedRefrence()
          .saveCurrencyCode(key: "CurrencyCode", data: findCurrencyCode);
      await SharedRefrence().getCurrencyCode(key: "CurrencyCode").then((value) {
        currencyValue = value;
        print("valueeeeeeeeeeeee of currency ====$currencyValue");
      });
    });
  }

  @override
  void initState() {
    super.initState();
    countryCurrency();
  }

  @override
  Widget build(BuildContext context) {
    bool postLogin = widget.postLogin ?? false;
    // firstInit = false;
    if (!firstInit) {
      firstInit = true;
      // String addrs = "";
      firstInit = true;
      if (kDebugMode) {
        _bioController.text = "service provider in your area ";
      }
      firstNameController.text = firstNameController.text.isEmpty
          ? getFirstName(_controller.userData.value)
          : firstNameController.text;
      lastNameController.text = lastNameController.text.isEmpty
          ? getLastName(_controller.userData.value)
          : lastNameController.text;

      if (!(widget.afterLogin ?? false)) {
        streetController.text = streetController.text.isEmpty
            ? _serviceController.address.value
            : streetController.text;
      } else {
        streetController.text = (streetController.text.isEmpty
            ? _controller.userData.value.providerProfile == null
                ? ""
                : _controller.userData.value.providerProfile!.streetAddress
            : streetController.text)!;
        suitController.text = (suitController.text.isEmpty
            ? _controller.userData.value.providerProfile == null
                ? ""
                : _controller.userData.value.providerProfile!.suiteNumber ?? ""
            : suitController.text)!;

        zipController.text = _controller.userData.value.zipCode ?? "";

        _priceController.text = _controller.userData.value.providerProfile ==
                null
            ? ""
            : "${_controller.userData.value.providerProfile!.hourlyRate ?? ""}";
        _bioController.text = _controller.userData.value.bio ?? "";

        dob.text = _controller.userData.value.providerProfile == null
            ? ""
            : "${_controller.userData.value.providerProfile!.dob ?? ""}";

        cityController.text = _controller.userData.value.providerProfile == null
            ? ""
            : "${_controller.userData.value.providerProfile!.city ?? ""}";
        countryController.text = _controller.userData.value.providerProfile ==
                null
            ? ""
            : "${_controller.userData.value.providerProfile!.country ?? ""}";

        stateController.text =
            _controller.userData.value.providerProfile == null
                ? ""
                : "${_controller.userData.value.providerProfile!.state ?? ""}";

        // streetController.text = streetController.text.isEmpty
        //     ? _controller.userData.value.userProfileModel == null
        //         ? ""
        //         : _controller.userData.value.userProfileModel.streetAddress
        //     : streetController.text;
        // suitController.text = suitController.text.isEmpty
        //     ? _controller.userData.value.userProfileModel == null
        //         ? ""
        //         : _controller.userData.value.userProfileModel.suiteNumber
        //     : suitController.text;

        // zipController.text = _controller.userData.value.zipCode;

        // _priceController.text =
        //     _controller.userData.value.userProfileModel == null
        //         ? ""
        //         : "\$${_controller.userData.value.userProfileModel.hourlyRate}";
        // _bioController.text = _controller.userData.value.bio ?? "";

        // dob.text = _controller.userData.value.userProfileModel == null
        //     ? ""
        //     : "${_controller.userData.value.userProfileModel.dob}";

        // cityController.text =
        //     _controller.userData.value.userProfileModel == null
        //         ? ""
        //         : "${_controller.userData.value.userProfileModel.city}";

        // stateController.text =
        //     _controller.userData.value.userProfileModel == null
        //         ? ""
        //         : "${_controller.userData.value.userProfileModel.state}";
      }

      controllerSelection(dob);
      controllerSelection(_bioController);
      controllerSelection(stateController);
      controllerSelection(cityController);
      controllerSelection(countryController);
      controllerSelection(streetController);
      controllerSelection(suitController);
      controllerSelection(zipController);
      controllerSelection(_priceController);
    }
    var trues = ModalRoute.of(context)!.settings.arguments ?? true;
    // final width = MediaQuery.of(context).size.width;
    // final height = MediaQuery.of(context).size.height;

    bool isTrue = (trues as bool);
    return WillPopScope(
      onWillPop: () async {
        if (isTrue)
          Navigator.pop(context);
        else
          BottomNavigation.changeProfileWidget(ProfileScreen());
        return false;
      },
      child: GetBuilder<StepsController>(
          init: StepsController(),
          builder: (stepsController) {
            return Scaffold(
              // bottomNavigationBar: Align(
              //   alignment: Alignment.bottomCenter,
              //   child: Padding(
              //     padding: const EdgeInsets.only(top: 20),//todo
              //     child: Container(
              //       color: Colors.white,
              //       child: Column(
              //         mainAxisAlignment: MainAxisAlignment.end,
              //         mainAxisSize: MainAxisSize.min,
              //         children: [
              //           FarenowButton(
              //               title: widget.afterLogin ? "Submit" : "Next",
              //               onPressed: () {
              //                 if(streetController.text.isEmpty){
              //                   streetController.text="null";
              //                 }if(zipController.text.isEmpty){
              //                   zipController.text="null";
              //                 }
              //                 if(_bioController.text.isEmpty){
              //                   _bioController.text="null";
              //                 }
              //                 if (!_formKey.currentState!.validate()) {
              //                   return;
              //                 }
              //                 bool isMoving =
              //                 _serviceController.selectedServiceType ==
              //                     "moving"
              //                     ? true
              //                     : false;
              //
              //                 String type = "Individual";
              //
              //                 Map body = <String, dynamic>{
              //                   "type": type,
              //                   "street_address":
              //                   streetController.text.toString(),
              //                   "suite_number":
              //                   suitController.text.toString(),
              //                   "state": stateController.text,
              //                   "city": cityController.text.toString(),
              //                   "zip_code": zipController.text.toString(),
              //                   "first_name":
              //                   firstNameController.text.toString(),
              //                   "last_name":
              //                   lastNameController.text.toString(),
              //                   "dob": dob.text.toString(),
              //                   "service_type":
              //                   isMoving ? "MOVING" : "SERVICE",
              //                   "hourly_rate": isMoving
              //                       ? null
              //                       : _priceController.text
              //                       .toString()
              //                       .replaceAll('\$', ""),
              //                   "bio": _bioController.text.toString()
              //                 };
              //                 print("");
              //
              //                 var vehicleBody;
              //                 if (isMoving) {
              //                   vehicleBody = _addVehicleController
              //                       .selectedVehicle.value
              //                       .map((v) => v.toJson())
              //                       .toList();
              //                 }
              //                 print("");
              //                 _serviceController.businessSignup(body, image,
              //                     isMoving, vehicleBody, widget.afterLogin);
              //
              //                 // if (isTrue)
              //                 //   Navigator.pushNamed(
              //                 //       context, BottomNavigation.id);
              //                 // else
              //                 //   BottomNavigation.changeProfileWidget(
              //                 //       ProfileScreen());
              //               },
              //               type: BUTTONTYPE.rectangular),
              //           widget.afterLogin
              //               ? FarenowButton(
              //               title: "Delete User",
              //               onPressed: () {
              //                 Get.dialog(DeleteUser());
              //               },
              //               type: BUTTONTYPE.rectangular)
              //               : FarenowButton(
              //               title: "Previous",
              //               onPressed: () {
              //                 stepsController.previousstepCounter();
              //                 Get.back();
              //               },
              //               type: BUTTONTYPE.action),
              //         ],
              //       ),
              //     ),
              //   ),
              // ),
              resizeToAvoidBottomInset: true,
              backgroundColor: Colors.grey.shade100,
              appBar: widget.afterLogin == true
                  ? AppBar(
                      elevation: 0,
                      backgroundColor: white,
                      title: const Text(
                        "Edit Profile",
                        style: TextStyle(color: black),
                      ),
                      iconTheme: IconTheme.of(context).copyWith(color: black),
                    )
                  : stepsAppBar(5),
              body:
                  // Stack(
                  //   children: [
                  SingleChildScrollView(
                // reverse: true,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        15.height,
                        businessProfleText(),
                        15.height,
                        proFileImage(
                          image: image,
                          isEmpty: getImageUrl(_controller.userData)
                              .toString()
                              .isEmpty,
                          imageWidget: cacheNetworkImage(
                              imageUrl: getImageUrl(_controller.userData),
                              imageHeight: 102,
                              imageWidth: 102,
                              radius: 60,
                              fit: BoxFit.fill,
                              placeHolder:
                                  "assets/images/img_profile_place_holder.jpg"),
                        ),
                        25.height,
                        FarenowTextField(
                            controller: firstNameController,
                            onValidation: (value) {
                              if (value!.isEmpty) {
                                return "Field required*";
                              }
                              return null;
                            },
                            hint: "First name",

                            // readonly:
                            //     (_controller.userData.value.socialType ?? "")
                            //             .isNotEmpty
                            //         ? true
                            //         : false,
                            label: "First Name"),

                        15.height,
                        FarenowTextField(
                            controller: lastNameController,
                            onValidation: (value) {
                              if (value!.isEmpty) {
                                return "Field required*";
                              }
                              return null;
                            },
                            hint: "Last name",

                            // readonly:
                            //     (_controller.userData.value.socialType ?? "")
                            //             .isNotEmpty
                            //         ? true
                            //         : false,
                            label: "Last Name"),
                        15.height,
                        FarenowTextField(
                            controller: dob,
                            onValidation: (value) {
                              if (value!.isEmpty) {
                                return "Field required*";
                              }
                              return null;
                            },
                            hint: "Select Date",
                            readonly: true,
                            isDOB: true,
                            onDOBTap: () {
                              _selectDate(context);
                            },
                            label: "Date of Birth"),

                        15.height,
                        if (checkFlag())
                          Column(
                            children: [
                              FarenowTextField(
                                  controller: _priceController,
                                  /*    hint: "${findCurrencyCode}10 per hour",*/
                                  hint: currencyValue != null
                                      ? "${currencyValue}10 Per Hour"
                                      : "10 Per Hour",
                                  style: const TextStyle(
                                      fontFamily: "Roboto", fontSize: 40),
                                  onChange: (value) {
                                    value = value.replaceAll(
                                        "${currencyValue}", "");
                                    /*value = "${currencyValue}$value";*/
                                    value = "$value";
                                    _priceController.text = value;
                                    _priceController.selection = TextSelection(
                                        baseOffset: value.length,
                                        extentOffset: value.length);
                                  },
                                  readonly:
                                      (_controller.userData.value.socialType ??
                                                  "")
                                              .isNotEmpty
                                          ? false
                                          : false,
                                  onValidation: (value) {
                                    if (value!.isEmpty) {
                                      return "Field required*";
                                    }
                                    return null;
                                  },
                                  label: "Hourly Rate"),
                            ],
                          ),
                        15.height,
                        FarenowTextField(
                            controller: suitController,
                            onValidation: (value) {
                              if (value!.isEmpty) {
                                return "Field required*";
                              }
                              return null;
                            },
                            hint: "Apartment",
                            label: "Apartment"),
                        15.height,
                        FarenowTextField(
                            controller: streetController,
                            onValidation: (value) {
                              if (value!.isEmpty) {
                                return "Field required*";
                              }
                              return null;
                            },
                            hint: "Home Address",
                            label: "Home Address"),
                        15.height,

                        FarenowTextField(
                            controller: cityController,
                            onValidation: (value) {
                              if (value!.isEmpty) {
                                return "Field required*";
                              }
                              return null;
                            },
                            hint: "City*",
                            label: "City"),
                        15.height,
                        FarenowTextField(
                            controller: stateController,
                            onValidation: (value) {
                              if (value!.isEmpty) {
                                return "Field required*";
                              }
                              return null;
                            },
                            // onSubmit: (value) {
                            //   countryNode.requestFocus();
                            // },
                            // node: ,

                            hint: "State*",
                            label: "State/Region"),

                        15.height,
                        FarenowTextField(
                            controller: countryController,
                            onValidation: (value) {
                              if (value!.isEmpty) {
                                return "Field required*";
                              }
                              return null;
                            },
                            hint: "Country*",
                            label: "Country"),

                        // DropdownSearch<String>(
                        //   // label: "Zipcode",
                        //   showAsSuffixIcons: true,
                        //   selectedItem: selectedArea,
                        //   hint: 'Area',
                        //   dropdownSearchDecoration: InputDecoration(
                        //     isDense: true,
                        //     filled: true,
                        //     fillColor: Color(0xffF3F4F4),
                        //     hintText: "Area",
                        //     hintStyle: TextStyle(
                        //         fontWeight: FontWeight.w400,
                        //         color: Color(0xff757575),
                        //         fontSize: 16),
                        //     enabledBorder: new OutlineInputBorder(
                        //         borderSide: new BorderSide(
                        //       color: Color(0xffF3F4F4),
                        //     )),
                        //     focusedBorder: OutlineInputBorder(
                        //       borderSide: BorderSide(
                        //         color: Color(0xffF3F4F4),
                        //       ),
                        //     ),
                        //     suffixIconConstraints:
                        //         BoxConstraints(minHeight: 60),
                        //   ),
                        //   searchBoxDecoration: InputDecoration(
                        //     filled: true,
                        //     fillColor: Color(0xffF3F4F4),
                        //     hintText: "Area",
                        //     hintStyle: TextStyle(
                        //         fontWeight: FontWeight.w400,
                        //         color: Color(0xff757575),
                        //         fontSize: 16),
                        //     enabledBorder: new OutlineInputBorder(
                        //         borderSide: new BorderSide(
                        //       color: Color(0xffF3F4F4),
                        //     )),
                        //     focusedBorder: OutlineInputBorder(
                        //       borderSide: BorderSide(
                        //         color: Color(0xffF3F4F4),
                        //       ),
                        //     ),
                        //   ),
                        //   showSearchBox: true,
                        //   searchBoxController: searchBoxController,
                        //   onFind: (String filter) async {
                        //     Future.delayed(Duration(seconds: 1), () {});
                        //     return ['zipCodes.data.data'];
                        //   },
                        //   onChanged: (String data) {
                        //     selectedArea = data;
                        //   },
                        // ),
                        /*   15.height,
                        FarenowTextField(
                            controller: zipController,
                            type: TextInputType.number,
                            onValidation:  ( value) {
                              if (value!.isEmpty) {
                                return "Field required*";
                              }
                              return null;
                            },
                            hint: "Enter zip code",
                            label: "Zip Code"),*/

                        15.height,
                        if (_serviceController.selectedServiceType ==
                                "moving" &&
                            !postLogin)
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
                                          "moving" &&
                                      !postLogin)
                                    const SizedBox(
                                      height: 6,
                                    ),
                                  if (_serviceController.selectedServiceType ==
                                          "moving" &&
                                      !postLogin)
                                    CustomContainer(
                                      width: Get.width,
                                      alignment: Alignment.topLeft,
                                      child: vehicleList(),
                                    ),
                                ],
                              )),

                        FarenowTextField(
                            controller: _bioController,
                            inputAction: TextInputAction.done,
                            /* onSubmit: (value)async {
                              if (streetController.text.isEmpty) {
                                streetController.text = "null";
                              }
                              if (zipController.text.isEmpty) {
                                zipController.text = "null";
                              }
                              if (_bioController.text.isEmpty) {
                                _bioController.text = "null";
                              }
                              if (!_formKey.currentState!.validate()) {
                                return;
                              }
                              bool isMoving =
                              _serviceController.selectedServiceType ==
                                  "moving"
                                  ? true
                                  : false;
                              await preferences.saveData(key: "street_address",data: streetController.text.toString());
                              await preferences.saveData(key: "suite_number",data: suitController.text.toString());
                              await preferences.saveData(key: "state",data: stateController.text);
                              await preferences.saveData(key: "city",data: cityController.text.toString());
                              await preferences.saveData(key: "country",data: countryController.text.toString());
                              await preferences.saveData(key:  "dob",data: dob.text.toString());
                              await preferences.saveData(key:  "hourly_rate",data: _priceController.text);
                              await preferences.saveData(key:   "bio",data:_bioController.text.toString());
                              String type = "Individual";
                              //todo
                              Map body = <String, dynamic>{
                                "type": type,
                                "street_address":
                                streetController.text.toString(),
                                "suite_number": suitController.text.toString(),
                                "state": stateController.text,
                                "city": cityController.text.toString(),
                                "country": countryController.text.toString(),
                               // "zip_code": zipController.text.toString(),
                                //"zip_code": "",
                                "first_name":
                                firstNameController.text.toString(),
                                "last_name": lastNameController.text.toString(),
                                "dob": dob.text.toString(),
                                "service_type": isMoving ? "MOVING" : "SERVICE",
                                "hourly_rate": isMoving
                                    ? null
                                    : _priceController.text
                                    .toString()
                                    .replaceAll('${currencyValue}', ""),
                                "bio": _bioController.text.toString()
                              };
                              print("");
                              print("========================-----------------------------$body");



                              var vehicleBody;
                              if (isMoving) {
                                vehicleBody = _addVehicleController
                                    .selectedVehicle.value
                                    .map((v) => v.toJson())
                                    .toList();
                              }

                              print("");
                              _serviceController.businessSignup(
                                  body,
                                  image,
                                  isMoving,
                                  vehicleBody,
                                  widget.afterLogin,
                                  true
                              );
                              */ /*if (image != null) {
                                _serviceController.businessSignup(
                                    body,
                                    image,
                                    isMoving,
                                    vehicleBody,
                                    widget.afterLogin,
                                    true
                                );
                              } else {
                                print("Image is null. Please select an image.");
                              }*/ /*

                              // if (isTrue)
                              //   Navigator.pushNamed(
                              //       context, BottomNavigation.id);
                              // else
                              //   BottomNavigation.changeProfileWidget(
                              //       ProfileScreen());
                            },*/
                            //  {
                            //   Get.focusScope!.unfocus();
                            // },
                            maxLine: 7,
                            onValidation: (value) {
                              if (value.length < 20) {
                                return "Please enter minimum 20 character";
                              }
                              return null;
                            },
                            hint: "Enter your bio",
                            label: "Bio"),

                        15.height,
                        // const Text(
                        //   "Please make sure all information you submit is accurate before submit. ",
                        //   style: TextStyle(
                        //       fontSize: 16,
                        //       color: Colors.black,
                        //       fontWeight: FontWeight.w400),
                        // ),
                        // const SizedBox(
                        //   height: 200,
                        // ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 20), //todo
                            child: Container(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  FarenowButton(
                                      style: FarenowButtonStyleModel(
                                          padding: EdgeInsets.zero),
                                      title: widget.afterLogin == true
                                          ? "Submit"
                                          : "Next",
                                      onPressed: () async {
                                        if (streetController.text.isEmpty) {
                                          streetController.text = "";
                                        }
                                        if (zipController.text.isEmpty) {
                                          zipController.text = "";
                                        }
                                        if (_bioController.text.isEmpty) {
                                          _bioController.text = "";
                                        }
                                        if (!_formKey.currentState!
                                            .validate()) {
                                          return;
                                        }
                                        bool isMoving = _serviceController
                                                    .selectedServiceType ==
                                                "moving"
                                            ? true
                                            : false;
                                        String type = "Individual";
                                        //todo
                                        Map body = <String, dynamic>{
                                          "type": type,
                                          "street_address":
                                              streetController.text.toString(),
                                          "suite_number":
                                              suitController.text.toString(),
                                          "state": stateController.text,
                                          "city":
                                              cityController.text.toString(),
                                          "country":
                                              countryController.text.toString(),
                                          //"zip_code": zipController.text.toString(),
                                          // "zip_code": "",
                                          "first_name": firstNameController.text
                                              .toString(),
                                          "last_name": lastNameController.text
                                              .toString(),
                                          "dob": dob.text.toString(),
                                          "service_type":
                                              isMoving ? "MOVING" : "SERVICE",
                                          "hourly_rate": isMoving
                                              ? null
                                              : _priceController.text
                                                  .toString()
                                                  .replaceAll(
                                                      '${currencyValue}', ""),
                                          "bio": _bioController.text.toString()
                                        };
                                        print("hello check");

                                        var vehicleBody;
                                        if (isMoving) {
                                          vehicleBody = _addVehicleController
                                              .selectedVehicle.value
                                              .map((v) => v.toJson())
                                              .toList();
                                        }
                                        // print("");
                                        if(widget.afterLogin==false){
                                          if(image==null){
                                            AppDialogUtils.errorDialog("Image Is required");
                                          }
                                          else{
                                            _serviceController.businessSignup(
                                                body,
                                                image,
                                                isMoving,
                                                vehicleBody,
                                                widget.afterLogin,
                                                true);
                                          }

                                        }else{
                                          _serviceController.businessSignup(
                                              body,
                                              image,
                                              isMoving,
                                              vehicleBody,
                                              widget.afterLogin,
                                              true);
                                        }


                                        // if (isTrue)
                                        //   Navigator.pushNamed(
                                        //       context, BottomNavigation.id);
                                        // else
                                        //   BottomNavigation.changeProfileWidget(
                                        //       ProfileScreen());
                                      },
                                      type: BUTTONTYPE.rectangular),
                                  widget.afterLogin == true
                                      ? FarenowButton(
                                          style: FarenowButtonStyleModel(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 12)),
                                          title: "Delete User",
                                          onPressed: () {
                                            Get.dialog(DeleteUser());
                                          },
                                          type: BUTTONTYPE.outline)
                                      : FarenowButton(
                                          style: FarenowButtonStyleModel(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 12)),
                                          title: "Previous",
                                          onPressed: () {
                                            stepsController
                                                .previousstepCounter();
                                            Get.back();
                                          },
                                          type: BUTTONTYPE.outline),
                                ],
                              ),
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
              ),

              // ],
              // )
            );
          }),
    );
  }

  String getCommaSepratedList(List list) {
    if (list.length == 1) {
      return list.first.zipCode;
    }
    List<String> codex = [];
    for (int index = 0; index < list.length; index++) {
      codex.add(list[index].zipCode);
    }

    String codes = codex.join(', ');
    return codes;
  }

  proFileImage({imageWidget, isEmpty, image}) {
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        image != null
            ? Container(
                height: 102,
                width: 102,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: FileImage(image), fit: BoxFit.cover),
                    borderRadius: const BorderRadius.all(Radius.circular(70))),
              )
            : isEmpty
                ? Container(
                    height: 102,
                    width: 102,
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(
                                "assets/images/img_profile_place_holder.jpg")),
                        borderRadius: BorderRadius.all(Radius.circular(70))),
                  )
                : Container(
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
            child: const Icon(
              Icons.edit,
              color: Colors.white,
              size: 15,
            ),
            width: 27,
            height: 27,
            decoration: BoxDecoration(
                color: const Color(0xff00B181),
                borderRadius: BorderRadius.circular(20)),
          ),
        )
      ],
    );
  }

  networkImage() {
    if (_controller.userData.value == null) {
      return null;
    }
    return _controller.userData.value.image;
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
                    cacheNetworkImage(
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
                          _addVehicleController.selectedVehicle
                              .removeAt(index - 1);
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
    if (_addVehicleController.selectedVehicle.length < 2) {
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

  checkFlag() {
    if (_serviceController.selectedServiceType == "moving") {
      return false;
    } else if (!(widget.afterLogin ?? false)) {
      return true;
    }
    // if (_controller.userData.value.userProfileModel == null) {
    //   return false;
    // }
    if (_controller.userData.value.providerProfile == null) {
      return false;
    }
    if (_controller.userData.value.providerProfile!.hourlyRate != null) {
      return true;
    }
    return false;
  }

  String getFirstName(value) {
    String fName = (value.firstName ?? _controller.firstName.value)
        .toString()
        .capitalizeFirst!;
    if ((value.socialType ?? "").isNotEmpty) {
      return fName.toString().split(" ")[0];
    }
    return fName;
  }

  String getLastName(value) {
    String lName = (value.lastName ?? _controller.firstName.value)
        .toString()
        .capitalizeFirst!;
    if ((value.socialType ?? "").isNotEmpty) {
      String name = lName.toString().split(" ")[0];
      return lName.toString().replaceAll("${name} ", "").capitalizeFirst!;
    }
    return lName;
  }

  Container businessProfleText() {
    return Container(
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
      child: const Text(
        "Set up your individual profile", //todo changed from business to indiviual
        style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: AppColors.solidBlue),
      ),
    );
  }
}
/*
if (_addVehicleController
                                              .selectedVehicle.length <
                                          5)
                                        CustomContainer(
                                          onTap: () {
                                            _addVehicleController.getTypes();
                                          },
                                          borderWidth: 1,
                                          child: Icon(
                                            Icons.add,
                                            color: AppColors.appBlue,
                                          ),
                                          borderColor: AppColors.appBlue,
                                          allRadius: 12,
                                        ),
 */
