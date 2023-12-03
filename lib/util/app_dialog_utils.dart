import 'package:fare_now_provider/util/widgest_utills.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

class AppDialogUtils {
  static dialogLoading({msg}) {
    EasyLoading.show(status: msg ?? "Please wait..", dismissOnTap: true,);
  }

  static errorDialog(String msg) {
    EasyLoading.showError(msg,
        duration: Duration(seconds: 2), dismissOnTap: true);
  }

  static successDialog(String msg) {
    EasyLoading.showSuccess(msg, duration: Duration(seconds: 4));
  }

  static dismiss() {
    EasyLoading.dismiss();
  }
}

Widget gridViews({builder, columnSpan, itemCount}) {
  columnSpan = columnSpan ?? 0;
  itemCount = itemCount ?? 0;
  int count = 0;
  return Container(
    width: Get.width,
    height: Get.height,
    child: ListView(
      children: [
        for (int index = 0; index < itemCount / columnSpan; index++)
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (int indexI = 0; indexI < columnSpan; indexI++, count++)
                if (count < itemCount)
                  Expanded(
                    flex: 0,
                    child: builder(count, columnSpan),
                  )
            ],
          )
      ],
    ),
  );
}

alertDialog({title, content, confirm, cancel}) {
  Get.defaultDialog(
    title: title,
    content: Text(
      content,
      textAlign: TextAlign.center,
    ),
    confirm: confirm == null ? emptyContainer : confirm,
    cancel: confirm == null ? emptyContainer : cancel,
  );
}
