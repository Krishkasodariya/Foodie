import 'package:Pizza/Admin_Screen/AdminBottomNavigation.dart';
import 'package:Pizza/Admin_Screen/payment_history.dart';
import 'package:Pizza/All%20Screen/AboutScreen.dart';
import 'package:Pizza/All%20Screen/LoginScreen.dart';
import 'package:Pizza/Controller/AdminController.dart';
import 'package:Pizza/Controller/BottomController.dart';
import 'package:Pizza/Controller/GoogleMapController.dart';
import 'package:Pizza/Controller/LoginController.dart';
import 'package:Pizza/Controller/PizzaController.dart';
import 'package:Pizza/Drawer/AddressBook.dart';
import 'package:Pizza/Admin_Screen/AllOrderHistory.dart';
import 'package:Pizza/Drawer/FavouriteOrderScreen.dart';
import 'package:Pizza/Drawer/LikesScreen.dart';
import 'package:Pizza/Drawer/OfferScreen.dart';
import 'package:Pizza/Drawer/ProfileScreen.dart';
import 'package:Pizza/Drawer/RatingScreen.dart';
import 'package:Pizza/Drawer/TrackingOrder.dart';
import 'package:Pizza/Drawer/YourOrderScreen.dart';
import 'package:Pizza/DynamicLink/Path_Constant.dart';
import 'package:Pizza/ModelClass/UserModel.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shimmer/shimmer.dart';

import 'UserPaymentHistory.dart';

class DrawerScreen extends StatefulWidget {
  const DrawerScreen({super.key});

  @override
  State<DrawerScreen> createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
  LoginController logincontroller = Get.find();
  PizzaController pizzaController = Get.find();
  BottomController bottomController = Get.find();
  AdminController adminController = Get.find();
  GoogleMapControllerScreen googleMapControllerScreen = Get.find();

  String? linkMessage;
  bool createdLink = false;
  FirebaseDynamicLinks firebaseDynamicLinks = FirebaseDynamicLinks.instance;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initDynamicLink();

    googleMapControllerScreen.GetLocationData();
    googleMapControllerScreen.HomeLocationupdate(ref);
    logincontroller.Getuid();
    logincontroller.profileData();
    logincontroller.savemodel(UserModel(
        name: logincontroller.addname.text,
        phonenumber: logincontroller.addphonenumber.text,
        email: logincontroller.addemail.text,
        image: logincontroller.imageurl,
        uid: logincontroller.userid,
        isocode: logincontroller.LoginIsoCode,
        dialcode: logincontroller.LoginCountryCode));
    logincontroller.getmodel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF4F6FA),
      appBar: AppBar(
        backgroundColor: Color(0xffF2F4F7),
        elevation: 0,
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
      ),
      body: Container(
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 15),
              child: Container(
                width: double.infinity,
                height: 110,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                  boxShadow: [
                    BoxShadow(
                        color: Color(0xffE9E9F7),
                        blurRadius: 10,
                        spreadRadius: 4)
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: Row(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Spacer(),
                          Text("${logincontroller.addname.text}",
                              style: GoogleFonts.lexend(
                                  color: Colors.black,
                                  fontSize: 23,
                                  fontWeight: FontWeight.w500)),
                          SizedBox(
                            height: 8,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("View activity",
                                  style: GoogleFonts.lexend(
                                      color: Color(0xffEF4F5F),
                                      fontSize: 15,
                                      fontWeight: FontWeight.w400)),
                              Icon(
                                Icons.play_arrow_rounded,
                                color: Color(0xffEF4F5F),
                                size: 15,
                              )
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                      Spacer(),
                      Stack(
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  PageTransition(
                                      type: PageTransitionType.rightToLeft,
                                      child: ProfileScreen()));
                              setState(() {
                                logincontroller.changeColor = false;
                                googleMapControllerScreen
                                    .changeProfileHeight.value = false;
                              });
                            },
                            child: Container(
                              width: 85,
                              height: 85,
                              decoration: BoxDecoration(
                                  color: Color(0xffE9E9F7),
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: Color(0xffEF4F5F),
                                    width: 2,
                                  )),
                              child: Center(
                                child: logincontroller.imageurl.isEmpty
                                    ? Container(
                                        width: 110,
                                        height: 110,
                                        decoration: BoxDecoration(
                                          color: Color(0xffE9E9F7),
                                          shape: BoxShape.circle,
                                        ),
                                        child: Icon(
                                          Icons.person,
                                          color: Color(0xffB1BBDA),
                                          size: 60,
                                        ))
                                    : ClipRRect(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(60)),
                                        child: Container(
                                            width: 110,
                                            height: 110,
                                            decoration: BoxDecoration(
                                              color: Color(0xffE9E9F7),
                                              shape: BoxShape.circle,
                                            ),
                                            child: CachedNetworkImage(
                                                imageUrl: logincontroller.imageurl,
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
                                                width: 110,
                                                height: 110,
                                                fit: BoxFit.cover)),
                                      ),
                              ),
                            ),
                          ),
                          Positioned(
                              top: 65,
                              left: 15,
                              child: Container(
                                  width: 50,
                                  height: 23,
                                  decoration: BoxDecoration(
                                      color: Color(0xffEF4F5F),
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(15)),
                                      border: Border.all(
                                          color: Color(0xffFEF1F3), width: 3)),
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 5),
                                    child: Row(
                                      children: [
                                        Text("32%",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 12,
                                                fontWeight: FontWeight.w400)),
                                        Icon(
                                          Icons.arrow_forward_ios_rounded,
                                          size: 10,
                                          color: Colors.white,
                                        )
                                      ],
                                    ),
                                  )))
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: ListView(
                physics: BouncingScrollPhysics(),
                children: [
                  SizedBox(
                    height: 25,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15, right: 15),
                    child: Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: !createdLink
                                ? () {
                                    createDynamicLink(true, kLikepage);

                                    print(
                                        "llllllllllllllllllllllllllllllllllllllll${linkMessage}");
                                    Navigator.push(
                                        context,
                                        PageTransition(
                                            child: LikesScreen(),
                                            type: PageTransitionType
                                                .rightToLeft));
                                  }
                                : null,
                            child: Container(
                              height: 80,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15)),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Color(0xffE9E9F7),
                                        blurRadius: 10,
                                        spreadRadius: 2)
                                  ]),
                              child: Column(
                                children: [
                                  Spacer(),
                                  Image(
                                    image: AssetImage("images/like.webp"),
                                    width: 28,
                                    height: 28,
                                  ),
                                  Spacer(),
                                  Text(
                                    "Likes",
                                    style: GoogleFonts.nunito(
                                        fontSize: 17,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  Spacer(),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  PageTransition(
                                      type: PageTransitionType.rightToLeft,
                                      child: UserPaymentHistory()));
                            },
                            child: Container(
                              height: 80,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15)),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Color(0xffE9E9F7),
                                        blurRadius: 10,
                                        spreadRadius: 2)
                                  ]),
                              child: Column(
                                children: [
                                  Spacer(),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 3),
                                    child: Image(
                                      image: AssetImage("images/payment.webp"),
                                      width: 29,
                                      height: 29,
                                    ),
                                  ),
                                  Spacer(),
                                  Text(
                                    "Payment",
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.nunito(
                                        fontSize: 17,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  Spacer(),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () {},
                            child: Container(
                              height: 80,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15)),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Color(0xffE9E9F7),
                                        blurRadius: 10,
                                        spreadRadius: 2)
                                  ]),
                              child: Column(
                                children: [
                                  Spacer(),
                                  Image(
                                    image: AssetImage("images/setting.webp"),
                                    width: 25,
                                    height: 25,
                                  ),
                                  Spacer(),
                                  Text(
                                    "Settings",
                                    style: GoogleFonts.nunito(
                                        fontSize: 17,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  Spacer(),
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15, right: 15),
                    child: Container(
                      width: double.infinity,
                      height: 58,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          boxShadow: [
                            BoxShadow(
                                color: Color(0xffE9E9F7),
                                blurRadius: 10,
                                spreadRadius: 2)
                          ]),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        child: Row(
                          children: [
                            Container(
                              width: 36,
                              height: 36,
                              decoration: BoxDecoration(
                                  color: Color(0xffF2F4F7),
                                  shape: BoxShape.circle),
                              child: Padding(
                                padding: const EdgeInsets.all(9),
                                child: Image(
                                    image: AssetImage("images/sync.webp"),
                                    color: Color(0xff787E91)),
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              "App update available",
                              style: GoogleFonts.nunito(
                                  fontSize: 18,
                                  color: Color(0xff313848),
                                  fontWeight: FontWeight.w600),
                            ),
                            Spacer(),
                            Container(
                              width: 60,
                              height: 25,
                              decoration: BoxDecoration(
                                  color: Color(0xffFFF6F7),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15))),
                              child: Center(
                                child: Text(
                                  "v17.27.0",
                                  style: GoogleFonts.nunito(
                                      fontSize: 12,
                                      color: Color(0xffEF4F5F),
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                            ),
                            Spacer(),
                            Icon(
                              Icons.arrow_forward_ios,
                              color: Color(0xff313848),
                              size: 17,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15, right: 15),
                    child: GestureDetector(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return RatingScreen();
                          },
                        );
                      },
                      child: Container(
                        width: double.infinity,
                        height: 58,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            boxShadow: [
                              BoxShadow(
                                  color: Color(0xffE9E9F7),
                                  blurRadius: 10,
                                  spreadRadius: 2)
                            ]),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          child: Row(
                            children: [
                              Container(
                                width: 36,
                                height: 36,
                                decoration: BoxDecoration(
                                    color: Color(0xffF2F4F7),
                                    shape: BoxShape.circle),
                                child: Icon(Icons.star_border_rounded,
                                    color: Color(0xff787E91)),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                "Your rating",
                                style: GoogleFonts.nunito(
                                    fontSize: 18,
                                    color: Color(0xff313848),
                                    fontWeight: FontWeight.w600),
                              ),
                              Spacer(),
                              Spacer(),
                              Spacer(),
                              Container(
                                  width: 48,
                                  height: 20,
                                  decoration: BoxDecoration(
                                      color: Color(0xffF2F4F7),
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(8))),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "--",
                                        style: GoogleFonts.nunito(
                                            fontSize: 15,
                                            color: Color(0xff787E91),
                                            fontWeight: FontWeight.w600),
                                      ),
                                      Icon(Icons.star_rate_rounded,
                                          color: Color(0xff787E91), size: 15),
                                    ],
                                  )),
                              Spacer(),
                              Icon(
                                Icons.arrow_forward_ios,
                                color: Color(0xff313848),
                                size: 17,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15, right: 15),
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                          boxShadow: [
                            BoxShadow(
                                color: Color(0xffE9E9F7),
                                blurRadius: 10,
                                spreadRadius: 4)
                          ]),
                      child: Column(
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
                                    color: Color(0xffEF4F5F),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5))),
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              Center(
                                child: Text(
                                  "Food orders",
                                  style: GoogleFonts.lexend(
                                      color: Colors.black,
                                      fontSize: 21,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 10, left: 10),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    PageTransition(
                                        child: TrackingOrder(),
                                        type: PageTransitionType.rightToLeft));
                              },
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        width: 36,
                                        height: 36,
                                        decoration: BoxDecoration(
                                            color: Color(0xffF2F4F7),
                                            shape: BoxShape.circle),
                                        child: Padding(
                                          padding: const EdgeInsets.all(9),
                                          child: Image(
                                              image: AssetImage(
                                                  "images/order.webp"),
                                              color: Color(0xff787E91)),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        "Tracking orders",
                                        style: GoogleFonts.nunito(
                                            fontSize: 18,
                                            color: Color(0xff313848),
                                            fontWeight: FontWeight.w600),
                                      ),
                                      Spacer(),
                                      Icon(
                                        Icons.arrow_forward_ios,
                                        color: Color(0xff313848),
                                        size: 17,
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 60),
                                    child: Container(
                                      width: double.infinity,
                                      height: 1,
                                      decoration: BoxDecoration(
                                          border: Border.symmetric(
                                              horizontal: BorderSide(
                                                  color: Color(0xffEAEDF3),
                                                  width: 1.5))),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 10, left: 10),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    PageTransition(
                                        child: YourOrderScreen(),
                                        type: PageTransitionType.rightToLeft));
                              },
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        width: 36,
                                        height: 36,
                                        decoration: BoxDecoration(
                                            color: Color(0xffF2F4F7),
                                            shape: BoxShape.circle),
                                        child: Padding(
                                          padding: const EdgeInsets.all(9),
                                          child: Image(
                                              image: AssetImage(
                                                  "images/order.webp"),
                                              color: Color(0xff787E91)),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        "Your orders",
                                        style: GoogleFonts.nunito(
                                            fontSize: 18,
                                            color: Color(0xff313848),
                                            fontWeight: FontWeight.w600),
                                      ),
                                      Spacer(),
                                      Icon(
                                        Icons.arrow_forward_ios,
                                        color: Color(0xff313848),
                                        size: 17,
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 60),
                                    child: Container(
                                      width: double.infinity,
                                      height: 1,
                                      decoration: BoxDecoration(
                                          border: Border.symmetric(
                                              horizontal: BorderSide(
                                                  color: Color(0xffEAEDF3),
                                                  width: 1.5))),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 10, left: 10),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    PageTransition(
                                        child: FavouriteOrderScreen(),
                                        type: PageTransitionType.rightToLeft));
                              },
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        width: 36,
                                        height: 36,
                                        decoration: BoxDecoration(
                                            color: Color(0xffF2F4F7),
                                            shape: BoxShape.circle),
                                        child: Padding(
                                          padding: const EdgeInsets.all(9),
                                          child: Image(
                                              image: AssetImage(
                                                  "images/like.webp"),
                                              color: Color(0xff787E91)),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        "Favorite orders",
                                        style: GoogleFonts.nunito(
                                            fontSize: 18,
                                            color: Color(0xff313848),
                                            fontWeight: FontWeight.w600),
                                      ),
                                      Spacer(),
                                      Icon(
                                        Icons.arrow_forward_ios,
                                        color: Color(0xff313848),
                                        size: 17,
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 60),
                                    child: Container(
                                      width: double.infinity,
                                      height: 1,
                                      decoration: BoxDecoration(
                                          border: Border.symmetric(
                                              horizontal: BorderSide(
                                                  color: Color(0xffEAEDF3),
                                                  width: 1.5))),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 10, left: 10),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    PageTransition(
                                        child: AddressBook(),
                                        type: PageTransitionType.rightToLeft));
                                googleMapControllerScreen
                                    .changeAddressHeight.value = false;
                              },
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        width: 36,
                                        height: 36,
                                        decoration: BoxDecoration(
                                            color: Color(0xffF2F4F7),
                                            shape: BoxShape.circle),
                                        child: Padding(
                                          padding: const EdgeInsets.all(9),
                                          child: Image(
                                              image: AssetImage(
                                                  "images/address.webp"),
                                              color: Color(0xff787E91)),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        "Address Book",
                                        style: GoogleFonts.nunito(
                                            fontSize: 18,
                                            color: Color(0xff313848),
                                            fontWeight: FontWeight.w600),
                                      ),
                                      Spacer(),
                                      Icon(
                                        Icons.arrow_forward_ios,
                                        color: Color(0xff313848),
                                        size: 17,
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 60),
                                    child: Container(
                                      width: double.infinity,
                                      height: 1,
                                      decoration: BoxDecoration(
                                          border: Border.symmetric(
                                              horizontal: BorderSide(
                                                  color: Color(0xffEAEDF3),
                                                  width: 1.5))),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 25,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15, right: 15),
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                          boxShadow: [
                            BoxShadow(
                                color: Color(0xffE9E9F7),
                                blurRadius: 10,
                                spreadRadius: 4)
                          ]),
                      child: Column(
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
                                    color: Color(0xffEF4F5F),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5))),
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              Center(
                                child: Text(
                                  "Offer",
                                  style: GoogleFonts.lexend(
                                      color: Colors.black,
                                      fontSize: 21,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 10, left: 10),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    PageTransition(
                                        child: OfferScreen(),
                                        type: PageTransitionType.rightToLeft));
                              },
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        width: 36,
                                        height: 36,
                                        decoration: BoxDecoration(
                                            color: Color(0xffF2F4F7),
                                            shape: BoxShape.circle),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8),
                                          child: Image(
                                              image: AssetImage(
                                                  "images/discount.webp"),
                                              color: Color(0xff787E91)),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        "Coupons",
                                        style: GoogleFonts.nunito(
                                            fontSize: 18,
                                            color: Color(0xff313848),
                                            fontWeight: FontWeight.w600),
                                      ),
                                      Spacer(),
                                      Icon(
                                        Icons.arrow_forward_ios,
                                        color: Color(0xff313848),
                                        size: 17,
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 60),
                                    child: Container(
                                      width: double.infinity,
                                      height: 1,
                                      decoration: BoxDecoration(
                                          border: Border.symmetric(
                                              horizontal: BorderSide(
                                                  color: Color(0xffEAEDF3),
                                                  width: 1.5))),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 25,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15, right: 15),
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                          boxShadow: [
                            BoxShadow(
                                color: Color(0xffE9E9F7),
                                blurRadius: 10,
                                spreadRadius: 4)
                          ]),
                      child: Column(
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
                                    color: Color(0xffEF4F5F),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5))),
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              Center(
                                child: Text(
                                  "Admin",
                                  style: GoogleFonts.lexend(
                                      color: Colors.black,
                                      fontSize: 21,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 10, left: 10),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    PageTransition(
                                        child: const PaymentHistory(),
                                        type: PageTransitionType.rightToLeft));
                              },
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        width: 36,
                                        height: 36,
                                        decoration: BoxDecoration(
                                            color: Color(0xffF2F4F7),
                                            shape: BoxShape.circle),
                                        child: Padding(

                                          padding: const EdgeInsets.all(8),
                                          child: Image(
                                            color: Color(0xff787E91),
                                            image: AssetImage("images/payment.webp"),
                                            width: 29,
                                            height: 29,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        "Payment History",
                                        style: GoogleFonts.nunito(
                                            fontSize: 18,
                                            color: Color(0xff313848),
                                            fontWeight: FontWeight.w600),
                                      ),
                                      Spacer(),
                                      Icon(
                                        Icons.arrow_forward_ios,
                                        color: Color(0xff313848),
                                        size: 17,
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 60),
                                    child: Container(
                                      width: double.infinity,
                                      height: 1,
                                      decoration: BoxDecoration(
                                          border: Border.symmetric(
                                              horizontal: BorderSide(
                                                  color: Color(0xffEAEDF3),
                                                  width: 1.5))),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 10, left: 10),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    PageTransition(
                                        child: AdminBottomNavigation(),
                                        type: PageTransitionType.rightToLeft));
                                adminController.isAdmin.value = true;
                              },
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        width: 36,
                                        height: 36,
                                        decoration: BoxDecoration(
                                            color: Color(0xffF2F4F7),
                                            shape: BoxShape.circle),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8),
                                          child: Image(
                                              image: AssetImage(
                                                  "images/discount.webp"),
                                              color: Color(0xff787E91)),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        "Any changes",
                                        style: GoogleFonts.nunito(
                                            fontSize: 18,
                                            color: Color(0xff313848),
                                            fontWeight: FontWeight.w600),
                                      ),
                                      Spacer(),
                                      Icon(
                                        Icons.arrow_forward_ios,
                                        color: Color(0xff313848),
                                        size: 17,
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 60),
                                    child: Container(
                                      width: double.infinity,
                                      height: 1,
                                      decoration: BoxDecoration(
                                          border: Border.symmetric(
                                              horizontal: BorderSide(
                                                  color: Color(0xffEAEDF3),
                                                  width: 1.5))),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 10, left: 10),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    PageTransition(
                                        child: AllOrderHistory(),
                                        type: PageTransitionType.rightToLeft));
                              },
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        width: 36,
                                        height: 36,
                                        decoration: BoxDecoration(
                                            color: Color(0xffF2F4F7),
                                            shape: BoxShape.circle),
                                        child: Padding(
                                          padding: const EdgeInsets.all(9),
                                          child: Image(
                                              image: AssetImage(
                                                  "images/order.webp"),
                                              color: Color(0xff787E91)),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        "Customer orders",
                                        style: GoogleFonts.nunito(
                                            fontSize: 18,
                                            color: Color(0xff313848),
                                            fontWeight: FontWeight.w600),
                                      ),
                                      Spacer(),
                                      Icon(
                                        Icons.arrow_forward_ios,
                                        color: Color(0xff313848),
                                        size: 17,
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 60),
                                    child: Container(
                                      width: double.infinity,
                                      height: 1,
                                      decoration: BoxDecoration(
                                          border: Border.symmetric(
                                              horizontal: BorderSide(
                                                  color: Color(0xffEAEDF3),
                                                  width: 1.5))),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 25,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15, right: 15),
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                          boxShadow: [
                            BoxShadow(
                                color: Color(0xffE9E9F7),
                                blurRadius: 10,
                                spreadRadius: 4)
                          ]),
                      child: Column(
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
                                    color: Color(0xffEF4F5F),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5))),
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              Center(
                                child: Text(
                                  "More",
                                  style: GoogleFonts.lexend(
                                      color: Colors.black,
                                      fontSize: 21,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 10, left: 10),
                            child: GestureDetector(
                              onTap: () {
                                // Share.share("com.example.wallpaper");
                                Share.share("com.example.pizza");
                              },
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        width: 36,
                                        height: 36,
                                        decoration: BoxDecoration(
                                            color: Color(0xffF2F4F7),
                                            shape: BoxShape.circle),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8),
                                          child: Image(
                                              image: AssetImage(
                                                  "images/share.webp"),
                                              color: Color(0xff787E91)),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        "Share this app",
                                        style: GoogleFonts.nunito(
                                            fontSize: 18,
                                            color: Color(0xff313848),
                                            fontWeight: FontWeight.w600),
                                      ),
                                      Spacer(),
                                      Icon(
                                        Icons.arrow_forward_ios,
                                        color: Color(0xff313848),
                                        size: 17,
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 60),
                                    child: Container(
                                      width: double.infinity,
                                      height: 1,
                                      decoration: BoxDecoration(
                                          border: Border.symmetric(
                                              horizontal: BorderSide(
                                                  color: Color(0xffEAEDF3),
                                                  width: 1.5))),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          GestureDetector(
                            onTap: !createdLink
                                ? () {
                                    createDynamicLink(true, kAboutpage);
                                    print(
                                        "ssssssssssssssssssssssssssssssssss${linkMessage}");
                                    Navigator.push(
                                        context,
                                        PageTransition(
                                            child: AboutScreen(),
                                            type: PageTransitionType
                                                .rightToLeft));
                                  }
                                : null,
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(right: 10, left: 10),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        width: 36,
                                        height: 36,
                                        decoration: BoxDecoration(
                                            color: Color(0xffF2F4F7),
                                            shape: BoxShape.circle),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8),
                                          child: Image(
                                              image: AssetImage(
                                                  "images/about.webp"),
                                              color: Color(0xff787E91)),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        "About",
                                        style: GoogleFonts.nunito(
                                            fontSize: 18,
                                            color: Color(0xff313848),
                                            fontWeight: FontWeight.w600),
                                      ),
                                      Spacer(),
                                      Icon(
                                        Icons.arrow_forward_ios,
                                        color: Color(0xff313848),
                                        size: 17,
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 60),
                                    child: Container(
                                      width: double.infinity,
                                      height: 1,
                                      decoration: BoxDecoration(
                                          border: Border.symmetric(
                                              horizontal: BorderSide(
                                                  color: Color(0xffEAEDF3),
                                                  width: 1.5))),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 10, left: 10),
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  logincontroller.logout();
                                  Get.off(LoginScrren());

                                });
                              },
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        width: 36,
                                        height: 36,
                                        decoration: BoxDecoration(
                                            color: Color(0xffF2F4F7),
                                            shape: BoxShape.circle),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.5),
                                          child: Image(
                                              image: AssetImage(
                                                  "images/logout.webp"),
                                              color: Color(0xff787E91)),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        "Logout",
                                        style: GoogleFonts.nunito(
                                            fontSize: 18,
                                            color: Color(0xff313848),
                                            fontWeight: FontWeight.w600),
                                      ),
                                      Spacer(),
                                      Icon(
                                        Icons.arrow_forward_ios,
                                        color: Color(0xff313848),
                                        size: 17,
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 60),
                                    child: Container(
                                      width: double.infinity,
                                      height: 1,
                                      decoration: BoxDecoration(
                                          border: Border.symmetric(
                                              horizontal: BorderSide(
                                                  color: Color(0xffEAEDF3),
                                                  width: 1.5))),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 25,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    height: 180,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Foodie",
                          style: GoogleFonts.calistoga(
                            fontSize: 30,
                            color: Color(0xffB0B4C0),
                          ),
                        ),
                        Text(
                          "v17.27.0",
                          style: GoogleFonts.nunito(
                              fontSize: 15,
                              color: Color(0xffB0B4C0),
                              fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> initDynamicLink() async {
    firebaseDynamicLinks.onLink.listen((event) {
      /*  final Uri uri = event.link;

      final queryParams = uri.queryParameters;*/
      Navigator.pushNamed(context, event.link.path);
    }).onError((handleError) {
      print("999999999999999999999${handleError}");
    });
  }

  Future<void> createDynamicLink(bool short, String link) async {
    setState(() {
      createdLink = true;
    });

    final DynamicLinkParameters parameters = DynamicLinkParameters(
        link: Uri.parse(kUriPrefix + link),
        uriPrefix: kUriPrefix,
        androidParameters: AndroidParameters(
            packageName: "com.example.Pizza", minimumVersion: 0));

    Uri url;
    if (short) {
      final ShortDynamicLink shortLink =
          await firebaseDynamicLinks.buildShortLink(parameters);
      url = shortLink.shortUrl;
    } else {
      url = await firebaseDynamicLinks.buildLink(parameters);
    }

    linkMessage = url.toString();
    print("aaaaaaaaaaaaaaaaaaaaaaaaa${linkMessage}");

    setState(() {
      createdLink = false;
    });
  }

  void ref() {
    setState(() {});
  }
}
