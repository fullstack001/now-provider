import 'package:fare_now_provider/components/buttons-management/style_model.dart';
import 'package:fare_now_provider/components/text_fields/farenow_text_field.dart';
import 'package:fare_now_provider/controllers/rating_controller.dart';
import 'package:fare_now_provider/custom_packages/keyboard_overlay/keyboard_overlay.dart';
import 'package:fare_now_provider/models/available_services/available_service_data.dart';
import 'package:fare_now_provider/util/api_utils.dart';
import 'package:fare_now_provider/util/app_colors.dart';
import 'package:fare_now_provider/util/app_dialog_utils.dart';
import 'package:fare_now_provider/util/home_widgets.dart';
import 'package:fare_now_provider/util/widgest_utills.dart';
import 'package:fare_now_provider/widgets/rating_start.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../components/buttons-management/part_of_file/part.dart';

class FeedBackPage extends StatefulWidget {
  final data;
  final onRateComplete;

  FeedBackPage({
    Key? key,
    this.data,
    this.onRateComplete,
  }) : super(key: key);

  @override
  _FeedBackPageState createState() => _FeedBackPageState();
}

class _FeedBackPageState extends State<FeedBackPage>
    with HandleFocusNodesOverlayMixin {
  TextEditingController _feedbackController = TextEditingController();

  var initialRating = 1.0;
  RatingController rating = Get.find();

  var feedbackNode = FocusNode();
  void setDoneButton() {
    if (GetPlatform.isIOS) {
      feedbackNode = GetFocusNodeOverlay(
          child: TopKeyboardUtil(
        DoneButtonIos(
          label: 'Done',
          onSubmitted: () => Get.focusScope!.unfocus(),
          platforms: ['android', 'ios'],
        ),
      ));
    }
  }

  @override
  void initState() {
    setDoneButton();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (!kReleaseMode) {
      _feedbackController.text = "A quick brow fox jump over the lazy dog";
    }

    return Scaffold(
      backgroundColor: Colors.white,
     resizeToAvoidBottomInset: true,
     body: SingleChildScrollView(
       child: Column(
         children: [
           Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  width: 60,
                  height: 10,
                  decoration: BoxDecoration(
                      color: Color(0xffCDCFD0),
                      borderRadius: BorderRadius.circular(22)),
                ),
                8.height,
                const Text(
                  'Add Feedback',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 32,
                    color: Color(0xff151415),
                  ),
                ),
                // Row(
                //   children: [
                //     const SizedBox(
                //       width: 24,
                //     ),
                //     ClipOval(
                //       child: cacheNetworkImage(
                //         imageHeight: 72,
                //         imageWidth: 72,
                //         imageUrl:
                //             ApiUtills.imageBaseUrl + (widget.data.user.image ?? ""),
                //       ),
                //     ),
                //     const SizedBox(
                //       width: 12,
                //     ),
                //     Column(
                //       crossAxisAlignment: CrossAxisAlignment.start,
                //       children: [
                //         Text(
                //           getUserName(widget.data.user),
                //           style: const TextStyle(
                //               fontWeight: FontWeight.bold, fontSize: 18),
                //         ),
                //         RatingStar(
                //           size: 20,
                //           rating:
                //               double.parse((widget.data.user.rating ?? 0.0).toString()),
                //           color: AppColors.appGreen,
                //         )
                //       ],
                //     )
                //   ],
                // ),

                8.height,
                FarenowTextField(
                  border: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Color(0xffE0E0E0), width: 1),
                      borderRadius: BorderRadius.circular(22)),
                  hint: "Enter feedback here",
                  label: "Add Comment",
                  maxLine: 6,
                  controller: _feedbackController,
                  node: feedbackNode,
                  filledColor: Color(0xffF5F5F5),
                ),
                10.height,
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Add Rating",
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                      color: Color(0xff151415),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: RatingBar.builder(
                    initialRating: initialRating,
                    minRating: 1,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    wrapAlignment: WrapAlignment.start,
                    unratedColor: Color(0xff151515).withOpacity(0.5),
                    itemCount: 5,
                    itemSize: 40.0,
                    itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                    itemBuilder: (context, _) => const Icon(
                      Icons.star_border_sharp,
                      color: AppColors.solidBlue,
                    ),
                    onRatingUpdate: (value) {
                      print(value.toString());
                      initialRating = value;
                    },
                    updateOnDrag: true,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flexible(
                      child: FarenowButton(
                        style: FarenowButtonStyleModel(
                            padding:
                                EdgeInsets.symmetric(horizontal: 12, vertical: 4)),
                        title: 'Cancel',
                        onPressed: () {
                          Get.back();
                        },
                        type: BUTTONTYPE.action,
                      ),
                    ),
                    Flexible(
                      child: FarenowButton(
                        style: FarenowButtonStyleModel(
                            padding:
                                EdgeInsets.symmetric(horizontal: 12, vertical: 4)),
                        title: 'Submit',
                        onPressed: () {
                          if (_feedbackController.text.isEmpty) {
                            alertDialog(
                              title: "Alert",
                              content: "Please enter your feedback",
                              confirm: MaterialButton(
                                onPressed: () {
                                  Get.back();
                                },
                                child: const Text("Okay"),
                              ),
                            );
                            return;
                          }

                          String feedBack = _feedbackController.text.toString();
                          var userId = widget.data.user.id;
                          var serviceId = widget.data.id;

                          Map body = <String, dynamic>{
                            "service_request_id": serviceId,
                            "user_id": userId,
                            "comment": feedBack,
                            "rating": initialRating
                          };

                          rating.sendFeedback(
                              body: body,
                              onSendFeedback: () {
                                Get.back();
                                Get.back();
                                widget.onRateComplete();
                              });
                        },
                        type: BUTTONTYPE.rectangular,
                      ),
                    ),
                  ],
                ),
                // SizedBox(height: 30,),

              ],
            ),
    ),
           SizedBox(height: 30,),
           Padding(padding: EdgeInsets.only(bottom:MediaQuery.of(context).viewInsets.bottom ))
         ],
       ),
     )
    );
  }
}
