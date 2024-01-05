import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:Pizza/All%20Screen/LoginScreen.dart';
import 'package:Pizza/ModelClass/BoardingModelClass.dart';
import 'package:Pizza/SplashScreenData/SpalshScreen.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class BoardingScreen extends StatefulWidget {
  const BoardingScreen({super.key});

  @override
  State<BoardingScreen> createState() => _BoardingScreenState();
}

class _BoardingScreenState extends State<BoardingScreen> {
  List<BoardingModelClass> boardinglist = [
    BoardingModelClass(
      title: "Chosse A Tasty",
      lottiefile: "images/phone_burger.json",
      subtitle:
          "When you order Eat Street ,we'll \n   hook you up with exclusive \n                  coupons.",
    ),
    BoardingModelClass(
      title: "Discover Place",
      lottiefile: "images/pizza_phone.json",
      subtitle:
          "We make it simple to find the \n  food you crave. Enter your \n           address and let",
    ),
    BoardingModelClass(
      title: "Pick Up Or",
      lottiefile: "images/delivery_boy.json",
      subtitle:
          "We make food ordering fast simple \n  and free - no matter if you order",
    ),
  ];
  PageController pageController = new PageController();
  int pindex = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 1.4,
              child: CustomPaint(
                painter: ArcPainter(),
              ),
            ),
            Positioned(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 1.4,
             // top: 130,
              //right: 5,
              //left: 5,
              child: Lottie.asset(
                boardinglist[pindex].lottiefile,
                key: Key('${Random().nextInt(999999999)}'),
                width: 600,
                alignment: Alignment.topCenter,
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.33,
                child: PageView.builder(
                  controller: pageController,
                  itemCount: boardinglist.length,
                  onPageChanged: (value) {
                    setState(() {
                      pindex = value;
                    });
                  },
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        Text(
                          boardinglist[index].title,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 25,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 40),
                        Text(
                          boardinglist[index].subtitle,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w200),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(left: 10,right: 10),
                child: Container(
                  width: double.infinity,
                  height: 60,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      TextButton(
                          onPressed: () {
                            pageController.jumpToPage(2);
                          },
                          child: Text("Skip",style: TextStyle(color: Colors.white,fontSize: 15),)),
                      Spacer(),
                      SmoothPageIndicator(
                        controller: pageController,
                        count: boardinglist.length,
                        effect: JumpingDotEffect(
                          activeDotColor: Colors.white,
                          dotWidth: 8,
                          dotHeight: 8,
                        ),
                      ),
                      Spacer(),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 6),
                        child: IconButton(
                            onPressed: () {
                              pageController.nextPage(
                                  duration: Duration(milliseconds: 500),
                                  curve: Curves.easeIn);
                              if(pindex==2){
                                Get.off(SplashScreen());
                              }
                            },
                            icon: Icon(
                              Icons.navigate_next_rounded,
                              color: Colors.white,
                              size: 32,
                            )),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ArcPainter extends CustomPainter {
  void paint(Canvas canvas, Size size) {
    Path redarc = Path()
      ..moveTo(0, 0)
      ..lineTo(0, size.height - 170)
      ..quadraticBezierTo(
          size.width / 2, size.height, size.width, size.height - 170)
      ..lineTo(size.width, size.height)
      ..lineTo(size.width, 0)
      ..close();

    canvas.drawPath(redarc, Paint()..color = Color(0xffE23644));

    Path whitearc = Path()
      ..moveTo(0, 0)
      ..lineTo(0, size.height - 185)
      ..quadraticBezierTo(
          size.width / 2, size.height - 70, size.width, size.height - 185)
      ..lineTo(size.width, size.height)
      ..lineTo(size.width, 0)
      ..close();

    canvas.drawPath(whitearc, Paint()..color = Colors.white);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // throw UnimplementedError();
    return false;
  }
}
