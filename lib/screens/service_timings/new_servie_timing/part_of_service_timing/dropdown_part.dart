
import 'package:fare_now_provider/components/buttons-management/part_of_file/part.dart';
import 'package:fare_now_provider/screens/service_timings/controller/service_timing_controller.dart';





class DropDownOFServiceTiming extends StatelessWidget {
  final List<String> items = [
    'Item1',
    'Item2',
    'Item3',
    'Item4',
    'Item5',
    'Item6',
    'Item7',
    'Item8',
  ];
  String? selectedValue;
  String flag;
  DropDownOFServiceTiming({required this.flag});
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ServiceTimingController>(
        init: ServiceTimingController(),
        builder: (controller) {
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
                color: Color(0xffE0E0E0),
                borderRadius: BorderRadius.circular(14)
            ),


            child: DropdownButton<String>(
              isExpanded: true,

              items:  controller.items.map((e) => DropdownMenuItem<String>(
                  value: e,
                  child: Text(e)
              )).toList(),
              hint: Text("Select Day"),
              alignment: Alignment.center,

              borderRadius: BorderRadius.circular(14),
              underline: SizedBox(),


              value: flag == "start"
                  ? controller.selectedStartDate
                  : controller.selectedEndDate,
              onChanged: (value) {
                controller.setSelectedDay(flag, value!);
              },
            ),
          );

          //   CustomDropDownButton2(
          //   icon: Container(),
          //   hintAlignment: Alignment.center,
          //   // buttonElevation: 1,
          //   buttonHeight: 47,
          //   // dropdownElevation: 1,
          //   buttonDecoration: BoxDecoration(
          //       color: Color(0xffE0E0E0),
          //       borderRadius: BorderRadius.circular(14)),
          //   hint: "Select Day",
          //
          //   dropdownDecoration:
          //   BoxDecoration(borderRadius: BorderRadius.circular(10)),
          //   dropdownItems: controller.items,
          //   value: flag == "start"
          //       ? controller.selectedStartDate
          //       : controller.selectedEndDate,
          //
          //   valueAlignment: Alignment.center,
          //   onChanged: (value) {
          //     controller.setSelectedDay(flag, value!);
          //   },
          // );


        });
  }
}