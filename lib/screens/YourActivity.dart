import 'package:flutter/material.dart';

class YourActivity extends StatelessWidget {
  const YourActivity({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          height: 180,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 5,
              itemBuilder: (context, index) {
                return Padding(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  child: Card(
                    child: Container(
                      width: MediaQuery.of(context).size.width * 292 / 360,
                      padding:
                      EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            "Leads",
                            style: TextStyle(
                                color: Colors.black26,
                                fontWeight: FontWeight.bold,
                                fontSize: 24),
                          ),
                          Text(
                            "0",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 40),
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.arrow_upward,
                                color: Colors.green,
                                size: 24,
                              ),
                              Text(
                                " 0 ",
                                style: TextStyle(
                                    color: Colors.green,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 24),
                              ),
                              Text(
                                "vs , a week ago",
                                style: TextStyle(
                                    color: Colors.black26,
                                    fontWeight: FontWeight.normal,
                                    fontSize: 20),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                );
              }),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          child: Column(
            children: [
              Container(
                width: double.infinity,
                height: 30,
                child: Text(
                  "4 Week Overview",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 24,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                width: double.infinity,
                height: 30,
                child: Text(
                  "Febraury 22 - March 22",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w200),
                ),
              ),
              Container(
                width: double.infinity,
                height: 80,
                child: Text(
                  "Showing pre -tax prices for 3/15-3/21. Prices for next week are posted everyfriday",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w200),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 5),
                child: Container(
                  width: MediaQuery.of(context).size.width * 266 / 360,
                  height: MediaQuery.of(context).size.height * 266 / 760,
                  color: Colors.grey.shade300,
                ),
              ),
              Container(
                alignment: Alignment.center,
                width: double.infinity,
                height: 30,
                child: Text(
                  "No Activity",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                  width: double.infinity,
                  height: 30,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Build solid profile ",
                        style: TextStyle(
                            color: Colors.blue,
                            fontSize: 16,
                            fontWeight: FontWeight.normal),
                      ),
                      Text(
                        "to get some lead",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w200),
                      ),
                    ],
                  )),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Buy Services",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 24,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(),
                  SizedBox(),
                  Text(
                    "View",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w200),
                  ),
                  Text(
                    "Leads",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w200),
                  ),
                ],
              ),
              Divider(thickness: 1),
              Text(
                "Window Cleaning",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.w300),
              ),
              Divider(
                thickness: 1,
              ),
              Text(
                "Gutter Cleaning and Maintenance",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.w300),
              ),
              Divider(
                thickness: 1,
              ),
              Text(
                "Upholstery and Furniture Cleaning",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.w300),
              ),
              Divider(
                thickness: 1,
              ),
              Text(
                "House Cleaning",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.w300),
              ),
              Divider(
                thickness: 1,
              ),
              Row(
                children: [
                  Text(
                    "You got",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w300),
                  ),
                  Text(
                    " 0 ",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 24,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "additional views.",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w300),
                  ),
                ],
              ),
            ],
          ),
        ),
        Container(
          height: 30,
        )
      ],
    );
  }
}