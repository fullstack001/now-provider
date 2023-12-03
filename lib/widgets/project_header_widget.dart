import 'package:fare_now_provider/controllers/profile_screen_controller/ProfileScreenController.dart';
import 'package:fare_now_provider/util/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProjectHeaderWidget extends StatelessWidget {
  final onChangeCurrentIndex;
  final currentIndex;

  ProjectHeaderWidget({
    Key? key,
    this.onChangeCurrentIndex,
    this.currentIndex,
  }) : super(key: key);

  List<bool> flags = [true, false, false, false,false];
  List<bool> flagTabs = [true, false];
  List<Widget> page = [];
  ProfileScreenController _controller = Get.find<ProfileScreenController>();
  @override
  Widget build(BuildContext context) {
    resetFlags();
    flags[currentIndex] = true;
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Container(
        width: Get.width,
        height: 56,
        child: ListView(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          children: [
            InkWell(
              onTap: () {
                resetFlags();
                flags[0] = !flags[0];
                onChangeCurrentIndex(0);
              },
              child: Container(
                padding: const EdgeInsets.only(left: 10),
                width: 130,
                child: Column(
                  children: [
                    Expanded(
                      child: Container(
                        alignment: Alignment.center,
                        height: 40,
                        child: Text(
                          "Requested",
                          style: TextStyle(
                              color: flags[0]
                                  ? AppColors.solidBlue
                                  : const Color(0xff757575),
                              fontSize: 16,
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                    ),
                    Container(
                      height: 2,
                      color:
                          flags[0] ? AppColors.solidBlue : Colors.transparent,
                    )
                  ],
                ),
              ),
            ),
            InkWell(
              onTap: () {
                resetFlags();
                flags[1] = true;
                onChangeCurrentIndex(1);
              },
              child: Container(
                padding: const EdgeInsets.only(left: 10),
                width: 130,
                child: Column(
                  children: [
                    Expanded(
                      child: Container(
                        alignment: Alignment.center,
                        height: 40,
                        child: Text(
                          "Accept",
                          style: TextStyle(
                              color: flags[1]
                                  ? AppColors.solidBlue
                                  : const Color(0xff757575),
                              fontSize: 16,
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                    ),
                    Container(
                      height: 2,
                      color:
                          flags[1] ? AppColors.solidBlue : Colors.transparent,
                    )
                  ],
                ),
              ),
            ),
            InkWell(
              onTap: () {
                resetFlags();
                flags[2] = !flags[2];
                onChangeCurrentIndex(2);
              },
              child: Container(
                padding: const EdgeInsets.only(left: 10),
                width: 130,
                child: Column(
                  children: [
                    Expanded(
                      child: Container(
                        alignment: Alignment.center,
                        height: 40,
                        child: Text(
                          "Rejected",
                          style: TextStyle(
                              color: flags[2]
                                  ? AppColors.solidBlue
                                  : const Color(0xff757575),
                              fontSize: 16,
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                    ),
                    Container(
                      height: 2,
                      color:
                          flags[2] ? AppColors.solidBlue : Colors.transparent,
                    )
                  ],
                ),
              ),
            ),
            InkWell(
              onTap: () {
                resetFlags();
                flags[3] = !flags[3];
                onChangeCurrentIndex(3);
                print("=========tap cancelled=========");
              },
              child: Container(
                padding: const EdgeInsets.only(left: 10),
                width: 130,
                child: Column(
                  children: [
                    Expanded(
                      child: Container(
                        alignment: Alignment.center,
                        height: 40,
                        child: Text(
                          "Cancelled",
                          style: TextStyle(
                              color: flags[3]
                                  ? AppColors.solidBlue
                                  : const Color(0xff757575),
                              fontSize: 16,
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                    ),
                    Container(
                      height: 2,
                      color:
                      flags[3] ? AppColors.solidBlue : Colors.transparent,
                    )
                  ],
                ),
              ),
            ),
            _controller.userData.value.providerType != "Individual"
                ? InkWell(
                  onTap: () {
                    resetFlags();
                    flags[4] = !flags[4];
                    onChangeCurrentIndex(4);
                    print("=========tap chat=========");
                  },
                  child: Container(
                    padding: const EdgeInsets.only(left: 10),
                    width: 130,
                    child: Column(
                      children: [
                        Expanded(
                          child: Container(
                            alignment: Alignment.center,
                            height: 40,
                            child: Text(
                              "Chat",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: flags[4]
                                      ? AppColors.solidBlue
                                      : const Color(0xff757575),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                        ),
                        Container(
                          height: 2,
                          color: flags[4]
                              ? AppColors.solidBlue
                              : Colors.transparent,
                        )
                      ],
                    ),
                  ),
                )
                : Container(),
          ],
        ),
      ),
    );
  }

  void resetFlags() {
    for (int index = 0; index < flags.length; index++) {
      flags[index] = false;
    }
  }
}
/*class ProjectHeaderWidget extends StatelessWidget {
  final onChangeCurrentIndex;
  final currentIndex;

  ProjectHeaderWidget({
    Key? key,
    this.onChangeCurrentIndex,
    this.currentIndex,
  }) : super(key: key);

  List<bool> flags = [true, false, false, false, false];
  List<bool> flagTabs = [true, false];
  List<Widget> page = [];
  ProfileScreenController _controller = Get.find<ProfileScreenController>();

  @override
  Widget build(BuildContext context) {
    resetFlags();
    flags[currentIndex] = true;
    return Container(
      width: Get.width,
      height: 56,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          buildTab("Requested", flags[0], () => onChangeCurrentIndex(0)),
          buildTab("Accept", flags[1], () => onChangeCurrentIndex(1)),
          buildTab("Rejected", flags[2], () => onChangeCurrentIndex(2)),
          buildTab("Cancelled", flags[3], () => onChangeCurrentIndex(3)),
          if (_controller.userData.value.providerType != "Individual")
            buildTab("Chat", flags[4], () => onChangeCurrentIndex(4)),
        ],
      ),
    );
  }

  Widget buildTab(String title, bool isSelected, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.only(left: 10),
        width: 130,
        child: Column(
          children: [
            Expanded(
              child: Container(
                alignment: Alignment.center,
                height: 40,
                child: Text(
                  title,
                  style: TextStyle(
                    color: isSelected ? AppColors.solidBlue : Color(0xff757575),
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
            Container(
              height: 2,
              color: isSelected ? AppColors.solidBlue : Colors.transparent,
            )
          ],
        ),
      ),
    );
  }

  void resetFlags() {
    for (int index = 0; index < flags.length; index++) {
      flags[index] = false;
    }
  }
}*/