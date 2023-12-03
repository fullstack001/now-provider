import 'dart:io';

import 'package:fare_now_provider/components/buttons-management/part_of_file/part.dart';
import 'package:fare_now_provider/controller_init.dart';
import 'package:fare_now_provider/controllers/location_controller/locaction_controller.dart';
import 'package:fare_now_provider/screens/auth_screen/login_screen.dart';
import 'package:fare_now_provider/screens/auth_screen/pin_verification_screen.dart';
import 'package:fare_now_provider/screens/auth_screen/profile_data_steps/business_profile_settings_screen.dart';
import 'package:fare_now_provider/screens/auth_screen/profile_data_steps/profile_settings_screen.dart';
import 'package:fare_now_provider/screens/auth_screen/profile_data_steps/step_4.dart';
import 'package:fare_now_provider/screens/auth_screen/profile_data_steps/step_6.dart';
import 'package:fare_now_provider/screens/auth_screen/signup_screen.dart';
import 'package:fare_now_provider/screens/auth_screen/zipcode/select_zipcode.dart';
import 'package:fare_now_provider/screens/bottom_navigation.dart';
import 'package:fare_now_provider/screens/brand_or_service_provider_screen.dart';
import 'package:fare_now_provider/screens/build_profile_steps.dart';
import 'package:fare_now_provider/screens/business_credentials.dart';
import 'package:fare_now_provider/screens/find_customers.dart';
import 'package:fare_now_provider/screens/notifications_screen.dart';
import 'package:fare_now_provider/screens/offer_services_screen.dart';
import 'package:fare_now_provider/screens/profile_screen.dart';
import 'package:fare_now_provider/screens/select_work.dart';
import 'package:fare_now_provider/screens/service_settings.dart';
import 'package:fare_now_provider/screens/service_timings/new_servie_timing/serive_timing_screen.dart';
import 'package:fare_now_provider/screens/set_profile_screen.dart';
import 'package:fare_now_provider/screens/signup_or_login_screen.dart';
import 'package:fare_now_provider/util/app_colors.dart';
import 'package:fare_now_provider/util/shared_reference.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:geocoding/geocoding.dart' as gc;
import 'package:geolocator/geolocator.dart' as gl;
import 'package:logger/logger.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:permission_handler/permission_handler.dart' as ph;
import 'package:rxdart/subjects.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

import 'IndivisualStep5.dart';
import 'MyServices.dart';
import 'firebase_options.dart';
import 'screens/splash_screen.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  print("Handling a background message: ${message.messageId}");
}

bool check = false;

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

String? selectedNotificationPayload;

final BehaviorSubject<ReceivedNotification> didReceiveLocalNotificationSubject =
    BehaviorSubject<ReceivedNotification>();

final BehaviorSubject<String?> selectNotificationSubject =
    BehaviorSubject<String?>();

const MethodChannel platform =
    MethodChannel('dexterx.dev/flutter_local_notifications_example');

class ReceivedNotification {
  ReceivedNotification({
    required this.id,
    required this.title,
    required this.body,
    required this.payload,
  });

  final int id;
  final String? title;
  final String? body;
  final String? payload;
}

void main() async {
  Future.delayed(const Duration(seconds: 0)).then((value) async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
    await dotenv.load();
    // IoSPushNotificationsService().initialise();
    FirebaseMessaging _firebase = FirebaseMessaging.instance;
    _firebase.getToken().then((value) => print(value));
    if (GetPlatform.isIOS) {
      await _firebase.setForegroundNotificationPresentationOptions(
        alert: true,
        badge: true,
        sound: true,
      );
      _firebase.requestPermission(
        alert: true,
        announcement: false,
        badge: true,
        carPlay: false,
        criticalAlert: false,
        provisional: false,
        sound: true,
      );
    }

    if (GetPlatform.isAndroid) {}
    // AwsomNotificationService.initializeAwesomeNotification();
    await ControllerInit().init();
    FlutterError.onError = (FlutterErrorDetails details) {
      if (kReleaseMode) {
        Sentry.captureException(
          details.exception,
          stackTrace: details.stack,
        );
      } else {
        // You might want to print the details of the error in debug mode.
        FlutterError.dumpErrorToConsole(details);
      }
    };
    if (kReleaseMode) {
      await SentryFlutter.init(
        (options) {
          options.dsn = dotenv.env['SENTRY_DSN'];
          options.tracesSampleRate = 1.0;
          options.environment = 'production';
        },
        appRunner: () => runApp(MyApp()),
      );
    } else {
      runApp(MyApp());
    }
  });
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  // ignore: non_constant_identifier_names
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  final locationController = Get.put(LocationController());
  // String? _currentAddress;
  String? _currentIsoCode;
  // Position? _currentPosition;
  String? setIso;
  final logger = Logger();

  bool isLoading = false;

  @override
  void initState() {
    Future.delayed(const Duration(milliseconds: 100)).then((value) async {
      // String? authToken =
      //     await SharedRefrence().getString(key: ApiUtills.authToken);
    });
    locationController.getIsLoading(true);
    WidgetsBinding.instance.addObserver(this);

    _getCurrentPosition();

    if (Platform.isAndroid) {
      _checkLocationPermissionAndRestartApp();
    }
    super.initState();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    super.didChangeAppLifecycleState(state);
    // await 5.delay();
    if (state == AppLifecycleState.resumed) {
      final locationStatus = await ph.Permission.location.status;
      final locationServiceStatus = await ph.Permission.location.serviceStatus;
      Logger().i(locationStatus);
      Logger().i(locationServiceStatus);

      if (Platform.isIOS) {
        await _getCurrentPosition();
      }

      if (Platform.isAndroid) {
        await _checkLocationPermissionAndRestartApp();
      }
    }
  }

  Future<void> _checkLocationPermissionAndRestartApp() async {
    final locationStatus = await ph.Permission.location.status;
    final locationServiceStatus = await ph.Permission.location.serviceStatus;
    final locationRequest = await ph.Permission.location.request();

    if (locationStatus.isGranted) {
      await gl.Geolocator.getCurrentPosition(
              desiredAccuracy: gl.LocationAccuracy.high)
          .then((gl.Position position) {
        _getAddressFromLatLng(position);
      }).catchError((e) {
        logger.e(e);
      });
    } else {
      if (locationServiceStatus.isDisabled) {
        logger.d("opening at the start");

        final hasPermission = await ph.openAppSettings();
        if (!hasPermission) {
          _checkLocationPermissionAndRestartApp();
        }
      } else if (locationRequest.isGranted) {
        await gl.Geolocator.getCurrentPosition(
                desiredAccuracy: gl.LocationAccuracy.high)
            .then((gl.Position position) {
          _getAddressFromLatLng(position);
        }).catchError((e) {
          debugPrint(e);
        });
      } else {
        ///here trying to open App setting
        logger.d("opening at the end");
        ph.openAppSettings();
      }
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  Future<void> _forceRequestLocationPermission() async {
    final status = await ph.Permission.location.status;

    if (status.isDenied) {
      final status = await ph.Permission.location.request();

      if (status.isPermanentlyDenied) {
        ph.openAppSettings();
      } else if (status.isGranted) {
        await gl.Geolocator.getCurrentPosition(
                desiredAccuracy: gl.LocationAccuracy.high)
            .then((gl.Position position) {
          _getAddressFromLatLng(position);
        }).catchError((e) {
          debugPrint(e);
        });
      }
    }
  }

  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    gl.LocationPermission permission;

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    // final bool isLocationPermissionGranted =
    //     prefs.getBool('locationPermissionGranted') ?? false;
    try {
      serviceEnabled = await gl.Geolocator.isLocationServiceEnabled();

      logger.e(serviceEnabled);
      if (!serviceEnabled) {
        permission = await gl.Geolocator.requestPermission();
        locationController.getIsLocationServiceEnabled(false);
        await Fluttertoast.showToast(
            msg: "You need to enable in location service");
        await 3.delay();
        logger.e("service not enabled");
        // _forceRequestLocationPermission();
        return false;
      }
      locationController.getIsLocationServiceEnabled(serviceEnabled);

      permission = await gl.Geolocator.checkPermission();
      logger.d(permission);
      if (permission == gl.LocationPermission.denied) {
        final permission1 = await gl.Geolocator.requestPermission();
        if (permission1 == gl.LocationPermission.denied) {
          await _forceRequestLocationPermission();
          return true;
        }
        // _forceRequestLocationPermission();
      }
      if (permission == gl.LocationPermission.deniedForever) {
        await _forceRequestLocationPermission();
        return true;
      }

      prefs.setBool('locationPermissionGranted', true);
      return true;
    } catch (e) {
      prefs.setBool('locationPermissionGranted', false);
      logger.e("$e");
      return false;
    }
  }

  Future<void> _getCurrentPosition() async {
    logger.d("get current location");
    try {
      final hasPermission = await _handleLocationPermission();

      logger.d(hasPermission);

      if (!hasPermission) return;

      logger.f("message");

      final position = await gl.Geolocator.getCurrentPosition(
          desiredAccuracy: gl.LocationAccuracy.lowest);
      logger.f("message11111");

      // .then((gl.Position position) async {
      // _currentPosition = position;
      logger.i(position);
      await _getAddressFromLatLng(position);
    } catch (e) {
      logger.f("message444444  $e");
      // _handleLocationPermission();
      // logger.e(jsonEncode(e));
      // _forceRequestLocationPermission();
      // debugPrint(jsonEncode(e));
    }
  }

  Future<void> _getAddressFromLatLng(gl.Position position) async {
    try {
      final placeMarks = await gc.placemarkFromCoordinates(
          position.latitude, position.longitude);

      gc.Placemark place = placeMarks[0];
      logger.d(place);
      _currentIsoCode = place.isoCountryCode?.toString() ?? "";
      await SharedRefrence().saveIsocode(key: "IsoCode", data: _currentIsoCode);
      locationController.getIsLoading(false);
    } catch (e) {
      locationController.getIsLoading(false);
      logger.e(e);
    }
  }

  dynamic _initEasyLoading() {
    EasyLoading.instance
      ..displayDuration = const Duration(milliseconds: 1500)
      ..indicatorType = EasyLoadingIndicatorType.dualRing
      ..loadingStyle = EasyLoadingStyle.custom
      ..indicatorSize = 40.0
      ..radius = 10.0
      ..successWidget = const Icon(
        MaterialCommunityIcons.check_circle_outline,
        color: Colors.green,
        size: 50,
      )
      ..errorWidget = const Icon(
        MaterialCommunityIcons.close_circle_outline,
        color: Colors.red,
        size: 50,
      )
      ..infoWidget = const Icon(
        MaterialCommunityIcons.information_outline,
        color: Colors.lightBlueAccent,
        size: 50,
      )
      ..maskType = EasyLoadingMaskType.custom
      ..progressColor = Colors.blue
      ..maskType = EasyLoadingMaskType.custom
      ..backgroundColor = Colors.white
      ..indicatorColor = Colors.blue
      ..toastPosition = EasyLoadingToastPosition.bottom
      ..textColor = Colors.black
      ..fontSize = 14
      ..maskColor = Colors.black.withOpacity(0.4)
      ..userInteractions = false
      ..dismissOnTap = false;

    return EasyLoading.init();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarBrightness: Brightness.dark,
    ));
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus &&
            currentFocus.focusedChild != null) {
          FocusManager.instance.primaryFocus!.unfocus();
        }
      },
      child: GetMaterialApp(
        title: 'Farenow Provider',
        debugShowCheckedModeBanner: false,
        builder: _initEasyLoading(),

        theme: ThemeData(
          fontFamily: "Product Sans Regular",
          primaryColor: AppColors.appBlue,
          primarySwatch: Colors.red,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          appBarTheme: const AppBarTheme(
            systemOverlayStyle: SystemUiOverlayStyle.dark,
          ),
        ),
        initialRoute: SplashScreen.id,
        // ProfileSettingsScreen.id,
        //SplashScreen.id,
        routes: {
          MyServices.id: (context) => MyServices(),
          ServiceSettings.id: (context) => ServiceSettings(),
          Step6.id: (context) => Step6(),
          Step4.id: (context) => const Step4(),
          IndivisualStep5.id: (context) => const IndivisualStep5(),
          ServiceTimingScreen.id: (context) => ServiceTimingScreen(),
          SplashScreen.id: (context) => const SplashScreen(),
          BuildProfileStepsScreen.id: (context) => BuildProfileStepsScreen(),
          BottomNavigation.id: (context) => BottomNavigation(),
          BrandOrServiceProviderScreen.id: (context) =>
              BrandOrServiceProviderScreen(),
          BusinessCredentials.id: (context) => BusinessCredentials(),
          BusinessProfileSettingsScreen.id: (context) =>
              const BusinessProfileSettingsScreen(),
          FindCustomersScreen.id: (context) => FindCustomersScreen(),
          LoginScreen.id: (context) => const LoginScreen(),
          NotificationsScreen.id: (context) => NotificationsScreen(),
          OfferServices.id: (context) => OfferServices(),
          PinCodeVerificationScreen.id: (context) =>
              PinCodeVerificationScreen(),
          ProfileScreen.id: (context) => ProfileScreen(),
          ProfileSettingsScreen.id: (context) => const ProfileSettingsScreen(),
          SetProfileScreen.id: (context) => SetProfileScreen(),
          SignupOrLoginScreen.id: (context) => SignupOrLoginScreen(),
          SignupScreen.id: (context) => SignupScreen(
                userCountryIso2Code: _currentIsoCode,
              ),
          SelectWorkScreen.id: (context) => SelectWorkScreen(),
          SelectZipcodeScreen.id: (context) => SelectZipcodeScreen(),
        },
      ),
    );
  }

// Future<String> checkToken() async {
//   String authToken =
//       await SharedRefrence().getString(key: ApiUtills.authToken);
//   String userData = await SharedRefrence().getString(key: ApiUtills.userData);
//   if (userData.isNotEmpty) {
//     var data = json.decode(userData);
//     var resp = await ServiceReposiotry().userAvailable(data['id'].toString());
//     authToken = resp ? authToken : "";
//     print(authToken);
//   }
//   print(
//       "${authToken.isNotEmpty ? BottomNavigation.id : SignupOrLoginScreen.id}");
//   return authToken.isNotEmpty ? BottomNavigation.id : SignupOrLoginScreen.id;
// }
}
