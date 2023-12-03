import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
/*import 'package:flutter_simple_rating_bar/flutter_simple_rating_bar.dart';*/

class YouCampre extends StatelessWidget {
  const YouCampre({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 10,
          ),
          Container(
            child: Text(
              "Rating",
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 24),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            child: Text(
              "0 new reviews this week.",
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          getRating("You", "0.0"),
          SizedBox(
            height: 10,
          ),
          getRating("Avg . pro", "4.9"),
          SizedBox(
            height: 10,
          ),
          Divider(),
          SizedBox(
            height: 20,
          ),
          Container(
            child: Text(
              "Response rate",
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 24),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            child: Text(
              "How often you respond to direct leads wintin 4 business hours, 8am-8pm local time. (Last 30 days)",
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w200,
                  fontSize: 18),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            child: Row(
              children: [
                Container(
                  child: Icon(
                    Icons.arrow_upward,
                    size: 20,
                    color: Colors.green,
                  ),
                ),
                Container(
                  child: Text(
                    " 0 ",
                    style: TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                        fontSize: 24),
                  ),
                ),
                Container(
                  child: Text(
                    "vs, a week ago",
                    style: TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.w200,
                        fontSize: 18),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 15,
          ),
          getRow("You", 0, Colors.green),
          SizedBox(
            height: 10,
          ),
          getRow("Avg.pro", 24, Colors.grey.shade300),
          SizedBox(
            height: 10,
          ),
          getRow("Top.pro", 100, Colors.grey.shade300),
          SizedBox(
            height: 10,
          ),
          Container(
            child: Text(
              "Response time",
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 24),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            child: Text(
              "How often you respond to direct leads wintin 4 business hours, 8am-8pm local time. (Last 30 days)",
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w200,
                  fontSize: 18),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          getResponse("You", 0, 0, Colors.green),
          SizedBox(
            height: 10,
          ),
          getResponse("Avg.pro", 2, 8, Colors.grey.shade300),
          SizedBox(
            height: 10,
          ),
          getResponse("Top.pro", 0, 2, Colors.grey.shade300),
          SizedBox(
            height: 20,
          ),
          Container(
            child: Text("Buy Service",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 24,
                    fontWeight: FontWeight.bold)),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
              width: double.infinity,
              height: 56,
              child: Container(
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
                          DropdownMenuItem<String>(
                              value: "Child 1", child: Text("Child 1")),
                          DropdownMenuItem<String>(
                              value: "Child 2", child: Text("Child 2")),
                          DropdownMenuItem<String>(
                              value: "Child 3", child: Text("Child 3")),
                        ],
                      ),
                    ),
                  ),
                ),
              )),
          SizedBox(
            height: 10,
          ),
          getCard(),
          SizedBox(
            height: 12,
          ),
          getCard(),
          Container(
            width: double.infinity,
            height: 530,
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Card(
                      elevation: 5,
                      child: Container(
                        padding: EdgeInsets.all(15),
                        width: 330,
                        height: 200,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              child: Text(
                                "Window Cleaning in your area",
                                style: TextStyle(
                                    fontSize: 24, fontWeight: FontWeight.bold),
                              ),
                            ),
                            Container(
                              child: Text(
                                "Last 3 months",
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w300),
                              ),
                            ),
                            SizedBox(
                              height: 25,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Column(
                                  children: [
                                    Container(
                                      child: Text(
                                        "31",
                                        style: TextStyle(
                                            fontSize: 24,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Container(
                                      child: Text(
                                        "Jobs",
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w300),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(),
                                Column(
                                  children: [
                                    Container(
                                      child: Text(
                                        "38",
                                        style: TextStyle(
                                            fontSize: 24,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Container(
                                      child: Text(
                                        "Active pros",
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w300),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            )
                          ],
                        ),
                      )),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

//Functions
  getCard() {
    return Card(
      elevation: 4,
      child: Container(
        padding: EdgeInsets.all(10),
        width: double.infinity,
        height: 260,
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Container(
                      width: 54,
                      height: 54,
                      decoration: BoxDecoration(
                          color: Colors.grey.shade300, shape: BoxShape.circle)),
                ),
                Expanded(
                  flex: 3,
                  child: Container(
                    child: Text(
                      "Garden State Window Cleaning",
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                  ),
                )
              ],
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: SizedBox(
                      width: 10,
                    ),
                  ),
                  Expanded(
                    flex: 0,
                    child: Container(
                      child: Text(
                        "0.0",
                        style: TextStyle(
                            fontSize: 24,
                            color: Colors.green,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: RatingBar.builder(
                      maxRating: 5,
                      itemBuilder: (context, _) => const Icon(
                        Icons.star,
                        size: 30,
                        color: Colors.grey,
                      ),
                      itemCount: 5,
                      itemSize: 40,
                      allowHalfRating: true,
/*   onRatingCallback:
       (double value, ValueNotifier<bool> isIndicator) {
     print('Number of stars-->  $value');
     //change the isIndicator from false  to true ,the       RatingBar cannot support touch event;
     isIndicator.value = true;
   },*/
                      glowColor: Colors.green,
                      onRatingUpdate: (rating) {
                        print(rating);
                      },
                    ),
                  ),
                  Expanded(
                    flex: 0,
                    child: Container(
                      child: Text(
                        "(0)",
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                            fontWeight: FontWeight.normal),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 0,
                    child: SizedBox(
                      width: 0,
                    ),
                  ),
                ],
              ),
            ),
            getCardDetails("Hired 49 times"),
            SizedBox(
              height: 10,
            ),
            getCardDetails("21 years in business"),
            SizedBox(
              height: 10,
            ),
            getCardDetails("Parlin , NJ")
          ],
        ),
      ),
    );
  }

  getCardDetails(String value) {
    return Row(
      children: [
        Expanded(
          child: Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                  color: Colors.grey.shade300, shape: BoxShape.circle)),
        ),
        Expanded(
          flex: 3,
          child: Container(
            child: Text(
              "$value",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
        )
      ],
    );
  }

  getResponse(String name, double value, value2, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                    shape: BoxShape.circle, color: Colors.grey.shade200),
              ),
              SizedBox(
                width: 20,
              ),
              Container(
                width: 80,
                child: Text(
                  name,
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.normal,
                      fontSize: 16),
                ),
              ),
            ],
          ),
          Container(
            width: 80,
            child: Text(
              "${value}h ${value2}m",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 110,
                height: 32,
                child: Row(
                  children: [
                    Container(
                      width: value + 50,
                      color: color,
                    )
                  ],
                ),
              )
            ],
          ),
          SizedBox(),
        ],
      ),
    );
  }

  getRating(String name, rating) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                    shape: BoxShape.circle, color: Colors.grey.shade200),
              ),
              SizedBox(
                width: 20,
              ),
              Container(
                child: Text(
                  name,
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.normal,
                      fontSize: 16),
                ),
              ),
            ],
          ),
          SizedBox(),
          Row(
            children: [
              Container(
                child: Text(
                  rating,
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 24),
                ),
              ),
              SizedBox(
                width: 20,
              ),
              Container(
                child: Icon(
                  Icons.star,
                  size: 20,
                  color: Colors.grey.shade300,
                ),
              ),
              Container(
                child: Icon(
                  Icons.star,
                  size: 20,
                  color: Colors.grey.shade300,
                ),
              ),
              Container(
                child: Icon(
                  Icons.star,
                  size: 20,
                  color: Colors.grey.shade300,
                ),
              ),
              Container(
                child: Icon(
                  Icons.star,
                  size: 20,
                  color: Colors.grey.shade300,
                ),
              ),
              Container(
                child: Icon(
                  Icons.star,
                  size: 20,
                  color: Colors.grey.shade300,
                ),
              ),
              SizedBox(
                width: 5,
              ),
              Text(
                "(0)",
                style: TextStyle(color: Colors.grey.shade300, fontSize: 18),
              )
            ],
          ),
        ],
      ),
    );
  }

  getRow(String name, double value, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                    shape: BoxShape.circle, color: Colors.grey.shade200),
              ),
              SizedBox(
                width: 20,
              ),
              Container(
                width: 80,
                child: Text(
                  name,
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.normal,
                      fontSize: 16),
                ),
              ),
            ],
          ),
          Container(
            width: 80,
            child: Text(
              "$value%",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 24,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 110,
                height: 32,
                child: Row(
                  children: [
                    Container(
                      width: value + 5,
                      color: color,
                    )
                  ],
                ),
              )
            ],
          ),
          SizedBox(),
        ],
      ),
    );
  }
}
