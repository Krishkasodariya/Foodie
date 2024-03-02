import 'package:get/get.dart';
import 'OrderFoodItemModel.dart';

class TrackingDataModel {
  String? orderId;
  bool ?viewDetail = false;
  bool ?apply = false;
  bool ?pending = false;
  bool ?processing = false;
  bool ?conform = false;
  bool ?cooking = false;
  String? userUid;
  int? subTotal;
  int? milliseconds;
  int? gst;
  int? deliveryFee;
  int? grandTotal;
  String? date;
  String? time;
  String? address;
  String? userName;
  String? nearAddress;
  String? userPhoneNumber;
  String? userImage;
  double? latitude;
  double? longitude;
  RxList<OrderFoodItemModel>? datalist = <OrderFoodItemModel>[].obs;
  String? deliveryName;
  String? deliveryUid;
  String? deliveryPhone;
  String? deliveryEmail;
  String? deliveryImage;

  TrackingDataModel(
      {this.deliveryName,
      this.orderId,
      this.milliseconds,
      this.datalist,
      required this.viewDetail,
      required this.apply,
      this.date,
      this.deliveryFee,
      this.grandTotal,
      this.gst,
      this.subTotal,
      this.time,
      this.userUid,
      this.userName,
      this.address,
      this.nearAddress,
      this.userPhoneNumber,
      this.latitude,
      this.longitude,
      this.deliveryEmail,
      this.deliveryImage,
      this.deliveryPhone,
      this.deliveryUid,
      this.conform,
      this.cooking,
      this.pending,
      this.processing,this.userImage});
}
