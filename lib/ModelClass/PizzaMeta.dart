import 'dart:typed_data';
import 'dart:ui';

class PizzaMeta {
  int customPizzametaPrice;
  Uint8List ?customPizzametaUint8list;
  Offset? customPizzametaPosition;
  Size? customPizzametaSize;
  int customPizzametaSelectitem;
  int customPizzametaTotal;
  int customPizzametaBill;
  String pizzaSize;
  String ?base64;

  PizzaMeta(
      {required this.pizzaSize,
      this.customPizzametaSize,
        this.base64,
       this.customPizzametaUint8list,
      this.customPizzametaPosition,
      required this.customPizzametaPrice,
      required this.customPizzametaSelectitem,
      required this.customPizzametaTotal,
      required this.customPizzametaBill});

  Map<String, dynamic> toJson() {
    return {
      "base64": base64,
      "pizzaSize": pizzaSize,
      "customPizzametaPrice": customPizzametaPrice,
      "customPizzametaSelectitem": customPizzametaSelectitem,
      "customPizzametaBill": customPizzametaBill,
      "customPizzametaTotal": customPizzametaTotal,
    };
  }

  factory PizzaMeta.fromJson(Map<String, dynamic> data) {
    return PizzaMeta(
      base64: data["base64"],
      pizzaSize: data["pizzaSize"],
      customPizzametaPrice: data["customPizzametaPrice"],
      customPizzametaSelectitem: data["customPizzametaSelectitem"],
      customPizzametaBill: data["customPizzametaBill"],
      customPizzametaTotal: data["customPizzametaTotal"],
    );
  }
}
