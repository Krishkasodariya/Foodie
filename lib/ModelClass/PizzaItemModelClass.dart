import 'package:get/get.dart';
import 'package:Pizza/ModelClass/FoodItemModel.dart';

class PizzaItemModel extends GetxController{
  bool checklike=false;
  String? name;
  int? price;
  String? time;
  String? distance;
  double? rating;
  RxList<FoodItemModel> foodimagelist=<FoodItemModel>[].obs;
  String? subname;
  PizzaItemModel({
    required this.checklike,
      required this.foodimagelist,
      required this.name,
      required this.distance,
      required this.price,
      required this.rating,
      required this.time,
      required this.subname});
}
