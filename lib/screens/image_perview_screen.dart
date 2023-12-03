import 'package:fare_now_provider/portfolio_controller.dart';
import 'package:fare_now_provider/util/api_utils.dart';
import 'package:fare_now_provider/util/widgest_utills.dart';
import 'package:fare_now_provider/widgets/custom_container.dart';
import 'package:fare_now_provider/widgets/text_with_icon.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ImagePerviewScreen extends StatelessWidget {
  ImagePerviewScreen({Key? key}) : super(key: key);
  PortfolioController _portfolioController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black.withOpacity(0.5),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Obx(() => CustomContainer(
                width: Get.width,
                alignment: Alignment.center,
                child: Stack(
                  alignment: Alignment.topRight,
                  children: [
                    Column(
                      children: [
                        CustomContainer(
                          width: Get.width,
                          height: Get.width,
                          marginTop: 24,
                          marginLeft: 24,
                          marginRight: 24,
                          paddingAll: 24,
                          child: cacheNetworkImage(
                              imageUrl:
                                  "${ApiUtills.imageBaseUrl}${_portfolioController.images.value[_portfolioController.currentIndex.value].url}",
                              imageWidth: Get.width,
                              imageHeight: Get.width,
                              color: Colors.transparent,
                              placeHolder: 'assets/images/img_gallery.png'),
                        ),
                        TextWithIcon(
                          width: Get.width,
                          fontSize: 16,
                          fontColor: Colors.white,
                          flex: 1,
                          marginLeft: 24,
                          marginRight: 24,
                          maxLine: 3,
                          title:
                              "${_portfolioController.images.value[_portfolioController.currentIndex.value].description} sdf",
                        ),
                        CustomContainer(
                          width: Get.width,
                          height: Get.width / 4,
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            children: [
                              for (int index = 0;
                                  index < _portfolioController.images.length;
                                  index++)
                                CustomContainer(
                                  marginTop: 12,
                                  marginLeft: index == 0 ? 24 : 6,
                                  marginRight: index ==
                                          (_portfolioController.images.length) -
                                              1
                                      ? 24
                                      : 6,
                                  child: CustomContainer(
                                    onTap: () {
                                      _portfolioController.currentIndex(index);
                                      _portfolioController.currentIndex
                                          .refresh();
                                    },
                                    width: (Get.width / 4) - 24,
                                    height: (Get.width / 4) - 24,
                                    borderColor: _portfolioController
                                                .currentIndex.value ==
                                            index
                                        ? Colors.white
                                        : Colors.transparent,
                                    paddingAll: 4,
                                    borderWidth: 1,
                                    allRadius: Get.width / 3,
                                    child: cacheNetworkImage(
                                        color: Colors.transparent,
                                        imageUrl:
                                            "${ApiUtills.imageBaseUrl}${_portfolioController.images[index].url}",
                                        imageWidth: (Get.width / 4) - 24,
                                        imageHeight: (Get.width / 4) - 24,
                                        radius: Get.width / 3,
                                        placeHolder:
                                            'assets/images/img_gallery.png'),
                                  ),
                                )
                            ],
                          ),
                        )
                      ],
                    ),
                    CustomContainer(
                      onTap: () {
                        Get.back();
                      },
                      marginRight: 24,
                      width: 24,
                      height: 24,
                      child: Icon(
                        Icons.cancel,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              )),
        ],
      ),
    );
  }
}
