import 'package:Pizza/All%20Screen/PizzaScreen.dart';
import 'package:Pizza/Controller/BottomController.dart';
import 'package:Pizza/Controller/PizzaController.dart';
import 'package:Pizza/Drawer/OfferScreen.dart';
import 'package:Pizza/ModelClass/FoodImageSlider.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:lottie/lottie.dart';
import 'package:page_transition/page_transition.dart';
import 'package:Pizza/All%20Screen/BottomSheetDialog.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class DinnerScreen extends StatefulWidget {
  const DinnerScreen({super.key});
  @override
  State<DinnerScreen> createState() => _DinnerScreenState();
}

class _DinnerScreenState extends State<DinnerScreen> {

  final formKey = GlobalKey<FormState>();

  PizzaController pizzaController = Get.find();
  var foodsearchContoller = TextEditingController();
  int sliderindex = 0;
  NativeAd ?nativeAd;
  bool isLoaded=false;
  BottomController bottomController = Get.find();
  List<FoodImageSlider> dinnerimagelist = [
    FoodImageSlider(
        image: "images/b1.jpg",
        description: "aa",
        offer: "aa",
        order: "aa",
        tital: "aa"),
    FoodImageSlider(
        image: "images/b2.jpg",
        description: "aa",
        offer: "aa",
        order: "aa",
        tital: "aa"),
    FoodImageSlider(
        image: "images/b12.jpg",
        description: "aa",
        offer: "aa",
        order: "aa",
        tital: "aa"),
    FoodImageSlider(
        image: "images/b3.jpg",
        description: "aa",
        offer: "aa",
        order: "aa",
        tital: "aa"),
  ];


  @override
  void initState(){
    // TODO: implement initState
    super.initState();
    loaded();
    pizzaController.UpdateLike(ref);
  }

  @override
  void dispose(){
    // TODO: implement dispose
    super.dispose();
    nativeAd!.dispose();
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
                  expandedHeight: 65,
                  flexibleSpace: FlexibleSpaceBar(
                    background: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          child: Container(
                            height: 50,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(
                                    Radius.circular(15)),
                                color: Colors.white,
                                border:
                                Border.all(color: Color(0xffe7e7e7), width: 1),
                                boxShadow: [
                                  BoxShadow(
                                      color: Color(0xfff5f5f5),
                                      spreadRadius: 1,
                                      blurRadius: 5,
                                      blurStyle: BlurStyle.outer)
                                ]),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 10, right: 10),
                              child: TextField(
                                controller: foodsearchContoller,
                                onChanged: (value) {
                                  dinnerSearch(value);
                                },
                                cursorColor: Color(0xff7E8286),
                                decoration: InputDecoration(
                                  icon: Image(
                                    image: AssetImage("images/search.png"),
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
                SliverAppBar(
                  backgroundColor: Colors.white,
                  pinned: false,
                  automaticallyImplyLeading: false,
                  snap: false,
                  stretch: true,
                  expandedHeight: 285,
                  flexibleSpace: FlexibleSpaceBar(
                    background: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      PageTransition(
                                          child: OfferScreen(),
                                          type:
                                          PageTransitionType.rightToLeft));
                                },
                                child: Padding(
                                  padding:
                                  const EdgeInsets.only(left: 10, right: 5),
                                  child: Container(
                                    height: 50,
                                    decoration: BoxDecoration(
                                        color: Color(0xffF2F2F2),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(15))),
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 10, right: 10),
                                      child: Row(
                                        children: [
                                          Text(
                                            "Offer Zone",
                                            style: GoogleFonts.nunito(
                                                color: Color(0xff404248),
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600),
                                          ),
                                          Spacer(),
                                          Lottie.asset("images/offer.json",
                                              width: 30, height: 30)
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      PageTransition(
                                          child: OfferScreen(),
                                          type:
                                          PageTransitionType.rightToLeft));
                                },
                                child: Padding(
                                  padding:
                                  const EdgeInsets.only(right: 10, left: 5),
                                  child: Container(
                                    height: 50,
                                    decoration: BoxDecoration(
                                        color: Color(0xffF2F2F2),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(15))),
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 10, right: 10),
                                      child: Row(
                                        children: [
                                          Text(
                                            "Free Delivery",
                                            style: GoogleFonts.nunito(
                                                color: Color(0xff404248),
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600),
                                          ),
                                          Spacer(),
                                          Lottie.asset(
                                              "images/freedelivery.json",
                                              width: 40,
                                              height: 40)
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                        Padding(padding: EdgeInsets.only(top: 20)),
                        Padding(
                          padding: const EdgeInsets.only(left: 13),
                          child: Container(
                            width: double.infinity,
                            height: 200,
                            child: CarouselSlider.builder(
                                itemCount: dinnerimagelist.length,
                                itemBuilder: (context, index, realIndex) {
                                  return Container(
                                    padding: EdgeInsets.only(right: 13),
                                    width: double.infinity,
                                    height: 200,
                                    child: ClipRRect(
                                      borderRadius:
                                      BorderRadius.all(Radius.circular(20)),
                                      child: Image(
                                        image: AssetImage(
                                            "${dinnerimagelist[index].image}"),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  );
                                },
                                options: CarouselOptions(
                                  onPageChanged: (index, reason) {
                                    setState(() {
                                      sliderindex = index;
                                    });
                                  },
                                  aspectRatio: 16 / 8,
                                  autoPlay: true,
                                  autoPlayAnimationDuration:
                                  Duration(milliseconds: 2200),
                                  autoPlayInterval:
                                  Duration(milliseconds: 2200),
                                  scrollPhysics: BouncingScrollPhysics(),
                                  viewportFraction: 0.93,
                                  enableInfiniteScroll: true,
                                  reverse: false,
                                  autoPlayCurve: Curves.fastOutSlowIn,
                                )),
                          ),
                        ),
                        AnimatedSmoothIndicator(
                          activeIndex: sliderindex,
                          count: dinnerimagelist.length,
                          effect: JumpingDotEffect(
                            activeDotColor: Color(0xffEF4F5F),
                            dotWidth: 8.5,
                            dotHeight: 8.5,
                            dotColor: Color(0xff787E91),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SliverPadding(padding: EdgeInsets.only(top: 15)),
                SliverToBoxAdapter(
                  child: Row(
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
                        "All Restaurants",
                        style: GoogleFonts.nunito(
                            color: Color(0xff5F666D),
                            fontSize: 18,
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
                ),
                SliverPadding(padding: EdgeInsets.only(top: 15)),
                SliverList.separated(
                  itemCount: pizzaController.pizzalist.length,
                  itemBuilder: (context, index) {

                    if(isLoaded && index % 4 == 2){
                      return Padding(
                        padding: const EdgeInsets.only(left: 15,right: 15),
                        child: StatefulBuilder(
                          builder: (context, setState) {
                           return Container(
                                width: double.infinity,
                                height: 290,
                                decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(30))),
                                child: AdWidget(key:formKey,ad: nativeAd!));
                          },

                        ),
                      );
                    }else{
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
                                        data: pizzaController.pizzalist)));
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
                                              .pizzalist[index]
                                              .foodimagelist
                                              .length,
                                          itemBuilder:
                                              (context, iindex, realIndex) {
                                            return Stack(
                                              children: [
                                                Image(
                                                    image: AssetImage(
                                                        "${pizzaController
                                                            .pizzalist[index]
                                                            .foodimagelist[iindex]
                                                            .image}"),
                                                    width: double.infinity,
                                                    height: 200,
                                                    fit: BoxFit.cover),
                                                Padding(
                                                  padding: const EdgeInsets.only(
                                                      top: 15, right: 15),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                    crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                    children: [
                                                      Expanded(
                                                        child: Padding(
                                                          padding:
                                                          const EdgeInsets
                                                              .only(
                                                              left: 10,
                                                              right: 10),
                                                          child: Container(
                                                            height: 30,
                                                            decoration: BoxDecoration(
                                                                color: Colors
                                                                    .black38,
                                                                border: Border
                                                                    .all(
                                                                    color: Colors
                                                                        .black54,
                                                                    width: 1),
                                                                borderRadius: BorderRadius
                                                                    .all(Radius
                                                                    .circular(
                                                                    8))),
                                                            child: Padding(
                                                              padding:
                                                              const EdgeInsets
                                                                  .only(
                                                                  left: 10,
                                                                  right: 10),
                                                              child: Row(
                                                                children: [
                                                                  Container(
                                                                    width: 185,
                                                                    child: Text(
                                                                        "${pizzaController
                                                                            .pizzalist[index]
                                                                            .foodimagelist[iindex]
                                                                            .name}",
                                                                        style: GoogleFonts
                                                                            .nunito(
                                                                          color: Colors
                                                                              .white,
                                                                          fontSize:
                                                                          16,
                                                                          fontWeight:
                                                                          FontWeight
                                                                              .w600,
                                                                        ),
                                                                        overflow:
                                                                        TextOverflow
                                                                            .ellipsis,
                                                                        maxLines:
                                                                        1),
                                                                  ),
                                                                  SizedBox(
                                                                    width: 10,
                                                                  ),
                                                                  Image(
                                                                    image: AssetImage(
                                                                        "images/rupee.png"),
                                                                    color: Colors
                                                                        .white,
                                                                    width: 16,
                                                                    height: 16,
                                                                  ),
                                                                  Text(
                                                                      "${pizzaController
                                                                          .pizzalist[index]
                                                                          .foodimagelist[iindex]
                                                                          .price}",
                                                                      style: GoogleFonts
                                                                          .nunito(
                                                                          color: Colors
                                                                              .white,
                                                                          fontSize:
                                                                          15,
                                                                          fontWeight:
                                                                          FontWeight
                                                                              .w600)),
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      Obx(
                                                            () =>
                                                            Container(
                                                              child: GestureDetector(
                                                                  onTap: () async {
                                                                    setState(() {
                                                                      pizzaController
                                                                          .dinnerLike(
                                                                          index);
                                                                    });
                                                                  },
                                                                  child: !pizzaController
                                                                      .pizzalist[
                                                                  index]
                                                                      .checklike
                                                                      ? Image(
                                                                    image: AssetImage(
                                                                        "images/like.png"),
                                                                    width: 29,
                                                                    height: 29,
                                                                    fit: BoxFit
                                                                        .cover,
                                                                    color: Colors
                                                                        .white,
                                                                  )
                                                                      : Image(
                                                                    image: AssetImage(
                                                                        "images/fill_like.png"),
                                                                    width: 29,
                                                                    height: 29,
                                                                    fit: BoxFit
                                                                        .cover,
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
                                                pizzaController.pizzaindex.value =
                                                    iindex;
                                              });
                                            },
                                            aspectRatio: 16 / 9,
                                            viewportFraction: 1,
                                            autoPlayCurve: Curves.fastOutSlowIn,
                                          )),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                            bottomLeft: Radius.circular(30),
                                            bottomRight: Radius.circular(30))),
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 15, right: 15, top: 5),
                                      child: Column(
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                "${pizzaController
                                                    .pizzalist[index].name}",
                                                style: GoogleFonts.lexend(
                                                    fontSize: 19,
                                                    fontWeight: FontWeight.w500),
                                              ),
                                              Spacer(),
                                              Container(
                                                  width: 43,
                                                  height: 23,
                                                  decoration: BoxDecoration(
                                                      color: Color(0xff267E3E),
                                                      borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(
                                                              5))),
                                                  child: Padding(
                                                    padding:
                                                    const EdgeInsets.only(
                                                        left: 5, right: 2),
                                                    child: Row(
                                                      children: [
                                                        Center(
                                                          child: Text(
                                                              "${pizzaController
                                                                  .pizzalist[index]
                                                                  .rating}",
                                                              style: GoogleFonts
                                                                  .nunito(
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize: 14,
                                                                  fontWeight:
                                                                  FontWeight
                                                                      .w600)),
                                                        ),
                                                        Center(
                                                          child: Icon(
                                                            Icons.star_rounded,
                                                            size: 13,
                                                            color: Colors.white,
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
                                                "${pizzaController
                                                    .pizzalist[index].subname}",
                                                style: GoogleFonts.nunito(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w600,
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
                                                      color: Color(0xff8F94A4),
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
                                                    fontWeight: FontWeight.w600,
                                                    color: Color(0xff8F94A4)),
                                              ),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              Text(
                                                "${pizzaController
                                                    .pizzalist[index].price}",
                                                style: GoogleFonts.nunito(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w600,
                                                    color: Color(0xff8F94A4)),
                                              ),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              Text(
                                                "for one",
                                                style: GoogleFonts.nunito(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w600,
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
                                                "${pizzaController
                                                    .pizzalist[index].time}",
                                                style: GoogleFonts.nunito(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w600,
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
                                                      color: Color(0xff8F94A4),
                                                      shape: BoxShape.circle),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 8,
                                              ),
                                              Text(
                                                "${pizzaController
                                                    .pizzalist[index].distance}",
                                                style: GoogleFonts.nunito(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w600,
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
                    }

                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return SizedBox(
                      height: 20,
                    );
                  },
                ),
                SliverPadding(padding: EdgeInsets.only(top: 20)),
              ],
            ),
            Obx(
                  () =>
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: pizzaController.isBootomSheet.value
                        ? Container(
                      width: double.infinity,
                      height: 60,
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 15, right: 15),
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
                                          topRight: Radius.circular(20),
                                          topLeft: Radius.circular(20)),
                                    ),
                                    context: context,
                                    builder: (context) {
                                      return BottomSheetDialog(
                                          pizzaindex: pizzaController
                                              .pizzaindex.value,
                                          data: pizzaController.pizzalist);
                                    },
                                  );
                                },
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
                                        shape: MaterialStateProperty.all(
                                            RoundedRectangleBorder(
                                                borderRadius:
                                                BorderRadius.all(
                                                    Radius.circular(
                                                        10)))),
                                        backgroundColor:
                                        MaterialStateProperty.all(
                                            Color(0xffEF4F5F))),
                                    onPressed: () {
                                      setState(() {
                                        pizzaController.Pizzatotalprice();
                                        bottomController.currentindex.value =
                                        3;
                                      });
                                    },
                                    child: Text(
                                      "Next",
                                      style: TextStyle(
                                          fontSize: 16, color: Colors.white),
                                    )),
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                        : Container(),
                  ),
            )
          ],
        ),
      ),
    );
  }

   loaded() {
    nativeAd = NativeAd(adUnitId: "ca-app-pub-3940256099942544/2247696110",

        factoryId: "listid",
        nativeTemplateStyle: NativeTemplateStyle(
            templateType: TemplateType.medium,
            mainBackgroundColor: Color(0xfff2f2f2),
            cornerRadius: 30,
            callToActionTextStyle: NativeTemplateTextStyle(
                textColor: Colors.black,
                backgroundColor: Colors.white,
                style: NativeTemplateFontStyle.bold,
                size: 19),
            primaryTextStyle: NativeTemplateTextStyle(
                textColor: Colors.black,
                backgroundColor: Colors.white,
                style: NativeTemplateFontStyle.italic,
                size: 16.0),
            secondaryTextStyle: NativeTemplateTextStyle(
                textColor: Colors.black,
                backgroundColor: Colors.white,
                style: NativeTemplateFontStyle.bold,
                size: 16.0),
            tertiaryTextStyle: NativeTemplateTextStyle(
                textColor: Colors.black,
                backgroundColor: Colors.white,
                style: NativeTemplateFontStyle.normal,
                size: 16.0)),
        listener: NativeAdListener(
          onAdOpened: (ad) {
            print("--Native---$ad-----onAdOpened--------");
          },
          onAdClicked: (ad) {
            print("--Native---$ad-----onAdClicked--------");
            setState(() {
              isLoaded=false;
              ad.dispose();
            });
          },
          onAdLoaded: (ad) {
            setState(() {
              isLoaded=true;
            });
            print("--Native---$ad-----onAdLoaded--------");
          },
          onAdFailedToLoad: (ad, error) {
            print("--Native---$ad-----onAdFailedToLoad-----$error---");
            ad.dispose();
            isLoaded = false;
          },
          onAdClosed: (ad) {
            setState(() {
              isLoaded=false;
            });
            print("--Native---$ad-----onAdClosed--------");
          },
        ),
        request: AdRequest())..load();
  }

  void ref() {
    setState(() {});
  }
}
