import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dotted_dashed_line/dotted_dashed_line.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';
import '../All Screen/GstInformationDialog.dart';
import '../Controller/OrderController.dart';
import '../Controller/PizzaController.dart';

class PaymentHistory extends StatefulWidget {
  const PaymentHistory({super.key});

  @override
  State<PaymentHistory> createState() => _PaymentHistoryState();
}

class _PaymentHistoryState extends State<PaymentHistory> {
  PizzaController pizzaController = Get.find();
  OrderController orderController = Get.find();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (orderController.orderAllDatalist.isEmpty) {
      orderController.getAllUserOrderData();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF4F6FA),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
            setState(() {});
          },
          child: Icon(
            Icons.arrow_back_rounded,
            size: 25,
            color: Colors.black,
          ),
        ),
        title: Text("All Payment",
            style: GoogleFonts.nunito(
                color: Color(0xff293041),
                fontSize: 20,
                fontWeight: FontWeight.w500)),
      ),
      body: Obx(
        () => RefreshIndicator(
          color: Color(0xffEF4F5F),
          onRefresh: () {
            orderController.orderAllDatalist.clear();
            orderController.getAllUserOrderData();
            return Future.delayed(Duration(seconds: 3));
          },
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Column(
              children: [
                SizedBox(
                  height: 15,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        child: Container(
                          height: 1,
                          decoration: BoxDecoration(
                              border: Border.all(
                            color: Color(0xffDAD9DD),
                            width: 1,
                          )),
                        ),
                      ),
                    ),
                    Text(
                      "PAYMENT HISTORY",
                      style: GoogleFonts.nunito(
                          color: Color(0xff7e878d),
                          fontSize: 15.2,
                          fontWeight: FontWeight.w500),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        child: Container(
                          height: 1,
                          decoration: BoxDecoration(
                              border: Border.all(
                            color: Color(0xffDAD9DD),
                            width: 1,
                          )),
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                Expanded(
                  child: ListView.separated(
                    padding: EdgeInsets.only(bottom: 20),
                    itemCount: orderController.orderAllDatalist.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(left: 15, right: 15),
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30)),
                              boxShadow: [
                                BoxShadow(
                                    color: Color(0xffE9E9F7),
                                    blurRadius: 10,
                                    spreadRadius: 4)
                              ]),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 25,
                              ),
                              Row(
                                children: [
                                  Container(
                                    width: 4,
                                    height: 30,
                                    decoration: BoxDecoration(
                                        color: Color(0xffEF4F5F),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(5))),
                                  ),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  Center(
                                    child: Text(
                                      "${orderController.orderAllDatalist[index].date} at ${orderController.orderAllDatalist[index].time}",
                                      style: GoogleFonts.lexend(
                                          color: Color(0xff313848),
                                          fontSize: 19,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              DottedDashedLine(
                                height: 1,
                                width: double.infinity,
                                axis: Axis.horizontal,
                                dashColor: Color(0xffEF4F5F),
                                strokeWidth: 1.2,
                                dashSpace: 0,
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 10, right: 10),
                                child: Obx(
                                  () => Container(
                                    width: double.infinity,
                                    decoration: const BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(20),
                                            topRight: Radius.circular(20))),
                                    child: ListView.separated(
                                      itemCount: orderController
                                          .orderAllDatalist[index]
                                          .datalist!
                                          .length,
                                      physics: NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      scrollDirection: Axis.vertical,
                                      itemBuilder: (context, oindex) {
                                        return Container(
                                          width: double.infinity,
                                          child: Column(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 10, right: 10),
                                                child: Row(
                                                  children: [
                                                    Text(
                                                      "Name:-   ",
                                                      style: GoogleFonts.lexend(
                                                        fontWeight: FontWeight.w400,
                                                        fontSize: 17,
                                                        color: Color(0xff313848),
                                                      ),
                                                    ),
                                                    Obx(
                                                          () => Padding(
                                                        padding:
                                                        const EdgeInsets.only(
                                                            left: 15),
                                                        child: Text(
                                                            "${orderController.orderAllDatalist[index].name}",
                                                            style: GoogleFonts.nunito(
                                                              color:
                                                              Color(0xff7e878d),
                                                              fontSize: 17,
                                                            )),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),

                                              SizedBox(
                                                height: 15,
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 10, right: 10),
                                                child: Row(
                                                  children: [
                                                    Text(
                                                      "Phone:-   ",
                                                      style: GoogleFonts.lexend(
                                                        fontWeight: FontWeight.w400,
                                                        fontSize: 17,
                                                        color: Color(0xff313848),
                                                      ),
                                                    ),
                                                    Obx(
                                                          () => Flexible(
                                                        child: Padding(
                                                          padding:
                                                          const EdgeInsets.only(
                                                              left: 15, top: 10),
                                                          child: Text(
                                                              overflow: TextOverflow
                                                                  .ellipsis,
                                                              maxLines: 4,
                                                              "${orderController.orderAllDatalist[index].phoneNumber} ",
                                                              style:
                                                              GoogleFonts.nunito(
                                                                color:
                                                                Color(0xff7e878d),
                                                                fontSize: 15.5,
                                                              )),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              DottedDashedLine(
                                                  height: 1,
                                                  width: double.infinity,
                                                  axis: Axis.horizontal,
                                                  dashColor: Color(0xffDAD9DD),
                                                  strokeWidth: 1,
                                                  dashSpace: 3),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 10, right: 10),
                                                child: Row(
                                                  children: [
                                                    Text(
                                                      "Subtotal",
                                                      style: GoogleFonts.lexend(
                                                        fontWeight: FontWeight.w500,
                                                        fontSize: 17.5,
                                                        color: Color(0xff313848),
                                                      ),
                                                    ),
                                                    Spacer(),
                                                    Image(
                                                      image: AssetImage(
                                                          "images/rupee.webp"),
                                                      width: 17,
                                                      height: 17,
                                                      color: Color(0xff1F1F1F),
                                                    ),
                                                    Obx(
                                                          () => Text(
                                                          "${orderController.orderAllDatalist[index].subTotal}",
                                                          style: GoogleFonts.lexend(
                                                              color:
                                                              Color(0xff1F1F1F),
                                                              fontSize: 17,
                                                              fontWeight:
                                                              FontWeight.w500)),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 10, right: 10),
                                                child: Row(
                                                  children: [
                                                    Image(
                                                      image: AssetImage(
                                                          "images/bank.webp"),
                                                      width: 20,
                                                      height: 20,
                                                    ),
                                                    SizedBox(
                                                      width: 8,
                                                    ),
                                                    Text(
                                                      "GST",
                                                      style: GoogleFonts.lexend(
                                                        fontWeight: FontWeight.w400,
                                                        fontSize: 16,
                                                        color: Color(0xff313848),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 8,
                                                    ),
                                                    GestureDetector(
                                                      onTap: () {
                                                        showDialog(
                                                          context: context,
                                                          builder: (context) {
                                                            return GstInformationDialog();
                                                          },
                                                        );
                                                      },
                                                      child: Image(
                                                        image: AssetImage(
                                                            "images/information.webp"),
                                                        width: 19,
                                                        height: 19,
                                                      ),
                                                    ),
                                                    Spacer(),
                                                    Padding(
                                                      padding: const EdgeInsets.only(
                                                          bottom: 5),
                                                      child: Row(
                                                        children: [
                                                          Image(
                                                            image: AssetImage(
                                                                "images/rupee.webp"),
                                                            width: 16,
                                                            height: 16,
                                                            color: Color(0xff1F1F1F),
                                                          ),
                                                          Obx(
                                                                () => Text(
                                                                "${orderController.orderAllDatalist[index].gst}",
                                                                style: GoogleFonts.lexend(
                                                                    color: Color(
                                                                        0xff1F1F1F),
                                                                    fontSize: 16,
                                                                    fontWeight:
                                                                    FontWeight
                                                                        .w400)),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              SizedBox(
                                                height: 15,
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 10, right: 10),
                                                child: Row(
                                                  children: [
                                                    Image(
                                                      image: AssetImage(
                                                          "images/scooter1.webp"),
                                                      width: 20,
                                                      height: 20,
                                                    ),
                                                    SizedBox(
                                                      width: 8,
                                                    ),
                                                    Text(
                                                      "Delivery partner fee",
                                                      style: GoogleFonts.lexend(
                                                        fontWeight: FontWeight.w400,
                                                        fontSize: 16,
                                                        color: Color(0xff313848),
                                                      ),
                                                    ),
                                                    Spacer(),
                                                    Padding(
                                                      padding: const EdgeInsets.only(
                                                          bottom: 5),
                                                      child: Row(
                                                        children: [
                                                          Image(
                                                            image: AssetImage(
                                                                "images/rupee.webp"),
                                                            width: 16,
                                                            height: 16,
                                                            color: Color(0xff1F1F1F),
                                                          ),
                                                          Obx(
                                                                () => Text(
                                                                "${orderController.orderAllDatalist[index].deliveryFee}",
                                                                style: GoogleFonts.lexend(
                                                                    color: Color(
                                                                        0xff1F1F1F),
                                                                    fontSize: 16,
                                                                    fontWeight:
                                                                    FontWeight
                                                                        .w400)),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              DottedDashedLine(
                                                height: 1,
                                                width: double.infinity,
                                                axis: Axis.horizontal,
                                                dashColor: Color(0xffDAD9DD),
                                                strokeWidth: 1.2,
                                                dashSpace: 0,
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 10, right: 10),
                                                child: Row(
                                                  children: [
                                                    Text(
                                                      "Grand Total",
                                                      style: GoogleFonts.lexend(
                                                        fontWeight: FontWeight.w400,
                                                        fontSize: 16,
                                                        color: Color(0xff313848),
                                                      ),
                                                    ),
                                                    Spacer(),
                                                    Padding(
                                                      padding: const EdgeInsets.only(
                                                          bottom: 5),
                                                      child: Row(
                                                        children: [
                                                          Image(
                                                            image: AssetImage(
                                                                "images/rupee.webp"),
                                                            width: 16,
                                                            height: 16,
                                                            color: Color(0xff1F1F1F),
                                                          ),
                                                          Obx(
                                                                () => Text(
                                                                "${orderController.orderAllDatalist[index].grandTotal}",
                                                                style: GoogleFonts.lexend(
                                                                    color: Color(
                                                                        0xff1F1F1F),
                                                                    fontSize: 16,
                                                                    fontWeight:
                                                                    FontWeight
                                                                        .w400)),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              SizedBox(
                                                height: 15,
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                      separatorBuilder: (context, index) {
                                        return const SizedBox(
                                          height: 5,
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              ),

                            ],
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return SizedBox(
                        height: 20,
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
