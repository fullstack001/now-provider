import 'package:fare_now_provider/util/widgest_utills.dart';
import 'package:flutter/material.dart';

class CustomContainer extends StatelessWidget {
  var width;
  var height;
  var color;
  var allRadius;
  var topLeftRadius;
  var bottomLeftRadius;
  var topRightRadius;
  var bottomRightRadius;
  var marginAll;
  var marginTop;
  var marginBottom;
  var marginLeft;
  var marginRight;
  var paddingAll;
  var paddingTop;
  var paddingBottom;
  var paddingLeft;
  var paddingRight;
  var alignment;
  var shadowColor;
  var shadowSpreadRadius;
  var shadowBlurRadius;
  var shadowOffsetX;
  var shadowOffsetY;
  var gradientColor;
  var borderColor;
  var borderWidth;
  var onTap;
  var child;
  var visibility;
  bool? value;
  Function? onToggle;

  CustomContainer({
     this.value, this.onToggle, //todo
    this.gradientColor,
    this.width,
    this.height,
    this.alignment,
    this.marginAll,
    this.bottomRightRadius,
    this.bottomLeftRadius,
    this.topRightRadius,
    this.allRadius,
    this.paddingAll,
    this.shadowOffsetY,
    this.shadowColor,
    this.shadowSpreadRadius,
    this.shadowBlurRadius,
    this.borderWidth,
    this.marginBottom,
    this.marginRight,
    this.marginLeft,
    this.paddingRight,
    this.marginTop,
    this.paddingTop,
    this.topLeftRadius,
    this.shadowOffsetX,
    this.borderColor,
    this.paddingLeft,
    this.color,
    this.paddingBottom,
    this.onTap,
    this.child,
    this.visibility,
  });

  @override
  Widget build(BuildContext context) {
    var padding = paddingAll != null
        ? EdgeInsets.all(double.parse((paddingAll ?? 0).toString()))
        : EdgeInsets.only(
            top: double.parse((paddingTop ?? 0).toString()),
            bottom: double.parse((paddingBottom ?? 0).toString()),
            left: double.parse((paddingLeft ?? 0).toString()),
            right: double.parse((paddingRight ?? 0).toString()),
          );
    var margin = marginAll != null
        ? EdgeInsets.all(double.parse((marginAll ?? 0).toString()))
        : EdgeInsets.only(
            top: double.parse((marginTop ?? 0).toString()),
            bottom: double.parse((marginBottom ?? 0).toString()),
            left: double.parse((marginLeft ?? 0).toString()),
            right: double.parse((marginRight ?? 0).toString()),
          );
    var decoration = BoxDecoration(
      color: color ?? Colors.white,
      borderRadius: allRadius != null
          ? BorderRadius.all(
              Radius.circular(double.parse((allRadius ?? 0).toString())))
          : BorderRadius.only(
              topLeft: Radius.circular(
                  double.parse((topLeftRadius ?? 0).toString())),
              topRight: Radius.circular(
                  double.parse((topRightRadius ?? 0).toString())),
              bottomLeft: Radius.circular(
                  double.parse((bottomLeftRadius ?? 0).toString())),
              bottomRight: Radius.circular(
                  double.parse((bottomRightRadius ?? 0).toString())),
            ),
      border: Border.all(
          width: double.parse((borderWidth ?? 0).toString()),
          color: borderColor ?? Colors.transparent),
      boxShadow: [
        BoxShadow(
          color: shadowColor ?? Colors.transparent,
          spreadRadius: double.parse((shadowSpreadRadius ?? 0).toString()),
          blurRadius: double.parse((shadowBlurRadius ?? 0).toString()),
          offset: Offset(double.parse((shadowOffsetX ?? 0).toString()),
              double.parse((shadowOffsetY ?? 0).toString())),
        )
      ],
      gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: gradientColor ??
            [
              color ?? Colors.transparent,
              color ?? Colors.transparent,
            ],
      ),
    );
    return Visibility(
        visible: visibility ?? true,
        child: width == null && height == null
            ? bothNull(
                padding: padding,
                margin: margin,
                decoration: decoration,
                alignment: alignment,
                onTap: onTap,
                child: child,
              )
            : height == null
                ? heightNull(
                    width: width,
                    padding: padding,
                    margin: margin,
                    decoration: decoration,
                    alignment: alignment,
                    onTap: onTap,
                    child: child,
                  )
                : width == null
                    ? widthNull(
                        height: height,
                        padding: padding,
                        margin: margin,
                        decoration: decoration,
                        alignment: alignment,
                        onTap: onTap,
                        child: child,
                      )
                    : customContainer(
                        width: width,
                        height: height,
                        padding: padding,
                        margin: margin,
                        decoration: decoration,
                        alignment: alignment,
                        onTap: onTap,
                        child: child,
                      ));
  }

  customContainer({
    width,
    height,
    padding,
    decoration,
    margin,
    onTap,
    alignment,
    child,
  }) {
    return InkWell(
      onTap: onTap == null ? null : onTap,
      child: Container(
        width: double.parse((width ?? 80).toString()),
        height: double.parse((height ?? 50).toString()),
        alignment: alignment ?? Alignment.center,
        padding: padding,
        margin: margin,
        decoration: decoration,
        child: child ?? emptyContainer(),
      ),
    );
  }

  bothNull({
    padding,
    decoration,
    margin,
    alignment,
    onTap,
    child,
  }) {
    return InkWell(
      onTap: onTap == null ? null : onTap,
      child: Column(
        children: [
          Row(
            children: [
              Container(
                alignment: alignment ?? Alignment.center,
                padding: padding,
                margin: margin,
                decoration: decoration,
                child: child ?? emptyContainer(),
              ),
            ],
          ),
        ],
      ),
    );
  }

  heightNull({
    padding,
    width,
    decoration,
    margin,
    alignment,
    onTap,
    child,
  }) {
    return InkWell(
      onTap: onTap == null ? null : onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: double.parse((width).toString()),
            alignment: alignment ?? Alignment.center,
            padding: padding,
            margin: margin,
            decoration: decoration,
            child: child ?? emptyContainer(),
          ),
        ],
      ),
    );
  }

  widthNull({
    height,
    padding,
    decoration,
    margin,
    onTap,
    alignment,
    child,
  }) {
    return InkWell(
      onTap: onTap == null ? null : onTap,
      child: Row(
        children: [
          Container(
            height: double.parse((height ?? 50).toString()),
            alignment: alignment ?? Alignment.center,
            padding: padding,
            margin: margin,
            decoration: decoration,
            child: child ?? emptyContainer(),
          ),
        ],
      ),
    );
  }
}
