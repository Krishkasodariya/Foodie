import 'dart:typed_data';

import 'PizzaSize.dart';

class OrderFoodItemModel {
  int ?uid;
  String ?food;
  String ?image;
  String ?name;
  int ?price;
  bool ?checkadd = false;
  int ?selectitem = 1;
  int ?foodbill;
  String ?rating;
  Uint8List ?imagebyte;
  String ?pizzasize;

  OrderFoodItemModel({
      this.uid,
      this.food,
      this.name,
      this.image,
      this.rating,
      this.imagebyte,
      this.price,
      this.checkadd,
      this.selectitem,
      this.foodbill,
      this.pizzasize});

  Map<String, dynamic> toJson() {
    return {
      "uid": uid,
      "food": food,
      "name": name,
      "image": image,
      "rating": rating,
      "imagebyte": imagebyte,
      "price": price,
      "checkadd": checkadd,
      "selectitem": selectitem,
      "foodbill": foodbill,
      "pizzasize": pizzasize,
    };
  }

  factory OrderFoodItemModel.fromJson(Map<String, dynamic> data) {
    return OrderFoodItemModel(
        uid: data["uid"],
        food: data["food"],
        name: data["name"],
        image: data["image"],
        rating: data["rating"],
        imagebyte: data["imagebyte"],
        price: data["price"],
        checkadd: data["checkadd"],
        selectitem: data["selectitem"],
        foodbill: data["foodbill"],
        pizzasize: data["pizzasize"],);
  }
}
