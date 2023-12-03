import 'package:fare_now_provider/screens/View_business_Insight.dart';
import 'package:fare_now_provider/screens/WeeklyTargetingPrice.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ServiceDetails extends StatelessWidget {
  const ServiceDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: ListView(
          children: [
            Card(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 15),
                alignment: Alignment.centerLeft,
                width: double.infinity,
                height: 56,
                child: Text(
                  "Services",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Container(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                alignment: Alignment.centerLeft,
                width: double.infinity,
                height: 75,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "John Wich",
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "Based in New York, NY",
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w300),
                    ),
                  ],
                )),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Card(
                child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                    width: double.infinity,
                    height: 300,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Activity this week",
                          style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w200),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                Text(
                                  "5",
                                  style: TextStyle(
                                      fontSize: 24, fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  "Service Done",
                                  style: TextStyle(
                                      fontSize: 16, fontWeight: FontWeight.w200),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                Text(
                                  "0",
                                  style: TextStyle(
                                      fontSize: 24, fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  "leads",
                                  style: TextStyle(
                                      fontSize: 16, fontWeight: FontWeight.w200),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                Text(
                                  "0",
                                  style: TextStyle(
                                      fontSize: 24, fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  "views",
                                  style: TextStyle(
                                      fontSize: 16, fontWeight: FontWeight.w200),
                                ),
                              ],
                            )
                          ],
                        ),
                        Divider(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "\$0",
                                      style: TextStyle(
                                          fontSize: 24,
                                          color: Colors.black26,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      " / no budget set",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w200),
                                    ),
                                  ],
                                ),
                                Text(
                                  "direct leads",
                                  style: TextStyle(
                                      fontSize: 16, fontWeight: FontWeight.w200),
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "\$0",
                                  style: TextStyle(
                                      fontSize: 24,
                                      color: Colors.black26,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  "opportunities",
                                  style: TextStyle(
                                      fontSize: 16, fontWeight: FontWeight.w200),
                                ),
                              ],
                            )
                          ],
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.to(WeeklyTargetingPrice());
                          },
                          child: Container(
                            width: double.infinity,
                            height: 47,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.circular(10)),
                            child: Text(
                              "View weekly targeting prices",
                              style: TextStyle(color: Colors.white, fontSize: 16),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.to(() => ViewBusinessInsight());
                          },
                          child: Container(
                            width: double.infinity,
                            height: 47,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.circular(10)),
                            child: Text(
                              "View my business insights",
                              style: TextStyle(color: Colors.white, fontSize: 16),
                            ),
                          ),
                        ),
                      ],
                    )),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              alignment: Alignment.centerLeft,
              width: double.infinity,
              height: 56,
              child: Text(
                "Recommendations",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              width: 360,
              height: 210,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Card(
                        child: Container(
                          padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                          height: 200,
                          width: 360,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    "\$0",
                                    style: TextStyle(
                                        fontSize: 24,
                                        color: Colors.black26,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Container(
                                    width: 250,
                                    child: Text(
                                      " / of your Cleaner services have targeting on.",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w200),
                                    ),
                                  ),
                                ],
                              ),
                              Divider(
                                thickness: 5,
                              ),
                              Text(
                                "Match with up to 5877 more local customers",
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w200),
                              ),
                              Container(
                                width: 360,
                                height: 45,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    color: Colors.blue,
                                    borderRadius: BorderRadius.circular(10)),
                                child: Text(
                                  "View my business insights",
                                  style:
                                  TextStyle(color: Colors.white, fontSize: 16),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              alignment: Alignment.centerLeft,
              width: double.infinity,
              height: 56,
              child: Text(
                "Cleaner services",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              width: 360,
              height: 160,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Card(
                        child: Container(
                          padding:
                          EdgeInsets.symmetric(horizontal: 35, vertical: 20),
                          height: 150,
                          width: 360,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                alignment: Alignment.center,
                                width: 150,
                                child: Text(
                                  "Gutter cleaning and maintenance",
                                  style: TextStyle(
                                      fontSize: 16, fontWeight: FontWeight.w400),
                                ),
                              ),
                              Container(
                                width: double.infinity,
                                height: 45,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    border:
                                    Border.all(width: 1, color: Colors.black),
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10)),
                                child: Text(
                                  "Add targeting preferences",
                                  style: TextStyle(
                                      color: Colors.blue,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
            )
          ],
        ));
  }
}