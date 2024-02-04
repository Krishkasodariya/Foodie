import 'package:Pizza/All%20Screen/CartScreen.dart';
import 'package:Pizza/All%20Screen/DinnerScreen.dart';
import 'package:Pizza/All%20Screen/HomeScreen.dart';
import 'package:Pizza/All%20Screen/SodaScreen.dart';
import 'package:get/get.dart';




class BottomController extends GetxController {

  bool onSubmit=false;
  RxInt currentindex = 0.obs;
  RxList page = [HomeScreen(), DinnerScreen(),  SodaScreen(), CartScreen()].obs;

  RxInt adminCurrentindex = 0.obs;
  RxList adminPage = [DinnerScreen(), SodaScreen(),].obs;


}
