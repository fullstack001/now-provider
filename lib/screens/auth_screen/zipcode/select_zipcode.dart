import 'package:fare_now_provider/components/buttons-management/part_of_file/part.dart';
import 'package:fare_now_provider/controllers/profile_screen_controller/ProfileScreenController.dart';
import 'package:fare_now_provider/controllers/services/service_controller.dart';
import 'package:fare_now_provider/models/prediction/predictions.dart';
import 'package:fare_now_provider/models/selected_zips_list.dart';
import 'package:fare_now_provider/screens/auth_screen/profile_data_steps/steps_controller/step_controller.dart';
import 'package:geocoding/geocoding.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../custom_packages/keyboard_overlay/keyboard_overlay.dart';
import '../../../models/postal_code/Results.dart';
import '../../../util/app_colors.dart';
import '../profile_data_steps/steps_appbar.dart';

class SelectZipcodeScreen extends StatefulWidget {
  static const id = 'select_zipcode_screen';

  final serviceArea;

  SelectZipcodeScreen({Key? key, this.serviceArea}) : super(key: key);

  @override
  _SelectZipcodeScreenState createState() => _SelectZipcodeScreenState();
}

class _SelectZipcodeScreenState extends State<SelectZipcodeScreen>
    with HandleFocusNodesOverlayMixin {
  List<String> items = [];
  List<SelectedZipList> newList = [];
  List<SelectedZipList> _list = [];
  var searchController = TextEditingController();
  ServiceController _controller = Get.find();
  ProfileScreenController _profileScreenController = Get.find();
  FocusNode searchPlace = FocusNode();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller.predictions.clear();
    // print("predictions ${_controller.predictions.length}");
  }

  bool firstInit = false;
  bool serviceArea = false;
  @override
  Widget build(BuildContext context) {
    // firstInit = false;
    if (!firstInit) {
      _list.clear();
      firstInit = true;
      serviceArea = widget.serviceArea ?? false;
      var newList = _profileScreenController.zipCodes.value;
      for (int index = 0; index < newList.length; index++) {
        // if (!newList[index].code.toString().contains(",")) {

        SelectedZipList _selectedZipList = SelectedZipList(
            zipCode: newList[index].code,
            city: newList[index].city,
            country: newList[index].country,
            state: newList[index].state,
            id: newList[index].id,
            placeid: newList[index].placeId);
        _list.add(_selectedZipList);
        // }
      }
    }

    return GetBuilder<StepsController>(
        init: StepsController(),
        builder: (stepController) {
          return Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: white,
            appBar: serviceArea ? null : stepsAppBar(7),
            body: Stack(
              children: [
                ListView(
                  children: [
                    20.height,
                    boldHeaderText(),
                    20.height,
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24.0),
                      child: Column(
                        children: [
                          Container(
                            alignment: Alignment.centerLeft,
                            child: const Text(
                              " Location ",
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 18,
                                  color: Color(0xff151415)),
                            ),
                          ),
                          15.height,
                          AppTextField(
                            focus: searchPlace,
                            onChanged: (value) {
                              if (value.isNotEmpty) {
                                _controller.searchResult(value);
                              } else {
                                List<Predictions> pre = [];
                                _controller.predictions(pre);
                              }
                            },
                            controller: searchController,
                            decoration: InputDecoration(
                              hintText: "Enter your location",
                              prefixIcon: const Icon(
                                Icons.location_on_outlined,
                                color: Color(0xff555555),
                              ),
                              hintStyle: const TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16,
                                  color: Color(0xff555555)),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(18),
                                  borderSide: const BorderSide(
                                      color: Color(0xff555555))),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(18),
                                borderSide:
                                    const BorderSide(color: Color(0xffBDBDBD)),
                              ),
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Field is required'; // Validation error message
                              }
                              return null; // No error
                            },
                            textFieldType: TextFieldType.USERNAME,
                          ),
                          /*if (isTextFieldEmpty())
                            Text(
                              "Field is required", // Display your validation message here
                              style: TextStyle(color: Colors.red),
                            ),*/
                        ],
                      ),
                    ),
                    Obx(() => Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24),
                          child: Column(
                            children: [
                              for (int index = 0;
                                  index < _controller.predictions.length;
                                  index++)
                                predictionItem(index),
                            ],
                          ),
                        )),
                    const SizedBox(
                      height: 48,
                    ),
                    Container(
                      margin:
                          const EdgeInsets.only(left: 24, right: 24, top: 50),
                      alignment: Alignment.bottomLeft,
                      width: Get.width,
                      child: Wrap(
                        spacing: 6.0,
                        runSpacing: 0.0,
                        children: <Widget>[
                          for (int index = 0; index < _list.length; index++)
                            _buildChip(_list[index], Colors.black, index),
                        ],
                      ),
                    ),
                  ],
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: FittedBox(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            FarenowButton(
                                title: serviceArea ? "Save" : "Done",
                                onPressed: () async {
                                  if (_list.isEmpty) {
                                    // Display an error message to select a location
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content: Text(
                                              "Please select a location.")),
                                    );
                                    return;
                                  }
                                  if (!serviceArea) {
                                    await _controller.signUpService(
                                        list: _list);
                                  } else {
                                    var list = _list;
                                    newList = newList.isEmpty ? list : newList;
                                    _controller.updateZipCodes(newList,
                                        onSuccess: () {
                                      _profileScreenController
                                          .getProviderZipCodes(icon: true);
                                    });
                                  }
                                  // String zipCode =
                                  //     searchController.text.toString();
                                  // _controller.zipCode(zipCode);

                                  // String zipCode = searchController.text.toString();
                                  // // _controller.zipCode(zipCode);
                                  //
                                  // if (!serviceArea) {
                                  //   print("list: ${_list}");
                                  //   _controller.signUpService(list: _list.isEmpty?[
                                  //     SelectedZipList(
                                  //         zipCode: "212",
                                  //         city: "newList[index].city",
                                  //         country: "1212",
                                  //         state: "qwe",
                                  //         id: "23",
                                  //         placeid: "w")
                                  //   ]:_list);
                                  // } else {
                                  //   var list = _list;
                                  //   newList = newList.isEmpty ? list : newList;
                                  //   print("new list: $newList");
                                  //   _controller.updateZipCodes(newList, onSuccess: () {
                                  //     Get.back();
                                  //   });
                                  // }
                                },
                                type: BUTTONTYPE.rectangular),
                            serviceArea
                                ? Container()
                                : FarenowButton(
                                    title: "Previous",
                                    onPressed: () {
                                      stepController.previousstepCounter();
                                      Get.back();
                                    },
                                    type: BUTTONTYPE.outline),
                            20.height,
                          ]),
                    ),
                  ),
                )
              ],
            ),
          );
        });
  }

  _buildChip(SelectedZipList value, Color color, int index) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InputChip(
        padding: const EdgeInsets.all(12.0),
        label: Marquee(
            direction: Axis.horizontal,
            animationDuration: const Duration(milliseconds: 100),
            pauseDuration: const Duration(milliseconds: 100),
            child: Text(
              "${getPostalCode(value)}",
              style: TextStyle(color: color, fontSize: 18),
            )),
        backgroundColor: AppColors.grey,
        // selected: _isSelected,
        // selectedColor: Colors.blue.shade600,
        onSelected: (bool selected) {
          print("");
          // setState(() {
          //   _isSelected = selected;
          // });
        },
        deleteIconColor: AppColors.solidBlue,
        deleteIcon: Container(
            width: 26,
            height: 26,
            decoration: const BoxDecoration(
                color: AppColors.solidBlue, shape: BoxShape.circle),
            alignment: Alignment.center,
            // padding: const EdgeInsets.all(4),
            child: const Icon(
              Icons.close,
              color: Colors.white70,
              size: 14,
            )),
        onDeleted: () {
          print("$index");
          Get.defaultDialog(
            title: "Alert",
            content: const Text("Do you want to remove this item?"),
            confirm: MaterialButton(
              onPressed: () {
                Get.back();
                // _list.remove(index);
                if (!serviceArea) {
                  _list.removeAt(index);
                  setState(() {});
                  Get.back();
                } else {
                  if (exist(_list[index].zipCode, _list[index].city,
                      _list[index].state, _list[index].country, newList)) {
                    var zip = _list[index];
                    _list.removeAt(index);
                    // newList.remove(zip);
                    removeFromNewList(zip.zipCode!);
                    setState(() {});
                    Get.back();
                    print("");
                  } else {
                    _profileScreenController.deleteZipCode(_list[index].id,
                        onSuccess: () {
                      _list.removeAt(index);
                      setState(() {});
                    });
                  }
                }
              },
              child: const Text(
                "Yes",
                style: TextStyle(fontSize: 16),
              ),
            ),
            cancel: MaterialButton(
              onPressed: () {
                Get.back();
              },
              child: const Text(
                "No",
                style: TextStyle(fontSize: 16),
              ),
            ),
          );
        },
      ),
    );
  }

  bool exist(zipCode, city, country, state, mapList) {
    if (_list.isEmpty) {
      return false;
    }
    for (int index = 0; index < mapList.length; index++) {
      if (mapList[index].zipCode == zipCode.toString()) {
        return true;
      } else if (mapList[index].zipCode == zipCode.toString() &&
          // mapList[index].city == city.toString() &&
          mapList[index].state == state.toString() &&
          mapList[index].country == country.toString()) {
        return true;
      }
    }

    return false;
  }

  String getCommaSepratedList(List<SelectedZipList> list) {
    if (list.length == 1) {
      return list.first.zipCode!;
    }
    List<String> codex = [];
    for (int index = 0; index < list.length; index++) {
      codex.add(list[index].zipCode!);
    }

    String codes = codex.join(', ');
    return codes;
  }

  void removeFromNewList(String zip) {
    for (int index = 0; index < newList.length; index++) {
      if (newList[index].zipCode == zip) {
        newList.removeAt(index);
        return;
      }
    }
  }

  getPostalCode(SelectedZipList value) {
    String code = value.zipCode!;
    print(value);
    // if (value.city != null) {
    //   code = code + ", ${value.city}";
    // }
    if (value.country != null) {
      code = code + ", ${value.country}";
    }
    if (value.state != null) {
      code = code + ", ${value.state}";
    }
    return code;
  }

  predictionItem(int index) {
    Results value = _controller.predictions[index];
    return InkWell(
      onTap: () async {
        Get.focusScope!.unfocus();
        _controller.zipCode("");
        var lat = value.geometry.location.lat;
        var lng = value.geometry.location.lng;
        List<Placemark> placemarks =
            await placemarkFromCoordinates(lat, lng, localeIdentifier: "en_US");

        Placemark place = placemarks[0];
        String city = placemarks[0].subLocality!;
        String country = placemarks[0].country!;
        String state = placemarks[0].administrativeArea!;
        String zipCode = value.addressComponents.first.longName;

        if (!exist(zipCode, city, state, country, _list)) {
          _list.add(SelectedZipList(
              zipCode: zipCode,
              city: city,
              state: state,
              country: country,
              placeid: value.placeId));
          String zipCodes = getCommaSepratedList(_list);
          _controller.commaList(_list);
          if (serviceArea) {
            if (!exist(zipCode, city, state, country, newList)) {
              newList.add(SelectedZipList(
                  zipCode: zipCode,
                  country: country,
                  state: state,
                  city: city,
                  placeid: value.placeId));
            }
          }
          setState(() {});
        }
        // _controller.predictions.clear();
        _controller.predictions.clear();
        searchController.text = "";

        setState(() {});
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 15),
            child: Text(
              value.formattedAddress,
              style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 16,
                  color: Colors.grey.shade700),
            ),
          ),
          const Divider(),
        ],
      ),
    );
  }

  void setDoneButton() {
    if (GetPlatform.isIOS) {
      searchPlace = GetFocusNodeOverlay(
          child: TopKeyboardUtil(
        DoneButtonIos(
          label: 'Done',
          onSubmitted: () => Get.focusScope!.unfocus(),
          platforms: const ['android', 'ios'],
        ),
      ));
    }
  }

  Container boldHeaderText() {
    return Container(
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: const Text(
        "Where do you work?",
        style: TextStyle(
            fontSize: 28, fontWeight: FontWeight.w700, color: AppColors.black),
      ),
    );
  }
}
