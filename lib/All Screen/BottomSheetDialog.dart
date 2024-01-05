import 'dart:typed_data';

import 'package:Pizza/Controller/BottomController.dart';
import 'package:Pizza/Controller/PizzaController.dart';
import 'package:Pizza/ModelClass/PizzaItemModelClass.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';


class BottomSheetDialog extends StatefulWidget {
  int pizzaindex;
  List<PizzaItemModel> data;

  BottomSheetDialog({
    super.key,
    required this.pizzaindex,
    required this.data,
  });

  @override
  State<BottomSheetDialog> createState() => _BottomSheetDialogState();
}

class _BottomSheetDialogState extends State<BottomSheetDialog> {
  PizzaController pizzaController = Get.find();
  List<PizzaItemModel> pizzalist = [];
  int pizzaindex = 0;
  BottomController bottomController = Get.find();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    pizzalist = widget.data;
    pizzaindex = widget.pizzaindex;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height / 2,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(20), topLeft: Radius.circular(20)),
      ),
      child: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.only(right: 15, left: 15),
            child: Row(
              children: [
                Text(
                  "Items added",
                  style: GoogleFonts.lexend(
                      color: Color(0xff293041),
                      fontSize: 20,
                      fontWeight: FontWeight.w500),
                ),
                Spacer(),
                GestureDetector(
                  onTap: () {
                    for (int i = 0; i < pizzaController.pizzabottomlist.length; i++) {
                      if (pizzaController.pizzabottomlist[i].food.contains("soda")) {
                        pizzaController.Sodaclear(context);
                        print("soda");
                        print("qqqqqqqqqqqqqqqqqqqqqqqqqqqqqq");
                      } else {
                        pizzaController.Pizzaclear(context);
                        print("pizza");
                      }

                      setState(() {});
                      pizzaController.update();
                      print("2222222222222222222222222222222");
                    }
                  },
                  child: Text(
                    "Clear all",
                    style: TextStyle(
                        color: Color(0xff9EA3B0),
                        fontSize: 16,
                        fontWeight: FontWeight.w400),
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            width: double.infinity,
            height: 1,
            color: Color(0xffF9FAFB),
          ),
          SizedBox(
            height: 20,
          ),
          Expanded(
            child: Container(
              width: double.infinity,
              child: ListView(
                physics: BouncingScrollPhysics(),
                shrinkWrap: true,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 12, left: 12),
                    child: Container(
                      width: double.infinity,
                      child: ListView.separated(
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        physics: NeverScrollableScrollPhysics(),
                        padding: EdgeInsets.only(bottom: 20),
                        itemCount: pizzaController.pizzabottomlist.length,
                        itemBuilder: (context, index) {
                          return Row(
                            children: [
                              ClipRRect(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15)),
                                  child: Image(
                                    image: AssetImage(
                                        "${pizzaController.pizzabottomlist[index].image}"),
                                    width: 80,
                                    height: 80,
                                    fit: BoxFit.cover,
                                  )),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 10, right: 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: 150,
                                      child: Text(
                                        "${pizzaController.pizzabottomlist[index].name}",
                                        maxLines: 1,
                                        style: GoogleFonts.nunito(
                                          color: Color(0xff373D4D),
                                          fontSize: 17,
                                          fontWeight: FontWeight.w700,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    Text("4.3 ratings",
                                        style: GoogleFonts.nunito(
                                            color: Color(0xff535B6D),
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500)),
                                    Row(
                                      children: [
                                        Image(
                                          image: AssetImage("images/rupee.png"),
                                          width: 15,
                                          height: 15,
                                          color: Color(0xff1F1F1F),
                                        ),
                                        Text(
                                            "${pizzaController.pizzabottomlist[index].price}",
                                            style: GoogleFonts.nunito(
                                                color: Color(0xff1F1F1F),
                                                fontSize: 15,
                                                fontWeight: FontWeight.w500))
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Spacer(),
                              Obx(
                                () => Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: 80,
                                      height: 35,
                                      decoration: BoxDecoration(
                                        color: Color(0xffEF4F5F),
                                        border: Border.all(
                                            color: Color(0xffEF4F5F)),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              if (pizzaController.pizzabottomlist[index].food.contains("soda")) {
                                                pizzaController.Sodabottomremove(index, context);
                                                print("soda");
                                              } else {
                                                pizzaController
                                                    .Pizzabottomremove(
                                                        pizzaindex,
                                                        index,
                                                        context);

                                                print("pizza");
                                              }
                                              setState(() {});
                                              pizzaController.update();
                                              pizzaController.refresh();
                                            },
                                            child: Icon(Icons.remove,
                                                color: Colors.white, size: 20),
                                          ),
                                          Center(
                                            child: Text(
                                                "${pizzaController.pizzabottomlist[index].selectitem}",
                                                style: GoogleFonts.nunito(
                                                    color: Colors.white,
                                                    fontSize: 17,
                                                    fontWeight:
                                                        FontWeight.w500)),
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              if (pizzaController
                                                  .pizzabottomlist[index].food
                                                  .contains("soda")) {
                                                pizzaController.Sodabottompluse(
                                                    index);
                                                print("soda");
                                              } else {
                                                pizzaController.Pizzabottomplus(
                                                    index);
                                                print("pizza");
                                              }
                                              setState(() {});
                                              pizzaController.update();
                                              pizzaController.refresh();
                                            },
                                            child: Icon(Icons.add,
                                                color: Colors.white, size: 20),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Image(
                                          image: AssetImage("images/rupee.png"),
                                          width: 15,
                                          height: 15,
                                          color: Color(0xff1F1F1F),
                                        ),
                                        Obx(
                                          () => Text(
                                              "${pizzaController.pizzabottomlist[index].foodbill}",
                                              style: GoogleFonts.nunito(
                                                  color: Color(0xff1F1F1F),
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w500)),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          );
                        },
                        separatorBuilder: (context, index) {
                          return SizedBox(
                            height: 20,
                          );
                        },
                      ),
                    ),
                  ),


                  Padding(
                    padding: const EdgeInsets.only(right: 12, left: 12),
                    child: Container(
                      width: double.infinity,
                      child: ListView.separated(
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        physics: NeverScrollableScrollPhysics(),
                        padding: EdgeInsets.only(bottom: 20),
                        itemCount: pizzaController.customizepizzalist[0].pizzametalist!.length,
                        itemBuilder: (context, index) {
                          return Row(
                            children: [
                              ClipRRect(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15)),
                                child: Image(
                                  image: MemoryImage(pizzaController
                                      .customizepizzalist[0]
                                      .pizzametalist![index]
                                      .customPizzametaUint8list),
                                  width: 80,
                                  height: 80,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 10, right: 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: 150,
                                      child: Text(
                                        "Customize Pizza",
                                        maxLines: 1,
                                        style: GoogleFonts.nunito(
                                          color: Color(0xff373D4D),
                                          fontSize: 17,
                                          fontWeight: FontWeight.w700,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    Text(
                                        "Size : ${pizzaController.addsizelist![index].name}",
                                        style: GoogleFonts.nunito(
                                            color: Color(0xff535B6D),
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500)),
                                    Row(
                                      children: [
                                        Image(
                                          image: AssetImage("images/rupee.png"),
                                          width: 15,
                                          height: 15,
                                          color: Color(0xff1F1F1F),
                                        ),
                                        Text(
                                            "${pizzaController.customizepizzalist[0].pizzametalist![index].customPizzametaPrice}",
                                            style: GoogleFonts.nunito(
                                                color: Color(0xff1F1F1F),
                                                fontSize: 15,
                                                fontWeight: FontWeight.w500)),

                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Spacer(),
                              Obx(
                                () => Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: 80,
                                      height: 35,
                                      decoration: BoxDecoration(
                                        color: Color(0xffEF4F5F),
                                        border: Border.all(
                                            color: Color(0xffEF4F5F)),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              setState((){
                                                pizzaController.custompizzaRemove(index);
                                              });
                                            },
                                            child: Icon(Icons.remove,
                                                color: Colors.white, size: 20),
                                          ),
                                          Center(
                                            child: Text(
                                                "${pizzaController.customizepizzalist[0].pizzametalist![index].customPizzametaSelectitem}",
                                                style: GoogleFonts.nunito(
                                                    color: Colors.white,
                                                    fontSize: 17,
                                                    fontWeight:
                                                        FontWeight.w500)),
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                pizzaController.custompizzaPlus(index);
                                              });

                                            },
                                            child: Icon(Icons.add,
                                                color: Colors.white, size: 20),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Image(
                                          image: AssetImage("images/rupee.png"),
                                          width: 15,
                                          height: 15,
                                          color: Color(0xff1F1F1F),
                                        ),
                                        Text(
                                            "${pizzaController.customizepizzalist[0].pizzametalist![index].customPizzametaBill}",
                                            style: GoogleFonts.nunito(
                                                color: Color(0xff1F1F1F),
                                                fontSize: 15,
                                                fontWeight: FontWeight.w500)),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          );
                        },
                        separatorBuilder: (context, index) {
                          return SizedBox(
                            height: 20,
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            width: double.infinity,
            height: 50,
            decoration: BoxDecoration(color: Colors.white, boxShadow: [
              BoxShadow(
                  color: Colors.black26, blurRadius: 5, offset: Offset(15, 0))
            ]),
            child: Row(
              //innner----------------------------------------------------)
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(left: 12),
                      child: Container(
                        height: 40,
                        child: Row(
                          children: [
                            Image(
                              image: AssetImage("images/order.png"),
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
                              Icons.arrow_drop_down_rounded,
                              color: Color(0xffEF4F5F),
                              size: 20,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.only(right: 12),
                    height: 40,
                    child: ElevatedButton(
                        style: ButtonStyle(
                            shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)))),
                            backgroundColor:
                                MaterialStateProperty.all(Color(0xffEF4F5F))),
                        onPressed: () {

                          Navigator.pop(context);

                          for (int i = 0; i < pizzaController.pizzabottomlist.length; i++) {
                            if (pizzaController.pizzabottomlist[i].food.contains("soda")) {
                              pizzaController.Sodatotalprice();
                              print("soda");
                            } else {
                              pizzaController.Pizzatotalprice();
                              print("pizza");
                            }
                            bottomController.currentindex.value = 3;
                            pizzaController.update();
                            setState(() {});
                          }
                        },
                        child: Text(
                          "Next",
                          style: TextStyle(fontSize: 16,color: Colors.white),
                        )),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
  void ref(){
    setState(() {});
  }
}
