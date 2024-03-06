import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotted_dashed_line/dotted_dashed_line.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:shimmer/shimmer.dart';
import '../All Screen/GstInformationDialog.dart';
import '../Controller/LoginController.dart';
import '../Controller/OrderController.dart';
import '../Controller/PizzaController.dart';

class TrackingOrder extends StatefulWidget {
  const TrackingOrder({super.key});

  @override
  State<TrackingOrder> createState() => _TrackingOrderState();
}

class _TrackingOrderState extends State<TrackingOrder> {
  PizzaController pizzaController = Get.find();
  OrderController orderController = Get.find();
  LoginController loginController = Get.find();

 @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loginController.Getuid();
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
      body: StreamBuilder<QuerySnapshot>(
        stream:
            FirebaseFirestore.instance.collection('trackingOrder').where("uid",isEqualTo: loginController.userid).snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasError) {

            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(
              child: Text('No orders found.'),
            );
          }

          return Container(
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
                      "TRACKING ORDER",
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
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      var order = snapshot.data!.docs[index];
                      var orderData = order['orderData'];

                      return Padding(
                        padding: const EdgeInsets.only(left: 15, right: 15),
                        child: order['cooking']
                            ? Container(
                                width: double.infinity,
                                height: 180,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(20)),
                                 image: DecorationImage(image: AssetImage("images/FoodCooking.webp"),fit: BoxFit.fill,)
                                ),
                              )
                            : Container(
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
                                              color: loginController.getColor(
                                                  order['pending'], order['processing'],order['deliver'] ),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(5))),
                                        ),
                                        SizedBox(
                                          width: 15,
                                        ),
                                        ClipRRect(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(60)),
                                          child: Container(
                                              width: 50,
                                              height: 50,
                                              decoration: BoxDecoration(
                                                color: Color(0xffE9E9F7),
                                                shape: BoxShape.circle,
                                              ),
                                              child: CachedNetworkImage(
                                                  imageUrl:
                                                  "${order['userImage']}",
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
                                                  fit: BoxFit.cover)),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "${order['userName']}",
                                              style: GoogleFonts.lexend(
                                                color: Color(0xff313848),
                                                fontSize: 18,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            Text(
                                              "${order['userPhoneNumber']}",
                                              style: GoogleFonts.lexend(
                                                color: Color(0xff313848),
                                                fontSize: 14.5,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            Text(
                                              "Delivery partner will call this number",
                                              style: GoogleFonts.lexend(
                                                color: Color(0xff909199),
                                                fontSize: 11,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Spacer(),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    DottedDashedLine(
                                      height: 1,
                                      width: double.infinity,
                                      axis: Axis.horizontal,
                                      dashColor: loginController.getColor(
                                          order['pending'], order['processing'],order['deliver'] ),
                                      strokeWidth: 1.2,
                                      dashSpace: 0,
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 10, right: 10),
                                      child: Container(
                                        width: double.infinity,
                                        decoration: const BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(20),
                                                topRight: Radius.circular(20))),
                                        child: ListView.separated(
                                          itemCount: orderData.length,
                                          physics:
                                              NeverScrollableScrollPhysics(),
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
                                                          child: orderData[oindex][
                                                                      'image'] !=
                                                                  null
                                                              ? CachedNetworkImage(
                                                                  imageUrl:
                                                                      "${orderData[oindex]['image']}",
                                                                  placeholder: (context, url) => Shimmer
                                                                      .fromColors(
                                                                          direction: ShimmerDirection
                                                                              .ltr,
                                                                          enabled:
                                                                              true,
                                                                          baseColor: Colors
                                                                              .grey
                                                                              .shade300,
                                                                          highlightColor: Colors
                                                                              .grey
                                                                              .shade100,
                                                                          child:
                                                                              Container(
                                                                            color:
                                                                                Colors.grey,
                                                                          )),
                                                                  width: 70,
                                                                  height: 70,
                                                                  fit: BoxFit
                                                                      .cover)
                                                              : Image(
                                                                  image: MemoryImage(
                                                                      base64Decode(
                                                                          "${orderData[oindex]['base64']}")),
                                                                  width: 70,
                                                                  height: 70,
                                                                  fit: BoxFit
                                                                      .cover,
                                                                )),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
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
                                                              child: orderData[
                                                                              oindex]
                                                                          [
                                                                          'name'] !=
                                                                      null
                                                                  ? Text(
                                                                      "${orderData[oindex]['name']}",
                                                                      maxLines:
                                                                          1,
                                                                      style: GoogleFonts
                                                                          .nunito(
                                                                        color: Color(
                                                                            0xff373D4D),
                                                                        fontSize:
                                                                            15,
                                                                        fontWeight:
                                                                            FontWeight.w700,
                                                                      ),
                                                                      overflow:
                                                                          TextOverflow
                                                                              .ellipsis,
                                                                    )
                                                                  : Text(
                                                                      "Customize Pizza",
                                                                      maxLines:
                                                                          1,
                                                                      style: GoogleFonts
                                                                          .nunito(
                                                                        color: Color(
                                                                            0xff373D4D),
                                                                        fontSize:
                                                                            15,
                                                                        fontWeight:
                                                                            FontWeight.w700,
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
                                                                    fontSize:
                                                                        13,
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
                                                                orderData[oindex]
                                                                            [
                                                                            'price'] !=
                                                                        null
                                                                    ? Text(
                                                                        "${orderData[oindex]['price']}",
                                                                        style: GoogleFonts.nunito(
                                                                            color: Color(
                                                                                0xff1F1F1F),
                                                                            fontSize:
                                                                                13,
                                                                            fontWeight: FontWeight
                                                                                .w500))
                                                                    : Text(
                                                                        "${orderData[oindex]['customPizzametaPrice']}",
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
                                                      Column(
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
                                                                  color: loginController.getColor(
                                                                      order['pending'], order['processing'],order['deliver'] ),),
                                                              borderRadius: BorderRadius
                                                                  .all(Radius
                                                                      .circular(
                                                                          10)),
                                                            ),
                                                            child: Center(
                                                              child: orderData[oindex]
                                                                          [
                                                                          'selectitem'] !=
                                                                      null
                                                                  ? Text(
                                                                      "${orderData[oindex]['selectitem']}",
                                                                      style: GoogleFonts.nunito(
                                                                          color: Colors
                                                                              .black,
                                                                          fontSize:
                                                                              16,
                                                                          fontWeight: FontWeight
                                                                              .w500))
                                                                  : Text(
                                                                      "${orderData[oindex]['customPizzametaSelectitem']}",
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
                                                              orderData[oindex][
                                                                          'foodbill'] !=
                                                                      null
                                                                  ? Text(
                                                                      "${orderData[oindex]['foodbill']}",
                                                                      style: GoogleFonts.nunito(
                                                                          color: Color(
                                                                              0xff1F1F1F),
                                                                          fontSize:
                                                                              15,
                                                                          fontWeight: FontWeight
                                                                              .w500))
                                                                  : Text(
                                                                      "${orderData[oindex]['customPizzametaBill']}",
                                                                      style: GoogleFonts.nunito(
                                                                          color: Color(
                                                                              0xff1F1F1F),
                                                                          fontSize:
                                                                              15,
                                                                          fontWeight:
                                                                              FontWeight.w500)),
                                                            ],
                                                          ),
                                                        ],
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
                                    GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            var newViewDetailValue =
                                                !order['viewDetail'];
                                            order.reference.update({
                                              'viewDetail': newViewDetailValue
                                            }).then((_) {
                                              print(
                                                  'viewDetail updated successfully');
                                            }).catchError((error) {
                                              print(
                                                  'Error updating viewDetail: $error');
                                            });
                                          });
                                        },
                                        child: order['viewDetail']
                                            ? Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: [
                                                  Text(
                                                    "Hide Details",
                                                    style: GoogleFonts.nunito(
                                                        fontSize: 16,
                                                        color:
                                                            Color(0xff737b81),
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
                                                        color:
                                                            Color(0xff737b81),
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  ),
                                                  Icon(
                                                    Icons
                                                        .arrow_drop_down_rounded,
                                                    size: 25,
                                                    color: Color(0xff737b81),
                                                  )
                                                ],
                                              )),
                                    SizedBox(
                                      height: order['viewDetail'] ? 10 : 0,
                                    ),
                                    order['viewDetail']
                                        ? Column(
                                            children: [
                                              order['pending']
                                                  ? Row(
                                                      children: [
                                                        Expanded(
                                                          child: Container(
                                                            height: 30,
                                                            decoration: BoxDecoration(
                                                                color:loginController.getColor(
                                                                    order['pending'], order['processing'],order['deliver'] ),
                                                                borderRadius: BorderRadius.only(
                                                                    topRight: Radius
                                                                        .circular(
                                                                            20),
                                                                    bottomRight:
                                                                        Radius.circular(
                                                                            20))),
                                                            child: Center(
                                                              child: Text(
                                                                  "DELIVERY PARTNER INFORMATION",
                                                                  style: GoogleFonts.lexend(
                                                                      color: Colors
                                                                          .white
                                                                          .withOpacity(
                                                                              0.8),
                                                                      fontSize:
                                                                          12)),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    )
                                                  : Container(),
                                              order['pending']
                                                  ? SizedBox(
                                                      height: 10,
                                                    )
                                                  : Container(),
                                              order['pending']
                                                  ? Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              bottom: 10),
                                                      child: Row(
                                                        children: [
                                                          SizedBox(
                                                            width: 15,
                                                          ),
                                                          ClipRRect(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            60)),
                                                            child: Container(
                                                                width: 50,
                                                                height: 50,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color: Color(
                                                                      0xffE9E9F7),
                                                                  shape: BoxShape
                                                                      .circle,
                                                                ),
                                                                child: Image(
                                                                  image: NetworkImage(
                                                                      order[
                                                                          'deliveryImage']),
                                                                  fit: BoxFit
                                                                      .cover,
                                                                )),
                                                          ),
                                                          SizedBox(
                                                            width: 10,
                                                          ),
                                                          Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Text(
                                                                "${order['deliveryName']}",
                                                                style:
                                                                    GoogleFonts
                                                                        .lexend(
                                                                  color: Color(
                                                                      0xff313848),
                                                                  fontSize: 18,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                ),
                                                              ),
                                                              Text(

                                                                overflow: TextOverflow.ellipsis,
                                                                "${order['deliveryEmail']}",
                                                                style:
                                                                    GoogleFonts
                                                                        .lexend(
                                                                  color: Color(
                                                                      0xff313848),
                                                                  fontSize:
                                                                      14,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                ),
                                                              ),
                                                              Text(
                                                                "${order['deliveryPhone']}",
                                                                style:
                                                                    GoogleFonts
                                                                        .lexend(
                                                                  color: Color(
                                                                      0xff313848),
                                                                  fontSize:
                                                                      13.5,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                ),
                                                              ),
                                                              Text(
                                                                "Your Delivery partner",
                                                                style:
                                                                    GoogleFonts
                                                                        .lexend(
                                                                  color: Color(
                                                                      0xff909199),
                                                                  fontSize: 11,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          Spacer(),
                                                        ],
                                                      ),
                                                    )
                                                  : Container(),
                                              Row(
                                                children: [
                                                  Expanded(
                                                    child: Container(
                                                      height: 30,
                                                      decoration: BoxDecoration(
                                                          color:
                                                          loginController.getColor(
                                                              order['pending'], order['processing'],order['deliver'] ),
                                                          borderRadius:
                                                              BorderRadius.only(
                                                                  topRight: Radius
                                                                      .circular(
                                                                          20),
                                                                  bottomRight:
                                                                      Radius.circular(
                                                                          20))),
                                                      child: Center(
                                                        child: Text(
                                                            "DELIVERY ADDRESS & DATE/TIME",
                                                            style: GoogleFonts.lexend(
                                                                color: Colors
                                                                    .white
                                                                    .withOpacity(
                                                                        0.8),
                                                                fontSize: 12)),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 10, right: 10),
                                                child: Row(
                                                  children: [
                                                    Icon(Icons.date_range,
                                                        color:
                                                            Color(0xff313848),
                                                        size: 26),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 15),
                                                      child: Text(
                                                          "${order['date']} at ${order['time']} ",
                                                          style: GoogleFonts
                                                              .nunito(
                                                            color: Color(
                                                                0xff7e878d),
                                                            fontSize: 17,
                                                          )),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 10, right: 10),
                                                child: Row(
                                                  children: [
                                                    Icon(Icons.home_filled,
                                                        color:
                                                            Color(0xff313848),
                                                        size: 26),
                                                    Flexible(
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                                left: 15,
                                                                top: 10),
                                                        child: Text(
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            maxLines: 4,
                                                            "${order['address']} Near ${order['nearAddress']}",
                                                            style: GoogleFonts
                                                                .nunito(
                                                              color: Color(
                                                                  0xff7e878d),
                                                              fontSize: 15.5,
                                                            )),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              SizedBox(
                                                height: 15,
                                              ),
                                              DottedDashedLine(
                                                  height: 1,
                                                  width: double.infinity,
                                                  axis: Axis.horizontal,
                                                  dashColor: loginController.getColor(
                                                      order['pending'], order['processing'],order['deliver'] ),
                                                  strokeWidth: 1,
                                                  dashSpace: 0),
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
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 17.5,
                                                        color:
                                                            Color(0xff313848),
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
                                                    Text("${order['subTotal']}",
                                                        style:
                                                            GoogleFonts.lexend(
                                                                color: Color(
                                                                    0xff1F1F1F),
                                                                fontSize: 17,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500)),
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
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        fontSize: 16,
                                                        color:
                                                            Color(0xff313848),
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
                                                            color: Color(
                                                                0xff1F1F1F),
                                                          ),
                                                          Text(
                                                              "${order['gst']}",
                                                              style: GoogleFonts.lexend(
                                                                  color: Color(
                                                                      0xff1F1F1F),
                                                                  fontSize: 16,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400)),
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
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        fontSize: 16,
                                                        color:
                                                            Color(0xff313848),
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
                                                            color: Color(
                                                                0xff1F1F1F),
                                                          ),
                                                          Text(
                                                              "${order['deliveryFee']}",
                                                              style: GoogleFonts.lexend(
                                                                  color: Color(
                                                                      0xff1F1F1F),
                                                                  fontSize: 16,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400)),
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
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        fontSize: 16,
                                                        color:
                                                            Color(0xff313848),
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
                                                            color: Color(
                                                                0xff1F1F1F),
                                                          ),
                                                          Text(
                                                              "${order['grandTotal']}",
                                                              style: GoogleFonts.lexend(
                                                                  color: Color(
                                                                      0xff1F1F1F),
                                                                  fontSize: 16,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400)),
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
                                      height: order['viewDetail'] ? 0 : 20,
                                    ),
                                    ElevatedButton(
                                        style: ButtonStyle(
                                            minimumSize: MaterialStateProperty
                                                .all(Size(double.infinity, 50)),
                                            shape: MaterialStateProperty.all(
                                                RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.only(
                                                            bottomRight: Radius
                                                                .circular(25),
                                                            bottomLeft:
                                                                Radius.circular(
                                                                    25)))),
                                            backgroundColor:
                                                MaterialStateProperty.all(
                                                  loginController.getColor(
                                                      order['pending'], order['processing'],order['deliver'] ),)),
                                        onPressed: () {},
                                        child: Text(
                                          "Reorder Now",
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: Colors.white),
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
          );
        },
      ),
    );
  }
}
