import 'package:Pizza/All%20Screen/AboutScreen.dart';
import 'package:Pizza/All%20Screen/DinnerScreen.dart';
import 'package:Pizza/All%20Screen/HomeScreen.dart';
import 'package:Pizza/Drawer/LikesScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RouteServices{
  static Route<dynamic> generateRoute(RouteSettings routeSettings){
    final args  =routeSettings.arguments;
    switch(routeSettings.name){
      case"/aboutpage":
        return CupertinoPageRoute(builder: (context) {
          return AboutScreen();
        },);

      case"/likepage":
        return CupertinoPageRoute(builder: (context) {
          return LikesScreen();
        },);
      default:
        return errorRoute();

    }
  }



  static Route<dynamic> errorRoute(){
    print("eeeeeeeeeeeeeeeeeeeeeeeeeee");
   return null!;
  }


}