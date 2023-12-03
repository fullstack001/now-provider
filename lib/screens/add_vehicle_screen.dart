import 'package:fare_now_provider/custom_packages/keyboard_overlay/keyboard_overlay.dart';
import 'package:fare_now_provider/models/add_vehicle/add_vehicle_model.dart';
import 'package:fare_now_provider/models/vehicle_type/vehicle_type_data.dart';
import 'package:fare_now_provider/models/verify_otp/vehicle_type.dart';
import 'package:fare_now_provider/models/verify_otp/vehicles.dart';
import 'package:fare_now_provider/screens/Controller/add_vehicle_controller.dart';
import 'package:fare_now_provider/util/api_utils.dart';
import 'package:fare_now_provider/util/app_colors.dart';
import 'package:fare_now_provider/util/widgest_utills.dart';
import 'package:fare_now_provider/widgets/custom_container.dart';
import 'package:fare_now_provider/widgets/custom_toolbar.dart';
import 'package:fare_now_provider/widgets/text_with_icon.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddVehicleScreen extends StatefulWidget {
  final postSignup;
  final vehicle;

  AddVehicleScreen({Key? key, this.postSignup, this.vehicle}) : super(key: key);

  @override
  _AddVehicleScreenState createState() => _AddVehicleScreenState();
}

class _AddVehicleScreenState extends State<AddVehicleScreen>
    with HandleFocusNodesOverlayMixin {
  AddVehicleController _addVehicleController = Get.put(AddVehicleController());

  List<DropdownMenuItem<String>>? _dropDownMenuCurrencyItems;

  List<DropdownMenuItem<String>> getDropDownMenuCurrencyItems() {
    List<DropdownMenuItem<String>>? items = [];
    for (VehicleTypeData? currency
        in _addVehicleController.typeResponse.value) {
      items.add(new DropdownMenuItem(
          value: currency!.title, child: new Text(currency.title!)));
    }
    return items;
  }

  void changedDropDownItem(String selectedCurrency) {
    print("$selectedCurrency");
    // _addVehicleController.selectedVehicle();
  }

  VehicleTypeData? selectedType;
  final _formKey = new GlobalKey<FormState>();

  var _nameController = TextEditingController();
  var _modelController = TextEditingController();
  var _numberController = TextEditingController();
  var _conditionController = TextEditingController();
  var _companyNameController = TextEditingController();

  FocusNode nameFocus = FocusNode();
  FocusNode modelFocus = FocusNode();
  FocusNode numberFocus = FocusNode();
  FocusNode conditionFocus = FocusNode();
  FocusNode companyFocus = FocusNode();

  bool firstInit = false;
  @override
  void initState() {
    setDoneButton();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool postSignUp = widget.postSignup ?? false;
    if (postSignUp && widget.vehicle != null) {
      // firstInit = false;
      if (!firstInit) {
        firstInit = true;
        _nameController.text = "${widget.vehicle.name}";
        _modelController.text = "${widget.vehicle.model}";
        _numberController.text = "${widget.vehicle.number}";
        _conditionController.text = "${widget.vehicle.condition}";
        _companyNameController.text = "${widget.vehicle.companyName}";
        if (widget.vehicle.vehicleType != null) {
          for (int index = 0;
              index < _addVehicleController.typeResponse.value.length;
              index++) {
            VehicleTypeData value =
                _addVehicleController.typeResponse.value[index];
            if (value.title!.toLowerCase() ==
                widget.vehicle.vehicleType.title.toLowerCase()) {
              selectedType = value;
              break;
            }
          }
        }
      }
    } else {
      if (!kReleaseMode) {
        _nameController.text = "Yaris";
        _modelController.text = "2021";
        _numberController.text = "lhr 1992";
        _conditionController.text = "gooood";
        _companyNameController.text = "Toyota";
      }
    }

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 2,
        centerTitle: false,
        backgroundColor: Colors.white,
        toolbarHeight: 64,
        flexibleSpace: CustomToolbar(
          title: "Add Vehicle",
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back,
              color: Colors.blue,
            ),
          ),
        ),
      ),
      body: Form(
        key: _formKey,
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                  child: CustomContainer(
                height: 45,
                width: Get.width,
                alignment: Alignment.topLeft,
                child: ListView(
                  children: [
                    CustomContainer(
                      width: Get.width,
                      paddingAll: 8,
                      marginAll: 12,
                      allRadius: 12,
                      shadowOffsetY: 2,
                      shadowOffsetX: 2,
                      shadowSpreadRadius: 2,
                      shadowBlurRadius: 6,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          PopupMenuButton(
                              child: Row(
                                children: [
                                  TextWithIcon(
                                    title: selectedType == null
                                        ? "Select vehicle type"
                                        : "${selectedType!.title}",
                                    fontSize: 16,
                                  ),
                                  Icon(Icons.arrow_drop_down)
                                ],
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                              ),
                              onSelected: (value) async {
                                try {
                                  int? val = int.parse(value.toString());
                                  print(
                                      "${_addVehicleController.typeResponse.value[val - 1].title}");
                                  var valueObj = _addVehicleController
                                      .typeResponse.value[val - 1];
                                  for (int index = 0;
                                      index <
                                          _addVehicleController
                                              .typeResponse.value.length;
                                      index++) {
                                    _addVehicleController.typeResponse
                                        .value[index].isSelected = false;
                                  }
                                  selectedType = valueObj;
                                  _addVehicleController.typeResponse
                                      .value[val - 1].isSelected = true;
                                  print("");
                                  setState(() {
                                    print("abc");
                                  });
                                } catch (e) {}
                              },
                              itemBuilder: (context) => dropDownList(
                                  _addVehicleController.typeResponse)),
                          if (selectedType == null)
                            TextWithIcon(
                              title: "select vehicle type",
                              fontColor: Colors.red,
                            ),
                          SizedBox(
                            height: 12,
                          ),
                          TextFormField(
                            textInputAction: TextInputAction.next,
                            validator: (val) {
                              if (val!.isEmpty) {
                                return "Field required";
                              }
                              return null;
                            },
                            focusNode: nameFocus,
                            onFieldSubmitted: (value) {
                              modelFocus.requestFocus();
                            },
                            controller: _nameController,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Color(0xffF3F4F4),
                              hintText: "Enter vehicle name",
                              hintStyle: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xff757575),
                                  fontSize: 16),
                              enabledBorder: new OutlineInputBorder(
                                  borderSide: new BorderSide(
                                color: Color(0xffF3F4F4),
                              )),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0xffF3F4F4),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 12,
                          ),
                          TextFormField(
                            textInputAction: TextInputAction.next,
                            validator: (val) {
                              if (val!.isEmpty) {
                                return "Field required";
                              }
                              return null;
                            },
                            focusNode: modelFocus,
                            onFieldSubmitted: (value) {
                              conditionFocus.requestFocus();
                            },
                            controller: _modelController,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Color(0xffF3F4F4),
                              hintText: "Enter model number",
                              hintStyle: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xff757575),
                                  fontSize: 16),
                              enabledBorder: new OutlineInputBorder(
                                  borderSide: new BorderSide(
                                color: Color(0xffF3F4F4),
                              )),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0xffF3F4F4),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 12,
                          ),
                          TextFormField(
                            textInputAction: TextInputAction.next,
                            validator: (val) {
                              if (val!.isEmpty) {
                                return "Field required";
                              }
                              return null;
                            },
                            focusNode: numberFocus,
                            onFieldSubmitted: (value) {
                              conditionFocus.requestFocus();
                            },
                            controller: _numberController,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Color(0xffF3F4F4),
                              hintText: "Enter vehicle number",
                              hintStyle: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xff757575),
                                  fontSize: 16),
                              enabledBorder: new OutlineInputBorder(
                                  borderSide: new BorderSide(
                                color: Color(0xffF3F4F4),
                              )),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0xffF3F4F4),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 12,
                          ),
                          TextFormField(
                            textInputAction: TextInputAction.next,
                            validator: (val) {
                              if (val!.isEmpty) {
                                return "Field required";
                              }
                              return null;
                            },
                            focusNode: conditionFocus,
                            onFieldSubmitted: (value) {
                              companyFocus.requestFocus();
                            },
                            controller: _conditionController,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Color(0xffF3F4F4),
                              hintText: "Vehicle condition",
                              hintStyle: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xff757575),
                                  fontSize: 16),
                              enabledBorder: new OutlineInputBorder(
                                  borderSide: new BorderSide(
                                color: Color(0xffF3F4F4),
                              )),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0xffF3F4F4),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 12,
                          ),
                          TextFormField(
                            textInputAction: TextInputAction.done,
                            validator: (val) {
                              if (val!.isEmpty) {
                                return "Field required";
                              }
                              return null;
                            },
                            focusNode: companyFocus,
                            onFieldSubmitted: (value) {
                              Get.focusScope!.unfocus();
                            },
                            controller: _companyNameController,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Color(0xffF3F4F4),
                              hintText: "Enter company name",
                              hintStyle: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xff757575),
                                  fontSize: 16),
                              enabledBorder: new OutlineInputBorder(
                                  borderSide: new BorderSide(
                                color: Color(0xffF3F4F4),
                              )),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0xffF3F4F4),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )),
              TextWithIcon(
                height: 45,
                allRadius: 8,
                marginBottom: 12,
                marginLeft: 12,
                marginRight: 12,
                width: Get.width,
                fontColor: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w700,
                bgColor: AppColors.appBlue,
                containerClick: () {
                  Get.focusScope!.unfocus();
                  if (!_formKey.currentState!.validate()) {
                    return;
                  }

                  if (selectedType == null) {
                    return;
                  }
                  String name = _nameController.text;
                  String model = _modelController.text;
                  String number = _numberController.text;
                  String condition = _conditionController.text;
                  String compName = _companyNameController.text;
                  AddVehicleModel vehic = AddVehicleModel(
                      vehicleTypeId: selectedType!.id,
                      name: name,
                      model: model,
                      number: number,
                      condition: condition,
                      companyName: compName,
                      image: selectedType!.image);
                  List<AddVehicleModel> typeList = [vehic];
                  if (postSignUp && widget.vehicle != null) {
                    // var _body = typeList.map((v) => v.toJson()).toList();
                    var _body = typeList.first.toJson();
                    _addVehicleController.updateVehicle(
                        widget.vehicle.id, _body);
                  } else if (postSignUp) {
                    VehicleType type = VehicleType(
                      title: selectedType!.title,
                      image: selectedType!.image,
                    );

                    var _body = typeList.map((v) => v.toJson()).toList();
                    _addVehicleController.store(_body, type);
                  } else {
                    List vList = _addVehicleController.selectedVehicle.value;
                    vList.addAll(typeList);
                    _addVehicleController.selectedVehicle(vList);
                    _addVehicleController.selectedVehicle.refresh();
                    var _body = typeList.map((v) => v.toJson()).toList();
                    print("$_body");
                    Get.back();
                  }
                  // _addVehicleController.store(_body);
                },
                title: widget.vehicle != null ? "Update" : "Submit",
              )
            ],
          ),
        ),
      ),
    );
  }

  dropDownList(value) {
    List<PopupMenuItem> menuList = [];
    for (int index = 0;
        index < _addVehicleController.typeResponse.length;
        index++) {
      VehicleTypeData value = _addVehicleController.typeResponse.value[index];
      var obj = PopupMenuItem(
        value: index + 1,
        child: TextWithIcon(
          alignment: MainAxisAlignment.start,
          icon: cacheNetworkImage(
              imageUrl: "${ApiUtills.imageBaseUrl}${value.image}",
              imageWidth: 80,
              imageHeight: 24,
              fit: BoxFit.fitHeight),
          width: Get.width,
          title: "${value.title}",
          fontSize: 16,
        ),
      );
      menuList.add(obj);
    }
    return menuList;
  }

  void setDoneButton() {
    if (GetPlatform.isIOS) {
      nameFocus = GetFocusNodeOverlay(
          child: TopKeyboardUtil(
        DoneButtonIos(
          label: 'Done',
          onSubmitted: () => Get.focusScope!.unfocus(),
          platforms: ['android', 'ios'],
        ),
      ));
      modelFocus = GetFocusNodeOverlay(
          child: TopKeyboardUtil(
        DoneButtonIos(
          label: 'Done',
          onSubmitted: () => Get.focusScope!.unfocus(),
          platforms: ['android', 'ios'],
        ),
      ));
      conditionFocus = GetFocusNodeOverlay(
          child: TopKeyboardUtil(
        DoneButtonIos(
          label: 'Done',
          onSubmitted: () => Get.focusScope!.unfocus(),
          platforms: ['android', 'ios'],
        ),
      ));
      companyFocus = GetFocusNodeOverlay(
          child: TopKeyboardUtil(
        DoneButtonIos(
          label: 'Done',
          onSubmitted: () => Get.focusScope!.unfocus(),
          platforms: ['android', 'ios'],
        ),
      ));
      numberFocus = GetFocusNodeOverlay(
          child: TopKeyboardUtil(
        DoneButtonIos(
          label: 'Done',
          onSubmitted: () => Get.focusScope!.unfocus(),
          platforms: ['android', 'ios'],
        ),
      ));
    }
  }
}
