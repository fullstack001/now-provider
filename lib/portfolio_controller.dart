import 'dart:io';

import 'package:fare_now_provider/api_service/service_repository.dart';
import 'package:fare_now_provider/models/prortfolio/portfio_data.dart';
import 'package:fare_now_provider/util/app_dialog_utils.dart';
import 'package:get/get.dart';

import 'screens/provider_portfolio_screen.dart';
import 'util/api_utils.dart';

class PortfolioController extends GetxController {
  var images = [].obs;
  ServiceReposiotry _reposiotry = ServiceReposiotry();
  var networkList = [].obs;
  var description = "".obs;
  var objectId = 0.obs;
  var currentIndex = 0.obs;
  var image = File("").obs;

  postPortfolio({List<PortfioData>? imagesLists, desc}) async {
    AppDialogUtils.dialogLoading();
    List imagesList = [];
    Map body = <String, dynamic>{};
    for (int index = 0; index < imagesLists!.length; index++) {
      var multiPart = await getMultiPart(imagesLists[index].image);
      imagesList.add(multiPart);
      body["description_$index"] = imagesLists[index].description;
      body["images_$index"] = multiPart;
      body["title_$index"] = imagesLists[index].title;
    }
    body["length"] = imagesLists.length;
    var formData = getFormData(body);
    print("the form data iss$formData");
    _reposiotry.postPortfolio(body: formData).then((value) {
      print("$value");
      if (value.message == "Portfolios retrieved successfully.") {
        print("body insidepost portfolio$body");
        networkList(value.portfioData);
        networkList.refresh();
        images.clear();
        images(networkList.value);
        images.refresh();
      }
      Future.delayed(Duration(seconds: 3)).then((value) {
        AppDialogUtils.dismiss();
      });
    }, onError: (ex) {
      AppDialogUtils.dismiss();
      print("$ex");
    });
  }

  void getPortfolio() {
    AppDialogUtils.dialogLoading();
    _reposiotry.getPortfolio().then((value) {
      if (value.message != "No Portfolio Found") {
        print("$value");
        images.clear();
        images(value.portfioData);
        images.refresh();
      }

      Future.delayed(Duration(seconds: 3)).then((value) {
        AppDialogUtils.dismiss();
        var list = images.value;
        Get.to(() => ProviderPortfolioScreen(list: list));
      });
    }, onError: (ex) {
      AppDialogUtils.dismiss();
      print("$ex");
    });
  }

  void deleteImagePort(id, index) async {
    AppDialogUtils.dialogLoading();
    Map body = <String, dynamic>{
      "images": [id]
    };
    _reposiotry.deleteImagePort(id).then((value) {
      if (value == "Images deleted successfully") {
        images.removeAt(index);
        images.refresh();
      }

      Future.delayed(Duration(seconds: 2)).then((value) {
        AppDialogUtils.dismiss();
      });
    }, onError: (ex) {
      AppDialogUtils.dismiss();
      print("$ex");
    });
  }

  void updatePortfolio(
      {List<PortfioData>? imagesLists, String? desc, id}) async {
    AppDialogUtils.dialogLoading();
    List imagesList = [];

    Map body = <String, dynamic>{};

    for (int index = 0; index < imagesLists!.length; index++) {
      var multiPart = await getMultiPart(imagesLists[index].image);
      imagesList.add(multiPart);
      body["description_$index"] = imagesLists[index].description;
      body["images_$index"] = multiPart;
    }
    body["_method"] = "patch";
    var formData = getFormData(body);
    _reposiotry.updatePortfolio(body: formData, id: id).then((value) {
      print("$value");
      if (value.message == "Portfolio retrieved successfully.") {
        networkList(value.portfioData);
        networkList.refresh();
        images.clear();
        images(networkList.value);
        images.refresh();
      }
      Future.delayed(Duration(seconds: 2)).then((value) {
        AppDialogUtils.dismiss();
      });
    }, onError: (ex) {
      AppDialogUtils.dismiss();
      print("$ex");
    });
  }
}
