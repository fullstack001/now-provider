import 'package:fare_now_provider/models/available_services/available_service_data.dart';
import 'package:fare_now_provider/util/api_utils.dart';
import 'package:fare_now_provider/util/app_colors.dart';
import 'package:fare_now_provider/util/home_widgets.dart';
import 'package:fare_now_provider/util/widgest_utills.dart';
import 'package:fare_now_provider/widgets/rating_start.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PlumberProfileView extends StatefulWidget {
  final data;
  final hasPayable;

  const PlumberProfileView({Key? key, this.data, this.hasPayable})
      : super(key: key);

  @override
  _PlumberProfileViewState createState() => _PlumberProfileViewState();
}

class _PlumberProfileViewState extends State<PlumberProfileView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.white,
          elevation: 0,
          title: Text(
            "Order Detail",
            style: TextStyle(color: Colors.black, fontSize: 16),
          ),
          leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(
              Icons.arrow_back,
              color: AppColors.blue,
              size: 26,
            ),
          ),
        ),
        body: LayoutBuilder(
          builder: (context, size) {
            return ListView(
              children: [
                Container(
                  padding: EdgeInsets.all(8),
                  child: Card(
                    child: Container(
                      padding: EdgeInsets.all(12),
                      width: size.maxWidth,
                      height: size.maxHeight * 0.148,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          ClipOval(
                            child: (widget.data as AvailableServiceData)
                                        .user
                                        .image ==
                                    null
                                ? Image(
                                    image: AssetImage(
                                      'assets/images/img_profile_place_holder.jpg',
                                    ),
                                    width: 80,
                                  )
                                : cacheNetworkImage(
                                    imageUrl: ApiUtills.imageBaseUrl +
                                        (widget.data as AvailableServiceData)
                                            .user
                                            .image,
                                    imageHeight: 80,
                                    imageWidth: 80,
                                  ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                  "${getUserName((widget.data as AvailableServiceData).user)}",
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: AppColors.black,
                                      fontWeight: FontWeight.bold)),
                              // Text(
                              //   "179 Jobs Completed",
                              //   style: TextStyle(
                              //       fontSize: 12,
                              //       fontWeight: FontWeight.w300),
                              // ),
                              RatingStar(
                                size: 18,
                                color: AppColors.appGreen,
                                rating: double.parse(
                                    ((widget.data as AvailableServiceData)
                                                .user
                                                .rating ??
                                            0)
                                        .toString()),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Order details",
                          style: Theme.of(context).textTheme.headline6,
                        ),
                      ),
                      Container(
                          alignment: Alignment.centerLeft,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Your Order number",
                                style: TextStyle(
                                    fontWeight: FontWeight.w300, fontSize: 16),
                              ),
                              SizedBox(height: 9),
                              Container(
                                color: Colors.blueGrey.shade100,
                                child: Text(
                                  "${widget.data.id}",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w300,
                                      fontSize: 16),
                                ),
                              ),
                            ],
                          )),
                      SizedBox(
                        height: 24,
                      ),
                      Container(
                          alignment: Alignment.centerLeft,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              getRow("Service",
                                  "${(widget.data as AvailableServiceData).subService}",
                                  textAlign: TextAlign.end),
                              SizedBox(
                                height: 12,
                              ),
                              if (widget.data.address != null)
                                getRow("Address",
                                    "${(widget.data as AvailableServiceData).address}",
                                    textAlign: TextAlign.end),
                              SizedBox(
                                height: 12,
                              ),
                              Text(
                                "Questions",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 18),
                              ),
                              SizedBox(
                                height: 12,
                              ),
                              getQuesttions(widget.data),
                              SizedBox(
                                height: 12,
                              ),
                              Text(
                                "Work done time",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 18),
                              ),
                              SizedBox(height: 9),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "${(widget.data as AvailableServiceData).workedHours} hours",
                                    style: TextStyle(
                                        fontWeight: FontWeight.normal,
                                        fontSize: 16),
                                  ),
                                ],
                              )
                            ],
                          )),
                      /*Container(
                              alignment: Alignment.centerLeft,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Payment method",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w300,
                                        fontSize: 16),
                                  ),
                                  Container(
                                      child: ListTile(
                                    leading: Image(
                                      fit: BoxFit.cover,
                                      image: AssetImage(
                                          "assets/image 1.5x/mastercard.png"),
                                    ),
                                    title: Text(
                                      "Mastercard",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w700),
                                    ),
                                    subtitle: Text(
                                      "...........2064",
                                      style: TextStyle(fontSize: 16),
                                    ),
                                  )),
                                  Text(
                                    "Billing",
                                    style:
                                        TextStyle(fontWeight: FontWeight.w300),
                                  ),
                                ],
                              )),*/
                      SizedBox(
                        height: 32,
                      ),
                      getRow(
                          "Request Hours",
                          double.parse(
                                  (widget.data as AvailableServiceData).hours.toString())
                              .toString()),
                      SizedBox(
                        height: 8,
                      ),
                      if (widget.hasPayable)
                        getRow("Extra Hours", getExtraHours(widget.data)),
                      if (widget.hasPayable)
                        SizedBox(
                          height: 8,
                        ),
                      /*    getRow("Rate/Hour", "\$" + getPerHourRate(widget.data)),
                      SizedBox(
                        height: 8,
                      ),
                      getRow(
                          "Paid Amount",
                          "\$" +
                              double.parse((widget.data as AvailableServiceData)
                                      .paidAmount)
                                  .toString()),
                      if (widget.hasPayable)
                        SizedBox(
                          height: 8,
                        ),
                      if (widget.hasPayable)
                        getRow("Payable Amount", getPayableAmount(widget.data)),
                      /*  getRow("Discount", "- Rs 20.16"),
                          getRow("Tax", "Rs 10.16")*/

                      */
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(12),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Grand Total",
                            style: TextStyle(fontWeight: FontWeight.w700),
                          ),
                          Text(
                            getGrandTotal(widget.data),
                            style: TextStyle(
                                color: AppColors.blue,
                                fontWeight: FontWeight.w700),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 12,
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ));
  }

  Row getRow(String title, price, {textAlign}) {
    return Row(
      children: [
        Text(
          title,
          style: TextStyle(fontWeight: FontWeight.w300),
        ),
        SizedBox(
          width: 40,
        ),
        Expanded(
          child: Text(
            price,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontWeight: FontWeight.w700),
            textAlign: textAlign ?? TextAlign.end,
          ),
        ),
      ],
    );
  }

  getPayableAmount(data) {
    AvailableServiceData value = data;
    double hours = double.parse(value.hours);
    double paidAmount = double.parse(value.paidAmount.toString());
    double perHrAmount = paidAmount / hours;
    double extraHours = double.parse(value.workedHours.toString()) - hours;
    double amountTobePaid = extraHours * perHrAmount;

    return "($extraHours * $perHrAmount) \$$amountTobePaid";
  }

  getPerHourRate(data) {
    AvailableServiceData value = data;
    double hours = double.parse(value.hours.toString());
    double paidAmount = double.parse(value.paidAmount.toString());
    double perHrAmount = paidAmount / hours;
    double extraHours = double.parse(value.workedHours.toString()) - hours;
    double amountTobePaid = extraHours * perHrAmount;

    return "$perHrAmount";
  }

  getExtraHours(data) {
    AvailableServiceData value = data;
    double hours = double.parse(value.hours.toString());
    double paidAmount = double.parse(value.paidAmount.toString());
    double perHrAmount = paidAmount / hours;
    double extraHours = double.parse(value.workedHours.toString()) - hours;
    double amountTobePaid = extraHours * perHrAmount;

    return "$extraHours";
  }

  String getGrandTotal(data) {
    AvailableServiceData value = data;
    double hours = double.parse(value.hours.toString());
    double paidAmount = double.parse(value.paidAmount.toString());
    double perHrAmount = paidAmount / hours;
    double extraHours = double.parse(value.workedHours.toString()) - hours;
    double amountTobePaid = extraHours * perHrAmount;
    String amount =
        "($amountTobePaid + $paidAmount) \$${amountTobePaid + paidAmount}";

    if (!widget.hasPayable) {
      amount = "\$$paidAmount";
    }
    return amount;
  }

  getQuesttions(data) {
    AvailableServiceData value = data;
    return Column(
      children: [
        for (int index = 0; index < value.requestInfos.length; index++)
          Column(
            children: [
              if (value.requestInfos[index].question != null &&
                  value.requestInfos[index].option != null)
                getRow(value.requestInfos[index].question.question,
                    value.requestInfos[index].option.option),
              SizedBox(
                height: 12,
              )
            ],
          ),
      ],
    );
  }
}
