import 'dart:io';

import 'package:fare_now_provider/components/buttons-management/part_of_file/part.dart';
import 'package:fare_now_provider/components/buttons-management/style_model.dart';
import 'package:fare_now_provider/components/celebrate_screen/celebrate.dart';
import 'package:fare_now_provider/controllers/profile_screen_controller/ProfileScreenController.dart';
import 'package:fare_now_provider/screens/service_settings.dart';
import 'package:fare_now_provider/util/api_utils.dart';
import 'package:fare_now_provider/util/app_colors.dart';
import 'package:fare_now_provider/util/app_dialog_utils.dart';
import 'package:fare_now_provider/util/widgest_utills.dart';
import 'package:fare_now_provider/widgets/text_with_icon.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:url_launcher/url_launcher.dart';


//image_picker remove
class LiscenseDocsScreen extends StatefulWidget {
  @override
  _LiscenseDocsScreenState createState() => _LiscenseDocsScreenState();
}

class _LiscenseDocsScreenState extends State<LiscenseDocsScreen> {
  ProfileScreenController _controller = Get.find();

  List image = [];

  _imgFromCamera() async {
    XFile? _image = await ImagePicker()
        .pickImage(source: ImageSource.camera, imageQuality: 50);
    print("");
    image.add(File(_image!.path));
    setState(() {});
  }

  _uploadDocument() async {
    var _picketFile = await FilePicker.platform.pickFiles(
        type: FileType.custom, allowedExtensions: ["pdf", "doc", "docx"]);
    print("");
    image.add(File(_picketFile!.files.single.path!));
    setState(() {});
  }

  _imgFromGallery() async {
    var _image = await ImagePicker()
        .pickImage(source: ImageSource.gallery, imageQuality: 50);
    print("");
    image.add(File(_image!.path));
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
                  Container(
                    height: 30,
                    alignment: Alignment.center,
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Container(
                      width: 80,
                      decoration: BoxDecoration(
                          color: Colors.black38,
                          borderRadius: BorderRadius.circular(12)),
                    ),
                  ),
                  ListTile(
                      leading: SvgPicture.asset(
                        'assets/providerImages/svg/gallery-add_sheet.svg',
                        width: 24,
                        height: 24,
                        color: const Color(0xff767676),
                      ),
                      title: Text('Photo Library'),
                      onTap: () {
                        _imgFromGallery();
                        Navigator.of(context).pop();
                      }),
                  Divider(
                    thickness: 1,
                  ),
                  ListTile(
                    leading: SvgPicture.asset(
                      'assets/providerImages/svg/camera.svg',
                      width: 24,
                      height: 24,
                      color: const Color(0xff767676),
                    ),
                    title: Text('Camera'),
                    onTap: () {
                      _imgFromCamera();
                      Navigator.of(context).pop();
                    },
                  ),
                  Divider(
                    thickness: 1,
                  ),
                  ListTile(
                    leading: SvgPicture.asset(
                      'assets/providerImages/svg/document-text.svg',
                      width: 24,
                      height: 24,
                      color: const Color(0xff767676),
                    ),
                    title: Text('Documents'),
                    onTap: () {
                      _uploadDocument();
                      Navigator.of(context).pop();
                    },
                  ),
                  Divider(
                    thickness: 1,
                  ),
                ],
              ),
            ),
          );
        });
  }

  List<Widget> docList = [];
  int currentPage = 0;
  bool firstInit = false;

//{
//                     "id": 127,
//                     "user_id": 248,
//                     "type": "2",
//                     "name": "620ce751dd1fc-1645012817.pdf",
//                     "url": "/storage/provider/docs/files/620ce751dd1fc-1645012817.pdf",
//                     "verified": 0,
//                     "created_at": "2022-02-16T12:00:17.000000Z",
//                     "updated_at": "2022-02-16T12:00:17.000000Z",
//                     "quotation_info_id": null
//                 }
  @override
  Widget build(BuildContext context) {
    if (!firstInit) {
      firstInit = true;
      for (int index = 0; index < _controller.documents.length; index++) {
        image.add(File(
            ApiUtills.imageBaseUrl + _controller.documents.value[index].url));
      }
    }

    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    if (image.isEmpty) {
      docList.clear();
      docList.add(getImageView(null));
    } else {
      docList.clear();
      docList = image.map((v) => getImageView(v)).toList();
      docList.add(getImageView(null));
    }

    return WillPopScope(
      onWillPop: () async {
        Get.back();
        return false;
      },
      child: Scaffold(
        backgroundColor: Colors.grey.shade100,
        appBar: AppBar(
          elevation: 1,
          backgroundColor: Colors.white,
          centerTitle: false,
          title: const Text(
            "License & Docs",
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.w500, color: Colors.black),
          ),
          iconTheme: IconTheme.of(context).copyWith(color: black),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 30),
          child: Stack(
            children: [
              SingleChildScrollView(
                child: Column(
                  children: [
                    20.height,
                    Container(
                      padding: const EdgeInsets.only(left: 24, right: 50),
                      child: const Text(
                        "Upload your license and Documents",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w700,
                            fontSize: 28),
                      ),
                    ),
                    80.height,
                    Container(
                      // width: width * 318 / 360,
                      // height: height * 228 / 800,
                      width: Get.width * 0.9,
                      height: Get.height * 0.3,
                      decoration: BoxDecoration(
                          color: const Color(0xffF3F4F4),
                          borderRadius: BorderRadius.circular(12)),
                      child: PageView(
                        children: docList,
                        onPageChanged: (page) {
                          currentPage = page;
                          setState(() {});
                        },
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        for (int index = 0; index < docList.length; index++)
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 3, vertical: 12),
                            child: Container(
                                alignment: Alignment.center,
                                width: 18,
                                height: 18,
                                decoration: BoxDecoration(
                                    color: index == currentPage
                                        ? AppColors.solidBlue
                                        : Colors.grey.shade400,
                                    shape: BoxShape.circle),
                                padding: EdgeInsets.all(1),
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: white, shape: BoxShape.circle),
                                  child: Padding(
                                    padding: const EdgeInsets.all(3.0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: index == currentPage
                                              ? AppColors.solidBlue
                                              : Colors.grey.shade400,
                                          shape: BoxShape.circle),
                                    ),
                                  ),
                                )),
                          )
                      ],
                    ),
                    SizedBox(
                      height: height * 106 / 800,
                    ),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: FarenowButton(
                    title: "Submit",
                    onPressed: () {
                      List<File> imageList = [];
                      for (int index = 0; index < image.length; index++) {
                        File file = image[index];
                        if (!file.path.startsWith(ApiUtills.imageBaseUrl)) {
                          imageList.add(file);
                        }
                      }
                      if (imageList.isEmpty) {
                        Get.defaultDialog(
                            title: "Alert",
                            content: const Text(
                              "Please add image before proceed next",
                            ),
                            confirm: MaterialButton(
                              onPressed: () {
                                Get.back();
                              },
                              child: const Text("Okay"),
                            ));
                        return;
                      }

                      _controller.upLoadDocs(imageList, onSuccess: () {
                        print("");
                        _controller.getProfile();
                        Get.to(CelebrateScreen(
                            imageUrl:
                            "assets/providerImages/svg/celebrate_upload_image.svg",
                            successMsg: "Upload successful",
                            detail:
                            "Your documents have been upladed successfully",
                            buttonText: "Done",
                            onTap: () {
                              // Get.off(ServiceSettings());
                              // Get.offUntil(()=>ServiceSettings(), (route) => false);
                              //  Get.offAndToNamed(ServiceSettings.id);
                              //  Get.back();
                              Get.back();
                              Get.back();
                              // Get.offAndToNamed(ServiceSettings.id);
                            }));
                      }, controller: _controller);
                    },
                    type: BUTTONTYPE.rectangular),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget getImageView(_image) {
    bool networkImage = false;
    if (_image != null) {
      networkImage = _image.path.startsWith(ApiUtills.imageBaseUrl);
    }
    return Stack(
      alignment: Alignment.topRight,
      children: [
        Container(
          width: Get.width,
          // color: Colors.red,
          child: InkWell(
            onTap: () {
              if (image.isNotEmpty) {
                if (currentPage == image.length) {
                  _showPicker(context);
                }
              } else if (image.isEmpty) {
                _showPicker(context);
              }
            },
            child: checkImageOrDoc(_image)
                ? getDocView(_image)
                : networkImage
                ? cacheNetworkImage(
              radius: 22,
              imageRadius: 22,
              imageUrl: _image.path,
              fit: BoxFit.fitHeight,
              placeHolder: "assets/images/img_loading.png",
              imageWidth: Get.width * 318 / 360,
              imageHeight: Get.height * 228 / 800,
            )
                : _image == null
                ? Container(
                width: Get.width * 318 / 360,
                height: Get.height * 228 / 800,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color:
                    const Color(0xff0068E1).withOpacity(0.12),
                    borderRadius: BorderRadius.circular(30)),
                padding: EdgeInsets.symmetric(vertical: 12),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // 14.height,
                    SvgPicture.asset(
                        "assets/providerImages/svg/gallery-add.svg",
                        width: 100,
                        height: 100,
                        color: const Color(0xff0068E1)
                            .withOpacity(0.2)),
                    FarenowButton(
                        title: "Upload Here",
                        onPressed: () {
                          if (image.isNotEmpty) {
                            if (currentPage == image.length) {
                              _showPicker(context);
                            }
                          } else if (image.isEmpty) {
                            _showPicker(context);
                          }
                        },
                        style: FarenowButtonStyleModel(
                            padding: EdgeInsets.symmetric(
                                horizontal: 24),
                            buttonColor: Color(0xffB6D5F7),
                            textColor: AppColors.solidBlue),
                        type: BUTTONTYPE.action)
                  ],
                )
              // Image.asset(
              //   "assets/providerImages/png/img_placeholder.png",
              // color: const Color(0xff0068E1).withOpacity(0.2),
              // )
            )
                : Container(
              width: Get.width * 318 / 360,
              height: Get.height * 228 / 800,
              decoration: BoxDecoration(
                  color: const Color(0xffF3F4F4),
                  image: DecorationImage(
                      image: FileImage(_image),
                      fit: BoxFit.cover),
                  borderRadius: BorderRadius.circular(30)),
              // child: Image.file(
              //   _image,
              //   fit: BoxFit.cover,
              //   filterQuality: FilterQuality.medium,
              // ),
            ),
          ),
        ),
        if (!networkImage && _image != null)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
            child: InkWell(
                onTap: () {
                  alertDialog(
                      title: "Alert",
                      content: "Do you want to delete this item?",
                      confirm: button(
                          title: "Yes",
                          onClick: () {
                            image.remove(_image);
                            print(docList.length.toString());
                            setState(() {});
                            Get.back();
                          }),
                      cancel: button(
                          title: "No",
                          onClick: () {
                            Get.back();
                          }));
                },
                child: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                      color: const Color(0xff0068E1).withOpacity(0.3),
                      borderRadius: BorderRadius.circular(18)),
                  padding: const EdgeInsets.all(9),
                  child: Container(
                    decoration: BoxDecoration(
                        color: AppColors.solidBlue,
                        borderRadius: BorderRadius.circular(12)),
                    child: const Icon(
                      Icons.close,
                      color: white,
                      size: 18,
                    ),
                  ),
                )),
          )
      ],
    );
  }

  checkImageOrDoc(File? image) {

    if (image == null) {
      return false;
    }
    if (image.path.contains(".pdf")) {
      return true;
    }
    if (image.path.contains(".doc") || image.path.contains(".docx")) {
      return true;
    }

    return false;
  }

  Widget getDocView(File? image) {
    bool networkImage = image!.path.startsWith(ApiUtills.imageBaseUrl);
    String path = image.path;
    String name = getFileName(image.path, networkImage);

    bool extPdf = image.path.contains('pdf');
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Icon(
        //   Icons.attach_file_outlined,
        //   size: 72,
        // ),
        extPdf
            ? InkWell(
          onTap: () {
            if (path.contains("https://")) {
              _launchURL(image.path);
            } else {
              _launchURL(image);
            }
          },
          child: Image.asset(
            'assets/img_pdf.png',
            height: 100,
          ),
        )
            : InkWell(
          onTap: () {
            if (path.contains("https://")) {
              _launchURL(image.path);
            } else {
              _launchURL(image);
            }
          },
          child: Image.asset(
            'assets/img_word.png',
            height: 100,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        TextWithIcon(
          width: Get.width,
          textAlign: TextAlign.center,
          title: "$name",
          fontSize: 18,
          fontWeight: FontWeight.bold,
          flex: 1,
          paddingRight: 12,
          paddingLeft: 12,
          maxLine: 2,
        ),
      ],
    );
  }



  void _launchURL(_url) async {
    if (!await launch(_url)) throw 'Could not launch $_url';
  }

  getFile(String path) {
    if (path.contains("file_picker/")) {
      return "file_picker/";
    }
    return "Download/";
  }

  String getFileName(String path, networkImage) {
    if (GetPlatform.isIOS) {
      if (path.contains("/files/")) {
        return path.split("files/")[1];
      }
      return path.split("/tmp/com.example.fareNowProvider-Inbox/")[1];
    } else {
      return path.split(networkImage ? "files/" : getFile(path))[1];
    }
  }
}
