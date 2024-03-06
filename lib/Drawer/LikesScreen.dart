import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:page_transition/page_transition.dart';
import 'package:Pizza/All%20Screen/PizzaScreen.dart';
import 'package:Pizza/Controller/PizzaController.dart';
import 'package:shimmer/shimmer.dart';

class LikesScreen extends StatefulWidget {
  const LikesScreen({super.key});

  @override
  State<LikesScreen> createState() => _LikesScreenState();
}

class _LikesScreenState extends State<LikesScreen> {
  PizzaController pizzaController = Get.find();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     backgroundColor: Colors.white,
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
        title: Text("Like Screen",
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
            SizedBox(
              height: 20,
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
                  "LIKE ORDER",
                  style: GoogleFonts.nunito(
                      color: Color(0xff7e878d),
                      fontSize: 16,
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
              height: 20,
            ),
            pizzaController.likelist.isNotEmpty
                ? Expanded(
                    child: ListView.separated(
                      itemCount: pizzaController.likelist.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(left: 15, right: 15),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  PageTransition(
                                      type: PageTransitionType.rightToLeft,
                                      child: PizzaScreen(
                                          pizzaindex: index,
                                          data: pizzaController.likelist)));
                            },
                            child: Container(
                              width: double.infinity,
                              height: 290,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(30)),
                                  boxShadow: [
                                    //    0xfff5f5f5
                                    BoxShadow(
                                        color: Color(0xffe8e8e8),
                                        spreadRadius: 2,
                                        blurRadius: 10,
                                        blurStyle: BlurStyle.outer)
                                  ]),
                              child: Column(
                                children: [
                                  Container(
                                    width: double.infinity,
                                    height: 200,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(30),
                                          topRight: Radius.circular(30)),
                                      color: Colors.grey,
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(30),
                                          topRight: Radius.circular(30)),
                                      child: Container(
                                        width: double.infinity,
                                        height: 200,
                                        child: CarouselSlider.builder(
                                            itemCount: pizzaController
                                                .likelist[index]
                                                .foodimagelist
                                                .length,
                                            itemBuilder: (context, iindex, realIndex) {
                                              return Stack(
                                                children: [

                                                  CachedNetworkImage(
                                                      imageUrl: "${ pizzaController.likelist[index].foodimagelist[iindex].image}",
                                                      placeholder: (context, url) =>
                                                          Shimmer.fromColors(
                                                              direction: ShimmerDirection.ltr,
                                                              enabled: true,
                                                              baseColor: Colors
                                                                  .grey
                                                                  .shade300,
                                                              highlightColor:
                                                              Colors.grey
                                                                  .shade100,
                                                              child:
                                                              Container(
                                                                color: Colors
                                                                    .grey,
                                                              )),
                                                      width: double.infinity,
                                                      height: 200,
                                                      fit: BoxFit.cover),
                                                  Padding(
                                                    padding:
                                                    const EdgeInsets.only(top: 15, right: 15),
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment
                                                          .end,
                                                      crossAxisAlignment: CrossAxisAlignment
                                                          .start,
                                                      children: [
                                                        Expanded(
                                                          child: Padding(
                                                            padding: const EdgeInsets.only(
                                                                left: 10, right: 10),
                                                            child: Container(
                                                              height: 30,
                                                              decoration: BoxDecoration(
                                                                  color: Colors.black38,
                                                                  border: Border.all(
                                                                      color: Colors.black54,
                                                                      width: 1),
                                                                  borderRadius: BorderRadius
                                                                      .all(
                                                                      Radius.circular(8))),
                                                              child: Padding(
                                                                padding: const EdgeInsets
                                                                    .only(
                                                                    left: 10, right: 10),
                                                                child: Row(
                                                                  children: [
                                                                    Container(
                                                                      width: 185,
                                                                      child: Text(
                                                                          "${pizzaController
                                                                              .likelist[index].foodimagelist[iindex].name}",
                                                                          style: GoogleFonts.nunito(
                                                                            color: Colors.white,
                                                                            fontSize: 16,
                                                                            fontWeight:
                                                                            FontWeight.w600,),
                                                                          overflow:TextOverflow.ellipsis,
                                                                          maxLines: 1),
                                                                    ),
                                                                    SizedBox(
                                                                      width: 5,
                                                                    ),
                                                                    Center(
                                                                      child: Container(
                                                                        width: 4,
                                                                        height: 4,
                                                                        decoration: BoxDecoration(
                                                                            color: Colors.white,
                                                                            shape: BoxShape.circle),
                                                                      ),
                                                                    ),
                                                                    SizedBox(
                                                                      width: 5,
                                                                    ),
                                                                    Image(
                                                                      image: AssetImage("images/rupee.webp"),
                                                                      color: Colors.white,
                                                                      width: 16,
                                                                      height: 16,
                                                                    ),
                                                                    Text(
                                                                        "${pizzaController
                                                                            .likelist[index].foodimagelist[iindex].price}",
                                                                        style: GoogleFonts
                                                                            .nunito(
                                                                            color: Colors
                                                                                .white,
                                                                            fontSize: 15,
                                                                            fontWeight:
                                                                            FontWeight.w600)),
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),

                                                        Obx(()=> Container(
                                                          child: GestureDetector(
                                                              onTap:()async{
                                                                setState(() {
                                                                  pizzaController.likeLike(index);
                                                                });

                                                              },
                                                              child:!pizzaController
                                                                  .likelist[index].checklike?Image(
                                                                image: AssetImage("images/like.webp"),
                                                                width: 29,
                                                                height: 29,
                                                                fit: BoxFit.cover,
                                                                color: Colors.white,
                                                              ):Image(
                                                                image: AssetImage("images/fill_like.webp"),
                                                                width: 29,
                                                                height: 29,
                                                                fit: BoxFit.cover,
                                                              )),

                                                        ),
                                                        ),

                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              );
                                            },
                                            options: CarouselOptions(
                                              onPageChanged: (iindex, reason) {
                                                setState(() {
                                                  pizzaController.pizzaindex.value = iindex;
                                                });
                                              },
                                              aspectRatio: 16 / 9,
                                              viewportFraction: 1,
                                              autoPlayCurve:
                                                  Curves.fastOutSlowIn,
                                            )),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.only(
                                              bottomLeft: Radius.circular(30),
                                              bottomRight:
                                                  Radius.circular(30))),
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 15, right: 15, top: 5),
                                        child: Column(
                                          children: [
                                            Row(
                                              children: [
                                                Text(
                                                  "${pizzaController.likelist[index].name}",
                                                  style: GoogleFonts.lexend(
                                                      fontSize: 19,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                                Spacer(),
                                                Container(
                                                    width: 43,
                                                    height: 23,
                                                    decoration: BoxDecoration(
                                                        color:
                                                            Color(0xff267E3E),
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    5))),
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 5,
                                                              right: 2),
                                                      child: Row(
                                                        children: [
                                                          Center(
                                                            child: Text(
                                                                "${pizzaController.likelist[index].rating}",
                                                                style: GoogleFonts.nunito(
                                                                    color: Colors
                                                                        .white,
                                                                    fontSize:
                                                                        14,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600)),
                                                          ),
                                                          Center(
                                                            child: Icon(
                                                              Icons
                                                                  .star_rounded,
                                                              size: 13,
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    ))
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  "${pizzaController.likelist[index].subname}",
                                                  style: GoogleFonts.nunito(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: Color(0xff8F94A4)),
                                                ),
                                                SizedBox(
                                                  width: 8,
                                                ),
                                                Center(
                                                  child: Container(
                                                    width: 5,
                                                    height: 5,
                                                    decoration: BoxDecoration(
                                                        color:
                                                            Color(0xff8F94A4),
                                                        shape: BoxShape.circle),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 8,
                                                ),
                                                Text(
                                                  "Rs.",
                                                  style: GoogleFonts.nunito(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: Color(0xff8F94A4)),
                                                ),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                Text(
                                                  "${pizzaController.likelist[index].price}",
                                                  style: GoogleFonts.nunito(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: Color(0xff8F94A4)),
                                                ),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                Text(
                                                  "for one",
                                                  style: GoogleFonts.nunito(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: Color(0xff8F94A4)),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Row(
                                              children: [
                                                Icon(
                                                  Icons.watch_later_rounded,
                                                  color: Color(0xff267E3E),
                                                  size: 17,
                                                ),
                                                SizedBox(
                                                  width: 4,
                                                ),
                                                Text(
                                                  "${pizzaController.likelist[index].time}",
                                                  style: GoogleFonts.nunito(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: Color(0xff8F94A4)),
                                                ),
                                                SizedBox(
                                                  width: 8,
                                                ),
                                                Center(
                                                  child: Container(
                                                    width: 5,
                                                    height: 5,
                                                    decoration: BoxDecoration(
                                                        color:
                                                            Color(0xff8F94A4),
                                                        shape: BoxShape.circle),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 8,
                                                ),
                                                Text(
                                                  "${pizzaController.likelist[index].distance}",
                                                  style: GoogleFonts.nunito(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: Color(0xff8F94A4)),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return SizedBox(
                          height: 20,
                        );
                      },
                    ),
                  )
                : Container(
                    width: 300,
                    height: 350,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Lottie.asset(
                          "images/search.json",
                          width: 150,
                          height: 150,
                        ),
                      ],
                    ),
                  ),
          ],
        ),
      ),
    );
  }

  void ref() {
    setState(() {});
  }
}
