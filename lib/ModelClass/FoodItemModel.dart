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
   String? rating;

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



}
/* Map<String, dynamic> toJson() {
     return {

       "Id": id,
       "Food": food,
       "Image": image,
       "Name": name,
       "Rating": rating,
       "Size": pizzasizelist,
       "Ingredients": ingredients,
       "Pizzametalist": pizzametalist,
       "Price": price,
       "Selectitem": selectitem,
       "Foodbill": foodbill,
       "Foodtotal": foodtotal
     };
   }

   factory FoodItemModel.fromJson(Map<String, dynamic> data) {
     return FoodItemModel(
        image:data["Image"],
     price:data["Price"] ,
     id: data["Id"],
     food: data["Food"],
      checkadd: data[""],
     selectitem: data["Selectitem"],
     foodbill: data["Foodbill"],
     foodtotal: data["Foodtotal"],
     pizzametalist: data["Pizzametalist"],
     ingredients: data["Ingredients"],
     pizzasizelist: data["Size"],
     rating: data["Rating"],
     name:  data["Name"]);
   }
*/