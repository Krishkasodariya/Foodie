import 'dart:typed_data';
import 'dart:ui';

class PizzaMeta{
  int customPizzametaPrice;
  Uint8List customPizzametaUint8list;
  Offset customPizzametaPosition;
  Size customPizzametaSize;
  int customPizzametaSelectitem;
  int customPizzametaTotal;
  int customPizzametaBill;
  PizzaMeta({required this.customPizzametaSize, required this.customPizzametaUint8list, required this.customPizzametaPosition,required this.customPizzametaPrice,required this.customPizzametaSelectitem,required this.customPizzametaTotal,required this.customPizzametaBill});
}