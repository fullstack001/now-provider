import 'package:fare_now_provider/api_service/service_repository.dart';
import 'package:fare_now_provider/models/chat/user_chat_response.dart';
import 'package:fare_now_provider/util/api_utils.dart';
import 'package:fare_now_provider/util/app_dialog_utils.dart';
import 'package:fare_now_provider/util/shared_reference.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

bool outChat = false;

class ChatController extends GetxController {
  ServiceReposiotry _serviceReposiotry = ServiceReposiotry();

  var chatData = UserChatResponse().obs;
  var adminChatData = UserChatResponse().obs;

  void sendMessage({body, onUpdate}) async {
    try {
      String? authToken =
          await SharedRefrence().getString(key: ApiUtills.authToken);
      var response = await _serviceReposiotry.sendMessage(
          authToken: authToken, body: body);
      if (onUpdate != null) {
        onUpdate();
      }
      print("abc");
    } catch (exception) {
      Logger().e(exception);
    }
  }

  void autoMateMessages({flag, id, update}) {
    bool flagList = flag ?? false;
    fetchUserChat(id: id, update: update);
    if (flagList) {
      Future.delayed(Duration(seconds: 30)).then((value) {
        // if (chatData.value.userChatData != null) {
        // if (outChat) {
        autoMateMessages(flag: flagList, id: id, update: update);
        //}
      });
    }
  }

  void fetchUserChat({id, update, page, hid, orderId}) async {
    if (chatData.value.userChatData == null) {
      bool hide = hid ?? false;
      if (!hide) {
        AppDialogUtils.dialogLoading();
      }
    }
    try {
      String? authToken =
          await SharedRefrence().getString(key: ApiUtills.authToken);
      UserChatResponse response = await _serviceReposiotry.getUserChat(
          authToken: authToken, id: id, page: page, orderId: orderId);
      if (!response.error) {
        // response.userChatData.userChatListData =
        //     response.userChatData.userChatListData.reversed.toList();
        chatData(response);
        if (update != null) {
          // update();
        }
        update();
        refresh();
      }
      AppDialogUtils.dismiss();
    } catch (exception) {
      AppDialogUtils.dismiss();
    }
  }

  void adminChat({id, orderId, hid, page, update}) async {
    if (chatData.value.userChatData == null) {
      bool hide = hid ?? false;
      if (!hide) {
        AppDialogUtils.dialogLoading();
      }
    }
    try {
      String? authToken =
          await SharedRefrence().getString(key: ApiUtills.authToken);
      UserChatResponse response = await _serviceReposiotry.getUserChat(
          authToken: authToken,
          id: id,
          page: page,
          orderId: orderId,
          isAdmin: true);
      if (!response.error) {
        // response.userChatData.userChatListData =
        //     response.userChatData.userChatListData.reversed.toList();
        adminChatData(response);
        // response.userChatData.userChatListData.refresh();
        adminChatData.refresh();
        if (update != null) {
          update();
        }
      }
      AppDialogUtils.dismiss();
    } catch (exception) {
      Logger().e(exception);
      AppDialogUtils.dismiss();
    }
  }
}
