import 'dart:typed_data';

import 'package:Pizza/ModelClass/FoodItemModel.dart';
import 'package:Pizza/ModelClass/Ingredient.dart';
import 'package:Pizza/ModelClass/PizzaMeta.dart';
import 'package:Pizza/ModelClass/PizzaSize.dart';

class OrderFoodItemModel{
  int id;
  String  food;
  String ?image;
  String ?name;
  int price;
  bool checkadd = false;
  int selectitem = 1;
  int foodbill;
  int foodtotal;
  String? rating;

  Uint8List? imagebyte;

  List<PizzaSize> ?pizzasizelist = [];
  List<Ingredient> ?ingredients = [];
  List<PizzaMeta> ?pizzametalist = [];


  List<FoodItemModel> yourOrderBottomList=[];
  List<PizzaSize> ?yourOrderSizelist = [];
  List<PizzaMeta> ?yourOrderPizzaMetalist = [];

  OrderFoodItemModel({
    required this.id,
    required this.food,
    this.name,
    this.image,
    this.rating,
    this.imagebyte,
    this.pizzasizelist,
    this.ingredients,
    this.pizzametalist,
    /* this.pizzasize,
    this.pizzasizecheck,
    this.position,
    this.ingredientcheck,
    this.pizzametaposition,
    this.pizzametasize,*/
    required this.price,
    required this.checkadd,
    required this.selectitem,
    required this.foodbill,
    required this.foodtotal,
  });
}