import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomToolbar extends StatelessWidget {
  final title;
  final leading;
  final trailing;
  final height;

  CustomToolbar(
      {Key? key, this.title, this.leading, this.trailing, this.height})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      padding: EdgeInsets.only(top: 24),
      height: height ?? 90,
      color: Colors.white,
      child: Row(
        children: [
          SizedBox(
            width: 4,
          ),
          leading ?? getEmptyButton(),
          Expanded(
            child: Container(
              alignment: Alignment.center,
              width: 100,
              height: 64,
              child: Text(
                title ?? "",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          trailing ?? getEmptyButton(),
        ],
      ),
    );
  }

  getEmptyButton() {
    return Container(
      height: 64,
      child: IconButton(
        onPressed: () {},
        icon: Icon(
          Icons.arrow_back,
          color: Colors.transparent,
          size: 25,
        ),
      ),
    );
  }
}
