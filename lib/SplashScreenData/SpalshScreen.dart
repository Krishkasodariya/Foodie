import 'dart:async';
import 'package:Pizza/Controller/GoogleMapController.dart';
import 'package:Pizza/Controller/PizzaController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:Pizza/All%20Screen/LoginScreen.dart';
import 'package:Pizza/BottomNavigation/BottomNavigation.dart';
import 'package:Pizza/Controller/LoginController.dart';
import 'package:Pizza/ModelClass/UserModel.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

AppOpenAd? openad;

class _SplashScreenState extends State<SplashScreen> {
  LoginController loginController = Get.find();
  GoogleMapControllerScreen GoogleMapController = Get.find();

  bool isShowingAd = false;
  bool isLoaded = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadAd();

    GoogleMapController.defaultLocation();
    loginController.Getuid();
    loginController.profileData();
    GoogleMapController.GetLocationData();
    loginController.savemodel(UserModel(
        name: loginController.addname.text,
        phonenumber: loginController.addphonenumber.text,
        email: loginController.addemail.text,
        image: loginController.imageurl,
        uid: loginController.userid,
        isocode: loginController.LoginIsoCode,
        dialcode: loginController.LoginCountryCode));
    loginController.getmodel();

  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: /*isShowingAd
          ?*/ Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              color: Color(0xffe23644),
              child: Column(
                children: [
                  Spacer(),
                  Spacer(),
                  Text(
                    "Foodie",
                    style: GoogleFonts.calistoga(
                      fontSize: 50,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    "100% Green Deliveries",
                    style: GoogleFonts.roboto(
                        fontSize: 23,
                        color: Colors.white,
                        fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text("Carbon and Plastic Neutral \n                in India",
                      style: GoogleFonts.aBeeZee(
                          fontSize: 16,
                          color: Colors.white70,
                          fontWeight: FontWeight.w200)),
                  Image(image: AssetImage("images/green_deliveries.webp")),
                  Spacer(),
                  Container(
                    width: double.infinity,
                    height: 200,
                    child: Opacity(
                      opacity: 0.13,
                      child: Image(
                        image: AssetImage("images/tree.webp"),
                      ),
                    ),
                  )
                ],
              ),
            )
         /* : Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              color: Color(0xffe23644),
              child: Center(
                  child: CircularProgressIndicator(
                color: Colors.white,
              ))),*/
    );
  }

/*  Future chekedfirsttime() async {
    //SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    loginController.sharedPreferences = await SharedPreferences.getInstance();
    bool check = (loginController.sharedPreferences!.getBool("che") ?? false);

    if (check) {
      if (loginController.userid.isEmpty) {
        await loginController.sharedPreferences!.setBool('che', true);
        Timer(Duration(seconds: 5), () => Get.off(() => LoginScrren()));
        print("-OpenAd-----splash----------------LoginScrren-----------------");
      } else {
        Timer(Duration(seconds: 5), () => Get.off(() => BottomNavigation()));
        print("--OpenAd-----splash---------------BottomNavigation-----------------");
      }
    } else {
      await loginController.sharedPreferences!.setBool('che', true);
      Timer(Duration(seconds: 5), () => Get.off(() => LoginScrren()));
    }
  }*/

  Future<void> loadAd() async {
    await AppOpenAd.load(
        adUnitId: "ca-app-pub-3940256099942544/9257395921",
        request: AdRequest(),
        adLoadCallback: AppOpenAdLoadCallback(
          onAdLoaded: (ad) {
            setState(() {
              openad = ad;
              isLoaded = true;
            });

            ad.fullScreenContentCallback=FullScreenContentCallback(
              onAdClicked: (ad) {
              },
              onAdDismissedFullScreenContent: (ad){
                setState(() {
                  Get.off(BottomNavigation());
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
              openad!.show();
            });
          },
          onAdFailedToLoad: (error) {
            print("-OpenAd-$error----------ad is failed--------");
          },
        ),
        orientation: AppOpenAd.orientationPortrait);
  }


}
