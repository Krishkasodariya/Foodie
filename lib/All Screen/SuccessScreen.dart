import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:Pizza/BottomNavigation/BottomNavigation.dart';

class SuccessScreen extends StatefulWidget {
  const SuccessScreen({super.key});

  @override
  State<SuccessScreen> createState() => _SuccessScreenState();
}

class _SuccessScreenState extends State<SuccessScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(Duration(seconds: 1),()=>Get.off(()=>BottomNavigation()));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: WillPopScope(
          onWillPop: () {
            return Future.value(false);
          },
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            color: Colors.white,
            child: Column(
              children: [
                Spacer(),
                SizedBox(
                  height: 20,
                ),
                Center(
                  child: Lottie.asset(
                    "images/success.json",
                    width:  500,
                    height: 230,
                  ),
                ),
                Text(
                  "Enjoy Your Pizza",
                  style: GoogleFonts.lexend(
                      fontSize: 24,
                      color: Color(0xff313848),
                      fontWeight: FontWeight.w600),
                ),

                SizedBox(
                  height: 15,
                ),
                Center(
                  child: Text(
                    "Eating Your Pizaa And Happy With Family",
                    style: GoogleFonts.lexend(
                        fontSize: 15,
                        color: Color(0xff7e878d),
                        fontWeight: FontWeight.w400),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                SizedBox(height: 60,),
                Spacer(),
              ],
            ),
          ),
        ));
  }
}
