import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../components/buttons-management/enum/button_type.dart';
import '../components/buttons-management/farenow_button.dart';

class ServiceDetailsScreen extends StatelessWidget {
  const ServiceDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        color: Colors.grey[100],
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 150.w,
              child: FarenowButton(
                title: 'Cancel',
                onPressed: () {},
                type: BUTTONTYPE.text,
              ),
            ),
            SizedBox(
              width: 150.w,
              child: FarenowButton(
                title: 'Confirm',
                onPressed: () {},
                type: BUTTONTYPE.rectangular,
              ),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: const Text('Service Detail'),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 350.h,
              child: Stack(alignment: AlignmentDirectional.center, children: [
                Positioned.fill(
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Image.asset(
                      'assets/Rectangle 26.png',
                      fit: BoxFit.cover,
                      width: 375.w,
                      height: 110.h,
                    ),
                  ),
                ),
                Positioned(
                  top: 70.h,
                  child: CircleAvatar(
                    backgroundColor: const Color(0xffE0E0E0),
                    radius: 50.r,
                    child: SvgPicture.asset(
                      'assets/providerImages/svg/profile_tab.svg',
                      height: 60,
                    ),
                  ),
                ),
                Positioned(
                  top: 135.h,
                  right: 140.w,
                  child: Image.asset('assets/Ellipse 76.png'),
                ),
                Positioned(
                  top: 180.h,
                  child: Text(
                    'Godwin Benson',
                    style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 1),
                  ),
                ),
                Positioned(
                  top: 205.h,
                  child: Text(
                    '8 Jobs Completed',
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400,
                      letterSpacing: 1,
                      color: const Color(0xff555555),
                    ),
                  ),
                ),
                Positioned(
                    top: 225.h,
                    child: Row(
                      children: [
                        RatingBar.builder(
                          initialRating: 1,
                          minRating: 0,
                          direction: Axis.horizontal,
                          allowHalfRating: true,
                          itemCount: 1,
                          itemSize: 20,
                          itemPadding:
                              const EdgeInsets.symmetric(horizontal: 4.0),
                          itemBuilder: (context, _) => const Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                          onRatingUpdate: (rating) {},
                        ),
                        Text(
                          '4.5',
                          style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          '()',
                          style: TextStyle(
                            color: const Color(0xff555555),
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        const Icon(
                          Icons.location_on,
                          color: Color(0xff555555),
                          size: 15,
                        ),
                        Text(
                          'NewYork',
                          style: TextStyle(
                            color: const Color(0xff555555),
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    )),
                Positioned(
                  top: 245.h,
                  child: SizedBox(
                      height: 70.h,
                      width: 350.w,
                      child: FarenowButton(
                        title: 'Message',
                        onPressed: () {},
                        type: BUTTONTYPE.rectangular,
                      )),
                ),
              ]),
            ),
            ListView.separated(
              physics: const ScrollPhysics(),
              shrinkWrap: true,
              itemCount: 8,
              separatorBuilder: (_, __) => const Divider(),
              itemBuilder: (context, int index) {
                return ListTile(
                  visualDensity:
                      const VisualDensity(horizontal: 0, vertical: -4),
                  title: Text(
                    "Job Timer",
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                      color: const Color(0xff555555),
                    ),
                  ),
                  subtitle: Text(
                    "00:00:00",
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xff151415),
                    ),
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
