import 'package:Pizza/All%20Screen/AiFood.dart';
import 'package:Pizza/Controller/GoogleMapController.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import 'package:flutter_gradient_animation_text/flutter_gradient_animation_text.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:Pizza/All%20Screen/BottomSheetDialog.dart';
import 'package:Pizza/All%20Screen/CartScreen.dart';
import 'package:Pizza/All%20Screen/DinnerScreen.dart';
import 'package:Pizza/All%20Screen/ExitDialog.dart';
import 'package:Pizza/All%20Screen/AboutScreen.dart';
import 'package:Pizza/All%20Screen/SodaScreen.dart';
import 'package:Pizza/Controller/BottomController.dart';
import 'package:Pizza/Controller/PizzaController.dart';
import 'package:Pizza/ModelClass/EatingPizzaOne.dart';
import 'package:Pizza/ModelClass/EatingPizzaThree.dart';
import 'package:Pizza/ModelClass/EatingPizzaTwo.dart';
import 'package:Pizza/ModelClass/HomeCetegoriesModel.dart';
import 'package:page_transition/page_transition.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var homesearchContoller = TextEditingController();
  BottomController bottomController = Get.find();
  CarouselController carouselController = CarouselController();
  int sliderindex = 0;
  PizzaController pizzaController = Get.find();

  List<HomeCetegorieModel> categorieslist = [
    HomeCetegorieModel(
        name: "Food",
        image: "images/sfood.webp",
        navigate: DinnerScreen(),
        index: 1),
    HomeCetegorieModel(
        name: "Cold drinks",
        image: "images/soda.webp",
        navigate: SodaScreen(),
        index: 2),
    HomeCetegorieModel(
        name: "Cart",
        image: "images/basket.webp",
        navigate: CartScreen(),
        index: 3),
    /*  HomeCetegorieModel(
        name: "Genie",
        image: "images/genie.png",
        navigate: GenieScreen(),
      index: null
       ),*/
  ];
  List<String> homeimagelist = [
    "images/m2.webp",
    "images/m1.webp",
    "images/m4.webp",
    "images/m3.webp",
    "images/m5.webp",
  ];

  List<EatingPizzaOne> eatingOneList = [
    EatingPizzaOne(
        image: "images/e11.webp", name: "Farmhouse", pizza: "images/p11.webp"),
    EatingPizzaOne(
        image: "images/e1.webp", name: "Margherita", pizza: "images/p1.webp"),
    EatingPizzaOne(
        image: "images/e2.webp", name: "Veg Loaded", pizza: "images/p2.webp"),
    EatingPizzaOne(
        image: "images/e3.webp", name: "California", pizza: "images/p3.webp"),
    EatingPizzaOne(
        image: "images/e4.webp", name: "Cheese", pizza: "images/p4.webp"),
    EatingPizzaOne(
        image: "images/e5.webp", name: "Garden Fling", pizza: "images/p5.webp"),
    EatingPizzaOne(
        image: "images/e6.webp", name: "Bbq Paneer", pizza: "images/p6.webp"),
    EatingPizzaOne(
        image: "images/e7.webp", name: "Mexican", pizza: "images/p7.webp"),
    EatingPizzaOne(
        image: "images/e8.webp", name: "Tomatoes", pizza: "images/p8.webp"),
    EatingPizzaOne(
        image: "images/e9.webp", name: "Farmhouse", pizza: "images/p9.webp"),
    EatingPizzaOne(
        image: "images/e10.webp", name: "Margherita", pizza: "images/p10.webp"),
    EatingPizzaOne(
        image: "images/e12.webp", name: "Mexican", pizza: "images/p12.webp"),
  ];
  List<EatingPizzaTwo> eatingTwoList = [
    EatingPizzaTwo(image: "images/e5.webp"),
    EatingPizzaTwo(image: "images/e12.webp"),
    EatingPizzaTwo(image: "images/e11.webp"),
    EatingPizzaTwo(image: "images/e10.webp"),
    EatingPizzaTwo(image: "images/e9.webp"),
    EatingPizzaTwo(image: "images/e8.webp"),
    EatingPizzaTwo(image: "images/e7.webp"),
    EatingPizzaTwo(image: "images/e6.webp"),
    EatingPizzaTwo(image: "images/e4.webp"),
    EatingPizzaTwo(image: "images/e3.webp"),
    EatingPizzaTwo(image: "images/e2.webp"),
    EatingPizzaTwo(image: "images/e1.webp"),
  ];
  List<EatingPizzaThree> eatingThreeList = [
    EatingPizzaThree(image: "images/e2.webp"),
    EatingPizzaThree(image: "images/e8.webp"),
    EatingPizzaThree(image: "images/e5.webp"),
    EatingPizzaThree(image: "images/e9.webp"),
    EatingPizzaThree(image: "images/e1.webp"),
    EatingPizzaThree(image: "images/e10.webp"),
    EatingPizzaThree(image: "images/e4.webp"),
    EatingPizzaThree(image: "images/e6.webp"),
    EatingPizzaThree(image: "images/e11.webp"),
    EatingPizzaThree(image: "images/e3.webp"),
    EatingPizzaThree(image: "images/e12.webp"),
    EatingPizzaThree(image: "images/e7.webp"),
  ];

  List<HomeCetegorieModel> foundcategorieslist = [];
  FocusNode focusNode = FocusNode();
  GoogleMapControllerScreen googleMapControllerScreen = Get.find();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    googleMapControllerScreen.HomeLocationupdate(ref);
    googleMapControllerScreen.GetLocationData();
    foundcategorieslist = categorieslist;
  }
  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Colors.white,
      body: WillPopScope(
        onWillPop: () async {
          return await showDialog(
            context: context,
            builder: (context){
              return ExitDialog();
            },
          );
        },
        child: Stack(
          children: [
            Container(
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(15)),
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
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          child: TextField(
                            autofocus: false,
                            focusNode: focusNode,
                            controller: homesearchContoller,
                            onChanged: (value) {
                              homeSearch(value);
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
                    SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                        style: ButtonStyle(
                            minimumSize:
                            MaterialStateProperty.all(
                                Size(
                                    double
                                        .infinity,
                                    50)),
                            shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                        bottomRight:
                                        Radius.circular(
                                            25),
                                        bottomLeft:
                                        Radius.circular(
                                            25)))),
                            backgroundColor:
                            MaterialStateProperty.all(
                                Color(0xffEF505F))),
                        onPressed: () {
                          pizzaController.getPizzaData();
                        },
                        child: Text(
                          "Okay",
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.white),
                        )),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: Container(
                        width: double.infinity,
                        height: 95,
                        child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            physics: BouncingScrollPhysics(),
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  setState(() {
                                    bottomController.currentindex.value =
                                        foundcategorieslist[index].index!;
                                  });
                                },
                                child: Column(
                                  children: [
                                    Container(
                                      width: 70,
                                      height: 70,
                                      decoration: BoxDecoration(
                                          color: Color(0xffF2F2F3),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(15)),
                                          image: DecorationImage(
                                              image: AssetImage(
                                                  "${foundcategorieslist[index].image}"),
                                              fit: BoxFit.cover)),
                                    ),
                                    Text(
                                      "${foundcategorieslist[index].name}",
                                      style: GoogleFonts.nunito(
                                          color: Color(0xff474C4C),
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600),
                                    )
                                  ],
                                ),
                              );
                            },
                            separatorBuilder: (context, index) {
                              return SizedBox(
                                width: 17,
                              );
                            },
                            itemCount: foundcategorieslist.length),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 13),
                      child: Container(
                        width: double.infinity,
                        height: 200,
                        child: CarouselSlider.builder(
                            carouselController: carouselController,
                            itemCount: homeimagelist.length,
                            itemBuilder: (context, index, realIndex) {
                              return Container(
                                padding: EdgeInsets.only(right: 13),
                                width: double.infinity,
                                height: 200,
                                child: ClipRRect(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20)),
                                  child: Image(
                                    image: AssetImage(homeimagelist[index]),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              );
                            },
                            options: CarouselOptions(
                              onPageChanged: (index, reason){
                                setState((){
                                  sliderindex = index;
                                });
                              },
                              aspectRatio: 16 / 9,
                              autoPlay: true,
                              autoPlayAnimationDuration:
                                  Duration(milliseconds: 2200),
                              scrollPhysics: BouncingScrollPhysics(),
                              viewportFraction: 1,
                              enableInfiniteScroll: true,
                              reverse: false,
                              autoPlayCurve: Curves.fastOutSlowIn,
                            )),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    AnimatedSmoothIndicator(
                      activeIndex: sliderindex,
                      count: homeimagelist.length,
                      effect: JumpingDotEffect(
                        activeDotColor: Color(0xffEF4F5F),
                        dotWidth: 8.5,
                        dotHeight: 8.5,
                        dotColor: Color(0xff787E91),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    /*  Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: Container(
                        width: double.infinity,
                        height: 100,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                          border:
                              Border.all(color: Color(0xffa2a7b4), width: 1),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Spacer(),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 10, right: 10),
                              child: Text(
                                "Craving for something",
                                style: GoogleFonts.lexend(
                                    fontSize: 17,
                                    color: Color(0xff737373),
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                            SizedBox(
                              height: 2,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 10, right: 10),
                              child: Text(
                                "Different ?",
                                style: GoogleFonts.lexend(
                                    fontSize: 20,
                                    color: Color(0xff313848),
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                            SizedBox(
                              height: 2,
                            ),
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 10, right: 10),
                                  child: Text(
                                    "Try What2Eat ",
                                    style: GoogleFonts.lexend(
                                        fontSize: 17,
                                        color: Color(0xffEF4F5F),
                                        fontWeight: FontWeight.w400),
                                  ),
                                ),
                                Icon(
                                  Icons.arrow_circle_right_rounded,
                                  color: Color(0xffEF4F5F),
                                  size: 20,
                                )
                              ],
                            ),
                            Spacer(),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),*/
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            PageTransition(
                                type: PageTransitionType.rightToLeft,
                                child: AiFood()));
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        child: Container(
                          width: double.infinity,
                          height: 100,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                            border:
                                Border.all(color: Color(0xffa2a7b4), width: 1),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Spacer(),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 10, right: 10),
                                child: Text(
                                  "Find the best recipe for cooking!",
                                  style: GoogleFonts.lexend(
                                      fontSize: 17,
                                      color: Color(0xff737373),
                                      fontWeight: FontWeight.w400),
                                ),
                              ),
                              SizedBox(
                                height: 2,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 10, right: 10),
                                child: Text(
                                  "At Home ?",
                                  style: GoogleFonts.lexend(
                                      fontSize: 20,
                                      color: Color(0xff313848),
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                              SizedBox(
                                height: 2,
                              ),
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: Text(
                                      "Try What2Make ",
                                      style: GoogleFonts.lexend(
                                          fontSize: 17,
                                          color: Color(0xffEF4F5F),
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ),
                                  Center(
                                    child: Icon(
                                      Icons.arrow_circle_right_rounded,
                                      color: Color(0xffEF4F5F),
                                      size: 20,
                                    ),
                                  )
                                ],
                              ),
                              Spacer(),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: Container(
                        width: double.infinity,
                        height: 500,
                        decoration: BoxDecoration(
                          color: Color(0xffF2F2F2),
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                        ),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 20,
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
                                        color: Color(0xff8f8f8f),
                                        width: 1,
                                      )),
                                    ),
                                  ),
                                ),
                                Text(
                                  "DISCOVER PIZZA",
                                  style: GoogleFonts.nunito(
                                      color: Color(0xff696969),
                                      fontSize: 15.5,
                                      fontWeight: FontWeight.w700),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 20, right: 20),
                                    child: Container(
                                      height: 1,
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                        color: Color(0xff8F8F8F),
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
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 20, right: 20, bottom: 20),
                                child: Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15)),
                                    color: Colors.black12,
                                  ),
                                  child: Stack(
                                    children: [
                                      Column(children: [
                                        Expanded(
                                          flex: 1,
                                          child: Container(
                                            width: double.infinity,
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Expanded(
                                                  flex: 1,
                                                  child: Column(
                                                    children: [
                                                      Expanded(
                                                        child: ClipRRect(
                                                          borderRadius:
                                                              BorderRadius.only(
                                                                  topLeft: Radius
                                                                      .circular(
                                                                          15)),
                                                          child: CarouselSlider
                                                              .builder(
                                                                  itemCount:
                                                                      eatingOneList
                                                                          .length,
                                                                  itemBuilder:
                                                                      (context,
                                                                          index,
                                                                          realIndex) {
                                                                    return Column(
                                                                      children: [
                                                                        Image(
                                                                          image:
                                                                              AssetImage("${eatingOneList[index].image}"),
                                                                          fit: BoxFit
                                                                              .cover,
                                                                          height:
                                                                              230,
                                                                        ),
                                                                      ],
                                                                    );
                                                                  },
                                                                  options:
                                                                      CarouselOptions(
                                                                    scrollDirection:
                                                                        Axis.vertical,
                                                                    aspectRatio:
                                                                        16 / 9,
                                                                    viewportFraction:
                                                                        1.12,
                                                                    autoPlay:
                                                                        true,
                                                                    autoPlayAnimationDuration:
                                                                        Duration(
                                                                            seconds:
                                                                                10),
                                                                    autoPlayInterval:
                                                                        Duration(
                                                                            seconds:
                                                                                1),
                                                                    scrollPhysics:
                                                                        NeverScrollableScrollPhysics(),
                                                                    enableInfiniteScroll:
                                                                        true,
                                                                    reverse:
                                                                        false,
                                                                    autoPlayCurve:
                                                                        Curves
                                                                            .ease,
                                                                  )),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                Expanded(
                                                  flex: 1,
                                                  child: Column(
                                                    children: [
                                                      Expanded(
                                                        child: CarouselSlider
                                                            .builder(
                                                                itemCount:
                                                                    eatingTwoList
                                                                        .length,
                                                                itemBuilder:
                                                                    (context,
                                                                        index,
                                                                        realIndex) {
                                                                  return Column(
                                                                    children: [
                                                                      Image(
                                                                        image: AssetImage(
                                                                            "${eatingTwoList[index].image}"),
                                                                        fit: BoxFit
                                                                            .cover,
                                                                        height:
                                                                            140,
                                                                      ),
                                                                    ],
                                                                  );
                                                                },
                                                                options:
                                                                    CarouselOptions(
                                                                  scrollDirection:
                                                                      Axis.vertical,
                                                                  aspectRatio:
                                                                      16 / 9,
                                                                  viewportFraction:
                                                                      0.69,
                                                                  autoPlay:
                                                                      true,
                                                                  autoPlayAnimationDuration:
                                                                      Duration(
                                                                          seconds:
                                                                              10),
                                                                  autoPlayInterval:
                                                                      Duration(
                                                                          seconds:
                                                                              1),
                                                                  scrollPhysics:
                                                                      NeverScrollableScrollPhysics(),
                                                                  enableInfiniteScroll:
                                                                      true,
                                                                  reverse: true,
                                                                  autoPlayCurve:
                                                                      Curves
                                                                          .ease,
                                                                )),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                Expanded(
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      Expanded(
                                                        child: ClipRRect(
                                                          borderRadius:
                                                              BorderRadius.only(
                                                                  topRight: Radius
                                                                      .circular(
                                                                          15)),
                                                          child: CarouselSlider
                                                              .builder(
                                                                  itemCount:
                                                                      eatingThreeList
                                                                          .length,
                                                                  itemBuilder:
                                                                      (context,
                                                                          index,
                                                                          realIndex) {
                                                                    return Column(
                                                                      children: [
                                                                        Image(
                                                                          image:
                                                                              AssetImage("${eatingThreeList[index].image}"),
                                                                          fit: BoxFit
                                                                              .cover,
                                                                          height:
                                                                              180,
                                                                        ),
                                                                      ],
                                                                    );
                                                                  },
                                                                  options:
                                                                      CarouselOptions(
                                                                    scrollDirection:
                                                                        Axis.vertical,
                                                                    aspectRatio:
                                                                        16 / 9,
                                                                    autoPlay:
                                                                        true,
                                                                    autoPlayAnimationDuration:
                                                                        Duration(
                                                                            seconds:
                                                                                10),
                                                                    autoPlayInterval:
                                                                        Duration(
                                                                            seconds:
                                                                                1),
                                                                    scrollPhysics:
                                                                        NeverScrollableScrollPhysics(),
                                                                    viewportFraction:
                                                                        0.88,
                                                                    enableInfiniteScroll:
                                                                        true,
                                                                    reverse:
                                                                        false,
                                                                    autoPlayCurve:
                                                                        Curves
                                                                            .ease,
                                                                  )),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                            child: Container(
                                          width: double.infinity,
                                          height: 200,
                                          decoration: BoxDecoration(
                                            color: Colors.black,
                                            boxShadow: [
                                              BoxShadow(
                                                  color: Colors.black,
                                                  blurRadius: 301,
                                                  offset: Offset(0, -25))
                                            ],
                                            borderRadius: BorderRadius.only(
                                                bottomLeft: Radius.circular(15),
                                                bottomRight:
                                                    Radius.circular(15)),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 10, right: 10),
                                            child: Column(
                                              children: [
                                                SizedBox(
                                                  height: 20,
                                                ),
                                                Container(
                                                  width: double.infinity,
                                                  height: 170,
                                                  child: ListView.separated(
                                                      scrollDirection:
                                                          Axis.horizontal,
                                                      itemBuilder:
                                                          (context, index) {
                                                        return Column(
                                                          children: [
                                                            Container(
                                                              padding:
                                                                  EdgeInsets
                                                                      .all(2.5),
                                                              width: 100,
                                                              height: 150,
                                                              decoration: BoxDecoration(
                                                                  borderRadius:
                                                                      BorderRadius.all(
                                                                          Radius.circular(
                                                                              20)),
                                                                  color: Color(
                                                                      0xff919191)),
                                                              child: Container(
                                                                width: 100,
                                                                decoration: BoxDecoration(
                                                                    borderRadius:
                                                                        BorderRadius.all(Radius.circular(
                                                                            20)),
                                                                    color: Color(
                                                                        0xff1A1A1A),
                                                                    image: DecorationImage(
                                                                        image: AssetImage(
                                                                            "${eatingOneList[index].image}"),
                                                                        fit: BoxFit
                                                                            .cover)),
                                                              ),
                                                            ),
                                                            Text(
                                                              "${eatingOneList[index].name}",
                                                              style: GoogleFonts.lexend(
                                                                  color: Color(
                                                                      0xffE7E1DD),
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                  fontSize: 13),
                                                            )
                                                          ],
                                                        );
                                                      },
                                                      separatorBuilder:
                                                          (context, index) {
                                                        return SizedBox(
                                                          width: 10,
                                                        );
                                                      },
                                                      itemCount:
                                                          eatingOneList.length),
                                                ),
                                              ],
                                            ),
                                          ),
                                        )),
                                      ]),
                                      Positioned(
                                        bottom: 210,
                                        child: Align(
                                          alignment: Alignment.bottomLeft,
                                          child: Padding(
                                            padding:
                                                const EdgeInsets.only(left: 10),
                                            child: GradientAnimationText(
                                              text: Text(
                                                'Stories this week',
                                                style: TextStyle(
                                                    fontSize: 27,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                              colors: [
                                                Colors.white,
                                                Colors.red,
                                                Colors.white,
                                              ],
                                              duration: Duration(seconds: 5),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      color: Color(0xfffdfdfd),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 15, right: 15),
                            child: Container(
                              width: double.infinity,
                              height: 500,
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20)),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Color(0xfff5f5f5),
                                        spreadRadius: 1,
                                        blurRadius: 10,
                                        blurStyle: BlurStyle.outer)
                                  ]),
                              child: Column(
                                children: [
                                  Container(
                                    width: double.infinity,
                                    height: 300,
                                    decoration: BoxDecoration(
                                      color: Color(0xffefefef),
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(20)),
                                    ),
                                    child: Image(
                                      image:
                                          AssetImage("images/pizzanight.webp"),
                                      width: double.infinity,
                                      height: 300,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Expanded(
                                      child: Container(
                                    width: double.infinity,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          height: 20,
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 20),
                                          child: Text(
                                            "Fantastic food and \nwhere to find them!",
                                            style: GoogleFonts.lexend(
                                                color: Color(0xffEF4F5F),
                                                fontSize: 24,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 20),
                                          child: Text(
                                            "Cuisines from  around the world",
                                            style: GoogleFonts.nunito(
                                                color: Color(0xffEF4F5F),
                                                fontSize: 19,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 20, right: 20),
                                          child: GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                bottomController
                                                    .currentindex.value = 1;
                                              });
                                            },
                                            child: Container(
                                              width: double.infinity,
                                              height: 55,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(15)),
                                                  border: Border.all(
                                                      color: Color(0xffe7e7e7),
                                                      width: 1),
                                                  boxShadow: [
                                                    BoxShadow(
                                                        color:
                                                            Color(0xfff5f5f5),
                                                        spreadRadius: 1,
                                                        blurRadius: 5,
                                                        blurStyle:
                                                            BlurStyle.outer)
                                                  ]),
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 10, right: 10),
                                                child: Row(
                                                  children: [
                                                    Text(
                                                      "EXPLORE FOOD",
                                                      style: GoogleFonts.lexend(
                                                          color:
                                                              Color(0xffEF4F5F),
                                                          fontSize: 17,
                                                          fontWeight:
                                                              FontWeight.w600),
                                                    ),
                                                    Spacer(),
                                                    Container(
                                                      width: 30,
                                                      height: 30,
                                                      decoration: BoxDecoration(
                                                        shape: BoxShape.circle,
                                                        color:
                                                            Color(0xffEF4F5F),
                                                      ),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(5),
                                                        child: Image(
                                                            image: AssetImage(
                                                                "images/bowl.webp"),
                                                            color:
                                                                Colors.white),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ))
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 50,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Obx(
              () => Align(
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
                                            data: pizzaController
                                                .pizzalist.value);
                                      },
                                    );
                                  },
                                  child: Container(
                                    height: 40,
                                    child: Row(
                                      children: [
                                        Image(
                                          image: AssetImage("images/order.webp"),
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
                              ),


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

  void ref() {
    setState(() {});
  }

  void homeSearch(String value) {
    List<HomeCetegorieModel> homeresult = [];

    homeresult = categorieslist
        .where((element) =>
            element.name!.toLowerCase().contains(value.toLowerCase()))
        .toList();

    setState(() {
      foundcategorieslist = homeresult;
    });
  }
}
