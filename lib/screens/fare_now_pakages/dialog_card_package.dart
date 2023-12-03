import 'package:fare_now_provider/components/buttons-management/part_of_file/part.dart';
import 'package:fare_now_provider/components/buttons-management/style_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nb_utils/nb_utils.dart';

class PreviewPackageCard extends StatefulWidget {
  String? title;
  String? type;
  String? descriptioin;
  String? duration;
  String? percentage;

  PreviewPackageCard(
      {Key? key,
      this.descriptioin,
      this.duration,
      this.percentage,
      this.title,
      this.type})
      : super(key: key);

  @override
  State<PreviewPackageCard> createState() => _PreviewPackageCardState();
}

class _PreviewPackageCardState extends State<PreviewPackageCard> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Card(
          color: const Color(0xffFFFFFF),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
          elevation: 4,
          child: Container(
            width: Get.width * 0.9,
            // height: Get.width * 0.9,
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Card(
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          width: 60,
                          height: 60,
                          child: SvgPicture.asset(
                              "assets/providerImages/svg/preview_package.svg"),
                        ),
                      ),
                      10.width,
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.title.toString(),
                            style: const TextStyle(
                                color: Color(0xff151415),
                                fontSize: 20,
                                fontWeight: FontWeight.w500),
                          ),
                          Row(
                            children: [
                              Text("${widget.percentage}%",
                                  style: const TextStyle(
                                      color: Color(0xff151415),
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700)),
                              const Text(" discount",
                                  style: TextStyle(
                                      color: Color(0xff757575),
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400)),
                            ],
                          ),
                        ],
                      )
                    ],
                  ),
                  12.height,
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Row(
                      children: [
                        // Icon(Icons.dehaze_sharp),
                        Text("\t${widget.descriptioin}",
                            style: const TextStyle(
                                color: Color(0xff757575),
                                fontSize: 16,
                                fontWeight: FontWeight.w400)),
                      ],
                    ),
                  ),
                  12.height,
                  Row(
                    children: [
                      const Icon(
                        Icons.check,
                        color: greenColor,
                      ),
                      10.width,
                      Text("Type: ${widget.type}",
                          style: const TextStyle(
                              color: Color(0xff757575),
                              fontSize: 14,
                              fontWeight: FontWeight.w400)),
                    ],
                  ),
                  12.height,
                  Row(
                    children: [
                      const Icon(
                        Icons.check,
                        color: greenColor,
                      ),
                      10.width,
                      Text("Duration: ${widget.duration}",
                          style: const TextStyle(
                              color: Color(0xff757575),
                              fontSize: 14,
                              fontWeight: FontWeight.w400)),
                    ],
                  ),
                  12.height,
                  FarenowButton(
                      title: "Done",
                      onPressed: () {
                        Get.back();
                      },
                      style: FarenowButtonStyleModel(padding: EdgeInsets.zero),
                      type: BUTTONTYPE.rectangular)
                ]),
          ),
        )
      ],
    );
  }
}
