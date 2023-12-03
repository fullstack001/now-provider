import 'package:flutter/material.dart';
import 'package:get/get.dart';

AppBar appBarOfServiceTiming(BuildContext context, String title,
    String secondTitle, VoidCallback onTap) {
  return AppBar(
    elevation: 2,
    backgroundColor: Colors.white,
    title: Text(
      title,
      style: TextStyle(
          color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
    ),
    leading: IconButton(
      onPressed: () {
        Get.back();
      },
      icon: Icon(
        Icons.arrow_back,
        color: Colors.black,
        size: 25,
      ),
    ),
    actions: [
      GestureDetector(
        onTap: onTap,
        child: Container(
          alignment: Alignment.center,
          margin: EdgeInsets.only(right: 20),
          child: Text(
            secondTitle,
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
                color: Color(0xff0068E1), fontWeight: FontWeight.bold),
          ),
        ),
      )
    ],
  );
}
