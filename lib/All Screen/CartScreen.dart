import 'dart:convert';
import 'package:Pizza/All%20Screen/DonationBottomsheetDialog.dart';
import 'package:Pizza/All%20Screen/PaymentScreen.dart';
import 'package:Pizza/Controller/GoogleMapController.dart';
import 'package:Pizza/Controller/OrderController.dart';
import 'package:Pizza/Drawer/AddressBook.dart';
import 'package:Pizza/Drawer/ProfileScreen.dart';
import 'package:Pizza/ModelClass/FoodItemModel.dart';
import 'package:Pizza/ModelClass/PizzaMeta.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotted_dashed_line/dotted_dashed_line.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:page_transition/page_transition.dart';
import 'package:Pizza/All%20Screen/GoldBottomSheetDialog.dart';
import 'package:Pizza/All%20Screen/GstInformationDialog.dart';
import 'package:Pizza/All%20Screen/CookingScreen.dart';
import 'package:Pizza/Controller/BottomController.dart';
import 'package:Pizza/Controller/LoginController.dart';
import 'package:Pizza/Controller/PizzaController.dart';
import 'package:Pizza/Drawer/OfferScreen.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  GoogleMapControllerScreen googleMapControllerScreen = Get.find();

  PizzaController pizzaController = Get.find();
  LoginController loginController = Get.find();
  BottomController bottomController = Get.find();
  OrderController orderController=Get.find();
  int ordertotal = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loginController.profileUpdate(ref);
    pizzaController.Allupdate(ref);
    loginController.profileData();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /*   appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(
              context,
            );
          },
          child: Icon(
            Icons.arrow_back_rounded,
            size: 27,
            color: Colors.black,
          ),
        ),
        toolbarHeight: 50,
        elevation: 0,
        */
      /*flexibleSpace: Opacity(
          opacity: 0.1,
          child: Container(
            color: Color(0xffFFF6F7),
            child: Image(
              image: AssetImage("images/bg1.webp"),
              fit: BoxFit.cover,
              width: MediaQuery.of(context).size.width,
              height: 230,
            ),
          ),
        ),*/
      /*
        backgroundColor: CupertinoColors.white,
        title: Text("Cart Screen",
            style: TextStyle(color: Colors.black, fontSize: 19)),
       */
      /* actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: GestureDetector(
              onTap: (){
                setState(() {
                  Navigator.push(context, PageTransition(type: PageTransitionType.rightToLeft,child: CartScreen()));
                });
              },
              child: Container(
                  width: 38,
                  height: 38,
                  decoration: BoxDecoration(
                      color: Color(0xffE9E9F7), shape: BoxShape.circle),
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Center(
                      child: Image(
                        image: AssetImage("images/cart.webp"),
                        color: Color(0xffB1BBDA),
                      ),
                    ),
                  )),
            ),
          ),
        ],*/ /*
      ),*/
      backgroundColor: Color(0xffF4F6FA),
      body: WillPopScope(
        onWillPop: () {
          setState(() {
            if (bottomController.currentindex.value == 1) {
              Navigator.pop(context);
            } else {
              bottomController.currentindex.value = 0;
            }
          });
          return null!;
        },
        child: Stack(
          children: [
            SingleChildScrollView(
              child: pizzaController.pizzabottomlist.isNotEmpty ||
                      pizzaController.customizepizzalist[0].pizzametalist!
                          .isNotEmpty /* ||
                  pizzaController.addsizelist!.isNotEmpty*/
                  ? Container(
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        children: [
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 20, right: 20),
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
                                "DELIVERY TIME",
                                style: GoogleFonts.nunito(
                                    color: Color(0xff7e878d),
                                    fontSize: 15.2,
                                    fontWeight: FontWeight.w500),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 20, right: 20),
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
                          Padding(
                            padding: const EdgeInsets.only(right: 10, left: 10),
                            child: Container(
                              width: double.infinity,
                              height: 75,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20))),
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(left: 10, right: 10),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.watch_later_rounded,
                                      color: Color(0xff267E3E),
                                      size: 25,
                                    ),
                                    SizedBox(
                                      width: 15,
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text("Delivery in 20-25 min",
                                            style: GoogleFonts.nunito(
                                                fontSize: 17,
                                                color: Color(0xff313848),
                                                fontWeight: FontWeight.w600)),
                                        Text(
                                            "On Time Guarantee  is not available On\nCash on Delivery orders",
                                            style: GoogleFonts.nunito(
                                                fontSize: 15,
                                                color: Color(0xff8F94A4),
                                                fontWeight: FontWeight.w500))
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 20, right: 20),
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
                                "ITEM(S) ADDED",
                                style: GoogleFonts.nunito(
                                    color: Color(0xff7e878d),
                                    fontSize: 15.2,
                                    fontWeight: FontWeight.w500),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 20, right: 20),
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
                          Padding(
                            padding: const EdgeInsets.only(left: 10, right: 10),
                            child: Obx(
                              () => Container(
                                padding: EdgeInsets.only(top: 10, bottom: 10),
                                width: double.infinity,
                                decoration: const BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(20),
                                        topRight: Radius.circular(20))),
                                child: ListView.separated(
                                  itemCount:
                                      pizzaController.pizzabottomlist.length,
                                  physics: NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  scrollDirection: Axis.vertical,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding: const EdgeInsets.only(
                                          left: 10, right: 10),
                                      child: Container(
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
                                                    child: Image(
                                                      image: AssetImage(
                                                          "${pizzaController.pizzabottomlist[index].image}"),
                                                      width: 70,
                                                      height: 70,
                                                      fit: BoxFit.cover,
                                                    )),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 10, right: 10),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Container(
                                                        width: 150,
                                                        child: Text(
                                                          "${pizzaController.pizzabottomlist[index].name}",
                                                          maxLines: 1,
                                                          style: GoogleFonts
                                                              .nunito(
                                                            color: Color(
                                                                0xff373D4D),
                                                            fontSize: 15,
                                                            fontWeight:
                                                                FontWeight.w700,
                                                          ),
                                                          overflow: TextOverflow
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
                                                          Text(
                                                              "${pizzaController.pizzabottomlist[index].price}",
                                                              style: GoogleFonts.nunito(
                                                                  color: Color(
                                                                      0xff1F1F1F),
                                                                  fontSize: 13,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500)),
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
                                                          color:
                                                              Color(0xffFFF6F7),
                                                          boxShadow: [
                                                            BoxShadow(
                                                                color: Color(
                                                                    0xffdedede),
                                                                blurRadius: 5,
                                                                blurStyle:
                                                                    BlurStyle
                                                                        .outer)
                                                          ],
                                                          border: Border.all(
                                                              color: Color(
                                                                  0xffEF4F5F)),
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          10)),
                                                        ),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceAround,
                                                          children: [
                                                            GestureDetector(
                                                              onTap: () {
                                                                setState(() {
                                                                  if (pizzaController
                                                                      .pizzabottomlist[
                                                                          index]
                                                                      .food!
                                                                      .contains(
                                                                          "soda")) {
                                                                    pizzaController
                                                                        .Sodabottomremove(
                                                                            index,
                                                                            context);
                                                                    print(
                                                                        "soda");
                                                                  } else {
                                                                    pizzaController.Pizzabottomremove(
                                                                        pizzaController
                                                                            .pizzaindex
                                                                            .value,
                                                                        index,
                                                                        context);
                                                                    print(
                                                                        "pizza");
                                                                  }
                                                                });
                                                              },
                                                              child: Icon(
                                                                  Icons.remove,
                                                                  color: Color(
                                                                      0xffEF4F5F),
                                                                  size: 20),
                                                            ),
                                                            Center(
                                                              child: Text(
                                                                  "${pizzaController.pizzabottomlist[index].selectitem}",
                                                                  style: GoogleFonts.nunito(
                                                                      color: Colors
                                                                          .black,
                                                                      fontSize:
                                                                          16,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500)),
                                                            ),
                                                            GestureDetector(
                                                              onTap: () {
                                                                setState(() {
                                                                  if (pizzaController
                                                                      .pizzabottomlist[
                                                                          index]
                                                                      .food!
                                                                      .contains(
                                                                          "soda")) {
                                                                    pizzaController
                                                                        .Sodabottompluse(
                                                                            index);
                                                                    print(
                                                                        "soda");
                                                                  } else {
                                                                    pizzaController
                                                                        .Pizzabottomplus(
                                                                            index);
                                                                    print(
                                                                        "pizza");
                                                                  }
                                                                });
                                                              },
                                                              child: Icon(
                                                                  Icons.add,
                                                                  color: Color(
                                                                      0xffEF4F5F),
                                                                  size: 20),
                                                            ),
                                                          ],
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
                                                            () => Text(
                                                                "${pizzaController.pizzabottomlist[index].foodbill}",
                                                                style: GoogleFonts.nunito(
                                                                    color: Color(
                                                                        0xff1F1F1F),
                                                                    fontSize:
                                                                        15,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500)),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            DottedDashedLine(
                                              height: 0,
                                              width: double.infinity,
                                              axis: Axis.horizontal,
                                              dashColor: Color(0xffDAD9DD),
                                              strokeWidth: 1,
                                              dashSpace: 3,
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                  separatorBuilder: (context, index) {
                                    return SizedBox(
                                      height: 10,
                                    );
                                  },
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10, right: 10),
                            child: Obx(
                              () => Container(
                                padding: EdgeInsets.only(top: 10, bottom: 10),
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(20),
                                        bottomRight: Radius.circular(20))),
                                child: ListView.separated(
                                  itemCount: pizzaController
                                      .customizepizzalist[0]
                                      .pizzametalist!
                                      .length,
                                  physics: NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  // scrollDirection: Axis.vertical,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding: const EdgeInsets.only(
                                          left: 10, right: 10),
                                      child: Container(
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
                                                    child: Image(
                                                      image: MemoryImage(
                                                          pizzaController
                                                              .customizepizzalist[
                                                                  0]
                                                              .pizzametalist![
                                                                  index]
                                                              .customPizzametaUint8list!),
                                                      width: 70,
                                                      height: 70,
                                                      fit: BoxFit.cover,
                                                    )),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 10, right: 10),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Container(
                                                        width: 150,
                                                        child: Text(
                                                          "Customize Pizza",
                                                          maxLines: 1,
                                                          style: GoogleFonts
                                                              .nunito(
                                                            color: Color(
                                                                0xff373D4D),
                                                            fontSize: 15,
                                                            fontWeight:
                                                                FontWeight.w700,
                                                          ),
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                        ),
                                                      ),
                                                      Text(
                                                          "Size : ${pizzaController.customizepizzalist[0].pizzametalist![index].pizzaSize}",
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
                                                          Text(
                                                              "${pizzaController.customizepizzalist[0].pizzametalist![index].customPizzametaPrice}",
                                                              style: GoogleFonts.nunito(
                                                                  color: Color(
                                                                      0xff1F1F1F),
                                                                  fontSize: 13,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500)),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Spacer(),
                                                Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Container(
                                                      width: 75,
                                                      height: 30,
                                                      decoration: BoxDecoration(
                                                        color:
                                                            Color(0xffFFF6F7),
                                                        boxShadow: [
                                                          BoxShadow(
                                                              color: Color(
                                                                  0xffdedede),
                                                              blurRadius: 5,
                                                              blurStyle:
                                                                  BlurStyle
                                                                      .outer)
                                                        ],
                                                        border: Border.all(
                                                            color: Color(
                                                                0xffEF4F5F)),
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    10)),
                                                      ),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceAround,
                                                        children: [
                                                          GestureDetector(
                                                            onTap: () {
                                                              setState(() {
                                                                pizzaController
                                                                    .custompizzaRemove(
                                                                        index);
                                                              });
                                                            },
                                                            child: Icon(
                                                                Icons.remove,
                                                                color: Color(
                                                                    0xffEF4F5F),
                                                                size: 20),
                                                          ),
                                                          Center(
                                                            child: Text(
                                                                "${pizzaController.customizepizzalist[0].pizzametalist![index].customPizzametaSelectitem}",
                                                                style: GoogleFonts.nunito(
                                                                    color: Colors
                                                                        .black,
                                                                    fontSize:
                                                                        16,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500)),
                                                          ),
                                                          GestureDetector(
                                                            onTap: () {
                                                              setState(() {
                                                                pizzaController
                                                                    .custompizzaPlus(
                                                                        index);
                                                              });
                                                            },
                                                            child: Icon(
                                                                Icons.add,
                                                                color: Color(
                                                                    0xffEF4F5F),
                                                                size: 20),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Row(
                                                      children: [
                                                        Image(
                                                          image: AssetImage(
                                                              "images/rupee.webp"),
                                                          width: 15,
                                                          height: 15,
                                                          color:
                                                              Color(0xff1F1F1F),
                                                        ),
                                                        Obx(
                                                          () => Text(
                                                              "${pizzaController.customizepizzalist[0].pizzametalist![index].customPizzametaBill}",
                                                              style: GoogleFonts.nunito(
                                                                  color: Color(
                                                                      0xff1F1F1F),
                                                                  fontSize: 15,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500)),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            DottedDashedLine(
                                              height: 0,
                                              width: double.infinity,
                                              axis: Axis.horizontal,
                                              dashColor: Color(0xffDAD9DD),
                                              strokeWidth: 1,
                                              dashSpace: 3,
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                  separatorBuilder: (context, index) {
                                    return SizedBox(
                                      height: 10,
                                    );
                                  },
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10, right: 10),
                            child: Container(
                              width: double.infinity,
                              height: 100,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15))),
                              child: Column(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        bottomController.currentindex.value = 1;
                                      });
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 10, right: 10),
                                      child: Container(
                                        width: double.infinity,
                                        height: 48,
                                        child: Row(
                                          children: [
                                            Image(
                                              image: AssetImage(
                                                  "images/addpizza.webp"),
                                              width: 19,
                                              height: 19,
                                              color: Color(0xff7e878d),
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Text(
                                              "Add more pizza",
                                              style: GoogleFonts.nunito(
                                                  fontSize: 16,
                                                  color: Color(0xff313848),
                                                  fontWeight: FontWeight.w500),
                                            ),
                                            Spacer(),
                                            Image(
                                              image: AssetImage(
                                                  "images/next.webp"),
                                              width: 22,
                                              height: 22,
                                              color: Color(0xff7e878d),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10, right: 10),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Container(
                                            height: 1,
                                            color: Color(0xffDAD9DD),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        bottomController.currentindex.value = 2;
                                      });
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 10, right: 10),
                                      child: Container(
                                        width: double.infinity,
                                        height: 48,
                                        child: Row(
                                          children: [
                                            Image(
                                              image: AssetImage(
                                                  "images/addsoda.webp"),
                                              width: 19,
                                              height: 19,
                                              color: Color(0xff7e878d),
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Text(
                                              "Add more cold drinks",
                                              style: GoogleFonts.nunito(
                                                  fontSize: 16,
                                                  color: Color(0xff313848),
                                                  fontWeight: FontWeight.w500),
                                            ),
                                            Spacer(),
                                            Image(
                                              image: AssetImage(
                                                  "images/next.webp"),
                                              width: 22,
                                              height: 22,
                                              color: Color(0xff7e878d),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 20, right: 20),
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
                                "SAVING CORNER",
                                style: GoogleFonts.nunito(
                                    color: Color(0xff7e878d),
                                    fontSize: 15.2,
                                    fontWeight: FontWeight.w500),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 20, right: 20),
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
                          Padding(
                            padding: const EdgeInsets.only(left: 10, right: 10),
                            child: Container(
                              width: double.infinity,
                              height: 120,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15))),
                              child: Column(
                                children: [
                                  Container(
                                    width: double.infinity,
                                    height: 70,
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 10, right: 10),
                                      child: Align(
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  bottom: 18),
                                              child: Lottie.asset(
                                                  "images/offer.json",
                                                  width: 23,
                                                  height: 23),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 10, right: 10),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "Save Rs.500 more this order",
                                                    style: GoogleFonts.lexend(
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontSize: 16,
                                                      color: Color(0xff313848),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 4,
                                                  ),
                                                  Container(
                                                    padding: EdgeInsets.only(
                                                        left: 10,
                                                        right: 10,
                                                        top: 3.5),
                                                    height: 22,
                                                    decoration: BoxDecoration(
                                                        border: Border.all(
                                                            color: Color(
                                                                0xff89898a)),
                                                        color: Colors.white,
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    8))),
                                                    child: Text(
                                                      "SAVING CORNER",
                                                      style: GoogleFonts.lexend(
                                                          fontSize: 10,
                                                          color:
                                                              Color(0xff313848),
                                                          fontWeight:
                                                              FontWeight.w600),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  DottedDashedLine(
                                    height: 0,
                                    width: double.infinity,
                                    axis: Axis.horizontal,
                                    dashColor: Color(0xffDAD9DD),
                                    strokeWidth: 1,
                                    dashSpace: 3,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          PageTransition(
                                              child: OfferScreen(),
                                              type: PageTransitionType
                                                  .rightToLeft));
                                    },
                                    child: Container(
                                      width: double.infinity,
                                      height: 49,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            "View all coupons",
                                            style: GoogleFonts.lexend(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 16,
                                              color: Color(0xff313848),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(top: 2),
                                            child: Image(
                                              image: AssetImage(
                                                  "images/next.webp"),
                                              width: 25,
                                              height: 25,
                                              color: Color(0xff7e878d),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10, right: 10),
                            child: Container(
                              width: double.infinity,
                              height: 200,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15)),
                                  border: Border.all(
                                      width: 1, color: Color(0xffB48534))),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10, right: 10),
                                    child: Container(
                                      width: double.infinity,
                                      height: 40,
                                      child: Row(
                                        children: [
                                          Text(
                                            "Benefits on this order with",
                                            style: GoogleFonts.lexend(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 16,
                                              color: Color(0xff313848),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Text(
                                            "GOLD",
                                            style: GoogleFonts.lexend(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 17.5,
                                              color: Color(0xffB48534),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  DottedDashedLine(
                                    height: 0,
                                    width: double.infinity,
                                    axis: Axis.horizontal,
                                    dashColor: Color(0xffefdfa6),
                                    strokeWidth: 1,
                                    dashSpace: 3,
                                  ),
                                  Container(
                                    width: double.infinity,
                                    height: 103,
                                    decoration: BoxDecoration(
                                        gradient: LinearGradient(colors: [
                                      Color(0xffffffff),
                                      Color(0xffFDF9FA)
                                    ])),
                                    child: Stack(
                                      alignment: Alignment.bottomRight,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                            right: 5,
                                          ),
                                          child: Opacity(
                                            opacity: 0.5,
                                            child: Image(
                                              image: AssetImage(
                                                  "images/primium.webp"),
                                              color: Color(0xfff8edde),
                                              width: 120,
                                              height: 120,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 10, right: 10),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(height: 8),
                                              Text(
                                                "Free delivery",
                                                style: GoogleFonts.lexend(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 16,
                                                  color: Color(0xff313848),
                                                ),
                                              ),
                                              Text(
                                                "Above orders worth Rs.199",
                                                style: GoogleFonts.lexend(
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 16,
                                                  color: Color(0xff7e878d),
                                                ),
                                              ),
                                              Spacer(),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    bottom: 5),
                                                child: GestureDetector(
                                                  onTap: () {
                                                    showModalBottomSheet(
                                                      backgroundColor:
                                                          Colors.white,
                                                      isScrollControlled: true,
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.only(
                                                                topRight: Radius
                                                                    .circular(
                                                                        20),
                                                                topLeft: Radius
                                                                    .circular(
                                                                        20)),
                                                      ),
                                                      context: context,
                                                      builder: (context) {
                                                        return GoldBottomSheetDialog();
                                                      },
                                                    );
                                                  },
                                                  child: Row(
                                                    children: [
                                                      Text(
                                                        "New benefit added! Know more",
                                                        style:
                                                            GoogleFonts.lexend(
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          fontSize: 16,
                                                          color:
                                                              Color(0xffEF4F5F),
                                                        ),
                                                      ),
                                                      Image(
                                                        image: AssetImage(
                                                            "images/next.webp"),
                                                        width: 22,
                                                        height: 22,
                                                        color:
                                                            Color(0xffEF4F5F),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              SizedBox(height: 5),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  // SizedBox(height: 5,),
                                  DottedDashedLine(
                                    height: 0,
                                    width: double.infinity,
                                    axis: Axis.horizontal,
                                    dashColor: Color(0xffefdfa6),
                                    strokeWidth: 1,
                                    dashSpace: 3,
                                  ),
                                  Expanded(
                                    child: Container(
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.only(
                                              bottomRight: Radius.circular(15),
                                              bottomLeft: Radius.circular(15)),
                                          gradient: LinearGradient(colors: [
                                            Color(0xffffffff),
                                            Color(0xffFEF4E2)
                                          ])),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 10, right: 10),
                                            child: Text(
                                              "Add for 3 months at Rs.199",
                                              style: GoogleFonts.lexend(
                                                fontWeight: FontWeight.w400,
                                                fontSize: 16,
                                                color: Color(0xff313848),
                                              ),
                                            ),
                                          ),
                                          Spacer(),
                                          GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                pizzaController
                                                    .functionPrimium();
                                              });
                                            },
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 10, right: 10),
                                              child: !pizzaController
                                                      .checkadd.value
                                                  ? Container(
                                                      width: 60,
                                                      height: 35,
                                                      decoration: BoxDecoration(
                                                        color:
                                                            Color(0xffFFF6F7),
                                                        boxShadow: [
                                                          BoxShadow(
                                                              color: Color(
                                                                  0xffdedede),
                                                              blurRadius: 5,
                                                              blurStyle:
                                                                  BlurStyle
                                                                      .outer)
                                                        ],
                                                        border: Border.all(
                                                            color: Color(
                                                                0xffEF4F5F)),
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    10)),
                                                      ),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceAround,
                                                        children: [
                                                          Center(
                                                            child: Text("Add",
                                                                style: GoogleFonts.nunito(
                                                                    color: Color(
                                                                        0xffEF4F5F),
                                                                    fontSize:
                                                                        16,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500)),
                                                          ),
                                                        ],
                                                      ),
                                                    )
                                                  : Container(
                                                      width: 60,
                                                      height: 35,
                                                      decoration: BoxDecoration(
                                                        color:
                                                            Color(0xffEF4F5F),
                                                        boxShadow: [
                                                          BoxShadow(
                                                              color: Color(
                                                                  0xffdedede),
                                                              blurRadius: 5,
                                                              blurStyle:
                                                                  BlurStyle
                                                                      .outer)
                                                        ],
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    10)),
                                                      ),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceAround,
                                                        children: [
                                                          Center(
                                                            child: Text("Add",
                                                                style: GoogleFonts.nunito(
                                                                    color: Color(
                                                                        0xffffffff),
                                                                    fontSize:
                                                                        16,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500)),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 20, right: 20),
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
                                "BILL SUMMARY",
                                style: GoogleFonts.nunito(
                                    color: Color(0xff7e878d),
                                    fontSize: 15.2,
                                    fontWeight: FontWeight.w500),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 20, right: 20),
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
                          Padding(
                            padding: const EdgeInsets.only(left: 10, right: 10),
                            child: Container(
                              width: double.infinity,
                              height: 195,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15))),
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 12,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10, right: 10),
                                    child: Row(
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Subtotal",
                                              style: GoogleFonts.lexend(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 17.5,
                                                color: Color(0xff313848),
                                              ),
                                            ),
                                            pizzaController.checkbox.value
                                                ? Text(
                                                    "include Rs.2 Feeling India donation",
                                                    style: GoogleFonts.lexend(
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontSize: 15,
                                                      color: Color(0xff8F94A4),
                                                    ),
                                                  )
                                                : Text(""),
                                          ],
                                        ),
                                        Spacer(),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(bottom: 20),
                                          child: Row(
                                            children: [
                                              Image(
                                                image: AssetImage(
                                                    "images/rupee.webp"),
                                                width: 17,
                                                height: 17,
                                                color: Color(0xff1F1F1F),
                                              ),
                                              Obx(
                                                () => Text(
                                                    "${pizzaController.finalfoodtotal}",
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
                                          image: AssetImage("images/bank.webp"),
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
                                              const EdgeInsets.only(bottom: 5),
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
                                                    "${pizzaController.gst.value}",
                                                    style: GoogleFonts.lexend(
                                                        color:
                                                            Color(0xff1F1F1F),
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w400)),
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
                                              const EdgeInsets.only(bottom: 5),
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
                                                    "${pizzaController.deliveryfee.value}",
                                                    style: GoogleFonts.lexend(
                                                        color:
                                                            Color(0xff1F1F1F),
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w400)),
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
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 10, right: 10),
                                      child: Column(
                                        children: [
                                          Container(
                                            height: 1,
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                              color: Color(0xffDAD9DD),
                                              width: 1,
                                            )),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10, right: 10, bottom: 10),
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
                                              const EdgeInsets.only(bottom: 5),
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
                                                    "${pizzaController.grandtotal.value}",
                                                    style: GoogleFonts.lexend(
                                                        color:
                                                            Color(0xff1F1F1F),
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w400)),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Obx(
                            () => Container(
                              child:
                                  googleMapControllerScreen.visibleAddress.value
                                      ? Row(
                                          children: [
                                            Expanded(
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 20, right: 20),
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
                                              "DELIVERY ADDRESS",
                                              style: GoogleFonts.nunito(
                                                  color: Color(0xff7e878d),
                                                  fontSize: 15.2,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                            Expanded(
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 20, right: 20),
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
                                        )
                                      : Container(),
                            ),
                          ),
                          Obx(
                            () => Padding(
                              padding: googleMapControllerScreen
                                      .visibleAddress.value
                                  ? const EdgeInsets.only(
                                      left: 10, right: 10, top: 15)
                                  : EdgeInsets.only(left: 0, right: 0, top: 0),
                              child: googleMapControllerScreen
                                      .visibleAddress.value
                                  ? Container(
                                      width: double.infinity,
                                      height: 175,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(15))),
                                      child: Column(
                                        children: [
                                          SizedBox(
                                            height: 12,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 10, right: 10),
                                            child: Row(
                                              children: [
                                                Icon(
                                                  Icons.watch_later_rounded,
                                                  color: Color(0xff267E3E),
                                                  size: 18,
                                                ),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                Text(
                                                  "Delivery in  ",
                                                  style: GoogleFonts.lexend(
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 17.5,
                                                    color: Color(0xff313848),
                                                  ),
                                                ),
                                                Text(
                                                  "30-35 mins",
                                                  style: GoogleFonts.lexend(
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 17.5,
                                                    color: Color(0xff313848),
                                                  ),
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
                                            child: DottedDashedLine(
                                              height: 0,
                                              width: double.infinity,
                                              axis: Axis.horizontal,
                                              dashColor: Color(0xffDAD9DD),
                                              strokeWidth: 1,
                                              dashSpace: 3,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 15,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 10, right: 10),
                                            child: GestureDetector(
                                              onTap: () {
                                                showModalBottomSheet(
                                                  backgroundColor: Colors.white,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.only(
                                                            topRight: Radius
                                                                .circular(20),
                                                            topLeft:
                                                                Radius.circular(
                                                                    20)),
                                                  ),
                                                  context: context,
                                                  builder: (context) {
                                                    return AddressBook();
                                                  },
                                                );
                                                setState(() {
                                                  googleMapControllerScreen
                                                      .changeAddressHeight
                                                      .value = true;
                                                });
                                              },
                                              child: Row(
                                                children: [
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Icon(
                                                            CupertinoIcons
                                                                .house,
                                                            size: 20,
                                                            color: Color(
                                                                0xff313848),
                                                          ),
                                                          SizedBox(
                                                            width: 10,
                                                          ),
                                                          Text(
                                                            "Delivery at ",
                                                            style: GoogleFonts
                                                                .lexend(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              fontSize: 16,
                                                              color: Color(
                                                                  0xff313848),
                                                            ),
                                                          ),
                                                          Obx(
                                                            () => Text(
                                                              "${googleMapControllerScreen.addresstype.value}",
                                                              style: GoogleFonts
                                                                  .lexend(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                fontSize: 17,
                                                                color: Color(
                                                                    0xff313848),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(left: 30),
                                                        child: Obx(
                                                          () => Text(
                                                            "${googleMapControllerScreen.area.value}",
                                                            style: GoogleFonts
                                                                .lexend(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              fontSize: 16,
                                                              color: Color(
                                                                  0xff8F94A4),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Spacer(),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            right: 10),
                                                    child: Icon(
                                                      Icons.arrow_forward_ios,
                                                      color: Color(0xff313848),
                                                      size: 17,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 15,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 10, right: 10),
                                            child: DottedDashedLine(
                                              height: 0,
                                              width: double.infinity,
                                              axis: Axis.horizontal,
                                              dashColor: Color(0xffDAD9DD),
                                              strokeWidth: 1,
                                              dashSpace: 3,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 15,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 10, right: 10),
                                            child: GestureDetector(
                                              onTap: () {
                                                showModalBottomSheet(
                                                  backgroundColor: Colors.white,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.only(
                                                            topRight: Radius
                                                                .circular(20),
                                                            topLeft:
                                                                Radius.circular(
                                                                    20)),
                                                  ),
                                                  context: context,
                                                  builder: (context) {
                                                    return ProfileScreen();
                                                  },
                                                );
                                                setState(() {
                                                  googleMapControllerScreen
                                                      .changeProfileHeight
                                                      .value = true;
                                                });
                                              },
                                              child: Row(
                                                children: [
                                                  Icon(
                                                    Icons.phone_in_talk_rounded,
                                                    size: 21,
                                                    color: Color(0xff313848),
                                                  ),
                                                  SizedBox(
                                                    width: 8,
                                                  ),
                                                  Obx(
                                                    () => Text(
                                                      "${loginController.cartName.value}  ",
                                                      style: GoogleFonts.lexend(
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        fontSize: 16,
                                                        color:
                                                            Color(0xff313848),
                                                      ),
                                                    ),
                                                  ),
                                                  Obx(
                                                    () => Text(
                                                      "${loginController.cartPhone.value}",
                                                      style: GoogleFonts.lexend(
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        fontSize: 16,
                                                        color:
                                                            Color(0xff313848),
                                                      ),
                                                    ),
                                                  ),
                                                  Spacer(),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            right: 10),
                                                    child: Icon(
                                                      Icons.arrow_forward_ios,
                                                      color: Color(0xff313848),
                                                      size: 17,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  : Container(),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 10, right: 10, top: 15),
                            child: Container(
                              width: double.infinity,
                              height: 120,
                              decoration: BoxDecoration(
                                  gradient: LinearGradient(colors: [
                                    Color(0xffffffff),
                                    Color(0xffFFF5E3)
                                  ]),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15))),
                              child: Stack(
                                alignment: Alignment.bottomRight,
                                children: [
                                  Opacity(
                                      opacity: 0.5,
                                      child: Image(
                                        image:
                                            AssetImage("images/donation.webp"),
                                        width: double.infinity,
                                        height: 80,
                                        fit: BoxFit.cover,
                                      )),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10, right: 10),
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Container(
                                          width: double.infinity,
                                          height: 22,
                                          child: Row(
                                            children: [
                                              Text(
                                                "Feeding India donation",
                                                style: GoogleFonts.lexend(
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 16,
                                                  color: Color(0xff313848),
                                                ),
                                              ),
                                              Spacer(),
                                              Checkbox(
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                5))),
                                                activeColor: Color(0xffEF4F5F),
                                                value: pizzaController
                                                    .checkbox.value,
                                                onChanged: (value) {
                                                  setState(() {
                                                    pizzaController
                                                        .functionDonation(
                                                            value);
                                                  });
                                                },
                                              )
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: 2,
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              "Working towards a malnutrition-free India",
                                              style: GoogleFonts.lexend(
                                                fontWeight: FontWeight.w400,
                                                fontSize: 13,
                                                color: Color(0xff8F94A4),
                                              ),
                                            ),
                                            Spacer(),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 10),
                                              child: Row(
                                                children: [
                                                  Image(
                                                    image: AssetImage(
                                                        "images/rupee.webp"),
                                                    width: 15,
                                                    height: 15,
                                                    color: Color(0xff1F1F1F),
                                                  ),
                                                  Text("2",
                                                      style: GoogleFonts.nunito(
                                                          color:
                                                              Color(0xff1F1F1F),
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.w500)),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 2,
                                        ),
                                        Spacer(),
                                        GestureDetector(
                                          onTap: () {
                                            showModalBottomSheet(
                                              backgroundColor: Colors.white,
                                              isScrollControlled: true,
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.only(
                                                    topRight:
                                                        Radius.circular(20),
                                                    topLeft:
                                                        Radius.circular(20)),
                                              ),
                                              context: context,
                                              builder: (context) {
                                                return DonationBottomsheetDialog();
                                              },
                                            );
                                          },
                                          child: Container(
                                            width: double.infinity,
                                            height: 50,
                                            child: Row(
                                              children: [
                                                Text(
                                                  "Learn more",
                                                  style: GoogleFonts.lexend(
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 16,
                                                    color: Color(0xff313848),
                                                  ),
                                                ),
                                                Image(
                                                  image: AssetImage(
                                                      "images/next.webp"),
                                                  width: 22,
                                                  height: 22,
                                                  color: Color(0xff313848),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 20, right: 20),
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
                                "PAYMENT METHOD",
                                style: GoogleFonts.nunito(
                                    color: Color(0xff7e878d),
                                    fontSize: 15.2,
                                    fontWeight: FontWeight.w500),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 20, right: 20),
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
                          Padding(
                            padding: const EdgeInsets.only(left: 10, right: 10),
                            child: Container(
                              width: double.infinity,
                              height: 50,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15))),
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(left: 10, right: 10),
                                child: Row(
                                  children: [
                                    Text(
                                      "Cash On Delivery",
                                      style: GoogleFonts.lexend(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 16,
                                        color: Color(0xff313848),
                                      ),
                                    ),
                                    Spacer(),
                                    Radio(
                                      activeColor: Color(0xffEF4F5F),
                                      value: "Cash",
                                      groupValue:
                                          pizzaController.orderMethod.value,
                                      onChanged: (value) {
                                        setState(() {
                                          pizzaController.orderMethod.value =
                                              value!;
                                        });
                                      },
                                    )
                                    /* Checkbox(
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(5))),
                                      activeColor: Color(0xffEF4F5F),
                                      value:
                                          pizzaController.cashOnDelivery.value,
                                      onChanged: (value) {
                                        setState(() {
                                          pizzaController.cashOnDelivery.value = value!;
                                        });
                                      },
                                    )*/
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10, right: 10),
                            child: Container(
                              width: double.infinity,
                              height: 50,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15))),
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(left: 10, right: 10),
                                child: Row(
                                  children: [
                                    Text(
                                      "Online Payment",
                                      style: GoogleFonts.lexend(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 16,
                                        color: Color(0xff313848),
                                      ),
                                    ),
                                    Spacer(),
                                    /* Checkbox(
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(5))),
                                      activeColor: Color(0xffEF4F5F),
                                      value:
                                          pizzaController.cashOnDelivery.value,
                                      onChanged: (value) {
                                        setState(() {
                                          pizzaController.cashOnDelivery.value =
                                              value!;
                                        });
                                      },
                                    )*/
                                    Radio(
                                      activeColor: Color(0xffEF4F5F),
                                      value: "Online",
                                      groupValue:
                                          pizzaController.orderMethod.value,
                                      onChanged: (value) {
                                        setState(() {
                                          pizzaController.orderMethod.value =
                                              value!;
                                        });
                                      },
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 20, right: 20),
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
                                "CANCELLATION POLICY",
                                style: GoogleFonts.nunito(
                                    color: Color(0xff7e878d),
                                    fontSize: 15.2,
                                    fontWeight: FontWeight.w500),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 20, right: 20),
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
                          Padding(
                            padding: const EdgeInsets.only(left: 10, right: 10),
                            child: Container(
                              padding: EdgeInsets.all(10),
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15))),
                              child: Text(
                                "100% cancellation fee will be applicable if you decide to cancel the order anytime after order placement. Avoid cancellation as it leads to food wastage",
                                maxLines: 5,
                                style: GoogleFonts.lexend(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 15,
                                  color: Color(0xff8F94A4),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 100,
                          ),
                        ],
                      ))
                  : Center(
                      child: GestureDetector(
                        onTap: (){
                          setState(() {
                            bottomController.currentindex.value = 1;
                          });
                        },
                        child: Container(
                          color: Colors.white,
                          width: double.infinity,
                          height: MediaQuery.of(context).size.height,
                          child: Column(
                            children: [
                              SizedBox(
                                height: 20,
                              ),
                              Center(
                                child: Lottie.asset(
                                  "images/cooking.json",
                                  width: 230,
                                  height: 230,
                                ),
                              ),
                              Text(
                                "Good Food is Always",
                                style: GoogleFonts.lexend(
                                    fontSize: 24,
                                    color: Color(0xff313848),
                                    fontWeight: FontWeight.w600),
                              ),
                              Text(
                                "Cooking",
                                style: GoogleFonts.lexend(
                                    fontSize: 24,
                                    color: Color(0xff313848),
                                    fontWeight: FontWeight.w600),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Center(
                                child: Text(
                                  "Your cart is empty. Add something \n                  from the menu",
                                  style: GoogleFonts.lexend(
                                      fontSize: 15,
                                      color: Color(0xff7e878d),
                                      fontWeight: FontWeight.w400),
                                ),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Padding(
                                  padding: const EdgeInsets.only(
                                      left: 10, right: 10),
                                  child: Container(
                                    width: 250,
                                    height: 50,
                                    decoration: BoxDecoration(
                                        color: Color(0xffFFF6F7),
                                        border: Border.all(
                                            width: 1, color: Color(0xffEF4F5F)),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20))),
                                    child: Center(
                                      child: Text(
                                        "Find Food",
                                        style: GoogleFonts.lexend(
                                            fontSize: 17.5,
                                            color: Color(0xffEF4F5F),
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                  )),
                            ],
                          ),
                        ),
                      ),
                    ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: pizzaController.pizzabottomlist.isNotEmpty ||
                      pizzaController.customizepizzalist[0].pizzametalist!
                          .isNotEmpty /*||
                  pizzaController.addsizelist!.isNotEmpty*/
                  ? Container(
                      padding: EdgeInsets.only(left: 10, right: 10),
                      width: double.infinity,
                      height: 70,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(10),
                              topLeft: Radius.circular(10)),
                          boxShadow: [
                            BoxShadow(color: Colors.black38, blurRadius: 10)
                          ]),
                      child: Obx(
                        () => Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                                style: ButtonStyle(
                                    minimumSize: MaterialStateProperty.all(
                                        Size(double.infinity, 50)),
                                    shape: MaterialStateProperty.all(
                                        RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(15)))),
                                    backgroundColor: MaterialStateProperty.all(
                                        Color(0xffEF505F))),
                                onPressed: () async {
                                  if (googleMapControllerScreen.selectAddress.value) {
                                    if (pizzaController.orderMethod.value == "Cash") {
                                      print("cash");
                                      Navigator.push(
                                          context,
                                          PageTransition(
                                              child: CookingScreen(
                                                  total: pizzaController
                                                      .grandtotal.value),
                                              type: PageTransitionType
                                                  .rightToLeft));
                                      googleMapControllerScreen
                                          .selectAddress.value = false;
                                      googleMapControllerScreen
                                          .visibleAddress.value = false;
                                      pizzaController.resetOffer();
                                      pizzaController.functionCartClear();
                                    }
                                    else if (pizzaController.orderMethod.value == "Online") {
                                      showModalBottomSheet(
                                        backgroundColor: Colors.white,
                                        isScrollControlled: true,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.only(
                                              topRight: Radius.circular(20),
                                              topLeft: Radius.circular(20)),
                                        ),
                                        context: context,
                                        builder: (context) {
                                          return PaymentScreen();
                                        },
                                      );
                                    }
                                  }
                                  else {
                                    showModalBottomSheet(
                                      backgroundColor: Colors.white,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.only(
                                            topRight: Radius.circular(20),
                                            topLeft: Radius.circular(20)),
                                      ),
                                      context: context,
                                      builder: (context) {
                                        return AddressBook();
                                      },
                                    );
                                    orderController.addUserOrderData();
                                    orderController.addAllUserOrderData();
                                    setState(() {
                                      googleMapControllerScreen
                                          .changeAddressHeight.value = true;
                                    });
                                  }
                                },
                                child: googleMapControllerScreen
                                        .selectAddress.value
                                    ? Text(
                                        "Conform Order",
                                        style: TextStyle(
                                            fontSize: 16, color: Colors.white),
                                      )
                                    : Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            "Select address at next step",
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.white),
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(top: 2),
                                            child: Icon(
                                              Icons.navigate_next_rounded,
                                              color: Colors.white,
                                              size: 20,
                                            ),
                                          )
                                        ],
                                      )),
                          ],
                        ),
                      ),
                    )
                  : Container(),
            ),
          ],
        ),
      ),
    );
  }


  void ref(){
    setState((){});
  }
}
