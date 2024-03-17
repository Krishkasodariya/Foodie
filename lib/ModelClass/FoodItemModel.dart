import 'package:Pizza/ModelClass/Ingredient.dart';
import 'package:Pizza/ModelClass/PizzaMeta.dart';
import 'package:Pizza/ModelClass/PizzaSize.dart';

class FoodItemModel{
  String restaurantName;
  String id;
  String food;
  String? image;
  String? name;
  int price;
  bool checkadd = false;
  int selectitem = 1;
  int foodbill;
  int foodtotal;
  String? rating;
  List<PizzaSize>? pizzasizelist = [];
  List<Ingredient>? ingredients = [];
  List<PizzaMeta>? pizzametalist = [];
  FoodItemModel({
    required this.restaurantName,
    required this.id,
    required this.food,
    this.name,
    this.image,
    this.rating,
    this.pizzasizelist,
    this.ingredients,
    this.pizzametalist,
    required this.price,
    required this.checkadd,
    required this.selectitem,
    required this.foodbill,
    required this.foodtotal,
  });
  Map<String, dynamic> toJson() {
    return {
      "restaurantName":restaurantName,
      "id": id,
      "food": food,
      "checkadd": checkadd,
      "image": image,
      "name": name,
      "rating": rating,
      "price": price,
      "selectitem": selectitem,
      "foodbill": foodbill,
      "foodtotal": foodtotal,
    };
  }
  factory FoodItemModel.fromJson(Map<String, dynamic> data) {
    return FoodItemModel(
      restaurantName: data["restaurantName"],
        image: data["image"],
        price: data["price"],
        id: data["id"],
        food: data["food"],
        checkadd: data["checkadd"],
        selectitem: data["selectitem"],
        foodbill: data["foodbill"],
        foodtotal: data["foodtotal"],
        rating: data["rating"],
        name: data["name"]);

  }



}
