import 'package:Pizza/Admin_Screen/Add_Restaurants.dart';
import 'package:Pizza/Admin_Screen/Add_Soda.dart';
import 'package:Pizza/Controller/BottomController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';

import '../Controller/AdminController.dart';
import '../Controller/GoogleMapController.dart';
import '../Drawer/AddressBook.dart';
import '../Drawer/DrawerScreen.dart';

class AdminBottomNavigation extends StatefulWidget {
  const AdminBottomNavigation({super.key});

  @override
  State<AdminBottomNavigation> createState() => _AdminBottomNavigationState();
}

class _AdminBottomNavigationState extends State<AdminBottomNavigation> {
  BottomController bottomController = Get.find();
  GoogleMapControllerScreen googleMapControllerScreen = Get.find();
  AdminController adminController = Get.find();

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
                                :*/
                            Obx(
                                  () => Text(
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
                              child: /* googleMapControllerScreen.area == null
                                  ? Text(
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      "${googleMapControllerScreen.place.locality}",
                                      style: GoogleFonts.nunito(
                                          fontSize: 15,
                                          color: Color(0xff737373),
                                          fontWeight: FontWeight.w700),
                                    )
                                  :*/
                              Obx(
                                    () => Text(
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
                if (bottomController.adminCurrentindex == 0) {
                  Navigator.push(
                    context,
                    PageTransition(
                      type: PageTransitionType.rightToLeft,
                      child: const AddRestaurants(),
                    ),
                  );
                } else if (bottomController.adminCurrentindex == 1) {
                  Navigator.push(
                      context,
                      PageTransition(
                          type: PageTransitionType.rightToLeft,
                          child: SodaAddView()));
                  print("2222");
                }
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
      bottomNavigationBar: Obx(
            () => Container(
          color: Colors.red,
          width: double.infinity,
          height: 60,
          child: BottomNavigationBar(
            onTap: (value) {
              setState(() {
                bottomController.adminCurrentindex.value = value;
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
            currentIndex: bottomController.adminCurrentindex.value,
            type: BottomNavigationBarType.fixed,
            selectedItemColor: Color(0xffEF4F5F),
            unselectedItemColor: Color(0xff787E91),
            items: [
              BottomNavigationBarItem(
                  icon: bottomController.adminCurrentindex == 0
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
                  icon: bottomController.adminCurrentindex == 1
                      ? Image.asset(
                    "images/bsoda.webp",
                    width: 23,
                    height: 23,
                    color: Color(0xffEF4F5F),
                  )
                      : Image.asset(
                    "images/bsoda.webp",
                    width: 23,
                    height: 23,
                    color: Color(0xff787E91),
                  ),
                  label: "cold drinks"),
            ],
          ),
        ),
      ),
      body: Obx(
            () => WillPopScope(
          onWillPop: () {
            Navigator.pop(context);
            adminController.isAdmin.value = false;
            return Future.value(true);
          },
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: bottomController
                .adminPage.value[bottomController.adminCurrentindex.value],
          ),
        ),
      ),
    );
  }
}