import '../part_of_file/part.dart';

class FarenowButtonBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(FarenowButtonsController.new);
  }
}
