import 'package:flutter/material.dart';

class CircularText extends StatelessWidget {
  const CircularText({
    Key? key,
    @required this.size,
    @required this.color,
    @required this.text,
    @required this.textStyle,
  }) : super(key: key);

  final double? size;
  final Color? color;
  final String? text;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(shape: BoxShape.circle, color: color),
      child: Card(
        color: color,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50.0),
        ),
        // color: Colors.white,
        child: Center(
            child: Text(text!, textAlign: TextAlign.center, style: textStyle)),
      ),
    );
  }
}
