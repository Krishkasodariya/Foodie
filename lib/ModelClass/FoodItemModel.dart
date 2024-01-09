import 'dart:typed_data';
import 'dart:ui';
import 'package:Pizza/ModelClass/Ingredient.dart';
import 'package:Pizza/ModelClass/PizzaMeta.dart';
import 'package:Pizza/ModelClass/PizzaSize.dart';


class FoodItemModel {
   int id;
   String  food;
   String ?image;
   String ?name;
   int price;
   bool checkadd = false;
   int selectitem = 1;
   int foodbill;
   int foodtotal;
   double? rating;

   // Uint8List? imagebyte;

   List<PizzaSize> ?pizzasizelist = [];
   List<Ingredient> ?ingredients = [];
   List<PizzaMeta> ?pizzametalist = [];

  FoodItemModel({
     required this.id,
     required this.food,
     this.name,
     this.image,
     this.rating,
   // this.imagebyte,
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
       "id": id,
       "food": food,
       "checkadd": checkadd,
       "image": image,
       "name": name,
       "rating": rating,
   /*    "size": pizzasizelist,
       "ingredients": ingredients,
       "pizzametalist": pizzametalist,*/
       "price": price,
       "selectitem": selectitem,
       "foodbill": foodbill,
       "foodtotal": foodtotal
     };
   }

   factory FoodItemModel.fromJson(Map<String, dynamic> data) {
     return FoodItemModel(
        image:data["image"],
     price:data["price"] ,
     id: data["id"],
     food: data["food"],
      checkadd: data["checkadd"],
     selectitem: data["selectitem"],
     foodbill: data["foodbill"],
     foodtotal: data["foodtotal"],
   /*  pizzametalist: data["pizzametalist"],
     ingredients: data["ingredients"],
     pizzasizelist: data["size"],*/
     rating: data["rating"],
     name:  data["name"]);
   }
}