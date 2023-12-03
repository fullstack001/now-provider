import 'package:fare_now_provider/screens/auth_screen/zipcode/select_zipcode.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';

class ServicesArea extends StatefulWidget {
  @override
  _ServicesAreaState createState() => _ServicesAreaState();
}

class _ServicesAreaState extends State<ServicesArea> {
  var _check1 = true;
  var _check2 = true;
  var _check3 = false;
  double _slide = 0;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          backgroundColor: Colors.white54,
          appBar: AppBar(
            backgroundColor: Colors.white,
            centerTitle: false,
            iconTheme: IconTheme.of(context).copyWith(color: black),
            elevation: 1,
            title: const Text(
              "Service Area",
              style: TextStyle(color: Colors.black),
            ),
          ),
          body: SelectZipcodeScreen(
            serviceArea: true,
          )
          // TabBarView(
          //   children: [
          //     Container(
          //       child: Column(
          //         children: [
          //           Expanded(
          //               flex: 2,
          //               child: Container(
          //                 color: Colors.red,
          //               )),
          //           Expanded(
          //               flex: 4,
          //               child: Container(
          //                 child: Column(
          //                   children: [
          //                     Expanded(
          //                         flex: 1,
          //                         child: Container(
          //                           padding: EdgeInsets.only(left: 20),
          //                           alignment: Alignment.centerLeft,
          //                           child: Text(
          //                             "Most Trending Areas For Services",
          //                             style: TextStyle(
          //                                 fontWeight: FontWeight.bold,
          //                                 fontSize: 18),
          //                           ),
          //                         )),
          //                     Expanded(
          //                         flex: 2,
          //                         child: Container(
          //                             child: ListTile(
          //                           leading: Checkbox(
          //                             value: _check1,
          //                             onChanged: (val) {
          //                               setState(() {
          //                                 _check1 = val;
          //                               });
          //                             },
          //                           ),
          //                           title: Text("California"),
          //                           subtitle: Text("900 jobs Posted This Week"),
          //                         ))),
          //                     Divider(
          //                       indent: 20,
          //                       endIndent: 20,
          //                       color: Colors.black,
          //                     ),
          //                     Expanded(
          //                         flex: 2,
          //                         child: Container(
          //                             child: ListTile(
          //                           leading: Checkbox(
          //                             value: _check2,
          //                             onChanged: (val) {
          //                               setState(() {
          //                                 _check2 = val;
          //                               });
          //                             },
          //                           ),
          //                           title: Text("California"),
          //                           subtitle: Text("900 jobs Posted This Week"),
          //                         ))),
          //                     Divider(
          //                       indent: 20,
          //                       endIndent: 20,
          //                       color: Colors.black,
          //                     ),
          //                     Expanded(
          //                         flex: 2,
          //                         child: Container(
          //                             child: ListTile(
          //                           leading: Checkbox(
          //                             value: _check3,
          //                             onChanged: (val) {
          //                               setState(() {
          //                                 _check3 = val;
          //                               });
          //                             },
          //                           ),
          //                           title: Text("California"),
          //                           subtitle: Text("900 jobs Posted This Week"),
          //                         ))),
          //                   ],
          //                 ),
          //               )),
          //           Expanded(flex: 1, child: SizedBox()),
          //           Expanded(
          //               flex: 1,
          //               child: Container(
          //                   padding: EdgeInsets.symmetric(vertical: 20),
          //                   width: MediaQuery.of(context).size.width * 0.8,
          //                   child: MaterialButton(
          //                     onPressed: () {},
          //                     color: Colors.green,
          //                     textColor: Colors.white,
          //                     minWidth: MediaQuery.of(context).size.width * 0.8,
          //                     height: 47,
          //                     shape: OutlineInputBorder(
          //                         borderSide: BorderSide.none,
          //                         borderRadius: BorderRadius.circular(8)),
          //                     child: Text(
          //                       "Submit",
          //                       style: TextStyle(fontSize: 16),
          //                     ),
          //                   )))
          //         ],
          //       ),
          //     ),
          //     SingleChildScrollView(
          //       child: Container(
          //         child: Column(
          //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //           children: [
          //             Container(
          //               width: double.infinity,
          //               height: 100,
          //               padding: EdgeInsets.all(12),
          //               child: TextField(
          //                   decoration: InputDecoration(
          //                 disabledBorder: InputBorder.none,
          //                 border: OutlineInputBorder(
          //                     borderRadius: BorderRadius.circular(10),
          //                     borderSide: BorderSide(
          //                         color: Colors.blue,
          //                         width: 2,
          //                         style: BorderStyle.solid)),
          //                 hintText: "New York West Streat Park",
          //                 hintStyle: TextStyle(color: Colors.blue, fontSize: 16),
          //                 prefixIcon: Icon(
          //                   Icons.location_on,
          //                   color: Colors.blue,
          //                   size: 25,
          //                 ),
          //               )),
          //             ),
          //             Padding(
          //               padding: const EdgeInsets.all(20.0),
          //               child: Container(
          //                 width: double.infinity,
          //                 height: MediaQuery.of(context).size.width * 0.7,
          //                 decoration: BoxDecoration(
          //                     color: Colors.grey.shade200,
          //                     shape: BoxShape.circle),
          //               ),
          //             ),
          //             SizedBox(
          //               height: 10,
          //             ),
          //             Container(
          //               height: 100,
          //               child: Column(
          //                 children: [
          //                   Text(
          //                     "New York",
          //                     style: TextStyle(
          //                         color: Colors.black,
          //                         fontWeight: FontWeight.bold,
          //                         fontSize: 16),
          //                   ),
          //                   Text(
          //                     "Covering 120km in this  Area",
          //                     style: TextStyle(fontSize: 16, color: Colors.green),
          //                   )
          //                 ],
          //               ),
          //             ),
          //             Container(
          //               child: Slider(
          //                 min: 0,
          //                 max: 100,
          //                 value: _slide,
          //                 onChanged: (val) {
          //                   setState(() {
          //                     _slide = val;
          //                   });
          //                 },
          //               ),
          //             ),
          //             SizedBox(
          //               height: 10,
          //             ),
          //             Container(
          //                 padding:
          //                     EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          //                 width: MediaQuery.of(context).size.width * 0.8,
          //                 child: MaterialButton(
          //                   onPressed: () {},
          //                   color: Colors.green,
          //                   textColor: Colors.white,
          //                   minWidth: MediaQuery.of(context).size.width * 0.8,
          //                   height: 47,
          //                   shape: OutlineInputBorder(
          //                       borderSide: BorderSide.none,
          //                       borderRadius: BorderRadius.circular(8)),
          //                   child: Text(
          //                     "Submit",
          //                     style: TextStyle(fontSize: 16),
          //                   ),
          //                 ))
          //           ],
          //         ),
          //       ),
          //     )
          //   ],
          // ),
          ),
    );
  }
}
