import 'package:fare_now_provider/controllers/profile_screen_controller/ProfileScreenController.dart';
import 'package:fare_now_provider/models/available_services/available_data.dart';
import 'package:fare_now_provider/screens/Controller/HomeScreenController.dart';
import 'package:fare_now_provider/widgets/data_not_available_widget.dart';
import 'package:fare_now_provider/widgets/project_header_widget.dart';
import 'package:fare_now_provider/widgets/view_render_wdiget.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:laravel_echo/laravel_echo.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../api_service/service_repository.dart';
import '../util/api_utils.dart';
import '../util/shared_reference.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Color blue = Colors.blue;

  Color white = Colors.white;
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  HomeScreenController _homeScreenController = Get.find();
  PageController _pageController = PageController();

  bool availAble = true;

  int currentIndex = 0;
  String tabSelected = "accepted";
  ProfileScreenController _controller = Get.find();
  HomeScreenController _homeScreenControlle = Get.find();
  FirebaseMessaging _firebase = FirebaseMessaging.instance;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller.getProviderProfile(flag: true);

    _homeScreenControlle.getAvailableJobs(flag: true);

    _firebase.getToken().then((token) async {
      print("fcm token: $token");
      int platform = GetPlatform.isIOS ? 2 : 1;
      print("plat: ${platform}");
      String? authToken =
          await SharedRefrence().getString(key: ApiUtills.authToken);
      await ServiceReposiotry().uploadToken(token!, authToken, platform);
    });
    IO.Socket socket = IO.io('wss://api.farenow.com/socket.io');
    socket.on('connect', (_) {
      print('connected');
    });
    Echo laravelEcho = Echo(
      client: socket,
      broadcaster: EchoBroadcasterType.SocketIO,
    );
    laravelEcho
        .channel('alert-to-${_controller.userData.value.id}')
        .listen('.AlertEvent', (data) {
      print(data);
      _homeScreenControlle.getAvailableJobs(flag: true);
    });
  }

  @override
  Widget build(BuildContext context) {
    // _homeScreenController.getAvailableJobs(flag: true);
    return Scaffold(
      body: SafeArea(
        child: SmartRefresher(
          onRefresh: () async {
            _homeScreenController.getAvailableJobs(
                flag: true, refreshController: _refreshController);
          },
          controller: _refreshController,
          child: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints size) {
              return ConstrainedBox(
                constraints: BoxConstraints(maxHeight: size.maxHeight),
                child: Obx(
                  () => Column(
                    children: [
                      Visibility(
                        visible: false,
                        child: Text(
                            "${_homeScreenController.availableJos.value.availableServiceData == null ? "" : _homeScreenController.availableJos.value.availableServiceData.length}"),
                      ),
                      ProjectHeaderWidget(
                        currentIndex: currentIndex,
                        onChangeCurrentIndex: (value) {
                          currentIndex = value;
                          print("=====================$currentIndex");
                          _pageController.jumpToPage(currentIndex);
                          setState(() {});
                        },
                      ),
                      Container(
                        height: 2,
                        width: Get.width,
                        color: Colors.grey[300],
                      ),
                      8.height,
                      Expanded(
                        flex: 1,
                        child: Obx(() => Container(
                              height: Get.height,
                              child: PageView(
                                physics: const NeverScrollableScrollPhysics(),
                                allowImplicitScrolling: false,
                                controller: _pageController,
                                children: buildWidgets(
                                    _homeScreenController.availableJos),
                                onPageChanged: (index) {
                                  currentIndex = index;

                                  setState(() {});
                                },
                              ),
                            )),
                      )
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  check(data) {
    if (data.status.toLowerCase() != "accepted") {
      return false;
    }
    if (data.status.toLowerCase() != "rejected") {
      return false;
    }

    return true;
  }

  getPageWidget(List<dynamic> value) {
    List<Widget> list = [];
    if (value.isEmpty) {
      list.add(DataNotAvailableWidget());
      list.add(DataNotAvailableWidget());
      list.add(DataNotAvailableWidget());
      list.add(DataNotAvailableWidget());
      list.add(ChatDataNotAvailableWidget());
      return list;
    }
    for (int index = 0; index < value.length; index++) {
      list.add((value[index] as Widget));
    }

    return list;
  }

  buildWidgets(Rx<AvailableData> availableJos) {
    List widgetListNew = ViewRenderWidget()
        .getPages(availableJos, _homeScreenController, tabSelected: tabSelected,
            tabUpDate: (value) {
      print("");
      tabSelected = value;
      setState(() {});
    });
    return getPageWidget(widgetListNew);
    // return widgetList;
  }
}
