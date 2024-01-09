import 'package:Pizza/Controller/GoogleMapController.dart';
import 'package:Pizza/Drawer/AddressBook.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:page_transition/page_transition.dart';
import 'package:Pizza/Controller/BottomController.dart';
import 'package:Pizza/Controller/LoginController.dart';
import 'package:Pizza/Controller/PizzaController.dart';
import 'package:Pizza/Drawer/DrawerScreen.dart';
import 'package:Pizza/ModelClass/UserModel.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({super.key});

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  BottomController bottomController = Get.find();
  PizzaController pizzaController = Get.find();
  LoginController logincontroller = Get.find();
  GoogleMapControllerScreen googleMapControllerScreen = Get.find();
  //BannerAd? bannerAd;
  //bool isLoaded = false;

  @override
  void initState() {
    // TODO: implement initState
    //loaded();
    super.initState();
    googleMapControllerScreen.gotoUserCurrentPosition();
    pizzaController.getconnectivity(context);
    googleMapControllerScreen.GetLocationData();
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
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    pizzaController.subscription.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: Container(),
        actions: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 12, right: 10),
              child: Container(
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            PageTransition(
                                type: PageTransitionType.rightToLeft,
                                child: AddressBook()));
                      },
                      child: Icon(
                        Icons.location_on_rounded,
                        color: Color(0xffEF505F),
                        size: 28,
                      ),
                    ),
                    Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: /*googleMapControllerScreen.addresstype == null
                                ? Text(
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    "${googleMapControllerScreen.place.subLocality}",
                                    style: GoogleFonts.nunito(
                                        fontSize: 20,
                                        color: Color(0xff313848),
                                        fontWeight: FontWeight.w700),
                                  )
                                :*/ Obx(()=>
                                Text(
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      "${googleMapControllerScreen.addresstype}",
                                      style: GoogleFonts.nunito(
                                          fontSize: 20,
                                          color: Color(0xff313848),
                                          fontWeight: FontWeight.w700),
                                    ),
                                ),
                          ),
                          Container(
                            width: 220,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child:/* googleMapControllerScreen.area == null
                                  ? Text(
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      "${googleMapControllerScreen.place.locality}",
                                      style: GoogleFonts.nunito(
                                          fontSize: 15,
                                          color: Color(0xff737373),
                                          fontWeight: FontWeight.w700),
                                    )
                                  :*/ Obx(()=>
                                  Text(
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        "${googleMapControllerScreen.area}",
                                        style: GoogleFonts.nunito(
                                            fontSize: 15,
                                            color: Color(0xff737373),
                                            fontWeight: FontWeight.w700),
                                      ),
                                  ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    PageTransition(
                        type: PageTransitionType.rightToLeft,
                        child: DrawerScreen()));
              },
              child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                      color: Color(0xffE9E9F7), shape: BoxShape.circle),
                  child: Icon(
                    Icons.person,
                    color: Color(0xffB1BBDA),
                    size: 30,
                  )),
            ),
          ),
        ],
      ),
      bottomNavigationBar: /*isLoaded
          ? Container(
              width: bannerAd!.size.width.toDouble(),
              height:60,
              child: AdWidget(ad: bannerAd!))
          :*/ Obx(
              () => Container(
                color: Colors.red,
                width: double.infinity,
                height: 60,
                child: BottomNavigationBar(
                  onTap: (value) {
                    setState(() {
                      bottomController.currentindex.value = value;
                    });
                  },
                  selectedLabelStyle: GoogleFonts.nunito(
                      color: Color(0xffEF4F5F),
                      fontSize: 13,
                      fontWeight: FontWeight.w400),
                  unselectedLabelStyle: GoogleFonts.nunito(
                      color: Color(0xff787E91),
                      fontSize: 13,
                      fontWeight: FontWeight.w400),
                  backgroundColor: Colors.white,
                  elevation: 0,
                  unselectedFontSize: 12,
                  selectedFontSize: 12,
                  showSelectedLabels: true,
                  showUnselectedLabels: true,
                  currentIndex: bottomController.currentindex.value,
                  type: BottomNavigationBarType.fixed,
                  selectedItemColor: Color(0xffEF4F5F),
                  unselectedItemColor: Color(0xff787E91),
                  items: [
                    BottomNavigationBarItem(
                        icon: bottomController.currentindex == 0
                            ? Image.asset(
                                "images/home.webp",
                                width: 23,
                                height: 23,
                                color: Color(0xffEF4F5F),
                              )
                            : Image.asset(
                                "images/home.webp",
                                width: 23,
                                height: 23,
                                color: Color(0xff787E91),
                              ),
                        label: "home"),
                    BottomNavigationBarItem(
                        icon: bottomController.currentindex == 1
                            ? Image.asset(
                                "images/food.webp",
                                width: 23,
                                height: 23,
                                color: Color(0xffEF4F5F),
                              )
                            : Image.asset(
                                "images/food.webp",
                                width: 23,
                                height: 23,
                                color: Color(0xff787E91),
                              ),
                        label: "food"),
                    BottomNavigationBarItem(
                        icon: bottomController.currentindex == 2
                            ? Image.asset(
                                "images/bsoda.webp",
                                width: 22,
                                height: 22,
                                color: Color(0xffEF4F5F),
                              )
                            : Image.asset(
                                "images/bsoda.webp",
                                width: 22,
                                height: 22,
                                color: Color(0xff787E91),
                              ),
                        label: "cold drinks"),
                    BottomNavigationBarItem(
                        icon: bottomController.currentindex == 3
                            ? Image.asset(
                                "images/cart.webp",
                                width: 22,
                                height: 22,
                                color: Color(0xffEF4F5F),
                              )
                            : Image.asset(
                                "images/cart.webp",
                                width: 22,
                                height: 22,
                                color: Color(0xff787E91),
                              ),
                        label: "cart"),
                  ],
                ),
              ),
            ),
      body: Obx(
        () => Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child:
              bottomController.page.value[bottomController.currentindex.value],
        ),
      ),
    );
  }

  /*void loaded() {
    bannerAd = BannerAd(
        size: AdSize.banner,
        adUnitId: "ca-app-pub-3940256099942544/6300978111",
        listener: BannerAdListener(
          onAdOpened: (ad) {
            print("--Banner---$ad-----onAdOpened--------");
          },
          onAdLoaded: (ad) {
            setState(() {
              isLoaded = true;
            });

            Future.delayed(Duration(seconds: 10)).then((value){
              setState(() {
                isLoaded=false;
                ad.dispose();
              });
            });
          },
          onAdClicked: (ad) {
            print("--Banner---$ad-----onAdClicked--------");
            setState(() {
              isLoaded=false;
              ad.dispose();
            });

          },
          onAdClosed: (ad) {
            print("--Banner---$ad-----onAdClosed--------");
            setState(() {
              isLoaded=false;
            });
          },

          onAdFailedToLoad: (ad, error) {
            print("--Banner---$ad-----onAdFailedToLoad-----$error---");
            ad.dispose();
            isLoaded = false;
          },
        ),
        request: AdRequest())
      ..load();
  }*/
}
