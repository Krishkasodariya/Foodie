import 'package:get/get.dart';
import 'package:Pizza/ModelClass/FoodItemModel.dart';
import 'package:video_player/video_player.dart';

class PizzaItemModel extends GetxController {
  bool checklike = false;
  bool customFood = false;
  bool promo = false;
  String ?promoUrl;
  String? restaurantPhone;
  String? name;
  int? price;
  String? time;
  String? distance;
  double? rating;
  RxList<FoodItemModel> foodimagelist = <FoodItemModel>[].obs;
  String? subname;
  List<VideoPlayerController> ?videoPlayerController = [];


  PizzaItemModel(
      {required this.checklike,
      required this.foodimagelist,
      required this.name,
      required this.distance,
      required this.price,
      required this.rating,
      required this.time,
      required this.subname,
      required this.customFood,
      required this.promo,
      required this.restaurantPhone,
      required this.promoUrl,
      this.videoPlayerController});
}
