import 'package:cached_network_image/cached_network_image.dart';
import 'package:fare_now_provider/util/app_colors.dart';
import 'package:fare_now_provider/widgets/custom_container.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';

emptyContainer() {
  return Container(
    width: 0,
    height: 0,
  );
}

customContainer(
    {width,
    height,
    color,
    allRadius,
    topLeftRadius,
    bottomLeftRadius,
    topRightRadius,
    bottomRightRadius,
    marginAll,
    marginTop,
    marginBottom,
    marginLeft,
    marginRight,
    paddingAll,
    paddingTop,
    paddingBottom,
    paddingLeft,
    paddingRight,
    alignment,
    child}) {
  return Container(
    width: double.parse((width ?? 80).toString()),
    height: double.parse((height ?? 50).toString()),
    alignment: alignment ?? Alignment.center,
    padding: paddingAll != null
        ? EdgeInsets.all(double.parse((paddingAll ?? 0).toString()))
        : EdgeInsets.only(
            top: double.parse((paddingTop ?? 0).toString()),
            bottom: double.parse((paddingBottom ?? 0).toString()),
            left: double.parse((paddingLeft ?? 0).toString()),
            right: double.parse((paddingRight ?? 0).toString()),
          ),
    margin: marginAll != null
        ? EdgeInsets.all(double.parse((marginAll ?? 0).toString()))
        : EdgeInsets.only(
            top: double.parse((marginTop ?? 0).toString()),
            bottom: double.parse((marginBottom ?? 0).toString()),
            left: double.parse((marginLeft ?? 0).toString()),
            right: double.parse((marginRight ?? 0).toString()),
          ),
    decoration: BoxDecoration(
      color: color ?? Colors.white,
      borderRadius: allRadius != null
          ? BorderRadius.all(
              Radius.circular(double.parse((allRadius ?? 0).toString())))
          : BorderRadius.only(
              topLeft: Radius.circular(
                  double.parse((topLeftRadius ?? 6).toString())),
              topRight: Radius.circular(
                  double.parse((topRightRadius ?? 6).toString())),
              bottomLeft: Radius.circular(
                  double.parse((bottomLeftRadius ?? 6).toString())),
              bottomRight: Radius.circular(
                  double.parse((bottomRightRadius ?? 6).toString())),
            ),
    ),
    child: child ?? emptyContainer(),
  );
}

messageTypeContainer(
    {width,
    color,
    allRadius,
    topLeftRadius,
    bottomLeftRadius,
    topRightRadius,
    bottomRightRadius,
    marginAll,
    marginTop,
    marginBottom,
    marginLeft,
    marginRight,
    paddingAll,
    paddingTop,
    paddingBottom,
    paddingLeft,
    paddingRight,
    alignment,
    child}) {
  return Container(
    width: double.parse((width ?? 80).toString()),
    alignment: alignment ?? Alignment.center,
    padding: paddingAll != null
        ? EdgeInsets.all(double.parse((paddingAll ?? 0).toString()))
        : EdgeInsets.only(
            top: double.parse((paddingTop ?? 0).toString()),
            bottom: double.parse((paddingBottom ?? 0).toString()),
            left: double.parse((paddingLeft ?? 0).toString()),
            right: double.parse((paddingRight ?? 0).toString()),
          ),
    margin: marginAll != null
        ? EdgeInsets.all(double.parse((marginAll ?? 0).toString()))
        : EdgeInsets.only(
            top: double.parse((marginTop ?? 0).toString()),
            bottom: double.parse((marginBottom ?? 0).toString()),
            left: double.parse((marginLeft ?? 0).toString()),
            right: double.parse((marginRight ?? 0).toString()),
          ),
    constraints: const BoxConstraints(minHeight: 150),
    decoration: BoxDecoration(
      color: color ?? Colors.white,
      borderRadius: allRadius != null
          ? BorderRadius.all(
              Radius.circular(double.parse((allRadius ?? 0).toString())))
          : BorderRadius.only(
              topLeft: Radius.circular(
                  double.parse((topLeftRadius ?? 6).toString())),
              topRight: Radius.circular(
                  double.parse((topRightRadius ?? 6).toString())),
              bottomLeft: Radius.circular(
                  double.parse((bottomLeftRadius ?? 6).toString())),
              bottomRight: Radius.circular(
                  double.parse((bottomRightRadius ?? 6).toString())),
            ),
    ),
    child: child ?? emptyContainer(),
  );
}

Widget button({title, onClick, textColor, fontSize}) {
  return MaterialButton(
    onPressed: onClick,
    child: Text(
      title,
      style: TextStyle(
        color: textColor ?? Colors.black,
        fontSize: double.parse((fontSize ?? 14).toString()),
      ),
    ),
  );
}

cacheNetworkImage(
    {imageUrl,
    imageHeight,
    imageWidth,
    fit,
    placeHolder,
    radius,
    color,
    imageRadius}) {
  return Container(
    decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
            Radius.circular(double.parse((radius ?? 0).toString()))),
        image: DecorationImage(
          image: AssetImage(
            placeHolder ?? "assets/providerImages/png/img_placeholder.png",
          ),
        )),
    child: CustomContainer(
      allRadius: 22,
      height: double.parse(((imageHeight) ?? 48).toString()),
      width: double.parse(((imageWidth) ?? 48).toString()),
      color: color ?? Colors.white,
      child: FittedBox(
        child: CachedNetworkImage(
          imageUrl: imageUrl,
          color: color ?? Colors.white,
          height: double.parse((imageHeight ?? 48).toString()),
          width: double.parse((imageWidth ?? 48).toString()),
          imageBuilder: (context, imageProvider) => Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(
                  Radius.circular(double.parse((radius ?? 0).toString()))),
              image: DecorationImage(
                image: imageProvider,
                fit: fit ?? BoxFit.cover,
              ),
            ),
          ),
          placeholder: (context, url) => CupertinoTheme(
            data: CupertinoTheme.of(context)
                .copyWith(brightness: Brightness.dark),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  CircularProgressIndicator(
                    color: AppColors.solidBlue,
                  ),
                ],
              ),
            ),
          ),
          errorWidget: (context, url, error) => const Icon(
            Icons.error,
            color: Colors.transparent,
          ),
        ),
      ),
    ),
  );
}

customButton({
  title,
  onTap,
  width,
  height,
  allRadius,
  topLeftRadius,
  topRightRadius,
  bottomLeftRadius,
  bottomRightRadius,
  color,
  textSize,
  textWeight,
  textColor,
  marginAll,
  marginTop,
  marginBottom,
  marginLeft,
  marginRight,
  paddingAll,
  paddingTop,
  paddingBottom,
  paddingLeft,
  paddingRight,
}) {
  return InkWell(
    onTap: onTap ??
        () {
          print("invalid click");
        },
    child: Container(
      width: double.parse((width ?? Get.width).toString()),
      height: double.parse((height ?? 40).toString()),
      margin: marginAll == null
          ? EdgeInsets.only(
              top: double.parse((marginTop ?? 0).toString()),
              bottom: double.parse((marginBottom ?? 0).toString()),
              left: double.parse((marginLeft ?? 0).toString()),
              right: double.parse((marginRight ?? 0).toString()),
            )
          : EdgeInsets.all(double.parse((marginAll ?? 0).toString())),
      padding: paddingAll == null
          ? EdgeInsets.only(
              top: double.parse((paddingTop ?? 0).toString()),
              bottom: double.parse((paddingBottom ?? 0).toString()),
              left: double.parse((paddingLeft ?? 0).toString()),
              right: double.parse((paddingRight ?? 0).toString()),
            )
          : EdgeInsets.all(double.parse((paddingAll ?? 0).toString())),
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: color ?? AppColors.appGreen,
          borderRadius: allRadius == null
              ? BorderRadius.only(
                  topLeft: Radius.circular(
                      double.parse((topLeftRadius ?? 0).toString())),
                  topRight: Radius.circular(
                      double.parse((topRightRadius ?? 0).toString())),
                  bottomRight: Radius.circular(
                      double.parse((bottomRightRadius ?? 0).toString())),
                  bottomLeft: Radius.circular(
                      double.parse((bottomLeftRadius ?? 0).toString())),
                )
              : BorderRadius.all(
                  Radius.circular(double.parse((allRadius ?? 0).toString())))),
      child: Text(
        title ?? "Click Me",
        style: TextStyle(
            color: textColor ?? Colors.black,
            fontSize: double.parse((textSize ?? 18).toString()),
            fontWeight: textWeight ?? FontWeight.bold),
      ),
    ),
  );
}
