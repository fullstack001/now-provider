import 'package:fare_now_provider/screens/TopProStatus.dart';
import 'package:fare_now_provider/screens/ViewBusinessController.dart';
import 'package:fare_now_provider/screens/YouCampare.dart';
import 'package:fare_now_provider/screens/YourActivity.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ViewBusinessInsight extends StatelessWidget {
  ViewBusinessController controller = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 4,
          leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
          ),
          title: Text(
            "Insight- Fare Now",
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: Obx(() {
          return ListView(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                alignment: Alignment.centerLeft,
                width: double.infinity,
                height: 60,
                child: Text(
                  "Insights",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 24,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                height: 40,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 4),
                      child: Container(
                        height: 30,
                        child: GestureDetector(
                          onTap: () {
                            controller.setCurrentTab(0);
                          },
                          child: Container(
                            child: Column(
                              children: [
                                Text(
                                  "Your Activity",
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: controller.currentTab == 0
                                          ? Colors.blue
                                          : Colors.black),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                controller.currentTab == 0
                                    ? Container(
                                  width: 110,
                                  height: 2,
                                  color: Colors.blue,
                                )
                                    : Container(),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 4),
                      child: Container(
                        height: 30,
                        child: GestureDetector(
                          onTap: () {
                            controller.setCurrentTab(1);
                          },
                          child: Container(
                            child: Column(
                              children: [
                                Text(
                                  "Your Top Pro Status",
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: controller.currentTab == 1
                                          ? Colors.blue
                                          : Colors.black),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                controller.currentTab == 1
                                    ? Container(
                                  width: 165,
                                  height: 2,
                                  color: Colors.blue,
                                )
                                    : Container(),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 4),
                      child: Container(
                        height: 30,
                        child: GestureDetector(
                          onTap: () {
                            controller.setCurrentTab(2);
                          },
                          child: Container(
                            child: Column(
                              children: [
                                Text(
                                  "How You Compare",
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: controller.currentTab == 2
                                          ? Colors.blue
                                          : Colors.black),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                controller.currentTab == 2
                                    ? Container(
                                  width: 155,
                                  height: 2,
                                  color: Colors.blue,
                                )
                                    : Container(),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              controller.currentTab == 0
                  ? YourActivity()
                  : controller.currentTab == 1
                  ? TopProStatus()
                  : controller.currentTab == 2
                  ? YouCampre()
                  : Container()
            ],
          );
        }));
  }
}