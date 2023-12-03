// import 'dart:io';
//
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:device_info_plus/device_info_plus.dart';
// import 'package:get/get.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// class FirebaseHelp {
//   addFcmToken(token) async {
//     var id = await _getId();
//     Map body = <String, dynamic>{
//       "fcm_token": token,
//       "plat_form": GetPlatform.isAndroid ? "android" : "iOS",
//       "device_id": id
//     };
//     final DocumentReference documentReference =
//         FirebaseFirestore.instance.collection('fcm_tokens').doc(id);
//
//     var list = await FirebaseFirestore.instance.collection("fcm_tokens").get();
//     bool flag = false;
//     for (int index = 0; index < list.docs.length; index++) {
//       if (list.docs[index].data()['device_id'] == id) {
//         flag = true;
//         break;
//       }
//     }
//
//     if (!flag) {
//       documentReference.set(body).then((value) async {
//         SharedPreferences sharedPreferences =
//             await SharedPreferences.getInstance();
//         sharedPreferences.setString("fcm_token", token);
//         print("success");
//       }, onError: (e) {
//         print("error");
//       });
//     } else {
//       documentReference.update({
//         "fcm_token": token,
//         "plat_form": GetPlatform.isAndroid ? "android" : "iOS",
//         "device_id": id
//       }).then((value) async {
//         SharedPreferences sharedPreferences =
//             await SharedPreferences.getInstance();
//         sharedPreferences.setString("fcm_token", token);
//         print("success");
//       }, onError: (e) {
//         print("error");
//       });
//     }
//
//     print("device id: $id");
//   }
//
//   Future<String?> _getId() async {
//     var deviceInfo = DeviceInfoPlugin();
//     if (Platform.isIOS) {
//       // import 'dart:io'
//       var iosDeviceInfo = await deviceInfo.iosInfo;
//       return iosDeviceInfo.identifierForVendor; // unique ID on iOS
//     } else if (Platform.isAndroid) {
//       var androidDeviceInfo = await deviceInfo.androidInfo;
//       return androidDeviceInfo.androidId; // unique ID on Android
//     }
//   }
// }
//
// /*
// import 'dart:async';
// import 'dart:convert';
// import 'dart:io';
// import 'package:async/async.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
//
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/src/services/platform_channel.dart';
// import 'package:get/get.dart';
// import 'package:installment_mart/chat/lib/models/convo.dart';
// import 'package:installment_mart/chat/lib/models/user.dart';
// import 'package:installment_mart/chat/lib/services/services/encoding_decoding_service.dart';
// import 'package:installment_mart/service/Fcm_token_model.dart';
// import 'package:intl/intl.dart';
// import 'package:provider/provider.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:http/http.dart' as http;
//
// class Database {
//   static final FirebaseFirestore _db = FirebaseFirestore.instance;
//
//   static Future<void> addUser(User user) async {
//     await _db
//         .collection('users')
//         .doc(user.uid)
//         .set({'id': user.uid, 'name': user.displayName, 'email': user.email});
//   }
//
//   static Stream<List<Users>> streamUsers() {
//     return _db
//         .collection('users')
//         .snapshots()
//         .map((QuerySnapshot list) => list.docs
//             .map((DocumentSnapshot snap) =>
//                 Users.fromMap(snap.data() as Map<String, dynamic>))
//             .toList())
//         .handleError((dynamic e) {
//       print(e);
//     });
//   }
//
//   static Stream<List<Users>> getUsersByList(List userIds) {
//     // final List<Stream<Users>> streams = List();
//     // for (String id in userIds) {
//     //   streams.add(_db
//     //       .collection('users')
//     //       .doc(id)
//     //       .snapshots()
//     //       .map((DocumentSnapshot snap) => Users.fromMap(snap.data())));
//     // }
//
//     return _db.collection('users').snapshots().map((QuerySnapshot list) => list
//         .docs
//         .map((doc) => Users.fromMap(doc.data() as Map<String, dynamic>))
//         .toList());
//   }
//
//   static Stream<List<Convo>> streamConversations(String uid) {
//     var db = _db
//         .collection('messages')
//         .orderBy('lastMessage.timestamp', descending: true)
//         // .where('users', arrayContains: uid)
//         .snapshots()
//         .map((QuerySnapshot list) => list.docs
//             .map((DocumentSnapshot doc) => Convo.fromFireStore(doc))
//             .toList());
//
//     return db;
//   }
//
//   static void sendMessage(String convoID, List groupUsers, String id,
//       String pid, String content, String timestamp, isType,
//       {propid, adTitle}) async {
//     print('----------title-----------');
//     print(adTitle);
//     String encryptedData = EncodingDecodingService.encodeAndEncrypt(
//         content, convoID, 'installmentmart');
//
//     String fcmToken = await getFcmToken(pid) ?? "";
//
//     final DocumentReference convoDoc =
//         FirebaseFirestore.instance.collection('messages').doc(convoID);
//
//     convoDoc.set(<String, dynamic>{
//       'lastMessage': <String, dynamic>{
//         'idFrom': id,
//         'idTo': pid,
//         'timestamp': FieldValue.serverTimestamp(),
//         'content': encryptedData,
//         'read': false,
//         'isType': isType,
//         'propId': propid,
//         'adTitle': adTitle
//       },
//       'users': [id, pid],
//       "fcm_token": [
//         {
//           "id": id,
//           "token": "saflsajfasljf",
//         }
//       ]
//     }).then(
//       (dynamic success) {
//         if (fcmToken.isNotEmpty) {
//           var body = <String, dynamic>{
//             "token": fcmToken,
//             "message": content,
//             "convo_id": convoID,
//             'idFrom': id,
//             'idTo': pid,
//             'timestamp': FieldValue.serverTimestamp(),
//             'content': encryptedData,
//             'read': false,
//             'isType': isType,
//             'propId': propid,
//             'adTitle': adTitle
//           };
//           shootNotification(body);
//         }
//         //     .set(
//         //   <String, dynamic>{
//         //     'idFrom': id,
//         //     'idTo': pid,
//         //     'timestamp': timestamp,
//         //     'content': encryptedData,
//         //     'read': false,
//         //     'isType': isType,
//         //     'isGroup': false,
//         //     'audioDuration': audioDuration.toString() ?? '',
//         //     'imageUrl': imageUrl ?? '',
//         //     'videoUrl': videoUrl ?? ''
//         //   },
//         // );
//       },
//     );
//     final messageDoc = FirebaseFirestore.instance
//         .collection('messages')
//         .doc(convoID)
//         .collection(convoID)
//         .doc();
//
//     FirebaseFirestore.instance.runTransaction((Transaction transaction) async {
//       transaction.set(
//         messageDoc,
//         <String, dynamic>{
//           'idFrom': id,
//           'idTo': pid,
//           'timestamp': FieldValue.serverTimestamp(),
//           'content': encryptedData,
//           'read': false,
//           'isType': isType,
//           'adTitle': adTitle
//         },
//       );
//     });
//   }
//
//   static void updateMessageRead(DocumentSnapshot doc, String convoID) {
//     final DocumentReference documentReference = FirebaseFirestore.instance
//         .collection('messages')
//         .doc(convoID)
//         .collection(convoID)
//         .doc(doc.id);
//
//     documentReference.update(
//       {'read': true},
//     );
//   }
//
//   static void updateLastMessage(
//       DocumentSnapshot doc, String uid, pid, String convoID) {
//     final DocumentReference documentReference =
//         FirebaseFirestore.instance.collection('messages').doc(convoID);
//
//     documentReference
//         .set({
//           'lastMessage': <String, dynamic>{'read': true},
//         }, SetOptions(merge: true))
//         .then((dynamic success) {})
//         .catchError((dynamic error) {
//           print(error);
//         });
//   }
//
//   static void uploadToken(String token, String platform, String userID) async {
//     Map body = <String, dynamic>{
//       "fcm_token": token,
//       "plat_form": platform,
//       "user_id": userID
//     };
//
//     final CollectionReference convoDoc =
//         FirebaseFirestore.instance.collection('fcm_tokens');
//
//     final DocumentReference documentReference =
//         FirebaseFirestore.instance.collection('fcm_tokens').doc(userID);
//
//     var list = await FirebaseFirestore.instance.collection("fcm_tokens").get();
//
//     bool flag = false;
//     for (int index = 0; index < list.docs.length; index++) {
//       if (list.docs[index].data()['user_id'] == userID) {
//         flag = true;
//         break;
//       }
//     }
//
//     if (!flag) {
//       documentReference.set(body).then((value) async {
//         SharedPreferences sharedPreferences =
//             await SharedPreferences.getInstance();
//         sharedPreferences.setString("fcm_token", token);
//         print("success");
//         getFcmList();
//       }, onError: (e) {
//         print("error");
//       });
//     } else {
//       documentReference.update({
//         "fcm_token": token,
//       }).then((value) async {
//         SharedPreferences sharedPreferences =
//             await SharedPreferences.getInstance();
//         sharedPreferences.setString("fcm_token", token);
//         print("success");
//         getFcmList();
//       }, onError: (e) {
//         print("error");
//       });
//     }
//   }
//
//   static void getFcmList() async {
//     final data =
//         await FirebaseFirestore.instance.collection("fcm_tokens").get();
//     print("List");
//
//     data.docs[0].data();
//     List<FcmTokenModel> fcmList = [];
//     for (int index = 0; index < data.docs.length; index++) {
//       FcmTokenModel model = FcmTokenModel.fromJson(data.docs[index].data());
//       fcmList.add(model);
//     }
//
//     if (fcmList.isNotEmpty) {
//       SharedPreferences sharedPreferences =
//           await SharedPreferences.getInstance();
//
//       var listData = fcmList.map((v) => v.toJson()).toList();
//       print("List");
//       var strData = json.encode(listData);
//       sharedPreferences.setString("fcm_token_list", strData);
//     }
//   }
//
//   static void shootNotification(bodyX) async {
//     String serverKey =
//         "key=AAAAawyopwQ:APA91bGUqSkXAvlEaY4KbmaRycZG8GwNnC3OTLIe5V0KBMa0MZW_RiCC_Ex7bwub67zLNq-mOJs6CD8h5aSebgmC71qNG6WTKxnRbnw0kV8YU1pmGcH0aHdlmdBUFjyaPb8lADpwWrJV";
//     Map body = <String, dynamic>{
//       "to": bodyX['token'],
//       "notification": {
//         "title": bodyX['adTitle'],
//         "body": bodyX['message'],
//         "sound": "default"
//       },
//       "data": {
//         "title": bodyX['adTitle'],
//         "body": bodyX['message'],
//         "uid": bodyX["idFrom"],
//         "convo_id": bodyX['convo_id'],
//         "contact": bodyX['idTo'],
//         "prop_id": bodyX['propId'],
//         "ad_title": bodyX['adTitle'],
//         "click_action": "FLUTTER_NOTIFICATION_CLICK"
//       }
//     };
//     print(json.encode(body));
//     try {
//       final response =
//           await GetHttpClient(baseUrl: "https://fcm.googleapis.com/fcm/")
//               .post('send', body: body, headers: {
//         HttpHeaders.authorizationHeader: serverKey,
//       });
//
//       if(response.body==null){
//          shootNotification(bodyX);
//       }
//       print("res");
//     } on Exception catch (e) {
//       print("res");
//     }
//   }
//
//   static getFcmToken(String id) async {
//     SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
//     var data = sharedPreferences.getString("fcm_token_list") ?? "";
//     if (data.isNotEmpty) {
//       var fcmListStr = json.decode(data);
//       List<FcmTokenModel> fcmList = [];
//       for (int index = 0; index < fcmListStr.length; index++) {
//         FcmTokenModel model = FcmTokenModel.fromJson(fcmListStr[index]);
//         if (model.userId == id) {
//           return model.fcmToken;
//         }
//       }
//     }
//     return null;
//   }
// }
//
//  */