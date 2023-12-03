import 'package:flutter/material.dart';

class TimmerWidget extends StatefulWidget {
  var seconds;

  var minutes;

  var hours;
  var pause;
  var timeChange;

  // var days;

  TimmerWidget({
    Key? key,
    this.minutes,
    this.hours,
    this.seconds,
    this.pause,
    this.timeChange,
    // this.days,
  }) : super(key: key);

  @override
  _TimmerWidgetState createState() => _TimmerWidgetState();
}

class _TimmerWidgetState extends State<TimmerWidget> {
  int seconds = 0;
  int minutes = 0;
  int hours = 0;
  bool pause = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    startTimer();
  }

  @override
  Widget build(BuildContext context) {
    seconds = widget.seconds ?? 0;
    minutes = widget.minutes ?? 0;
    hours = widget.hours ?? 0;
    return Container(
      child: Row(
        children: [
          /*${(widget.days ?? 0) != 0 ? "${widget.days}days" : ""} */
          Text(
            "${hours.toString().padLeft(2, "0")}:${minutes.toString().padLeft(2, "0")}:${seconds.toString().padLeft(2, "0")}",
            style: TextStyle(fontSize: 18),
          ),
        ],
      ),
    );
  }

  void startTimer() {
    bool pause = widget.pause ?? false;
    Future.delayed(Duration(seconds: 1)).then((value) {
      if (!pause) {
        widget.seconds = widget.seconds + 1;
        if (widget.seconds == 60) {
          widget.seconds = 0;
          widget.minutes = widget.minutes + 1;
          if (widget.minutes == 60) {
            widget.minutes = 0;
            widget.hours = widget.hours + 1;
          }
        }
        if (widget.timeChange != null) {
          // if (widget.days != 0) {
          //   widget.timeChange(
          //       "${widget.days}days ${widget.hours}:${widget.minutes}:${widget.seconds}");
          // } else {
          widget.timeChange(
              "${widget.hours}:${widget.minutes}:${widget.seconds}");
          // }
        }

        setState(() {});
      }
      startTimer();
    });
  }
}
