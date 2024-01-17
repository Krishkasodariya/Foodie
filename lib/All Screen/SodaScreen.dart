import 'package:Pizza/All%20Screen/BottomSheetDialog.dart';
import 'package:Pizza/Controller/AdminController.dart';
import 'package:Pizza/Controller/BottomController.dart';
import 'package:Pizza/Controller/PizzaController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class SodaScreen extends StatefulWidget {
  const SodaScreen({super.key});

  @override
  State<SodaScreen> createState() => _SodaScreenState();
}

class _SodaScreenState extends State<SodaScreen> {
  var sodasearchContoller = new TextEditingController();
  PizzaController pizzaController = Get.find();
  BottomController bottomController = Get.find();
  AdminController adminController = Get.find();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (pizzaController.sodalist.isEmpty) {
      pizzaController.getSodaData();
    }
    pizzaController.Allupdate(ref);
    pizzaController.Searchupdate(ref);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: WillPopScope(
          onWillPop: () {
            bottomController.currentindex.value = 0;
            return null!;
          },
          child: Stack(
            children: [
              CustomScrollView(
                physics: BouncingScrollPhysics(),
                slivers: [
                  SliverPadding(padding: EdgeInsets.only(top: 10)),
                  /*SliverAppBar(
                    backgroundColor: Colors.white,
                    pinned: false,
                    stretch: false,
                    snap: false,
                    floating: true,
                    expandedHeight: 70,
                    flexibleSpace: FlexibleSpaceBar(
                      background: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 10, right: 10),
                            child: Container(
                              height: 50,
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15)),
                                  color: Colors.white,
                                  border: Border.all(
                                      color: Color(0xffe7e7e7), width: 1),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Color(0xfff5f5f5),
                                        spreadRadius: 1,
                                        blurRadius: 5,
                                        blurStyle: BlurStyle.outer)
                                  ]),
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(left: 10, right: 10),
                                child: TextField(
                                  controller: sodasearchContoller,
                                  onChanged: (value) {
                                    setState(() {

                                    });
                                  },
                                  cursorColor: Color(0xff7E8286),
                                  decoration: InputDecoration(
                                    icon: Image(
                                      image: AssetImage("images/search.webp"),
                                      width: 25,
                                      height: 25,
                                      color: Color(0xffEF4F5F),
                                    ),
                                    hintText: "Search",
                                    hintStyle: GoogleFonts.nunito(
                                      fontSize: 17,
                                      color: Color(0xff7E8286),
                                    ),
                                    border: InputBorder.none,
                                  ),
                                  style: GoogleFonts.nunito(
                                      fontSize: 17,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w400),
                                ),
                              ),
                            ),
                          ),
                          Padding(padding: EdgeInsets.only(top: 15)),
                        ],
                      ),
                    ),
                  ),*/
                  SliverPadding(padding: EdgeInsets.only(top: 10)),
                  Obx(
                    () => SliverList.separated(
                      itemCount: pizzaController.sodalist.length,
                      itemBuilder: (context, index) {
                        return StatefulBuilder(
                          builder: (context, setState) {
                            return Padding(
                                padding:
                                    const EdgeInsets.only(right: 15, left: 15),
                                child: Container(
                                  width: double.infinity,
                                  height: 160,
                                  decoration: BoxDecoration(
                                      boxShadow: [
                                        //    0xfff5f5f5
                                        BoxShadow(
                                            color: Color(0xffe8e8e8),
                                            spreadRadius: 2,
                                            blurRadius: 10,
                                            blurStyle: BlurStyle.outer)
                                      ],
                                      color: Colors.white,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20))),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        flex: 3,
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              right: 10, left: 10),
                                          child: Container(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                SizedBox(
                                                  height: 15,
                                                ),
                                                Row(
                                                  children: [
                                                    Container(
                                                        width: 22,
                                                        height: 22,
                                                        decoration: BoxDecoration(
                                                            border: Border.all(
                                                                color: Color(
                                                                    0xffA45B40),
                                                                width: 1.5),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            5))),
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(2.0),
                                                          child: Image(
                                                            image: AssetImage(
                                                                "images/arrowup.webp"),
                                                            color: Color(
                                                                0xffA45B40),
                                                          ),
                                                        )),
                                                    SizedBox(
                                                      width: 15,
                                                    ),
                                                    Container(
                                                      width: 70,
                                                      height: 22,
                                                      decoration: BoxDecoration(
                                                          color:
                                                              Color(0xffDB9C07),
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          5))),
                                                      child: Center(
                                                        child: Text(
                                                            "Bestseller",
                                                            style: GoogleFonts.nunito(
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 12,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500)),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Text(
                                                    "${pizzaController.sodalist[index].name}",
                                                    maxLines: 2,
                                                    style: GoogleFonts.nunito(
                                                        color:
                                                            Color(0xff373D4D),
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.w700)),
                                                SizedBox(
                                                  height: 1,
                                                ),
                                                Text(
                                                    "${pizzaController.sodalist[index].rating}",
                                                    style: GoogleFonts.nunito(
                                                        color:
                                                            Color(0xff535B6D),
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w500)),
                                                SizedBox(
                                                  height: 1,
                                                ),
                                                Row(
                                                  children: [
                                                    Image(
                                                      image: AssetImage(
                                                          "images/rupee.webp"),
                                                      width: 15,
                                                      height: 15,
                                                      color: Color(0xff1F1F1F),
                                                    ),
                                                    Text(
                                                        "${pizzaController.sodalist[index].price}",
                                                        style:
                                                            GoogleFonts.nunito(
                                                                color: Color(
                                                                    0xff1F1F1F),
                                                                fontSize: 15,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500)),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 18, bottom: 18),
                                        child: Container(
                                          width: 1.5,
                                          decoration: BoxDecoration(
                                              color: Color(0xffe5e5e5),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(5))),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 2,
                                        child: Column(
                                          children: [
                                            SizedBox(
                                              height: 15,
                                            ),
                                            Expanded(
                                              child: Container(
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          right: 10, left: 10),
                                                  child: Stack(
                                                    children: [
                                                      Align(
                                                        alignment:
                                                            FractionalOffset
                                                                .topCenter,
                                                        child: ClipRRect(
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          10)),
                                                          child: Image(
                                                            image: NetworkImage(
                                                                "${pizzaController.sodalist[index].image}"),
                                                            width: 120,
                                                            height: 120,
                                                            fit: BoxFit.cover,
                                                          ),
                                                        ),
                                                      ),
                                                      Align(
                                                        alignment: Alignment.bottomCenter,
                                                        child: adminController.isAdmin.value?
                                                            Container():
                                                        !pizzaController.sodalist[index].checkadd
                                                            ? GestureDetector(
                                                                onTap: () {
                                                                  setState(() =>
                                                                      pizzaController
                                                                          .Sodaadd(
                                                                              index));
                                                                },
                                                                child: Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                          .only(
                                                                          bottom:
                                                                              10),
                                                                  child:
                                                                      Container(
                                                                    width: 80,
                                                                    height: 35,
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      color: Color(
                                                                          0xffFFF6F7),
                                                                      border: Border.all(
                                                                          color:
                                                                              Color(0xffEF4F5F)),
                                                                      borderRadius:
                                                                          BorderRadius.all(
                                                                              Radius.circular(10)),
                                                                    ),
                                                                    child:
                                                                        Center(
                                                                      child: Text(
                                                                          "Add",
                                                                          style: GoogleFonts.nunito(
                                                                              color: Color(0xffEF4F5F),
                                                                              fontSize: 17,
                                                                              fontWeight: FontWeight.w500)),
                                                                    ),
                                                                  ),
                                                                ),
                                                              )
                                                            : Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .only(
                                                                        bottom:
                                                                            10),
                                                                child:
                                                                    Container(
                                                                  width: 80,
                                                                  height: 35,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    color: Color(
                                                                        0xffEF4F5F),
                                                                    border: Border.all(
                                                                        color: Color(
                                                                            0xffEF4F5F)),
                                                                    borderRadius:
                                                                        BorderRadius.all(
                                                                            Radius.circular(10)),
                                                                  ),
                                                                  child: Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .spaceAround,
                                                                    children: [
                                                                      GestureDetector(
                                                                        onTap:
                                                                            () {
                                                                          setState(() =>
                                                                              pizzaController.Sodaremove(index));
                                                                        },
                                                                        child: Icon(
                                                                            Icons
                                                                                .remove,
                                                                            color:
                                                                                Colors.white,
                                                                            size: 20),
                                                                      ),
                                                                      Center(
                                                                        child: Text(
                                                                            "${pizzaController.sodalist[index].selectitem}",
                                                                            style: GoogleFonts.nunito(
                                                                                color: Colors.white,
                                                                                fontSize: 17,
                                                                                fontWeight: FontWeight.w500)),
                                                                      ),
                                                                      GestureDetector(
                                                                        onTap:
                                                                            () {
                                                                          setState(() =>
                                                                              pizzaController.Sodaplus(index));
                                                                        },
                                                                        child: Icon(
                                                                            Icons
                                                                                .add,
                                                                            color:
                                                                                Colors.white,
                                                                            size: 20),
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
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ));
                          },
                        );
                      },
                      separatorBuilder: (context, index) {
                        return SizedBox(
                          height: 15,
                        );
                      },
                    ),
                  )
                ],
              ),
              Obx(() => Align(
                    alignment: Alignment.bottomCenter,
                    child: adminController.isAdmin.value
                        ? Container()
                        : pizzaController.isBootomSheet.value
                            ? Container(
                                width: double.infinity,
                                height: 60,
                                color: Colors.white,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 15, right: 15),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: GestureDetector(
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
                                                return BottomSheetDialog(
                                                  pizzaindex: 0,
                                                  data: [],
                                                );
                                              },
                                            );
                                          },
                                          child: Container(
                                            height: 40,
                                            child: Row(
                                              children: [
                                                Image(
                                                  image: AssetImage(
                                                      "images/order.webp"),
                                                  color: Color(0xff40495D),
                                                  width: 20,
                                                  height: 20,
                                                ),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                Text(
                                                  "ITEM ADDED",
                                                  style: GoogleFonts.lexend(
                                                    fontSize: 13,
                                                    fontWeight: FontWeight.w600,
                                                    color: Color(0xff40495D),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                Icon(
                                                  Icons.arrow_drop_up_rounded,
                                                  color: Color(0xffEF4F5F),
                                                  size: 20,
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Container(
                                          height: 40,
                                          child: ElevatedButton(
                                              style: ButtonStyle(
                                                  shape: MaterialStateProperty
                                                      .all(RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          10)))),
                                                  backgroundColor:
                                                      MaterialStateProperty.all(
                                                          Color(0xffEF4F5F))),
                                              onPressed: () {
                                                setState(() {
                                                  pizzaController
                                                      .Sodatotalprice();
                                                  bottomController
                                                      .currentindex.value = 3;
                                                });
                                              },
                                              child: Text(
                                                "Next",
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    color: Colors.white),
                                              )),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              )
                            : Container(),
                  ))
            ],
          ),
        ));
  }

  void ref() {
    setState(() {});
  }
}
