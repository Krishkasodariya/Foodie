/*
import 'package:dotted_dashed_line/dotted_dashed_line.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:Pizza/Controller/PizzaController.dart';
import 'package:Pizza/ModelClass/OrderFoodItemModel.dart';
import 'package:Pizza/ModelClass/OrderFoodItemModel.dart';

class YourOrderScreen extends StatefulWidget {
  const YourOrderScreen({super.key});

  @override
  State<YourOrderScreen> createState() => _YourOrderScreenState();
}

class _YourOrderScreenState extends State<YourOrderScreen> {
  PizzaController pizzaController=Get.find();
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

      body: Container(
        width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
        children: [
          SizedBox(height: 20,),
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
                "YOUR ORDER",
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
          SizedBox(height: 15,),

          Expanded(
            child: ListView(
              children: [
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Container(
                  padding: EdgeInsets.only(top: 10, bottom: 10),
                  width: double.infinity,
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20))),
                  child: ListView.separated(
                    itemCount: pizzaController.yourOrderlist[0].yourOrderBottomList.length,
                    physics: BouncingScrollPhysics(),
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemBuilder: (context, index){
                      return Padding(
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        child: Container(
                          width: double.infinity,
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  ClipRRect(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(15)),
                                      child:
                                      Image(
                                        image: AssetImage(
                                            "${pizzaController.yourOrderlist[0].yourOrderBottomList![index].image}"),
                                        width: 70,
                                        height: 70,
                                        fit: BoxFit.cover,
                                      )),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10, right: 10),
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                      MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          width: 150,
                                          child: pizzaController.yourOrderlist[0].yourOrderBottomList[index].name!=null?
                                          Text(
                                            "${pizzaController.yourOrderlist[0].yourOrderBottomList[index].name}",
                                            maxLines: 1,
                                            style: GoogleFonts.nunito(
                                              color: Color(0xff373D4D),
                                              fontSize: 15,
                                              fontWeight: FontWeight.w700,
                                            ),
                                            overflow:
                                            TextOverflow.ellipsis,
                                          ):
                                          Text(
                                            "1111111",
                                            maxLines: 1,
                                            style: GoogleFonts.nunito(
                                              color: Color(0xff373D4D),
                                              fontSize: 15,
                                              fontWeight: FontWeight.w700,
                                            ),
                                            overflow:
                                            TextOverflow.ellipsis,
                                          ),
                                        ),
                                        Text("4.3 ratings",
                                            style: GoogleFonts.nunito(
                                                color: Color(0xff535B6D),
                                                fontSize: 13,
                                                fontWeight:
                                                FontWeight.w500)),
                                        Row(
                                          children: [
                                            Image(
                                              image: AssetImage(
                                                  "images/rupee.webp"),
                                              width: 13,
                                              height: 13,
                                              color: Color(0xff1F1F1F),
                                            ),
                                            Text(
                                                "${pizzaController.yourOrderlist[0].yourOrderBottomList[index].price}",
                                                style: GoogleFonts.nunito(
                                                    color:
                                                    Color(0xff1F1F1F),
                                                    fontSize: 13,
                                                    fontWeight:
                                                    FontWeight.w500)),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  Spacer(),
                                  Obx(() => Column(
                                      mainAxisAlignment:
                                      MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          width: 75,
                                          height: 30,
                                          decoration: BoxDecoration(
                                            color: Color(0xffFFF6F7),
                                            boxShadow: [
                                              BoxShadow(
                                                  color:
                                                  Color(0xffdedede),
                                                  blurRadius: 5,
                                                  blurStyle:
                                                  BlurStyle.outer)
                                            ],
                                            border: Border.all(
                                                color: Color(0xffEF4F5F)),
                                            borderRadius:
                                            BorderRadius.all(Radius.circular(10)),
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                            children: [
                                              Center(
                                                child: Text(
                                                    "${pizzaController.yourOrderlist[0].yourOrderBottomList![index].selectitem}",
                                                    style: GoogleFonts
                                                        .nunito(
                                                        color: Colors
                                                            .black,
                                                        fontSize: 16,
                                                        fontWeight:
                                                        FontWeight
                                                            .w500)),
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
                                              color: Color(0xff1F1F1F),
                                            ),
                                            Obx(() => Text(
                                                  "${pizzaController.yourOrderlist[0].yourOrderBottomList[index].foodbill}",
                                                  style:
                                                  GoogleFonts.nunito(
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
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Container(
                  padding: EdgeInsets.only(top: 10, bottom: 10),
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20))),
                  child: ListView.separated(
                    itemCount: pizzaController.yourOrderlist[0].yourOrderPizzaMetalist!.length,
                    physics: BouncingScrollPhysics(),
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding:
                        const EdgeInsets.only(left: 10, right: 10),
                        child: Container(
                          width: double.infinity,
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  ClipRRect(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(15)),
                                      child:
                                      Image(
                                        image: MemoryImage( pizzaController.yourOrderlist[0].yourOrderPizzaMetalist![index]
                                            .customPizzametaUint8list),
                                        width: 70,
                                        height: 70,
                                        fit: BoxFit.cover,
                                      )),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10, right: 10),
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                      MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          width: 150,
                                          child: Text(
                                            "Customize Pizza",
                                            maxLines: 1,
                                            style: GoogleFonts.nunito(
                                              color: Color(0xff373D4D),
                                              fontSize: 15,
                                              fontWeight: FontWeight.w700,
                                            ),
                                            overflow:
                                            TextOverflow.ellipsis,
                                          ),
                                        ),
                                        Text(
                                            "Size : ${pizzaController.yourOrderlist[0].yourOrderSizelist![index].name}",
                                            style: GoogleFonts.nunito(
                                                color: Color(0xff535B6D),
                                                fontSize: 13,
                                                fontWeight:
                                                FontWeight.w500)),
                                        Row(
                                          children: [
                                            Image(
                                              image: AssetImage(
                                                  "images/rupee.webp"),
                                              width: 13,
                                              height: 13,
                                              color: Color(0xff1F1F1F),
                                            ),
                                            Text(
                                                "${pizzaController.yourOrderlist[0].yourOrderPizzaMetalist![index].customPizzametaPrice}",
                                                style: GoogleFonts.nunito(
                                                    color:
                                                    Color(0xff1F1F1F),
                                                    fontSize: 13,
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
                                    MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        width: 75,
                                        height: 30,
                                        decoration: BoxDecoration(
                                          color: Color(0xffFFF6F7),
                                          boxShadow: [
                                            BoxShadow(
                                                color: Color(0xffdedede),
                                                blurRadius: 5,
                                                blurStyle:
                                                BlurStyle.outer)
                                          ],
                                          border: Border.all(
                                              color: Color(0xffEF4F5F)),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10)),
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment
                                              .spaceAround,
                                          children: [

                                            Center(
                                              child: Text(
                                                  "${pizzaController.yourOrderlist[0].yourOrderPizzaMetalist![index].customPizzametaSelectitem}",
                                                  style:
                                                  GoogleFonts.nunito(
                                                      color: Colors
                                                          .black,
                                                      fontSize: 16,
                                                      fontWeight:
                                                      FontWeight
                                                          .w500)),
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
                                            color: Color(0xff1F1F1F),
                                          ),
                                          Obx(
                                                () => Text(
                                                "${pizzaController.yourOrderlist[0].yourOrderPizzaMetalist![index].customPizzametaBill}",
                                                style: GoogleFonts.nunito(
                                                    color:
                                                    Color(0xff1F1F1F),
                                                    fontSize: 15,
                                                    fontWeight:
                                                    FontWeight.w500)),
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
            ],),
          )


        ],
      )),
    );
  }
}
*/
