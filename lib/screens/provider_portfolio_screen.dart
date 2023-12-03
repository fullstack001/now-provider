import 'dart:io';

import 'package:fare_now_provider/components/buttons-management/part_of_file/part.dart';
import 'package:fare_now_provider/models/prortfolio/portfio_data.dart';
import 'package:fare_now_provider/portfolio_controller.dart';
import 'package:fare_now_provider/screens/add_portfolio_dialog.dart';
import 'package:fare_now_provider/screens/image_perview_screen.dart';
import 'package:fare_now_provider/util/api_utils.dart';
import 'package:fare_now_provider/util/app_colors.dart';
import 'package:fare_now_provider/util/app_dialog_utils.dart';
import 'package:fare_now_provider/util/widgest_utills.dart';
import 'package:fare_now_provider/widgets/custom_container.dart';
import 'package:fare_now_provider/widgets/text_with_icon.dart';
import 'package:fdottedline_nullsafety/fdottedline__nullsafety.dart';

import 'package:nb_utils/nb_utils.dart';

class ProviderPortfolioScreen extends StatefulWidget {
  final list;

  ProviderPortfolioScreen({
    Key? key,
    this.list,
  }) : super(key: key);

  @override
  State<ProviderPortfolioScreen> createState() =>
      _ProviderPortfolioScreenState();
}

class _ProviderPortfolioScreenState extends State<ProviderPortfolioScreen> {
  PortfolioController? _portfolioController = Get.put(PortfolioController());

  bool init = false;

  @override
  void initState() {
    _portfolioController!.images(widget.list);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: true,
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        elevation: 1,
        backgroundColor: Colors.white,
        centerTitle: false,
        iconTheme: IconTheme.of(context).copyWith(color: black),
        title: const Text(
          "Portfolio",
          style: TextStyle(
              color: black, fontSize: 18, fontWeight: FontWeight.w500),
        ),
        // actions: [
        //   Obx(() => Column(
        //         mainAxisAlignment: MainAxisAlignment.center,
        //         children: [
        //           if (_portfolioController!.images.isNotEmpty &&
        //               _portfolioController!.images.length < 8)
        //             CustomContainer(
        //               width: 32,
        //               height: 32,
        //               onTap: ,
        //               borderWidth: 2,
        //               borderColor: AppColors.appBlue,
        //               allRadius: 24,
        //               child: const Icon(
        //                 Icons.add,
        //                 color: AppColors.appBlue,
        //               ),
        //             ),
        //         ],
        //       )),
        // ],
      ),
      body: CustomContainer(
        width: Get.width,
        height: Get.height,
        child: Obx(() => Column(
              children: [
                12.height,
                if (_portfolioController!.images.length < 3)
                  Text(
                    "Upload atleast ${_portfolioController!.images.length}/3 images",
                    style: const TextStyle(color: Colors.red),
                  ),
                Expanded(
                  child: _portfolioController!.images.isEmpty
                      ? getAddButton()
                      : ListView(children: [
                          Column(
                            children: List.generate(
                                _portfolioController!.images.length,
                                (index) => getCard(index)),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 24),
                            child: FDottedLine(
                              corner: FDottedLineCorner.all(12),
                              child: Container(
                                width: Get.width,
                                height: 56,
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 12),
                                color: Color(0xffEBF4FF),
                                child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text(
                                        "Add more",
                                        style: TextStyle(
                                            color: AppColors.solidBlue,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400),
                                      ),
                                      GestureDetector(
                                        onTap: addPortfolioButton,
                                        child: Container(
                                          padding: const EdgeInsets.all(8),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                            color: AppColors.solidBlue,
                                          ),
                                          width: 46,
                                          height: 46,
                                          child: const Icon(
                                            Icons.add,
                                            size: 22,
                                            color: white,
                                          ),
                                        ),
                                      )
                                    ]),
                              ),
                            ),
                          ),
                        ]
                          // [
                          //   for (int index = 0;
                          //       index < _portfolioController!.images.length;
                          //       index++)
                          //     itemWidget(index),
                          // ],
                          ),
                ),
                if (_portfolioController!.images.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 12),
                    child: CustomContainer(
                      width: Get.width,
                      height: 70,
                      child: TextWithIcon(
                        allRadius: 18,
                        paddingAll: 12,
                        height: 55,
                        width: Get.width,
                        fontSize: 18,
                        containerClick: () {
                          if (getImageCount() >= 3) {
                            Get.focusScope!.unfocus();
                            if (_portfolioController!
                                .description.value.isEmpty) {
                              alertDialog(
                                title: "Alert",
                                content: "Please enter description",
                                confirm: MaterialButton(
                                  onPressed: () {
                                    Get.back();
                                  },
                                  child: const Text("yes"),
                                ),
                              );
                              return;
                            }
                            List<PortfioData> files = [];

                            for (int index = 0;
                                index < _portfolioController!.images.length;
                                index++) {
                              PortfioData value =
                                  _portfolioController!.images[index];
                              if (value.image != null) {
                                files.add(value);
                              }
                            }

                            _portfolioController!.postPortfolio(
                                imagesLists: files,
                                desc: _portfolioController!.description.value);
                          }
                        },
                        fontColor: getImageCount() >= 3
                            ? Colors.white
                            : AppColors.black,
                        fontWeight: FontWeight.w600,
                        bgColor: getImageCount() >= 3
                            ? AppColors.solidBlue
                            : AppColors.grey,
                        title:
                            "${getTitles(_portfolioController!.images.value)}",
                      ),
                    ),
                  )
              ],
            )),
      ),
    );
  }

  getCard(int index) {
    var value = _portfolioController!.images.value[index];
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: Card(
        color: white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(22)),
        child: Container(
          padding: const EdgeInsets.only(bottom: 12),
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(24)),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 24, right: 24, left: 24),
                  child: Column(
                    children: [
                      getImage(index),
                      10.height,
                      Container(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            _portfolioController!
                                .images.value[index].description,
                            style: const TextStyle(
                                color: Color(0xff151415),
                                fontSize: 18,
                                fontWeight: FontWeight.w500),
                          )),
                    ],
                  ),
                ),
                10.height,
                FarenowButton(
                  onPressed: () {
                    alertDialog(
                      title: "Alert",
                      content: "Do you want to remove this?",
                      confirm: MaterialButton(
                        onPressed: () {
                          if (value.image != null) {
                            _portfolioController!.images.value.removeAt(index);
                            _portfolioController!.images.refresh();
                            Get.back();
                          } else {
                            _portfolioController!
                                .deleteImagePort(value.id, index);
                            Get.back();
                          }
                        },
                        child: const Text("yes"),
                      ),
                      cancel: MaterialButton(
                        onPressed: () {
                          Get.back();
                        },
                        child: const Text("No"),
                      ),
                    );
                  },
                  title: "Delete",
                  type: BUTTONTYPE.rectangular,
                )
              ]),
        ),
      ),
    );
  }

  getImage(int index) {
    var value = _portfolioController!.images.value[index];
    return Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
            color: const Color(0xffF5F5F5),
            borderRadius: BorderRadius.circular(22),
            border: Border.all(
                color: value.status == 0 ? Colors.red : Colors.black12)),
        child: value.image == null
            ? cacheNetworkImage(
                imageUrl: getImagePath(value),
                imageWidth: 100,
                radius: 22,
                color: Colors.transparent,
                imageHeight: 100,
        )
            : Padding(
                padding: EdgeInsets.all(4.0),
                child: Image(
                  image: FileImage(
                    _portfolioController!.images.value[index].image,
                  ),
                  fit: BoxFit.fill,
                ),
                // Image(
                //   image: AssetImage(
                //       "assets/providerImages/png/img_placeholder.png"),
                // ),
              ));
  }

  getImagePath(PortfioData value) {
    String url =
      "${ApiUtills.imageBaseUrl}${(value).url}";
      /*  "${ApiUtills.imageBaseUrl}${(value).url.replaceAll("/storage", "storage")}";*/
    return url;
  }

  getAddButton() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CustomContainer(
          onTap: addPortfolioButton,
          width: 110,
          height: 120,
          child: const Image(
            image: AssetImage(
              'assets/images/img_resume.png',
            ),
          ),
        ),
        const SizedBox(
          height: 12,
        ),
        TextWithIcon(
          containerClick: addPortfolioButton,
          width: Get.width,
          title: "Add Portfolio",
          fontSize: 20,
          fontWeight: FontWeight.w700,
        )
      ],
    );
  }

  void addPortfolioButton() {
    _portfolioController!.description("");
    _portfolioController!.image.value = File("");
    showModalBottomSheet(
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(22), topRight: Radius.circular(22))),
        context: context,
        builder: ((context) {
          return SingleChildScrollView(
            child: Column(
              children: [
                AddPortfolioDialog(
                  onPortfolioAdd: (PortfioData value) {
                    _portfolioController!.images.value.add(value);
                    _portfolioController!.images.refresh();
                  },
                ),
                Padding(
                    padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom))
              ],
            ),
          );
        }));
    // Get.dialog(AddPortfolioDialog(
    //   onPortfolioAdd: (PortfioData value) {
    //     _portfolioController!.images.value.add(value);
    //     _portfolioController!.images.refresh();
    //   },
    // ));
  }

  getImageCount() {
    int count = 0;

    if (getTitles(_portfolioController!.images.value) == "Update") {
      bool exist = isExist(_portfolioController!.images.value);
      if (exist) {
        return 5;
      }
    }
    for (int index = 0; index < _portfolioController!.images.length; index++) {
      PortfioData value = _portfolioController!.images[index];
      if (value.image != null) {
        count = count + 1;
      }
    }
    return count;
  }

  getTitles(List<dynamic> valueX) {
    for (int index = 0; index < valueX.length; index++) {
      PortfioData value = valueX[index];
      if (value.image == null) {
        return "Update";
      }
    }
    return "Submit";
  }

  itemWidget(int index) {
    var value = _portfolioController!.images.value[index];
    return CustomContainer(
      marginTop: index == 0 ? 12 : 0,
      width: Get.width,
      marginLeft: 24,
      marginRight: 24,
      marginBottom: index == _portfolioController!.images.length - 1 ? 12 : 0,
      child: CustomContainer(
        width: Get.width,
        onTap: () {
          _portfolioController!.currentIndex(index);
          Get.dialog(ImagePerviewScreen());
        },
        child: Column(
          children: [
            if (index != 0)
              const Divider(
                color: Colors.grey,
              ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                getImage(index),
                Expanded(
                    child: TextWithIcon(
                  width: Get.width,
                  flex: 1,
                  fontSize: 14,
                  maxLine: 4,
                  marginTop: 8,
                  marginRight: 12,
                  marginLeft: 12,
                  overFlow: TextOverflow.ellipsis,
                  title: _portfolioController!.images.value[index].description,
                )),
                IconButton(
                    onPressed: () {
                      alertDialog(
                        title: "Alert",
                        content: "Do you want to remove this?",
                        confirm: MaterialButton(
                          onPressed: () {
                            if (value.image != null) {
                              _portfolioController!.images.value
                                  .removeAt(index);
                              _portfolioController!.images.refresh();
                              Get.back();
                            } else {
                              _portfolioController!
                                  .deleteImagePort(value.id, index);
                              Get.back();
                            }
                          },
                          child: const Text("yes"),
                        ),
                        cancel: MaterialButton(
                          onPressed: () {
                            Get.back();
                          },
                          child: const Text("No"),
                        ),
                      );
                    },
                    icon: const Icon(
                      Icons.delete,
                      color: Colors.red,
                    )),
              ],
            ),
          ],
        ),
      ),
    );
  }

  bool isExist(List<dynamic> valueX) {
    for (int index = 0; index < valueX.length; index++) {
      PortfioData value = valueX[index];
      if (value.image != null) {
        return true;
      }
    }
    return false;
  }
}

/*
import 'dart:io';

import 'package:fare_now_provider/models/prortfolio/protfolio_images.dart';
import 'package:fare_now_provider/portfolio_controller.dart';
import 'package:fare_now_provider/util/api_utils.dart';
import 'package:fare_now_provider/util/app_colors.dart';
import 'package:fare_now_provider/util/app_dialog_utils.dart';
import 'package:fare_now_provider/util/widgest_utills.dart';
import 'package:fare_now_provider/widgets/custom_container.dart';
import 'package:fare_now_provider/widgets/text_with_icon.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProviderPortfolioScreen extends StatelessWidget {
  ProviderPortfolioScreen({Key? key}) : super(key: key);

  PortfolioController _portfolioController = Get.put(PortfolioController());

  bool init = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "Portfolio",
          style: TextStyle(color: Colors.black),
        ),
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(
            Icons.arrow_back,
            size: 25,
            color: Colors.blue,
          ),
        ),
      ),
      body: SafeArea(
        child: CustomContainer(
          width: Get.width,
          height: Get.height,
          child: Obx(() => Column(
                children: [
                  Expanded(
                    child: ListView(
                      children: [
                        TextWithIcon(
                          title: "Description",
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          marginTop: 24,
                          marginLeft: 24,
                        ),
                        CustomContainer(
                          // margin: EdgeInsets.only(top: 12, left: 24, right: 24, bottom: 24),
                          width: Get.width,
                          marginTop: 12,
                          marginLeft: 24,
                          allRadius: 12,
                          marginRight: 24,
                          height: 200,
                          color: Color(0xffF0F1F1),
                          child: TextFormField(
                            initialValue:
                                _portfolioController!.description.value,
                            maxLines: 10,
                            onChanged: (val) {
                              print(val);
                              _portfolioController!.description.value = val;
                              _portfolioController!.description.refresh();
                            },
                            keyboardType: TextInputType.multiline,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderSide: BorderSide.none),
                                filled: true,
                                hintText: "Enter work description",
                                hintStyle: TextStyle(
                                  fontSize: 16,
                                ),
                                contentPadding: EdgeInsets.all(8)),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TextWithIcon(
                              title: "Images",
                              fontSize: 20,
                              fontWeight: FontWeight.w400,
                              marginTop: 24,
                              marginLeft: 24,
                            ),
                            if (_portfolioController!.images.length < 8)
                              CustomContainer(
                                width: 32,
                                height: 32,
                                marginTop: 24,
                                marginLeft: 24,
                                onTap: () {
                                  _showPicker(context);
                                },
                                child: Icon(
                                  Icons.add,
                                  color: AppColors.black,
                                ),
                                borderWidth: 1,
                                borderColor: AppColors.black,
                                marginRight: 24,
                                allRadius: 32,
                              )
                          ],
                        ),
                        CustomContainer(
                          width: Get.width,
                          marginLeft: 18,
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: Wrap(
                              alignment: WrapAlignment.spaceBetween,
                              children: [
                                for (int index = 0;
                                    index < _portfolioController!.images.length;
                                    index++)
                                  CustomContainer(
                                    marginLeft: 0,
                                    width: (Get.width - 36) / 3,
                                    height: (Get.width - 36) / 3,
                                    paddingAll: 4,
                                    child: CustomContainer(
                                      marginLeft: 0,
                                      width: Get.width,
                                      height: Get.height,
                                      paddingAll: 4,
                                      child: getImage(index),
                                    ),
                                  ),
                                if (_portfolioController!.images.length % 3 != 0)
                                  CustomContainer(
                                    marginLeft: 0,
                                    width: (Get.width - 36) / 3,
                                    height: (Get.width - 36) / 3,
                                    paddingAll: 4,
                                    child: CustomContainer(
                                      marginLeft: 0,
                                      width: Get.width,
                                      onTap: () {},
                                      height: Get.height,
                                      paddingAll: 4,
                                    ),
                                  )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  CustomContainer(
                    marginRight: 24,
                    marginLeft: 24,
                    marginBottom: 12,
                    width: Get.width,
                    child: TextWithIcon(
                      paddingAll: 12,
                      width: Get.width,
                      fontSize: 18,
                      containerClick: () {
                        if (getImageCount() >= 3) {
                          Get.focusScope!.unfocus();
                          if (_portfolioController!.description.value.isEmpty) {
                            alertDialog(
                              title: "Alert",
                              content: "Please enter description",
                              confirm: MaterialButton(
                                onPressed: () {
                                  Get.back();
                                },
                                child: Text("yes"),
                              ),
                            );
                            return;
                          }
                          List<File> files = [];

                          for (int index = 0;
                              index < _portfolioController!.images.length;
                              index++) {
                            PortfioData value =
                                _portfolioController!.images[index];
                            if (value.url != null) {
                              // files.add(value.image);
                            }
                          }

                          if (getTitles(_portfolioController!.images.value) ==
                              "Update") {
                            _portfolioController!.updatePortfolio(
                                imagesLists: files,
                                desc: _portfolioController!.description.value,
                                id: _portfolioController!.objectId.value);
                          } else {
                            _portfolioController!.postPortfolio(
                                imagesLists: files,
                                desc: _portfolioController!.description.value);
                          }
                        }
                      },
                      allRadius: 8,
                      fontColor:
                          getImageCount() >= 3 ? Colors.white : AppColors.black,
                      fontWeight: FontWeight.w600,
                      bgColor: getImageCount() >= 3
                          ? AppColors.appBlue
                          : AppColors.grey,
                      title: "${getTitles(_portfolioController!.images.value)}",
                    ),
                  )
                ],
              )),
        ),
      ),
    );
  }

  getImage(int index) {
    var value = _portfolioController!.images.value[index];
    return Stack(
      alignment: Alignment.topRight,
      children: [
        value.image == null
            ? cacheNetworkImage(
                imageUrl: getImagePath(value),
                imageWidth: (Get.width - 36) / 3,
                radius: (Get.width - 36) / 3,
                imageHeight: (Get.width - 36) / 3)
            : Image(
                image: FileImage(
                  value.image,
                ),
              ),
        CustomContainer(
          onTap: () {
            alertDialog(
              title: "Alert",
              content: "Do you want to remove this?",
              confirm: MaterialButton(
                onPressed: () {
                  if (value.image != null) {
                    _portfolioController!.images.value.removeAt(index);
                    _portfolioController!.images.refresh();
                    Get.back();
                  } else {
                    _portfolioController!.deleteImagePort(value.id, index);
                    Get.back();
                  }
                },
                child: Text("yes"),
              ),
              cancel: MaterialButton(
                onPressed: () {
                  Get.back();
                },
                child: Text("No"),
              ),
            );
          },
          child: Icon((Icons.cancel)),
          width: 24,
          height: 24,
        )
      ],
    );
  }

  getImagePath(ProtfolioImages value) {
    String url =
        "${ApiUtills.imageBaseUrl}${(value).url.replaceAll("/storage", "storage")}";
    return url;
  }

  getImageCount() {
    int count = 0;

    if (getTitles(_portfolioController!.images.value) == "Update") {
      bool exist = isExist(_portfolioController!.images.value);
      if (exist) {
        return 5;
      }
    }
    for (int index = 0; index < _portfolioController!.images.length; index++) {
      ProtfolioImages value = _portfolioController!.images[index];
      if (value.image != null) {
        count = count + 1;
      }
    }
    return count;
  }

  getTitles(List<dynamic> valueX) {
    for (int index = 0; index < valueX.length; index++) {
      ProtfolioImages value = valueX[index];
      if (value.image == null) {
        return "Update";
      }
    }
    return "Submit";
  }

  bool isExist(List<dynamic> valueX) {
    for (int index = 0; index < valueX.length; index++) {
      ProtfolioImages value = valueX[index];
      if (value.image != null) {
        return true;
      }
    }
    return false;
  }
}
*/
