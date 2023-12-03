import 'package:fare_now_provider/components/buttons-management/part_of_file/part.dart';
import 'package:fare_now_provider/paymentmethodscontroller.dart';
import 'package:fare_now_provider/paymentmethodsmodel.dart';
import 'package:fare_now_provider/util/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'controllers/profile_screen_controller/ProfileScreenController.dart';

class PaymentMethodsScreen extends StatefulWidget {
  PaymentMethodsScreen({Key? key}) : super(key: key);

  @override
  State<PaymentMethodsScreen> createState() => _PaymentMethodsScreenState();
}

class _PaymentMethodsScreenState extends State<PaymentMethodsScreen> {
  final profileController = Get.find<ProfileScreenController>();

  static Set active = {};

  void _handleTap(index, controller) {
    if (active.contains(controller.paymentMethods.single.data![index].id)) {
      active.remove(controller.paymentMethods.single.data![index].id);
    } else {
      active.add(controller.paymentMethods.single.data![index].id);
    }

    setState(() {
      // active.add(controller.paymentMethods.single.data![index].id);
      // active.contains(index) ? active.remove(index) : active.add(index);
      // active.contains(controller.paymentMethods.single.data![index].id) ? active.remove(controller.paymentMethods.single.data![index].id) : active.add(controller.paymentMethods.single.data![index].id);
    });
  }

  // static List selected=[];
  //   bool isContained(len,val){
  //    for(int i=0;i<len;i++){
  //      if(selected.contains(val))
  //
  //      return true;
  //    }
  //    return false;
  //   }
  @override
  Widget build(BuildContext context) {
    // print(profileController.userData.value.paymentMethods);
    return Scaffold(
      backgroundColor: Colors.white70,
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconTheme.of(context).copyWith(color: Colors.black),
        elevation: 1,
        title: const Text(
          "Payment Methods",
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          GestureDetector(
            onTap: () {
              Get.back();
            },
            child: const Center(
              child: Padding(
                padding: EdgeInsets.only(right: 15),
                child: Text(
                  "Save",
                  style: TextStyle(
                      color: AppColors.solidBlue,
                      fontWeight: FontWeight.w500,
                      fontSize: 16),
                ),
              ),
            ),
          )
        ],
      ),
      body: GetBuilder<PMController>(
          init: PMController(),
          builder: (controller) {
            return controller.paymentMethods.isNotEmpty
                ? Padding(
              padding:
              const EdgeInsets.symmetric(horizontal: 0, vertical: 18),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24),
                      child: Text(
                        "Payment methods Accepted",
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 20,
                            color: Color(0xff151415)),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ListView.builder(
                        shrinkWrap: true,
                        physics: const ScrollPhysics(),
                        itemCount:
                        controller.paymentMethods.single.data!.length,
                        itemBuilder: (context, index) {
                          Datum _data = controller
                              .paymentMethods.single.data![index];
                          return Column(
                            children: [
                              ListTile(
                                contentPadding:
                                const EdgeInsets.symmetric(
                                    horizontal: 24),
                                title: Text(
                                  controller.paymentMethods.single
                                      .data![index].name,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16,
                                      color: Color(0xff555555)),
                                ),
                                trailing: CupertinoSwitch(
                                  activeColor: AppColors.solidBlue,
                                  onChanged: (valueFlag) async {
                                    print(active);
                                    _handleTap(index, controller);
                                    Map<String, dynamic> _body = {
                                      "payment_method_id": _data.id
                                    };

                                    print("check: $_body");
                                    print(
                                        "check2: ${controller.paymentMethods.single.data![index].id}");
                                    controller.addOrRemovePaymentMethods(
                                        _body, updateStatus: () async {
                                      await profileController
                                          .getProfile();
                                      setState(() {});
                                    });
                                  },
                                  value: checkActiveStatus(_data.id)
                                      ? true
                                      : false,
                                ),
                              ),
                              Divider(
                                thickness: 1,
                              )
                            ],
                          );
                        })
                  ],
                ),
              ),
            )
                : Container();
          }),
    );
  }

  checkActiveStatus(id) {
    if (profileController.userData.value.paymentMethods.isNotEmpty) {
      for (var i = 0;
      i < profileController.userData.value.paymentMethods.length;
      i++) {
        if (profileController.userData.value.paymentMethods[i].id == id) {
          return true;
        }
      }
    }
    return false;
  }
}
