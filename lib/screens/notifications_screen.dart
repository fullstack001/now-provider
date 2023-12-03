import 'package:fare_now_provider/blocs/notifications_bloc/notifications_bloc.dart';
import 'package:fare_now_provider/controllers/all_notification_controller.dart';
import 'package:fare_now_provider/models/NotificationClass.dart';
import 'package:fare_now_provider/models/notifications/all_notifications_data.dart';
import 'package:fare_now_provider/util/date_time_utills.dart';
import 'package:fare_now_provider/util/loading.dart';
import 'package:fare_now_provider/util/widgest_utills.dart';
import 'package:fare_now_provider/widgets/custom_container.dart';
import 'package:fare_now_provider/widgets/data_not_available_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'dart:math' as math;
import 'package:nb_utils/nb_utils.dart';

class NotificationsScreen extends StatelessWidget {
  static const String id = 'notifications_screen';
  AllNotificationController _controller = Get.put(AllNotificationController());

  @override
  Widget build(BuildContext context) {
    _controller.getAllNotifications();
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        elevation: 1,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: const Text(
          'Notification',
          style: TextStyle(
              color: Color(0xff151415),
              fontSize: 18,
              fontWeight: FontWeight.w500),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Obx(() => _controller.loading.value
                ? const Loading()
                : Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: _controller.allNotification.isEmpty
                        ? DataNotAvailableWidget()
                        : ListView.builder(
                            itemCount: _controller.allNotification.length,
                            itemBuilder: (context, index) {
                              AllNotificationsData value =
                                  _controller.allNotification.value[index];

                              return value.allNotificationsModelData.title ==
                                      null
                                  ? emptyContainer()
                                  : Card(
                                      color: white,
                                      margin: EdgeInsets.zero,
                                      child: Column(
                                        children: [
                                          5.height,
                                          ListTile(
                                            contentPadding:
                                                EdgeInsets.symmetric(
                                                    horizontal: 12),
                                            leading: Container(
                                              decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: Color((math.Random()
                                                                  .nextDouble() *
                                                              0xFFFFFF)
                                                          .toInt())
                                                      .withOpacity(1.0)),
                                              width: 60,
                                              height: 60,
                                              child: const Icon(
                                                Icons.person,
                                                color: black,
                                                size: 33,
                                              ),
                                            ),
                                            title: Text(
                                              "${getTitleNotif(value)}",
                                              style: const TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                            subtitle: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  5.height,
                                                  Text(
                                                    "${getTimeSice(value)}",
                                                    style: const TextStyle(
                                                        color:
                                                            Color(0xff757575),
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w400),
                                                    textAlign: TextAlign.left,
                                                  ),
                                                  5.height,
                                                  Text(
                                                    "${getBodyNotif(value)}",
                                                    style: const TextStyle(
                                                        color:
                                                            Color(0xff555555),
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w400),
                                                  ),
                                                ]),
                                          ),
                                          const Divider(
                                            thickness: 1,
                                          )
                                        ],
                                      ),
                                    );
                            },
                          ),
                  )),
          )
        ],
      ),
    );
  }

  getTitleNotif(AllNotificationsData value) {
    if (value.allNotificationsModelData == null) {
      return "n/a";
    }
    return value.allNotificationsModelData.title;
  }

  getBodyNotif(AllNotificationsData value) {
    if (value.allNotificationsModelData == null) {
      return "";
    }
    return value.allNotificationsModelData.body;
  }

  getTimeSice(AllNotificationsData value) {
    var time = DateTimeUtils().convertWorkingHoursTime(value.createdAt);
    var sinceTime = DateTimeUtils().checkSince(time);
    return sinceTime;
  }
}

class NotificationsWidget extends StatefulWidget {
  @override
  _NotificationsWidgetState createState() => _NotificationsWidgetState();
}

class _NotificationsWidgetState extends State<NotificationsWidget> {
  Color background = const Color(0xff034f43);
  Color specialWhite = const Color(0xffececf6);
  Color lightGreen = const Color(0xff9be1c4);

  List<NotificationClass> notifications = [];

  bool showOptions = false;

  @override
  void initState() {
    super.initState();

    final notificationsBloc = BlocProvider.of<NotificationsBloc>(context);
    notificationsBloc.add(const GetNotifications());
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        centerTitle: false,
        title: const Text(
          'Notification',
          style: TextStyle(
              color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: BlocBuilder<NotificationsBloc, NotificationsState>(
              builder: (context, state) {
                if (state is NotificationsLoaded)
                  return listNotifications(
                      screenHeight, screenWidth, state.notifications);
                else
                  return const Loading();
              },
            ),

            // ,
          ),
        ],
      ),
    );
  }

  Widget listNotifications(double screenHeight, double screenWidth,
      List<NotificationClass> notifications) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: ListView.builder(
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          final notification = notifications.toList()[index];

          return GestureDetector(
            onTap: () {},
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(38.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        notification.title!,
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        notification.details!,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
                const Divider(
                  color: Color(0xffE0E0E0),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
