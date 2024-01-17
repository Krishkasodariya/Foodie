import 'package:Pizza/ModelClass/OrderFoodItemModel.dart';
import 'package:get/get.dart';

class MainOrderFoodItemModel{
  bool favouriteOrder=false;
  bool viewDetail=false;
  bool apply=false;
  String? uid;
  int? subTotal;
  int? milliseconds;
  int? gst;
  int? deliveryFee;
  int? grandTotal;
  String? date;
  String? time;
  RxList<OrderFoodItemModel>? datalist = <OrderFoodItemModel>[].obs;

  MainOrderFoodItemModel(
      {
        this.milliseconds,
        this.datalist,
        required this.viewDetail,
        required this.apply,
      required this.favouriteOrder,
      this.date,
      this.deliveryFee,
      this.grandTotal,
      this.gst,
      this.subTotal,
      this.time,
      this.uid});
}
