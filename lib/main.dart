import 'package:Pizza/Controller/AdminController.dart';
import 'package:Pizza/Controller/GoogleMapController.dart';
import 'package:Pizza/Controller/OrderController.dart';
import 'package:Pizza/DynamicLink/Route_Services.dart';
import 'package:Pizza/Notification/FirebaseApiScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:Pizza/Controller/BottomController.dart';
import 'package:Pizza/Controller/LoginController.dart';
import 'package:Pizza/Controller/PizzaController.dart';
import 'package:Pizza/Controller/SodaController.dart';
import 'package:Pizza/OnBoardingScreen/BoardingScreen.dart';
import 'package:Pizza/SplashScreenData/SpalshScreen.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:shared_preferences/shared_preferences.dart';

// splashscrren ma appopen ads,bottom ma bannner, dinner screen ma native,pizzascreen ma intersession

//aikey------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
//payment keyid----rzp_test_h26N4DQazh4l0W
//Key Secret------AH3FRRR34e2uXrgDq6HgKyCu

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await MobileAds.instance.initialize();
  await FirebaseApi().initNotification();

  Get.put(LoginController());
  Get.put(BottomController());
  Get.put(PizzaController());
  Get.put(SodaController());
  Get.put(GoogleMapControllerScreen());
  Get.put(OrderController());
  Get.put(AdminController());

  configLoading();
  runApp(GetMaterialApp(
    builder: EasyLoading.init(),
    home: Myapp(),
    onGenerateRoute: RouteServices.generateRoute,
    debugShowCheckedModeBanner: false,
  ));
}

void configLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2000)
    ..indicatorType = EasyLoadingIndicatorType.fadingCircle
    ..loadingStyle = EasyLoadingStyle.dark
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..userInteractions = true
    ..dismissOnTap = false;
}

/*final router = GoRouter(
    routes: [GoRoute(path: '/', builder: (context, state) => BoardingScreen(),
      routes: [GoRoute(path: 'SplashScreen', builder: (context, state) => SplashScreen(),
        routes: [GoRoute(path: 'LoginScrren', builder: (context, state) => LoginScrren(),
              routes: [GoRoute(path: 'OtpScreen',builder: (context, state) => OtpScreen(country: country, phone: phone, iso: iso),)])
        ])
  ])
]);*/

class Myapp extends StatefulWidget {
  const Myapp({super.key});

  @override
  State<Myapp> createState() => _MyappState();
}

class _MyappState extends State<Myapp> {

  LoginController loginController = Get.find();
  BottomController bottomController = Get.find();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context){
    return MaterialApp(
      builder: (context, child) {
        return FutureBuilder(
          future: chekedfirsttime(),
          builder: (context, snapshot) {
            return Container();
          },
        );
      },
    );
  }

  Future chekedfirsttime() async {
    loginController.sharedPreferences = await SharedPreferences.getInstance();
    bool check = (loginController.sharedPreferences!.getBool("check") ?? false);
    if (check) {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => SplashScreen()));
    } else {
      await loginController.sharedPreferences!.setBool('check', true);
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => BoardingScreen()));
    }
  }
}


// 292130 -- dark purple