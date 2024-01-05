import 'package:dotted_dashed_line/dotted_dashed_line.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:Pizza/Controller/PizzaController.dart';
import 'package:Pizza/ModelClass/OfferModel.dart';

class OfferScreen extends StatefulWidget {
  const OfferScreen({super.key});

  @override
  State<OfferScreen> createState() => _OfferScreenState();
}

class _OfferScreenState extends State<OfferScreen> {
  PizzaController pizzaController = Get.find();

  //bool buttonOneCheck=false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    pizzaController.Allupdate(ref);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Navigator.pop(context,);
        setState(() {});
        return null!;
      },
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context,);
              setState(() {});
            },
            child: Icon(
              Icons.arrow_back_rounded,
              size: 26,
              color: Colors.black,
            ),
          ),
          title: Text("Coupons for you",
              style: TextStyle(color: Colors.black, fontSize: 20)),
        ),
        body: Container(
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
                      "BEST OFFER FOR YOU",
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
                  child: Container(
                    width: double.infinity,
                    child: ListView.separated(
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(left: 15, right: 15),
                            child: Container(
                              width: double.infinity,
                              height: !pizzaController.offerlist[index].check
                                  ? 187
                                  : 350,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20)),
                                  border: Border.all(
                                      color:
                                          !pizzaController.offerlist[index].apply
                                              ? Color(0xffDEE9FE)
                                              : Color(0xffFEDEDE),
                                      width: 1)),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 15,
                                  ),
                                  Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(left: 15),
                                        child: Lottie.asset(
                                            "${pizzaController.offerlist[index].image}",
                                            width: 27,
                                            height: 27),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 10),
                                        child: Text(
                                          "${pizzaController.offerlist[index].name}",
                                          style: GoogleFonts.nunito(
                                              fontSize: 18,
                                              color: Color(0xff313848),
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 55),
                                    child: Text(
                                      "${pizzaController.offerlist[index].subname}",
                                      style: GoogleFonts.nunito(
                                          fontSize: 16,
                                          color: Color(0xff7e878d),
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(left: 55),
                                        child: Container(
                                          padding: EdgeInsets.only(
                                              left: 10, right: 10, top: 3.5),
                                          height: 25,
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Color(0xff89898a)),
                                              color: Colors.white,
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(8))),
                                          child: Text(
                                            "SAVING CORNER",
                                            style: GoogleFonts.lexend(
                                                fontSize: 12,
                                                color: Color(0xff313848),
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ),
                                      ),
                                      Spacer(),
                                      GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            pizzaController
                                                    .offerlist[index].check =
                                                !pizzaController
                                                    .offerlist[index].check;
                                          });
                                        },
                                        child: pizzaController
                                                .offerlist[index].check
                                            ? Row(
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
                                              ),
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  pizzaController.offerlist[index].check
                                      ? Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 15, right: 15),
                                            child: Column(
                                              children: [
                                                DottedDashedLine(
                                                  height: 0,
                                                  width: double.infinity,
                                                  axis: Axis.horizontal,
                                                  dashColor: Color(0xffDAD9DD),
                                                  strokeWidth: 1,
                                                  dashSpace: 3,
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 8),
                                                      child: Container(
                                                        width: 8,
                                                        height: 8,
                                                        decoration: BoxDecoration(
                                                            color:
                                                                Color(0xff737b81),
                                                            shape:
                                                                BoxShape.circle),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 10,
                                                    ),
                                                    Text(
                                                      "Valid on total value of items above \nprice or more.",
                                                      style: GoogleFonts.nunito(
                                                        fontSize: 16,
                                                        color: Color(0xff7e878d),
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      ),
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      maxLines: 2,
                                                    )
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 8),
                                                      child: Container(
                                                        width: 8,
                                                        height: 8,
                                                        decoration: BoxDecoration(
                                                            color:
                                                                Color(0xff737b81),
                                                            shape:
                                                                BoxShape.circle),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 10,
                                                    ),
                                                    Text(
                                                      "Offer valid twice per user during\n the offer period",
                                                      style: GoogleFonts.nunito(
                                                        fontSize: 16,
                                                        color: Color(0xff7e878d),
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      ),
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      maxLines: 2,
                                                    )
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 8),
                                                      child: Container(
                                                        width: 8,
                                                        height: 8,
                                                        decoration: BoxDecoration(
                                                            color:
                                                                Color(0xff737b81),
                                                            shape:
                                                                BoxShape.circle),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 10,
                                                    ),
                                                    Text(
                                                      "Maximum Discount price as above",
                                                      style: GoogleFonts.nunito(
                                                        fontSize: 16,
                                                        color: Color(0xff7e878d),
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      ),
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      maxLines: 2,
                                                    )
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        )
                                      : Container(),
                                  !pizzaController.offerlist[index].apply
                                      ? Container(
                                          height: 1, color: Color(0xffDEE9FE))
                                      : Container(
                                          height: 1, color: Color(0xffFEDEDE)),
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        pizzaController.appliedOffer(
                                            index, context);
                                      });

                                    },
                                    child: !pizzaController.offerlist[index].apply
                                        ? Container(
                                            width: double.infinity,
                                            height: 46,
                                            decoration: BoxDecoration(
                                                color: Color(0xffF7FAFF),
                                                borderRadius: BorderRadius.only(
                                                    bottomRight:
                                                        Radius.circular(20),
                                                    bottomLeft:
                                                        Radius.circular(20))),
                                            child: Center(
                                                child: Text("TAP TO APPLY",
                                                    style: GoogleFonts.lexend(
                                                        color: Color(0xff367AF0),
                                                        fontSize: 15))),
                                          )
                                        : Container(
                                            width: double.infinity,
                                            height: 46,
                                            decoration: BoxDecoration(
                                                color: Color(0xfffff7f7),
                                                borderRadius: BorderRadius.only(
                                                    bottomRight:
                                                        Radius.circular(20),
                                                    bottomLeft:
                                                        Radius.circular(20))),
                                            child: Center(
                                                child: Text("CANCEL",
                                                    style: GoogleFonts.lexend(
                                                        color: Color(0xfff03636),
                                                        fontSize: 15))),
                                          ),
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
                        itemCount: pizzaController.offerlist.length),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
              ],
            )),
      ),
    );
  }

  void ref() {
    setState(() {});
  }
}
