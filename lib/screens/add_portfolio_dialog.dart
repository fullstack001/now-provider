import 'dart:io';

import 'package:fare_now_provider/components/buttons-management/part_of_file/part.dart';
import 'package:fare_now_provider/components/buttons-management/style_model.dart';
import 'package:fare_now_provider/components/text_fields/farenow_text_field.dart';
import 'package:fare_now_provider/models/prortfolio/portfio_data.dart';
import 'package:fare_now_provider/portfolio_controller.dart';
import 'package:fare_now_provider/util/app_colors.dart';
import 'package:fare_now_provider/util/app_dialog_utils.dart';
import 'package:fare_now_provider/widgets/custom_container.dart';
import 'package:fare_now_provider/widgets/text_with_icon.dart';
/*import 'package:fdottedline/fdottedline.dart';*/
import 'package:fdottedline_nullsafety/fdottedline__nullsafety.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nb_utils/nb_utils.dart';

import '../custom_packages/keyboard_overlay/keyboard_overlay.dart';

//image_picker remove
class AddPortfolioDialog extends StatefulWidget {
  var onPortfolioAdd;

  AddPortfolioDialog({Key? key, this.onPortfolioAdd}) : super(key: key);

  @override
  State<AddPortfolioDialog> createState() => _AddPortfolioDialogState();
}

class _AddPortfolioDialogState extends State<AddPortfolioDialog>
    with HandleFocusNodesOverlayMixin {
  PortfolioController? _portfolioController = Get.find();

  var image;
  final double maxHeight = 1200;
  final double maxWidth = 1200;

  FocusNode descriptionFocusNode = FocusNode();
  FocusNode titleNode = FocusNode();

  _imgFromCamera() async {
    var image = await ImagePicker().pickImage(
      source: ImageSource.camera,
      imageQuality: 85,
      maxWidth: maxWidth,
      maxHeight: maxHeight,
    );

    if (image != null) {
      setState(() {
        setImage(File(image!.path));
      });
    }
    return null;
  }

  _imgFromGallery() async {
    var image = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      imageQuality: 85,
      maxWidth: maxWidth,
      maxHeight: maxHeight,
    );

    if (image != null) {
      setState(() {
        setImage(File(image!.path));
      });
    }
    return null;
  }

  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Wrap(
              children: <Widget>[
                Align(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: Container(
                      height: 5,
                      width: 48,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: Color(0xffCDCFD0),
                          borderRadius: BorderRadius.circular(22)),
                    ),
                  ),
                ),
                ListTile(
                    leading: SvgPicture.asset(
                        "assets/providerImages/svg/gallery-add_sheet.svg"),
                    title: const Text('Photo Library'),
                    onTap: () {
                      _imgFromGallery();
                      Navigator.of(context).pop();
                    }),
                const Divider(
                  thickness: 1,
                ),
                ListTile(
                  leading:
                      SvgPicture.asset("assets/providerImages/svg/camera.svg"),
                  title: const Text('Camera'),
                  onTap: () {
                    _imgFromCamera();
                    Navigator.of(context).pop();
                  },
                ),
                const Divider(
                  thickness: 1,
                ),
              ],
            ),
          );
        });
  }

  @override
  void initState() {
    setDoneButton();
    super.initState();
  }

  TextEditingController title = TextEditingController();
  TextEditingController description = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Obx(() => CustomContainer(
              // allRadius: 12,
              width: Get.width,
              topLeftRadius: 22, topRightRadius: 22,
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: SingleChildScrollView(
                  child: Stack(
                    children: [
                      SingleChildScrollView(
                        child: Column(
                          // crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Align(
                              alignment: Alignment.center,
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 12),
                                child: Container(
                                  height: 5,
                                  width: 48,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      color: Color(0xffCDCFD0),
                                      borderRadius: BorderRadius.circular(22)),
                                ),
                              ),
                            ),
                            TextWithIcon(
                              width: Get.width,
                              bgColor: AppColors.white,
                              height: 35,
                              paddingTop: 10,
                              title: "Add Portfolio",
                              fontColor: Colors.black,
                              fontSize: 28,
                              fontWeight: FontWeight.w500,
                            ),
                            FarenowTextField(
                                controller: title,
                                node: titleNode,
                                onValidation: (value) {
                                  if (value!.isEmpty) {
                                    return "Field required*";
                                  }
                                  return null;
                                },
                                onSubmit: ((p0) {
                                  titleNode.requestFocus();
                                }),
                                hint: "Enter your portfolio title",
                                label: "Title"),
                            5.height,
                            FarenowTextField(
                                node: descriptionFocusNode,
                                onSubmit: ((p0) {
                                  descriptionFocusNode.requestFocus();
                                }),
                                initailValue:
                                    _portfolioController!.description.value,
                                maxLine: 3,
                                onChange: (val) {
                                  _portfolioController!.description.value = val;
                                  _portfolioController!.description.refresh();
                                },
                                onValidation: (value) {
                                  if (value!.isEmpty) {
                                    return "Field required*";
                                  }
                                  return null;
                                },
                                hint: "Enter work description",
                                label: "Description"),

                            10.height,
                            if (_portfolioController!.image.value.path.isEmpty)
                              FDottedLine(
                                corner: FDottedLineCorner.all(18),
                                color: AppColors.solidBlue,
                                child: CustomContainer(
                                  paddingAll: 4,
                                  color: Color(0xffEBF4FF),
                                  width: Get.width,
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Flexible(
                                          flex: 1,
                                          child: SvgPicture.asset(
                                            "assets/providerImages/svg/gallery-add.svg",
                                            color: AppColors.solidBlue,
                                            width: 50,
                                            height: 50,
                                          ),
                                        ),
                                        Flexible(
                                          flex: 3,
                                          child: FarenowButton(
                                              title: "Upload Image",
                                              onPressed: () {
                                                Get.focusScope!.unfocus();
                                                _showPicker(context);
                                              },
                                              style: FarenowButtonStyleModel(
                                                  buttonColor:
                                                      const Color(0xffB6D5F7),
                                                  textColor:
                                                      AppColors.solidBlue),
                                              type: BUTTONTYPE.action),
                                        )
                                      ]),
                                ),
                              ),

                            if (_portfolioController!
                                .image.value.path.isNotEmpty)
                              FDottedLine(
                                corner: FDottedLineCorner.all(18),
                                color: AppColors.solidBlue,
                                child: CustomContainer(
                                  paddingAll: 4,
                                  color: Color(0xffEBF4FF),
                                  width: Get.width,
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Flexible(
                                          flex: 1,
                                          child: Container(
                                            width: 50,
                                            height: 50,
                                            decoration: BoxDecoration(
                                                color: Colors.grey.shade400,
                                                borderRadius:
                                                    BorderRadius.circular(8)),
                                            padding: const EdgeInsets.all(4.0),
                                            child: Image(
                                              image: FileImage(
                                                _portfolioController!
                                                    .image.value,
                                              ),
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                        ),
                                        Flexible(
                                          flex: 3,
                                          child: FarenowButton(
                                              title: "Change Image",
                                              onPressed: () {
                                                Get.focusScope!.unfocus();
                                                _showPicker(context);
                                              },
                                              style: FarenowButtonStyleModel(
                                                  buttonColor:
                                                      const Color(0xffB6D5F7),
                                                  textColor:
                                                      AppColors.solidBlue),
                                              type: BUTTONTYPE.action),
                                        )
                                      ]),
                                ),
                              ),
                            16.height,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Flexible(
                                  fit: FlexFit.loose,
                                  child: FarenowButton(
                                      style: FarenowButtonStyleModel(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 4)),
                                      title: "Cancel",
                                      onPressed: () {
                                        Get.back();
                                      },
                                      type: BUTTONTYPE.action),
                                ),
                                Flexible(
                                  fit: FlexFit.loose,
                                  child: FarenowButton(
                                      style: FarenowButtonStyleModel(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 4)),
                                      title: "Submit",
                                      onPressed: () {
                                        Get.focusScope!.unfocus();
                                        if (_portfolioController!
                                            .description.value.isEmpty) {
                                          alertDialog(
                                              title: "Alert",
                                              content:
                                                  "Please enter description",
                                              confirm: MaterialButton(
                                                onPressed: () {
                                                  Get.back();
                                                },
                                                child: const Text("Okay"),
                                              ));
                                          return;
                                        }
                                        if (_portfolioController!
                                            .image.value.path.isEmpty) {
                                          alertDialog(
                                              title: "Alert",
                                              content: "Please select image",
                                              confirm: MaterialButton(
                                                onPressed: () {
                                                  Get.back();
                                                },
                                                child: const Text("Okay"),
                                              ));
                                          return;
                                        }
                                        PortfioData obj = PortfioData();
                                        obj.description = _portfolioController!
                                            .description.value;
                                        obj.image =
                                            _portfolioController!.image.value;
                                        obj.title = title.text;
                                        widget.onPortfolioAdd(obj);
                                        Get.back();
                                      },
                                      type: BUTTONTYPE.rectangular),
                                )
                              ],
                            )

                            // CustomContainer(
                            //   marginTop: 12,
                            //   marginBottom: 8,
                            //   width: Get.width,
                            //   onTap: () {
                            //     // Get.focusScope!.unfocus();
                            //     // if (_portfolioController!.description.value.isEmpty) {
                            //     //   alertDialog(
                            //     //       title: "Alert",
                            //     //       content: "Please enter description",
                            //     //       confirm: MaterialButton(
                            //     //         onPressed: () {
                            //     //           Get.back();
                            //     //         },
                            //     //         child: const Text("Okay"),
                            //     //       ));
                            //     //   return;
                            //     // }
                            //     // if (_portfolioController!.image.value.path.isEmpty) {
                            //     //   alertDialog(
                            //     //       title: "Alert",
                            //     //       content: "Please select image",
                            //     //       confirm: MaterialButton(
                            //     //         onPressed: () {
                            //     //           Get.back();
                            //     //         },
                            //     //         child: const Text("Okay"),
                            //     //       ));
                            //     //   return;
                            //     // }
                            //     // PortfioData obj = PortfioData();
                            //     // obj.description =
                            //     //     _portfolioController!.description.value;
                            //     // obj.image = _portfolioController!.image.value;
                            //     // widget.onPortfolioAdd(obj);
                            //     // Get.back();
                            //   },
                            //   child: TextWithIcon(
                            //     bgColor: AppColors.appBlue,
                            //     width: Get.width,
                            //     fontSize: 18,
                            //     fontColor: AppColors.white,
                            //     paddingAll: 8,
                            //     fontWeight: FontWeight.w700,
                            //     allRadius: 6,
                            //     marginRight: 12,
                            //     marginLeft: 12,
                            //     title: "Submit",
                            //   ),
                            // )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ))
      ],
    );
  }

  void showMessage() {
    Get.defaultDialog(
      title: "Alert",
      content: const Text("Image should be 690x320 or greater from this"),
      confirm: MaterialButton(
        child: const Text("Okay"),
        onPressed: () {
          Get.back();
        },
      ),
    );
  }

  void setImage(File image) async {
    final croppedFile = await ImageCropper().cropImage(
      sourcePath: image.path,
      compressFormat: ImageCompressFormat.jpg,
      compressQuality: 100,
      aspectRatio: const CropAspectRatio(ratioX: 690, ratioY: 520),
      uiSettings: [
        AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: Colors.deepOrange,
            toolbarWidgetColor: Colors.white,
            showCropGrid: true,
            hideBottomControls: true,
            initAspectRatio: CropAspectRatioPreset.ratio4x3,
            lockAspectRatio: true),
        IOSUiSettings(
            title: 'Cropper',
            rotateButtonsHidden: true,
            aspectRatioLockEnabled: true,
            rectX: 690,
            rectY: 520,
            rectWidth: 690,
            rectHeight: 520,
            minimumAspectRatio: 690,
            showCancelConfirmationDialog: true,
            showActivitySheetOnDone: false),
      ],
    );
    image = File(croppedFile!.path);
    var decodedImage = await decodeImageFromList(image.readAsBytesSync());
    var width = decodedImage.width;
    var height = decodedImage.height;
    image = File(image.path);

    _portfolioController!.image.value = image;
    _portfolioController!.image.refresh();
    if (width > 690 && height > 320) {
    } else {
      // showMessage();
    }
  }

  void setDoneButton() {
    if (GetPlatform.isIOS) {
      descriptionFocusNode = GetFocusNodeOverlay(
          child: TopKeyboardUtil(
        DoneButtonIos(
          label: 'Done',
          onSubmitted: () => Get.focusScope!.unfocus(),
          platforms: ['android', 'ios'],
        ),
      ));
      titleNode = GetFocusNodeOverlay(
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
