import 'dart:async';

import 'package:Pizza/Controller/BottomController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:Pizza/All%20Screen/PizzaDeliveryScreen.dart';

class CookingScreen extends StatefulWidget {
  int total;
  CookingScreen({super.key, required this.total});

  @override
  State<CookingScreen> createState() => _SuccessScreenState();
}

class _SuccessScreenState extends State<CookingScreen> {
BottomController bottomController=Get.find();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(Duration(seconds: 1),()=>Get.off(()=>PizzaDeliveryScreen()));
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
                "images/cooking.json",
                width: 230,
                height: 230,
              ),
            ),
            Text(
              "Your Pizza Is Cooking",
              style: GoogleFonts.lexend(
                  fontSize: 24,
                  color: Color(0xff313848),
                  fontWeight: FontWeight.w600),
            ),
            Text(
              "Please Wait",
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
                "Your order will place in your location",
                style: GoogleFonts.lexend(
                    fontSize: 15,
                    color: Color(0xff7e878d),
                    fontWeight: FontWeight.w400),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image(
                  image: AssetImage("images/rupee.webp"),
                  width: 30,
                  height: 30,
                  color: Color(0xff1F1F1F),
                ),
                Text("${widget.total}",
                    style: GoogleFonts.nunito(
                        color: Color(0xff1F1F1F),
                        fontSize: 30,
                        fontWeight: FontWeight.w500)),
              ],
            ),
            SizedBox(height: 60,),
            Spacer(),
          ],
                ),
              ),
        ));
  }
}
