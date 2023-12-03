
import 'package:fare_now_provider/components/buttons-management/part_of_file/part.dart';
import 'package:fare_now_provider/components/text_fields/farenow_text_field.dart';
import 'package:fare_now_provider/screens/fare_now_pakages/controller/package_controller.dart';
import 'package:fare_now_provider/screens/fare_now_pakages/dialog_card_package.dart';
import 'package:fare_now_provider/screens/fare_now_pakages/models/pacakge_plan_model.dart';
import 'package:fare_now_provider/util/app_dialog_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nb_utils/nb_utils.dart';


class CreatePackage extends StatefulWidget {
  final isUpdate;
  final Datum? data;
  CreatePackage({Key? key, this.isUpdate = false, this.data}) : super(key: key);

  @override
  State<CreatePackage> createState() => _CreatePackageState();
}

class _CreatePackageState extends State<CreatePackage> {
  final _titleController = TextEditingController();
  final _percentController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _durationController = TextEditingController();
  final _titleNode = FocusNode();
  final _percentNode = FocusNode();
  final _descriptionNode = FocusNode();
  final _durationNode = FocusNode();
  final _formKey = GlobalKey<FormState>();
  String? selectDuration;
  String durationError = "";

  final List<String> items = [
    'Weekly',
    'BiWeekly',
    'Monthly',
  ];

  final RegExp _numericRegExp = RegExp(r'^[0-9]+$');
  String? validateDuration() {
    String? duration = _durationController.text.trim();
    if (_numericRegExp.hasMatch(duration)) {
      return '';
    }
    else {
      return "Only numbers are allowed";
    }
  }
  String? selectedValue;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.isUpdate) {
      _titleController.text = widget.data!.title!;
      _percentController.text = widget.data!.off.toString();
      _descriptionController.text = widget.data!.description!;
      _durationController.text = widget.data!.duration.toString();
      selectedValue = widget.data!.type.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        iconTheme: IconTheme.of(context).copyWith(color: black),
        backgroundColor: white,
        elevation: 1,
        title: Text(
          widget.isUpdate ? "Update Package" : "Add Package",
          style: const TextStyle(
              color: black, fontWeight: FontWeight.w500, fontSize: 18),
        ),
      ),
      body: GetBuilder<PackageController>(
          init: PackageController(),
          builder: (controller) {
            return Form(
              key: _formKey,
              child: ListView(
                  shrinkWrap: true,
                  children: [
                    Padding(
                      padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 18),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          FarenowTextField(
                              onSubmit: (value) {
                                _titleNode.requestFocus();
                              },
                              node: _titleNode,
                              controller: _titleController,
                              onValidation:  ( value) {
                                if (value!.isEmpty) {
                                  return "Field required*";
                                }
                                return null;
                              },
                              hint: "Enter title",
                              label: "Package Title"),
                          14.height,
                          Container(
                            alignment: Alignment.centerLeft,
                            child: const Text(
                              "Type",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w400),
                            ),
                          ),
                          10.height,

                          Container(

                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            decoration: BoxDecoration(
                                color: const Color(0xffE0E0E0),
                                borderRadius: BorderRadius.circular(14)
                            ),

                            child: DropdownButton<String>(
                              padding: const EdgeInsets.symmetric(horizontal: 8),
                              isExpanded: true,


                              isDense: false,
                              hint: const Text('Select Type'),
                              value: selectedValue,
                              icon: const Icon(
                                Icons.keyboard_arrow_down_rounded,
                                size: 28,
                              ),
                              items:  items.map((e) => DropdownMenuItem<String>(
                                  value: e,
                                  child: Text(e)
                              )).toList()??[],
                              onChanged: (value) {
                                setState(() {
                                  selectedValue = value;
                                });
                              },
                            ),
                          ),

                          // CustomDropdownButton2(
                          //   hint: 'Select Type',
                          //   dropdownItems: items,
                          //   value: selectedValue,
                          //   buttonWidth: Get.width,
                          //   dropdownWidth: Get.width * 0.9,
                          //   dropdownPadding: EdgeInsets.symmetric(horizontal: 8),
                          //   // itemPadding: EdgeInsets.symmetric(horizontal: 12),
                          //   buttonHeight: 60,
                          //   icon: Icon(
                          //     Icons.keyboard_arrow_down_rounded,
                          //     size: 28,
                          //   ),
                          //
                          //   onChanged: (value) {
                          //     setState(() {
                          //       selectedValue = value;
                          //     });
                          //   },
                          // ),
                          // 14.height,
                          // FarenowTextField(
                          //   // controller: _durationController,
                          //   hint: "Enter Type",
                          //   label: "Select Type",
                          // ),
                          14.height,
                          FarenowTextField(
                            controller: _durationController,
                            hint: "Enter duration",
                            type: TextInputType.number,
                            label: "Duration",
                            onValidation: (val) {
                              if (val != null && val != "") {
                                if (int.parse(_durationController.text) < 0 ||
                                    int.parse(_durationController.text) > 255) {
                                  return "Please Select discount value between 0 to 255";
                                }
                              } else {
                                return "Field required";
                              }
                            },
                            onChange: (value){
                              setState(() {
                                durationError=validateDuration()??"";
                              });

                            },
                          ),
                          if(durationError.isNotEmpty)
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0,top: 8),
                            child: Text(durationError,
                            style: TextStyle(
                              color: Colors.red
                            ),
                            ),
                          ),
                          14.height,
                          FarenowTextField(
                            controller: _percentController,
                            hint: "Enter Discount Percentage",
                            label: "Discount Percentage",
                            type: TextInputType.number,
                            onChange: (value) {},
                            onValidation: (val) {
                              if (val != null && val != "") {
                                if (int.parse(_percentController.text) < 0 ||
                                    int.parse(_percentController.text) > 100) {
                                  return "Please Select discount value between 0 to 100";
                                }
                              } else {
                                return "Field required";
                              }
                            },

                          ),
                          14.height,
                          FarenowTextField(
                              controller: _descriptionController,
                              hint: "Enter work description",
                              label: "Description",
                              maxLine: 7,
                              inputAction: TextInputAction.done,
                              onSubmit: (value) {
                                widget.isUpdate
                                    ? updatePackage(controller)
                                    : createPackage(controller);
                              },
                              filledColor: const Color(0xffF5F5F5)),
                        ],
                      ),
                    ),
                    FarenowButton(
                        title: "Preview",
                        onPressed: () {
                          Get.dialog(PreviewPackageCard(
                            title: _titleController.text,
                            descriptioin: _descriptionController.text,
                            duration: _durationController.text,
                            percentage: _percentController.text,
                           /* type: "Weekly",*/
                            type: selectedValue.toString(),

                          ));
                        },
                        type: BUTTONTYPE.outline),
                    widget.isUpdate
                        ? FarenowButton(
                        title: "Update Package",
                        onPressed: () {
                          updatePackage(controller);
                        },
                        type: BUTTONTYPE.rectangular)
                        : FarenowButton(
                        title: "Add package",
                        onPressed: () {
                          createPackage(controller);
                        },
                        type: BUTTONTYPE.rectangular)
                  ]),
            );
          }),
    );
  }

  updatePackage(controller) {
    if (selectedValue != null) {
      if (_formKey.currentState!.validate()) {
        Map _body = {
          "title": _titleController.text,
          "type": selectedValue,
          "price": 0.0,
          "duration": _durationController.text,
          "off": _percentController.text,
          "description": _descriptionController.text
        };
        controller.updatePackages(body: _body, id: widget.data!.id);
      }
    }
  }

  createPackage(controller) {
    if (selectedValue != null) {
      if (_formKey.currentState!.validate()) {
        Map _body = {
          "title": _titleController.text,
          "type": selectedValue,
          "price": 0.0,
          "duration": _durationController.text.toInt(),
          "off": _percentController.text,
          "description": _descriptionController.text
        };
        controller.createPackages(body: _body);
      }
    } else {
      AppDialogUtils.errorDialog("Please Select Type");
    }
  }
}