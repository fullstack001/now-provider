import 'package:flutter/material.dart';

class TopProStatus extends StatelessWidget {
  const TopProStatus({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 10,
          ),
          Container(
            child: Text(
              "You’re not a Top Pro . Yet.",
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
              "Only 4% of Fare Now professionals currently qualify for Top Pro. But Top Pros are nearly twice as likely to get hired on average. Get your Top Pro badge by meeting the critedia below by July.",
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w200,
                  fontSize: 18),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Divider(
            thickness: 1,
            color: Colors.black12,
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            child: Text(
              "Your Top Pro progress",
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 24),
            ),
          ),
          getContainer(),
          getContainer(),
          getContainer(),
        ],
      ),
    );
  }

  getContainer() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Container(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              flex: 1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Checkbox(value: false, onChanged: (val) {}),
                      Text(
                        "Review rating",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                      ),
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 3, left: 40),
                    child: Text(
                      "Maintain a rating of at leasts 4.8 based onverfied reviews.",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w200,
                          fontSize: 16),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 3, left: 40),
                    child: Text(
                      "Learn how",
                      style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
                flex: 1,
                child: Container(
                  padding: EdgeInsets.all(40),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border:
                      Border.all(width: 12, color: Colors.blue.shade200)),
                  child: Container(
                    child: Column(
                      children: [
                        Container(
                          child: Text(
                            "0.0 / 4.8",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 18),
                          ),
                        ),
                        Container(
                          child: Text(
                            "stars",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 18),
                          ),
                        ),
                      ],
                    ),
                  ),
                ))
          ],
        ),
      ),
    );
  }
}