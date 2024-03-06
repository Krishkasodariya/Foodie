import 'package:Pizza/ModelClass/OrderFoodItemModel.dart';
import 'package:get/get.dart';

class MainOrderFoodItemModel{
  String? orderId;
  bool favouriteOrder = false;
  bool viewDetail = false;
  bool apply = false;
  String? uid;
  int? subTotal;
  int? milliseconds;
  int? gst;
  int? deliveryFee;
  int? grandTotal;
  String? date;
  String? time;
  String? address;
  String? name;
  String? nearAddress;
  String? phoneNumber;
  double? latitude;
  double? longitude;
  RxList<OrderFoodItemModel>? datalist = <OrderFoodItemModel>[].obs;

  MainOrderFoodItemModel(
      {this.orderId,
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
      this.uid,
      this.name,
      this.address,
      this.nearAddress,
      this.phoneNumber,
      this.latitude,
      this.longitude});
}
