import 'dart:convert';
import 'package:Pizza/All%20Screen/GstInformationDialog.dart';
import 'package:Pizza/Controller/OrderController.dart';
import 'package:Pizza/ModelClass/FoodItemModel.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dotted_dashed_line/dotted_dashed_line.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:Pizza/Controller/PizzaController.dart';
import 'package:shimmer/shimmer.dart';

class YourOrderScreen extends StatefulWidget {
  const YourOrderScreen({super.key});

  @override
  State<YourOrderScreen> createState() => _YourOrderScreenState();
}

class _YourOrderScreenState extends State<YourOrderScreen> {
  PizzaController pizzaController = Get.find();
  OrderController orderController = Get.find();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (orderController.orderDatalist.isEmpty) {
      orderController.getUserOrderData();
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
              Navigator.pop(
                context,
              );
              setState(() {});
            },
            child: Icon(
              Icons.arrow_back_rounded,
              size: 25,
              color: Colors.black,
            ),
          ),
          title: Text("Your Order",
              style: GoogleFonts.nunito(
                  color: Color(0xff293041),
                  fontSize: 20,
                  fontWeight: FontWeight.w500)),
        ),
        body: Obx(
          () => RefreshIndicator(
            color: Color(0xffEF4F5F),
            onRefresh: () {
              orderController.orderDatalist.clear();
              orderController.getUserOrderData();
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
                        "ORDER HISTORY",
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
                      itemCount: orderController.orderDatalist.length,
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
                                        "${orderController.orderDatalist[index].date} at ${orderController.orderDatalist[index].time}",
                                        style: GoogleFonts.lexend(
                                            color: Color(0xff313848),
                                            fontSize: 19,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                    Spacer(),
                                    Padding(
                                      padding: const EdgeInsets.only(right: 10),
                                      child: Image(
                                        image:
                                            AssetImage("images/fill_like.webp"),
                                        width: 29,
                                        height: 29,
                                        fit: BoxFit.cover,
                                      ),
                                    )
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
                                  padding: const EdgeInsets.only(
                                      left: 10, right: 10),
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
                                            .orderDatalist[index]
                                            .datalist!
                                            .length,
                                        physics: NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        scrollDirection: Axis.vertical,
                                        itemBuilder: (context, oindex) {
                                          return Container(
                                            width: double.infinity,
                                            height: 80,
                                            child: Column(
                                              children: [
                                                Row(
                                                  children: [
                                                    ClipRRect(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    15)),
                                                        child: orderController
                                                                    .orderDatalist[
                                                                        index]
                                                                    .datalist![
                                                                        oindex]
                                                                    .image !=
                                                                null
                                                            ? CachedNetworkImage(
                                                                imageUrl:
                                                                    "${orderController.orderDatalist[index].datalist![oindex].image}",
                                                                placeholder: (context, url) => Shimmer
                                                                    .fromColors(
                                                                        direction: ShimmerDirection
                                                                            .ltr,
                                                                        enabled:
                                                                            true,
                                                                        baseColor: Colors
                                                                            .grey
                                                                            .shade300,
                                                                        highlightColor: Colors.grey.shade100,
                                                                        child: Container(
                                                                          color:
                                                                              Colors.grey,
                                                                        )),
                                                                width: 70,
                                                                height: 70,
                                                                fit: BoxFit.cover)
                                                            : Image(
                                                                image: MemoryImage(
                                                                    base64Decode(
                                                                        "${orderController.orderDatalist[index].datalist![oindex].base64}")),
                                                                width: 70,
                                                                height: 70,
                                                                fit: BoxFit
                                                                    .cover,
                                                              )),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 10,
                                                              right: 10),
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          Container(
                                                            width: 145,
                                                            child: orderController
                                                                        .orderDatalist[
                                                                            index]
                                                                        .datalist![
                                                                            oindex]
                                                                        .name !=
                                                                    null
                                                                ? Text(
                                                                    "${orderController.orderDatalist[index].datalist![oindex].name}",
                                                                    maxLines: 1,
                                                                    style: GoogleFonts
                                                                        .nunito(
                                                                      color: Color(
                                                                          0xff373D4D),
                                                                      fontSize:
                                                                          15,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w700,
                                                                    ),
                                                                    overflow:
                                                                        TextOverflow
                                                                            .ellipsis,
                                                                  )
                                                                : Text(
                                                                    "Customize Pizza",
                                                                    maxLines: 1,
                                                                    style: GoogleFonts
                                                                        .nunito(
                                                                      color: Color(
                                                                          0xff373D4D),
                                                                      fontSize:
                                                                          15,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w700,
                                                                    ),
                                                                    overflow:
                                                                        TextOverflow
                                                                            .ellipsis,
                                                                  ),
                                                          ),
                                                          Text("4.3 ratings",
                                                              style: GoogleFonts.nunito(
                                                                  color: Color(
                                                                      0xff535B6D),
                                                                  fontSize: 13,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500)),
                                                          Row(
                                                            children: [
                                                              Image(
                                                                image: AssetImage(
                                                                    "images/rupee.webp"),
                                                                width: 13,
                                                                height: 13,
                                                                color: Color(
                                                                    0xff1F1F1F),
                                                              ),
                                                              orderController
                                                                          .orderDatalist[
                                                                              index]
                                                                          .datalist![
                                                                              oindex]
                                                                          .price !=
                                                                      null
                                                                  ? Text(
                                                                      "${orderController.orderDatalist[index].datalist![oindex].price}",
                                                                      style: GoogleFonts.nunito(
                                                                          color: Color(
                                                                              0xff1F1F1F),
                                                                          fontSize:
                                                                              13,
                                                                          fontWeight: FontWeight
                                                                              .w500))
                                                                  : Text(
                                                                      "${orderController.orderDatalist[index].datalist![oindex].customPizzametaPrice}",
                                                                      style: GoogleFonts.nunito(
                                                                          color: Color(
                                                                              0xff1F1F1F),
                                                                          fontSize:
                                                                              13,
                                                                          fontWeight:
                                                                              FontWeight.w500)),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Spacer(),
                                                    Obx(
                                                      () => Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          Container(
                                                            width: 75,
                                                            height: 30,
                                                            decoration:
                                                                BoxDecoration(
                                                              color: Color(
                                                                  0xffFFF6F7),
                                                              boxShadow: [
                                                                BoxShadow(
                                                                    color: Color(
                                                                        0xffdedede),
                                                                    blurRadius:
                                                                        5,
                                                                    blurStyle:
                                                                        BlurStyle
                                                                            .outer)
                                                              ],
                                                              border: Border.all(
                                                                  color: Color(
                                                                      0xffEF4F5F)),
                                                              borderRadius: BorderRadius
                                                                  .all(Radius
                                                                      .circular(
                                                                          10)),
                                                            ),
                                                            child: Center(
                                                              child: orderController
                                                                          .orderDatalist[
                                                                              index]
                                                                          .datalist![
                                                                              oindex]
                                                                          .selectitem !=
                                                                      null
                                                                  ? Text(
                                                                      "${orderController.orderDatalist[index].datalist![oindex].selectitem}",
                                                                      style: GoogleFonts.nunito(
                                                                          color: Colors
                                                                              .black,
                                                                          fontSize:
                                                                              16,
                                                                          fontWeight: FontWeight
                                                                              .w500))
                                                                  : Text(
                                                                      "${orderController.orderDatalist[index].datalist![oindex].customPizzametaSelectitem}",
                                                                      style: GoogleFonts.nunito(
                                                                          color: Colors
                                                                              .black,
                                                                          fontSize:
                                                                              16,
                                                                          fontWeight:
                                                                              FontWeight.w500)),
                                                            ),
                                                          ),
                                                          Row(
                                                            children: [
                                                              Image(
                                                                image: AssetImage(
                                                                    "images/rupee.webp"),
                                                                width: 15,
                                                                height: 15,
                                                                color: Color(
                                                                    0xff1F1F1F),
                                                              ),
                                                              Obx(
                                                                () => orderController
                                                                            .orderDatalist[
                                                                                index]
                                                                            .datalist![
                                                                                oindex]
                                                                            .foodbill !=
                                                                        null
                                                                    ? Text(
                                                                        "${orderController.orderDatalist[index].datalist![oindex].foodbill}",
                                                                        style: GoogleFonts.nunito(
                                                                            color: Color(
                                                                                0xff1F1F1F),
                                                                            fontSize:
                                                                                15,
                                                                            fontWeight: FontWeight
                                                                                .w500))
                                                                    : Text(
                                                                        "${orderController.orderDatalist[index].datalist![oindex].customPizzametaBill}",
                                                                        style: GoogleFonts.nunito(
                                                                            color: Color(
                                                                                0xff1F1F1F),
                                                                            fontSize:
                                                                                15,
                                                                            fontWeight:
                                                                                FontWeight.w500)),
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          );
                                        },
                                        separatorBuilder: (context, index) {
                                          return SizedBox(
                                            height: 5,
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        orderController.orderDatalist[index]
                                                .viewDetail =
                                            !orderController
                                                .orderDatalist[index]
                                                .viewDetail;
                                      });
                                    },
                                    child: orderController
                                            .orderDatalist[index].viewDetail
                                        ? Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              Text(
                                                "Hide Details",
                                                style: GoogleFonts.nunito(
                                                    fontSize: 16,
                                                    color: Color(0xff737b81),
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                              Icon(
                                                Icons.arrow_drop_up_rounded,
                                                size: 25,
                                                color: Color(0xff737b81),
                                              )
                                            ],
                                          )
                                        : Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              Text(
                                                "View Details",
                                                style: GoogleFonts.nunito(
                                                    fontSize: 16,
                                                    color: Color(0xff737b81),
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                              Icon(
                                                Icons.arrow_drop_down_rounded,
                                                size: 25,
                                                color: Color(0xff737b81),
                                              )
                                            ],
                                          )),
                                SizedBox(
                                  height: orderController
                                          .orderDatalist[index].viewDetail
                                      ? 10
                                      : 0,
                                ),
                                orderController.orderDatalist[index].viewDetail
                                    ? Column(
                                        children: [
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
                                                      "${orderController.orderDatalist[index].subTotal}",
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
                                                  padding:
                                                      const EdgeInsets.only(
                                                          bottom: 5),
                                                  child: Row(
                                                    children: [
                                                      Image(
                                                        image: AssetImage(
                                                            "images/rupee.webp"),
                                                        width: 16,
                                                        height: 16,
                                                        color:
                                                            Color(0xff1F1F1F),
                                                      ),
                                                      Obx(
                                                        () => Text(
                                                            "${orderController.orderDatalist[index].gst}",
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
                                                  padding:
                                                      const EdgeInsets.only(
                                                          bottom: 5),
                                                  child: Row(
                                                    children: [
                                                      Image(
                                                        image: AssetImage(
                                                            "images/rupee.webp"),
                                                        width: 16,
                                                        height: 16,
                                                        color:
                                                            Color(0xff1F1F1F),
                                                      ),
                                                      Obx(
                                                        () => Text(
                                                            "${orderController.orderDatalist[index].deliveryFee}",
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
                                                  padding:
                                                      const EdgeInsets.only(
                                                          bottom: 5),
                                                  child: Row(
                                                    children: [
                                                      Image(
                                                        image: AssetImage(
                                                            "images/rupee.webp"),
                                                        width: 16,
                                                        height: 16,
                                                        color:
                                                            Color(0xff1F1F1F),
                                                      ),
                                                      Obx(
                                                        () => Text(
                                                            "${orderController.orderDatalist[index].grandTotal}",
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
                                      )
                                    : Container(),
                                SizedBox(
                                  height: orderController
                                          .orderDatalist[index].viewDetail
                                      ? 0
                                      : 20,
                                ),
                                ElevatedButton(
                                    style: ButtonStyle(
                                        minimumSize: MaterialStateProperty.all(
                                            Size(double.infinity, 50)),
                                        shape: MaterialStateProperty.all(
                                            RoundedRectangleBorder(
                                                borderRadius: BorderRadius.only(
                                                    bottomRight:
                                                        Radius.circular(25),
                                                    bottomLeft:
                                                        Radius.circular(25)))),
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                Color(0xffEF505F))),
                                    onPressed: () {
                                     //for (int i = 0; i < orderController.orderDatalist.length; i++) {
                                        for (int j = 0; j < orderController.orderDatalist[index].datalist!.length; j++) {
                                          pizzaController.pizzabottomlist.add(
                                              FoodItemModel(
                                                  id: "${orderController.orderDatalist[index].datalist![j].id}",
                                                  food: "${orderController.orderDatalist[index].datalist![j].food}",
                                                  price: orderController.orderDatalist[index].datalist![j].price!,
                                                  checkadd: orderController.orderDatalist[index].datalist![j].checkadd!,
                                                  selectitem: orderController.orderDatalist[index].datalist![j].selectitem!,
                                                  foodbill:  orderController.orderDatalist[index].datalist![j].foodbill!,
                                                  foodtotal:orderController.orderDatalist[index].datalist![j].foodtotal!,
                                              image: orderController.orderDatalist[index].datalist![j].image!,
                                              name: orderController.orderDatalist[index].datalist![j].name!,
                                              rating: orderController.orderDatalist[index].datalist![j].rating! ));
                                        }
                                    //  }
                                    },
                                    child: Text(
                                      "Reorder Now",
                                      style: TextStyle(
                                          fontSize: 16, color: Colors.white),
                                    )),
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
        ));
  }
}
