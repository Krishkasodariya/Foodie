import 'package:Pizza/All%20Screen/CartScreen.dart';
import 'package:Pizza/All%20Screen/DinnerScreen.dart';
import 'package:Pizza/All%20Screen/HomeScreen.dart';
import 'package:Pizza/All%20Screen/SodaScreen.dart';
import 'package:Pizza/DynamicLink/Path_Constant.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';



class BottomController extends GetxController {



  RxInt currentindex = 0.obs;
  RxList page = [HomeScreen(), DinnerScreen(),  SodaScreen(), CartScreen()].obs;



}
