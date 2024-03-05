import 'package:Pizza/Admin_Screen/Add_Pizza.dart';
import 'package:Pizza/All%20Screen/AdDialogScreen.dart';
import 'package:Pizza/Controller/AdminController.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:lottie/lottie.dart';
import 'package:page_transition/page_transition.dart';
import 'package:Pizza/All%20Screen/BottomSheetDialog.dart';
import 'package:Pizza/All%20Screen/CartScreen.dart';
import 'package:Pizza/All%20Screen/CustomizePizza.dart';
import 'package:Pizza/Controller/BottomController.dart';
import 'package:Pizza/Controller/PizzaController.dart';
import 'package:Pizza/ModelClass/PizzaItemModelClass.dart';
import 'package:shimmer/shimmer.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class PizzaScreen extends StatefulWidget {
  int pizzaindex;
  List<PizzaItemModel> data;

  PizzaScreen({super.key, required this.data, required this.pizzaindex});

  @override
  State<PizzaScreen> createState() => _PizzaScreenState();
}

class _PizzaScreenState extends State<PizzaScreen> {
  InterstitialAd? interstitialAd;
  bool isLoaded = false;
  List<PizzaItemModel> pizzalist = [];
  int pizzaindex = 0;

  AdminController adminController = Get.find();
  var pizzasearchContoller = TextEditingController();
  int offerindex = 0;

  PizzaController pizzaController = Get.find();
  BottomController bottomController = Get.find();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    pizzalist = widget.data;
    pizzaindex = widget.pizzaindex;
    pizzaController.Allupdate(ref);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            size: 30,
            color: Colors.black,
          ),
        ),
        title: Text("${pizzalist[pizzaindex].name}",
            style: TextStyle(color: Colors.black, fontSize: 20)),
        actions: !adminController.isAdmin.value
            ? []
            : [
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          PageTransition(
                              child: PizzaAddView(
                                  name: "${pizzalist[pizzaindex].name}"),
                              type: PageTransitionType.rightToLeft));
                    },
                    child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                            color: Color(0xffE9E9F7), shape: BoxShape.circle),
                        child: Icon(
                          Icons.add,
                          color: Color(0xffB1BBDA),
                          size: 30,
                        )),
                  ),
                ),
              ],
      ),
      backgroundColor: Color(0xfff5f5f5),
      body: Stack(
        children: [
          CustomScrollView(
            physics: BouncingScrollPhysics(),
            slivers: [
              SliverAppBar(
                backgroundColor: Colors.white,
                pinned: false,
                stretch: true,
                snap: false,
                floating: false,
                leading: Container(),
                expandedHeight: adminController.isAdmin.value ? 200 : 265,
                flexibleSpace: FlexibleSpaceBar(
                  background: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.star_rate_rounded,
                              size: 23, color: Color(0xffE9B500)),
                          Padding(
                            padding: const EdgeInsets.only(top: 5),
                            child: Text("   AWARDED BEST IN GUJARATI   ",
                                style: GoogleFonts.nunito(
                                    color: Color(0xff5F4724),
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600)),
                          ),
                          Icon(Icons.star_rate_rounded,
                              size: 23, color: Color(0xffE9B500)),
                        ],
                      ),
                      Text("${pizzalist[pizzaindex].name}",
                          style: GoogleFonts.nunito(
                              color: Color(0xff293041),
                              fontSize: 22,
                              fontWeight: FontWeight.bold)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image(
                            image: AssetImage("images/leaves.webp"),
                            width: 17,
                            height: 17,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text("Pure Veg",
                              style: GoogleFonts.nunito(
                                  color: Color(0xff646C81),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400)),
                          SizedBox(
                            width: 5,
                          ),
                          Center(
                            child: Container(
                              width: 4,
                              height: 4,
                              decoration: BoxDecoration(
                                  color: Color(0xff646C81),
                                  shape: BoxShape.circle),
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text("${pizzalist[pizzaindex].subname}",
                              style: GoogleFonts.nunito(
                                  color: Color(0xff646C81),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400)),
                        ],
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                              width: 43,
                              height: 23,
                              decoration: BoxDecoration(
                                  color: Color(0xff267E3E),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8))),
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(left: 5, right: 2),
                                child: Row(
                                  children: [
                                    Center(
                                      child: Text(
                                          "${pizzalist[pizzaindex].rating}",
                                          style: GoogleFonts.nunito(
                                              color: Colors.white,
                                              fontSize: 13,
                                              fontWeight: FontWeight.w600)),
                                    ),
                                    Center(
                                      child: Icon(
                                        Icons.star_rounded,
                                        size: 14,
                                        color: Colors.white,
                                      ),
                                    )
                                  ],
                                ),
                              )),
                          SizedBox(
                            width: 5,
                          ),
                          Text("4.3 ratings",
                              style: GoogleFonts.nunito(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400)),
                        ],
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 280,
                            height: 30,
                            decoration: BoxDecoration(
                                color: Color(0xffF8F9FC),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15)),
                                border: Border.all(
                                    color: Color(0xffE8EBF1), width: 1)),
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 10, right: 10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
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
                                    "${pizzalist[pizzaindex].time}",
                                    style: GoogleFonts.nunito(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.black),
                                  ),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  Center(
                                    child: Container(
                                      width: 4,
                                      height: 4,
                                      decoration: BoxDecoration(
                                          color: Colors.black,
                                          shape: BoxShape.circle),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  Text(
                                    "${pizzalist[pizzaindex].distance}",
                                    style: GoogleFonts.nunito(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.black),
                                  ),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 5, bottom: 5),
                                    child: Column(
                                      children: [
                                        Expanded(
                                          child: Container(
                                            width: 1,
                                            decoration: BoxDecoration(
                                                color: Color(0xff0ffE8EBF1)),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  Text(
                                    "Katargam",
                                    style: GoogleFonts.nunito(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.black),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      adminController.isAdmin.value
                          ? Container()
                          : Container(
                              width: double.infinity,
                              height: 80,
                              color: Color(0xfff4f6fa),
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(left: 15, right: 15),
                                child: Container(
                                  width: double.infinity,
                                  height: 60,
                                  child: Row(
                                    children: [
                                      Container(
                                        width: 70,
                                        height: 60,
                                        decoration: BoxDecoration(
                                            color: Color(0xffdfe8ff),
                                            borderRadius: BorderRadius.only(
                                              bottomLeft: Radius.circular(15),
                                              topLeft: Radius.circular(15),
                                            )),
                                        child: Padding(
                                          padding: const EdgeInsets.all(10),
                                          child: Lottie.asset(
                                              "${pizzaController.offerlist[offerindex].image}"),
                                        ),
                                      ),
                                      Expanded(
                                        child: Container(
                                          height: 60,
                                          color: Colors.white,
                                          child: CarouselSlider.builder(
                                              itemCount: pizzaController
                                                  .offerlist.length,
                                              itemBuilder:
                                                  (context, index, realIndex) {
                                                return Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 15,
                                                              right: 15),
                                                      child: Text(
                                                        "${pizzaController.offerlist[index].name}",
                                                        style:
                                                            GoogleFonts.nunito(
                                                                color: Colors
                                                                    .black,
                                                                fontSize: 18,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500),
                                                        maxLines: 1,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 15,
                                                              right: 15),
                                                      child: Text(
                                                        "${pizzaController.offerlist[index].subname}",
                                                        style:
                                                            GoogleFonts.nunito(
                                                                color: Color(
                                                                    0xffC0C3CB),
                                                                fontSize: 16,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500),
                                                        maxLines: 1,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      ),
                                                    )
                                                  ],
                                                );
                                              },
                                              options: CarouselOptions(
                                                onPageChanged: (index, reason) {
                                                  setState(() {
                                                    offerindex = index;
                                                  });
                                                },
                                                aspectRatio: 16 / 9,
                                                autoPlay: true,
                                                viewportFraction: 1,
                                                enableInfiniteScroll: true,
                                                reverse: false,
                                                autoPlayCurve:
                                                    Curves.fastOutSlowIn,
                                              )),
                                        ),
                                      ),
                                      Container(
                                        width: 60,
                                        height: 60,
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.only(
                                              topRight: Radius.circular(15),
                                              bottomRight: Radius.circular(15),
                                            )),
                                        child: Center(
                                          child: AnimatedSmoothIndicator(
                                            activeIndex: offerindex,
                                            count: pizzaController
                                                .offerlist.length,
                                            effect: JumpingDotEffect(
                                              activeDotColor: Color(0xffEF4F5F),
                                              dotWidth: 5,
                                              dotHeight: 5,
                                              dotColor: Color(0xff787E91),
                                            ),
                                          ),
                                        ),
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

              SliverPadding(
                  padding: EdgeInsets.only(
                      top: adminController.isAdmin.value ? 0 : 20)),
              adminController.isAdmin.value
                  ? SliverToBoxAdapter()
                  : SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Row(
                          children: [
                            Text(
                              "Customize pizza for you",
                              style: GoogleFonts.nunito(
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600),
                            ),
                            Expanded(
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(left: 10, right: 20),
                                child: Container(
                                  height: 1,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                    color: Color(0xffd5d5d5),
                                    width: 1,
                                  )),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),

              SliverPadding(
                  padding: EdgeInsets.only(
                      top: adminController.isAdmin.value ? 0 : 20)),

              adminController.isAdmin.value
                  ? SliverToBoxAdapter()
                  : SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        child: Container(
                          width: double.infinity,
                          height: 160,
                          decoration: BoxDecoration(
                            color: Color(0xffFFF6F7),
                            border:
                                Border.all(color: Color(0xffEF4F5F), width: 1),
                            boxShadow: [
                              BoxShadow(
                                  color: Color(0xffffbcc2),
                                  blurRadius: 5,
                                  blurStyle: BlurStyle.outer)
                            ],
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                          ),
                          child: Stack(
                            children: [
                              Opacity(
                                opacity: 0.1,
                                child: ClipRRect(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20)),
                                  child: Image(
                                    image: AssetImage("images/bg1.webp"),
                                    fit: BoxFit.cover,
                                    width: double.infinity,
                                    height: 160,
                                  ),
                                ),
                              ),
                              Row(
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 15),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Customize your ",
                                              style: GoogleFonts.lexend(
                                                  color: Colors.black,
                                                  fontSize: 19,
                                                  fontWeight: FontWeight.w400),
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  "own ",
                                                  style: GoogleFonts.lexend(
                                                      color: Colors.black,
                                                      fontSize: 19,
                                                      fontWeight:
                                                          FontWeight.w400),
                                                ),
                                                Text(
                                                  "pizza",
                                                  style: GoogleFonts.lexend(
                                                      color: Color(0xffEF4F5F),
                                                      fontSize: 19,
                                                      fontWeight:
                                                          FontWeight.w400),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      ElevatedButton(
                                        style: ButtonStyle(
                                            minimumSize:
                                                MaterialStatePropertyAll(
                                                    Size(130, 38)),
                                            shape: MaterialStatePropertyAll(
                                                RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                25)))),
                                            backgroundColor:
                                                MaterialStatePropertyAll(
                                              Color(0xffEF4F5F),
                                            ),
                                            elevation:
                                                MaterialStatePropertyAll(0)),
                                        onPressed: () {
                                          isLoaded = true;
                                          loaded();
                                          if (isLoaded) {
                                            setState(() {
                                              showDialog(
                                                context: context,
                                                builder: (context) {
                                                  return AdDialogScreen();
                                                },
                                              );
                                            });
                                          }
                                        },
                                        child: Text("Order Now",
                                            style: GoogleFonts.nunito(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.white)),
                                      )
                                    ],
                                  ),
                                  Spacer(),
                                  Image(
                                    image:
                                        AssetImage("images/pizza_vactor.webp"),
                                    width: 155,
                                    height: 155,
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

              //------------------------)

              SliverPadding(padding: EdgeInsets.only(top: 20)),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Row(
                    children: [
                      Text(
                        "Recommanded for you",
                        style: GoogleFonts.nunito(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.w600),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10, right: 20),
                          child: Container(
                            height: 1,
                            decoration: BoxDecoration(
                                border: Border.all(
                              color: Color(0xffd5d5d5),
                              width: 1,
                            )),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              SliverPadding(padding: EdgeInsets.only(top: 20)),
              SliverPadding(
                padding: EdgeInsets.only(bottom: 80),
                sliver: Obx(
                  () => SliverList.separated(
                    itemCount: pizzalist[pizzaindex].foodimagelist.length,
                    itemBuilder: (context, index) {
                      return StatefulBuilder(
                        builder: (context, setState) {
                          return Padding(
                            padding: const EdgeInsets.only(right: 15, left: 15),
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
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20))),
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
                                            const SizedBox(
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
                                                                0xff24963E),
                                                            width: 1.5),
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    5))),
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              5.0),
                                                      child: Container(
                                                        width: 3,
                                                        height: 3,
                                                        decoration:
                                                            BoxDecoration(
                                                                color: Color(
                                                                    0xff24963E),
                                                                shape: BoxShape
                                                                    .circle),
                                                      ),
                                                    )),
                                                const SizedBox(
                                                  width: 15,
                                                ),
                                                Container(
                                                  width: 70,
                                                  height: 22,
                                                  decoration: BoxDecoration(
                                                      color: Color(0xffDB9C07),
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  5))),
                                                  child: Center(
                                                    child: Text("Bestseller",
                                                        style:
                                                            GoogleFonts.nunito(
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 12,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500)),
                                                  ),
                                                ),
                                                Align(
                                                  alignment: Alignment.topRight,
                                                  child:
                                                      PopupMenuButton<String>(
                                                    tooltip: "",
                                                    splashRadius: 0,
                                                    enabled: true,
                                                    shape:
                                                        ContinuousRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              35),
                                                    ),
                                                    color: Theme.of(context)
                                                        .colorScheme
                                                        .onInverseSurface,
                                                    padding:
                                                        const EdgeInsets.all(0),
                                                    constraints:
                                                        const BoxConstraints(
                                                            maxWidth: 196),
                                                    onSelected: (value) async {
                                                      if (value == "Edit") {
                                                        Navigator.push(
                                                          context,
                                                          PageTransition(
                                                            child: PizzaAddView(
                                                              name:
                                                                  "${pizzalist[pizzaindex].name}",
                                                              pizzaData: pizzalist[
                                                                      pizzaindex]
                                                                  .foodimagelist[index],
                                                            ),
                                                            type:
                                                                PageTransitionType
                                                                    .rightToLeft,
                                                          ),
                                                        );
                                                      } else if (value ==
                                                          "Delete") {
                                                        var jobskill_query =
                                                            FirebaseFirestore
                                                                .instance
                                                                .collection(
                                                                    "pizza")
                                                                .where("name",
                                                                    isEqualTo:
                                                                        pizzalist[pizzaindex]
                                                                            .name);

                                                        jobskill_query
                                                            .get()
                                                            .then(
                                                          (querySnapshot) async {
                                                            List pizzaList =
                                                                querySnapshot
                                                                        .docs[0]
                                                                    [
                                                                    "foodimagelist"];

                                                            pizzaList.removeWhere(
                                                                (element) =>
                                                                    element[
                                                                        'id'] ==
                                                                    pizzalist[
                                                                            pizzaindex]
                                                                        .foodimagelist[
                                                                            index]
                                                                        .id);

                                                            await FirebaseFirestore
                                                                .instance
                                                                .collection(
                                                                    'pizza')
                                                                .doc(
                                                                    querySnapshot
                                                                        .docs[0]
                                                                        .id)
                                                                .update(
                                                              {
                                                                "foodimagelist":
                                                                    pizzaList
                                                              },
                                                            );
                                                            int index1 = pizzaController
                                                                .pizzalist
                                                                .indexWhere((element) =>
                                                                    element
                                                                        .name ==
                                                                    pizzalist[
                                                                            pizzaindex]
                                                                        .name);
                                                            pizzaController
                                                                .pizzalist[
                                                                    index1]
                                                                .foodimagelist
                                                                .removeWhere((element) =>
                                                                    element
                                                                        .id ==
                                                                    pizzalist[
                                                                            pizzaindex]
                                                                        .foodimagelist[
                                                                            index]
                                                                        .id);
                                                          },
                                                        );
                                                      }
                                                    },
                                                    itemBuilder: (_) => [
                                                      const PopupMenuItem<
                                                          String>(
                                                        value: "Edit",
                                                        child: Text(
                                                          "Edit",
                                                          style: TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                          ),
                                                        ),
                                                      ),
                                                      const PopupMenuItem<
                                                          String>(
                                                        value: "Delete",
                                                        child: Text(
                                                          "Delete",
                                                          style: TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                    child: const Icon(
                                                      Icons.more_vert,
                                                      size: 24,
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Text(
                                                "${pizzalist[pizzaindex].foodimagelist[index].name}",
                                                maxLines: 2,
                                                style: GoogleFonts.nunito(
                                                    color: Color(0xff373D4D),
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.w700)),
                                            SizedBox(
                                              height: 1,
                                            ),
                                            Text(
                                                "${pizzalist[pizzaindex].rating} ratings",
                                                style: GoogleFonts.nunito(
                                                    color: Color(0xff535B6D),
                                                    fontSize: 16,
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
                                                  width: 16,
                                                  height: 16,
                                                  color: Color(0xff1F1F1F),
                                                ),
                                                Text(
                                                    "${pizzalist[pizzaindex].foodimagelist[index].price}",
                                                    style: GoogleFonts.nunito(
                                                        color:
                                                            Color(0xff1F1F1F),
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w500)),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 1,
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
                                              padding: const EdgeInsets.only(
                                                  right: 10, left: 10),
                                              child: Stack(
                                                alignment:
                                                    Alignment.bottomCenter,
                                                children: [
                                                  Align(
                                                    alignment: FractionalOffset
                                                        .topCenter,
                                                    child: ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  10)),
                                                      child: CachedNetworkImage(
                                                          imageUrl:
                                                              "${pizzalist[pizzaindex].foodimagelist[index].image}",
                                                          placeholder: (context, url) => Shimmer
                                                              .fromColors(
                                                                  direction:
                                                                      ShimmerDirection
                                                                          .ltr,
                                                                  enabled: true,
                                                                  baseColor: Colors
                                                                      .grey
                                                                      .shade300,
                                                                  highlightColor:
                                                                      Colors
                                                                          .grey
                                                                          .shade100,
                                                                  child:
                                                                      Container(
                                                                    color: Colors
                                                                        .grey,
                                                                  )),
                                                          width: 150,
                                                          height: 120,
                                                          fit: BoxFit.cover),
                                                    ),
                                                  ),
                                                  Positioned(
                                                    width: 80,
                                                    height: 35,
                                                    bottom: 10,
                                                    child: adminController
                                                            .isAdmin.value
                                                        ? Container()
                                                        : !pizzalist[pizzaindex]
                                                                .foodimagelist[
                                                                    index]
                                                                .checkadd
                                                            ? GestureDetector(
                                                                onTap: () {
                                                                  setState(() =>
                                                                      pizzaController.Pizzaadd(
                                                                          pizzaindex,
                                                                          index));
                                                                },
                                                                child:
                                                                    Container(
                                                                  width: 80,
                                                                  height: 35,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    boxShadow: [
                                                                      BoxShadow(
                                                                          color: Colors
                                                                              .black26,
                                                                          blurRadius:
                                                                              5,
                                                                          spreadRadius:
                                                                              1)
                                                                    ],
                                                                    color: Color(
                                                                        0xffFFF6F7),
                                                                    border: Border.all(
                                                                        color: Color(
                                                                            0xffEF4F5F)),
                                                                    borderRadius:
                                                                        BorderRadius.all(
                                                                            Radius.circular(10)),
                                                                  ),
                                                                  child: Center(
                                                                    child: Text(
                                                                        "Add",
                                                                        style: GoogleFonts.nunito(
                                                                            color: Color(
                                                                                0xffEF4F5F),
                                                                            fontSize:
                                                                                17,
                                                                            fontWeight:
                                                                                FontWeight.w500)),
                                                                  ),
                                                                ),
                                                              )
                                                            : Container(
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
                                                                          Radius.circular(
                                                                              10)),
                                                                ),
                                                                child: Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceAround,
                                                                  children: [
                                                                    GestureDetector(
                                                                      onTap:
                                                                          () {
                                                                        setState(() => pizzaController.Pizzaremove(
                                                                            pizzaindex,
                                                                            index));
                                                                      },
                                                                      child: Icon(
                                                                          Icons
                                                                              .remove,
                                                                          color: Colors
                                                                              .white,
                                                                          size:
                                                                              20),
                                                                    ),
                                                                    Center(
                                                                      child: Text(
                                                                          "${pizzalist[pizzaindex].foodimagelist[index].selectitem}",
                                                                          style: GoogleFonts.nunito(
                                                                              color: Colors.white,
                                                                              fontSize: 17,
                                                                              fontWeight: FontWeight.w500)),
                                                                    ),
                                                                    GestureDetector(
                                                                      onTap:
                                                                          () {
                                                                        setState(() => pizzaController.Pizzaplus(
                                                                            pizzaindex,
                                                                            index));
                                                                      },
                                                                      child: Icon(
                                                                          Icons
                                                                              .add,
                                                                          color: Colors
                                                                              .white,
                                                                          size:
                                                                              20),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                  )
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
                            ),
                          );
                        },
                      );
                    },
                    separatorBuilder: (context, index) {
                      return SizedBox(
                        height: 15,
                      );
                    },
                  ),
                ),
              )
            ],
          ),
          Obx(
            () => Align(
              alignment: Alignment.bottomCenter,
              child: adminController.isAdmin.value
                  ? Container()
                  : pizzaController.isBootomSheet.value
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
                                              pizzaindex: pizzaindex,
                                              data: pizzalist);
                                        },
                                      );
                                    },
                                    child: Container(
                                      height: 40,
                                      child: Row(
                                        children: [
                                          Image(
                                            image:
                                                AssetImage("images/order.webp"),
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
                                            Navigator.push(
                                                context,
                                                PageTransition(
                                                    child: CartScreen(),
                                                    type: PageTransitionType
                                                        .rightToLeft));
                                            pizzaController.Pizzatotalprice();
                                            //bottomController.currentindex.value = 3;
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
            ),
          )
        ],
      ),
    );
  }

  void ref() {
    setState(() {});
  }

  Future<void> loaded() async {
    await InterstitialAd.load(
        adUnitId: "ca-app-pub-3940256099942544/1033173712",
        request: AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(
          onAdLoaded: (ad) {
            setState(() {
              isLoaded = true;
              interstitialAd = ad;
            });
            ad.fullScreenContentCallback = FullScreenContentCallback(
              onAdClicked: (ad) {},
              onAdDismissedFullScreenContent: (ad) {
                setState(() {
                  Navigator.push(
                      context,
                      PageTransition(
                          type: PageTransitionType.rightToLeft,
                          child: CustomizePizza()));
                  ad.dispose();
                  isLoaded = false;
                  print("122222");
                });
              },
              onAdWillDismissFullScreenContent: (ad) {
                print("1111111111");
                ad.dispose();
                isLoaded = false;
              },
            );
            setState(() {
              interstitialAd!.show();
            });
          },
          onAdFailedToLoad: (error) {
            print("-OpenAd-$error----------ad is failed--------");
          },
        ));
  }
}
