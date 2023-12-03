import 'package:fare_now_provider/models/available_services/quotation_info.dart';
import 'package:fare_now_provider/screens/Controller/HomeScreenController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RespondDialog extends StatefulWidget {
  final body;
  final quotationInfo;
  final response;

  RespondDialog({Key? key, this.body, this.quotationInfo, this.response})
      : super(key: key);

  @override
  _RespondDialogState createState() => _RespondDialogState();
}

class _RespondDialogState extends State<RespondDialog> {
  String selected = "1 Hour";
  var descriptionNameController = TextEditingController();
  var priceController = TextEditingController();
  final _formKey = new GlobalKey<FormState>();
  HomeScreenController _screenController = Get.find();

  @override
  Widget build(BuildContext context) {
    var id = widget.body.id;

    if (widget.quotationInfo != null) {
      QuotationInfo info = widget.quotationInfo;

      selected = info.duration;
      descriptionNameController.text = info.reply;
      priceController.text = "\$${info.price}";
    }
    return Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.all(32),
              width: Get.width,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(12))),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(12),
                    width: Get.width,
                    child: Text(
                      "Service Quotation",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Divider(),
                  Container(
                    padding: EdgeInsets.all(12),
                    width: Get.width,
                    child: Row(
                      children: [
                        SizedBox(
                          width: 12,
                        ),
                        Text(
                          "Price",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        Expanded(
                            child: SizedBox(
                          width: 10,
                        )),
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8))),
                          width: 80,
                          child: TextFormField(
                            controller: priceController,
                            onChanged: (val) {
                              priceController.text = val;
                              val.replaceAll("\$", "");
                              String values =
                                  priceController.text.replaceAll("\$", "");
                              priceController.text = "\$$values";
                              priceController.selection = TextSelection(
                                  baseOffset: priceController.text.length,
                                  extentOffset: priceController.text.length);

                              if (widget.quotationInfo != null) {
                                widget.quotationInfo.price = values;
                              }
                            },
                            validator: (val) {
                              if (val!.isEmpty || val == "\$") {
                                return "Field required";
                              }
                              return null;
                            },
                            textAlign: TextAlign.center,
                            keyboardType: TextInputType.number,
                            style: TextStyle(color: Colors.black),
                            decoration: InputDecoration(
                              isDense: true,
                              border: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              errorBorder: InputBorder.none,
                              disabledBorder: InputBorder.none,
                              hintText: "\$00",
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(12),
                    width: Get.width,
                    child: Row(
                      children: [
                        SizedBox(
                          width: 12,
                        ),
                        Text(
                          "Duration",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        Expanded(
                            child: SizedBox(
                          width: 10,
                        )),
                        Container(
                          height: 30,
                          decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8))),
                          child: DropdownButton<String>(
                            hint: Text("Select item"),
                            underline: Container(),
                            value: selected,
                            onChanged: ( value) {
                              setState(() {
                                selected = value!;
                                if (widget.quotationInfo != null) {
                                  (widget.quotationInfo as QuotationInfo)
                                      .duration = value;
                                }
                              });
                            },
                            items: [
                              "1 Hour",
                              "2 Hour",
                              "3 Hour",
                              "4 Hour",
                              "5 Hour",
                              "6 Hour",
                              "7 Hour",
                              "8 Hour",
                              "9 Hour",
                              "10 Hour",
                            ].map((String user) {
                              return DropdownMenuItem<String>(
                                value: user,
                                child: Row(
                                  children: <Widget>[
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      user,
                                      style: TextStyle(color: Colors.black),
                                    ),
                                  ],
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                      margin: EdgeInsets.only(left: 24),
                      child: Text(
                        "Detail",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                        ),
                      )),
                  Container(
                    margin: EdgeInsets.only(
                        top: 12, left: 24, right: 24, bottom: 24),
                    width: Get.width,
                    height: 150,
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.all(
                        Radius.circular(12),
                      ),
                    ),
                    child: TextFormField(
                      controller: descriptionNameController,
                      maxLines: 10,
                      onChanged: (val) {
                        print(val);
                        if (widget.quotationInfo != null) {
                          (widget.quotationInfo as QuotationInfo).detail = val;
                        }
                      },
                      validator: (val) {
                        if (val!.isEmpty) {
                          return "Field required";
                        }
                        return null;
                      },
                      keyboardType: TextInputType.multiline,
                      decoration: InputDecoration(
                          border:
                              OutlineInputBorder(borderSide: BorderSide.none),
                          filled: true,
                          hintText: "Enter work detail",
                          hintStyle: TextStyle(
                            fontSize: 16,
                          ),
                          contentPadding: EdgeInsets.all(8)),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                        left: 12, right: 12, bottom: 12, top: 12),
                    width: Get.width,
                    decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.all(Radius.circular(12))),
                    child: MaterialButton(
                      onPressed: () {
                        if (!_formKey.currentState!.validate()) {
                          return;
                        }

                        Map body = <String, String>{
                          "reply": "${descriptionNameController.text}",
                          "duration": "$selected",
                          "price":
                              "${priceController.text.replaceAll("\$", "")}"
                        };

                        _screenController.setQuotation(
                            id: id,
                            body: body,
                            update: (value) {
                              if (widget.response != null) {
                                widget.response(value);
                              }
                              Get.back();
                            });
                      },
                      child: Text(
                        "Submit",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
