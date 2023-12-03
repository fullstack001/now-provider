import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WeeklyTargetingPrice extends StatelessWidget {
  const WeeklyTargetingPrice({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(
              Icons.arrow_back,
              size: 24,
              color: Colors.blue,
            )),
        title: Text(
          "Weekly Targeting Price",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: ListView(
        children: [
          SizedBox(
            height: 10,
          ),
          Container(
            width: double.infinity,
            height: 130,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  height: 40,
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Targeting Prices",
                    style: TextStyle(
                        fontSize: 24,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  height: 47,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        flex: 2,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Container(
                            color: Colors.grey.shade100,
                            padding: EdgeInsets.symmetric(horizontal: 5),
                            child: Container(
                              child: DropdownButton<String>(
                                underline: Container(),
                                elevation: 3,
                                isExpanded: true,
                                onChanged: (val) {},
                                value: "Child 1",
                                style: new TextStyle(
                                  fontSize: 16.0,
                                  color: const Color(0xFF202020),
                                ),
                                items: <DropdownMenuItem<String>>[
                                  const DropdownMenuItem<String>(
                                      value: "Child 1",
                                      child: const Text("Child 1")),
                                  const DropdownMenuItem<String>(
                                      value: "Child 2",
                                      child: const Text("Child 2")),
                                  const DropdownMenuItem<String>(
                                      value: "Child 3",
                                      child: const Text("Child 3")),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Container(
                            color: Colors.grey.shade100,
                            padding: EdgeInsets.symmetric(horizontal: 5),
                            child: Container(
                              child: DropdownButton<String>(
                                underline: Container(),
                                elevation: 3,
                                isExpanded: true,
                                onChanged: (val) {},
                                value: "Child 1",
                                style: new TextStyle(
                                  fontSize: 16.0,
                                  color: const Color(0xFF202020),
                                ),
                                items: <DropdownMenuItem<String>>[
                                  const DropdownMenuItem<String>(
                                      value: "Child 1",
                                      child: const Text("Child 1")),
                                  const DropdownMenuItem<String>(
                                      value: "Child 2",
                                      child: const Text("Child 2")),
                                  const DropdownMenuItem<String>(
                                      value: "Child 3",
                                      child: const Text("Child 3")),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 100,
                        height: 40,
                        child: Column(
                          children: [
                            Text(
                              "This week",
                              style:
                              TextStyle(fontSize: 18, color: Colors.blue),
                            ),
                            Divider(
                              color: Colors.blue,
                              thickness: 2,
                              endIndent: 10,
                              indent: 10,
                            )
                          ],
                        ),
                      ),
                      Text(
                        "Next week",
                        style: TextStyle(fontSize: 18, color: Colors.black26),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              elevation: 4,
              child: Container(
                  width: double.infinity,
                  height: 460,
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        alignment: Alignment.centerLeft,
                        width: double.infinity,
                        height: 50,
                        child: Text(
                          "Direct leads",
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        color: Colors.grey.shade300,
                        height: 100,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                child: Text(
                                  "Square footage of building",
                                  style: TextStyle(
                                      fontSize: 22,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                            Expanded(
                              child: VerticalDivider(
                                color: Colors.black26,
                                thickness: 1,
                              ),
                            ),
                            Expanded(
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                child: Text(
                                  "Price",
                                  style: TextStyle(
                                      fontSize: 22,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Divider(
                        thickness: 3,
                        height: 2,
                      ),
                      Container(
                        width: double.infinity,
                        color: Colors.white,
                        height: 100,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 15),
                                child: Text(
                                  "Less than 1,000 - 2,000 sq ft",
                                  style: TextStyle(
                                      fontSize: 22,
                                      color: Colors.black,
                                      fontWeight: FontWeight.normal),
                                ),
                              ),
                            ),
                            VerticalDivider(
                              color: Colors.black26,
                              thickness: 1,
                            ),
                            Expanded(
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                child: Text(
                                  "\$13.28 to \$15.61",
                                  style: TextStyle(
                                      fontSize: 22,
                                      color: Colors.black,
                                      fontWeight: FontWeight.normal),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Divider(
                        thickness: 3,
                        height: 2,
                      ),
                      Container(
                        width: double.infinity,
                        color: Colors.white,
                        height: 100,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 15),
                                child: Text(
                                  "Less than 1,000 - 2,000 sq ft",
                                  style: TextStyle(
                                      fontSize: 22,
                                      color: Colors.black,
                                      fontWeight: FontWeight.normal),
                                ),
                              ),
                            ),
                            VerticalDivider(
                              color: Colors.black26,
                              thickness: 1,
                            ),
                            Expanded(
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                child: Text(
                                  "\$13.28 to \$15.61",
                                  style: TextStyle(
                                      fontSize: 22,
                                      color: Colors.black,
                                      fontWeight: FontWeight.normal),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Divider(
                        thickness: 3,
                        height: 2,
                      ),
                      Container(
                        width: double.infinity,
                        color: Colors.white,
                        height: 100,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 15),
                                child: Text(
                                  "Less than 1,000 - 2,000 sq ft",
                                  style: TextStyle(
                                      fontSize: 22,
                                      color: Colors.black,
                                      fontWeight: FontWeight.normal),
                                ),
                              ),
                            ),
                            VerticalDivider(
                              color: Colors.black26,
                              thickness: 1,
                            ),
                            Expanded(
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                child: Text(
                                  "\$13.28 to \$15.61",
                                  style: TextStyle(
                                      fontSize: 22,
                                      color: Colors.black,
                                      fontWeight: FontWeight.normal),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              elevation: 4,
              child: Container(
                  width: double.infinity,
                  height: 460,
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        alignment: Alignment.centerLeft,
                        width: double.infinity,
                        height: 50,
                        child: Text(
                          "Instantly booke jobs",
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        color: Colors.grey.shade300,
                        height: 100,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                child: Text(
                                  "Square footage of building",
                                  style: TextStyle(
                                      fontSize: 22,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                            Expanded(
                              child: VerticalDivider(
                                color: Colors.black26,
                                thickness: 1,
                              ),
                            ),
                            Expanded(
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                child: Text(
                                  "Price",
                                  style: TextStyle(
                                      fontSize: 22,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Divider(
                        thickness: 3,
                        height: 2,
                      ),
                      Container(
                        width: double.infinity,
                        color: Colors.white,
                        height: 100,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 15),
                                child: Text(
                                  "Less than 1,000 - 2,000 sq ft",
                                  style: TextStyle(
                                      fontSize: 22,
                                      color: Colors.black,
                                      fontWeight: FontWeight.normal),
                                ),
                              ),
                            ),
                            VerticalDivider(
                              color: Colors.black26,
                              thickness: 1,
                            ),
                            Expanded(
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                child: Text(
                                  "\$13.28 to \$15.61",
                                  style: TextStyle(
                                      fontSize: 22,
                                      color: Colors.black,
                                      fontWeight: FontWeight.normal),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Divider(
                        thickness: 3,
                        height: 2,
                      ),
                      Container(
                        width: double.infinity,
                        color: Colors.white,
                        height: 100,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 15),
                                child: Text(
                                  "Less than 1,000 - 2,000 sq ft",
                                  style: TextStyle(
                                      fontSize: 22,
                                      color: Colors.black,
                                      fontWeight: FontWeight.normal),
                                ),
                              ),
                            ),
                            VerticalDivider(
                              color: Colors.black26,
                              thickness: 1,
                            ),
                            Expanded(
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                child: Text(
                                  "\$13.28 to \$15.61",
                                  style: TextStyle(
                                      fontSize: 22,
                                      color: Colors.black,
                                      fontWeight: FontWeight.normal),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Divider(
                        thickness: 3,
                        height: 2,
                      ),
                      Container(
                        width: double.infinity,
                        color: Colors.white,
                        height: 100,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 15),
                                child: Text(
                                  "Less than 1,000 - 2,000 sq ft",
                                  style: TextStyle(
                                      fontSize: 22,
                                      color: Colors.black,
                                      fontWeight: FontWeight.normal),
                                ),
                              ),
                            ),
                            VerticalDivider(
                              color: Colors.black26,
                              thickness: 1,
                            ),
                            Expanded(
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                child: Text(
                                  "\$13.28 to \$15.61",
                                  style: TextStyle(
                                      fontSize: 22,
                                      color: Colors.black,
                                      fontWeight: FontWeight.normal),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )),
            ),
          ),
          Container(
            padding: EdgeInsets.all(18),
            child: Text(
              "Showing pre -tax prices for 3/15-3/21.Prices for next week are posted every friday.",
              style: TextStyle(fontSize: 18, color: Colors.grey.shade400),
            ),
          ),
          Container(
            padding: EdgeInsets.all(18),
            child: Text(
              "Frequest asked Questions",
              style: TextStyle(
                  fontSize: 24,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Divider(
            thickness: 1,
          ),
          ExpansionTile(
            tilePadding: EdgeInsets.all(15),
            childrenPadding: EdgeInsets.all(15),
            subtitle: Text(
              "Lorem ipsum dolor sit amet, consectetur adipiscing.",
              style: TextStyle(fontWeight: FontWeight.w300, fontSize: 16),
            ),
            title: Text(
              "Background check",
              style: TextStyle(
                  fontSize: 24,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
            ),
            children: <Widget>[
              Text(
                "Lorem ipsum dolor sit amet, consectetur adipiscing.",
                style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                    fontWeight: FontWeight.w300),
              ),
            ],
          ),
          Divider(
            thickness: 1,
          ),
          ExpansionTile(
            tilePadding: EdgeInsets.all(15),
            childrenPadding: EdgeInsets.all(15),
            subtitle: Text(
              "Lorem ipsum dolor sit amet, consectetur adipiscing.",
              style: TextStyle(fontWeight: FontWeight.w300, fontSize: 16),
            ),
            title: Text(
              "Background check",
              style: TextStyle(
                  fontSize: 24,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
            ),
            children: <Widget>[
              Text(
                "Lorem ipsum dolor sit amet, consectetur adipiscing.",
                style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                    fontWeight: FontWeight.w300),
              ),
            ],
          ),
          Divider(
            thickness: 1,
          ),
          ExpansionTile(
            tilePadding: EdgeInsets.all(15),
            childrenPadding: EdgeInsets.all(15),
            subtitle: Text(
              "Lorem ipsum dolor sit amet, consectetur adipiscing.",
              style: TextStyle(fontWeight: FontWeight.w300, fontSize: 16),
            ),
            title: Text(
              "Background check",
              style: TextStyle(
                  fontSize: 24,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
            ),
            children: <Widget>[
              Text(
                "Lorem ipsum dolor sit amet, consectetur adipiscing.",
                style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                    fontWeight: FontWeight.w300),
              ),
            ],
          ),
          Divider(
            thickness: 1,
          ),
          ExpansionTile(
            tilePadding: EdgeInsets.all(15),
            childrenPadding: EdgeInsets.all(15),
            subtitle: Text(
              "Lorem ipsum dolor sit amet, consectetur adipiscing.",
              style: TextStyle(fontWeight: FontWeight.w300, fontSize: 16),
            ),
            title: Text(
              "Background check",
              style: TextStyle(
                  fontSize: 24,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
            ),
            children: <Widget>[
              Text(
                "Lorem ipsum dolor sit amet, consectetur adipiscing.",
                style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                    fontWeight: FontWeight.w300),
              ),
            ],
          ),
          Divider(
            thickness: 1,
          ),
        ],
      ),
    );
  }
}