import 'package:fare_now_provider/screens/brand_or_service_provider_screen.dart';
import 'package:fare_now_provider/util/circular_text.dart';
import 'package:flutter/material.dart';

class BuildProfileStepsScreen extends StatefulWidget {
  static const id = 'build_profile_steps_screen';
  @override
  _BuildProfileStepsScreenState createState() =>
      _BuildProfileStepsScreenState();
}

class _BuildProfileStepsScreenState extends State<BuildProfileStepsScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Scaffold(
          body: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 89,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 26.0),
                    child: IconButton(
                      icon: Icon(
                        Icons.clear,
                        size: 40,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 60.5,
              ),
              Padding(
                padding: EdgeInsets.only(left: 46, right: 60),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0, right: 25),
                      child: CircularText(
                          size: 25,
                          color: Color(0xff1B80F5),
                          text: '1',
                          textStyle:
                              TextStyle(fontSize: 16, color: Colors.white)),
                    ),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Build a winning profile",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                                fontSize: 20),
                          ),
                          Text(
                            "Your profile is free, but it takes time to make it great. It’s worth it this is how you’ll get hired.",
                            style: TextStyle(
                                color: Color(0xff868B9A),
                                fontWeight: FontWeight.w400,
                                fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 40,
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(left: 46, right: 60),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 0.0, right: 25),
                        child: CircularText(
                            size: 25,
                            color: Color(0xff868B9A),
                            text: '2',
                            textStyle:
                                TextStyle(fontSize: 16, color: Colors.white)),
                      ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Add your preferences",
                              style: TextStyle(
                                  color: Color(0xff868B9A),
                                  fontWeight: FontWeight.w500,
                                  fontSize: 20),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                margin:
                    const EdgeInsets.symmetric(vertical: 16, horizontal: 22),
                child: ButtonTheme(
                  height: 50,
                  child: TextButton(
                    onPressed: () {
                      Navigator.pushNamed(
                          context, BrandOrServiceProviderScreen.id);
                    },
                    child: Center(
                        child: Text(
                      "Next",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    )),
                  ),
                ),
                decoration: BoxDecoration(
                  color: Color(0xff1B80F5),
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
