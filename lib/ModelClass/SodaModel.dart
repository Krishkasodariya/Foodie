class SodaModel {
  String? image;
  String? name;
  int? price;

  bool checkadd = false;
  int selectitem = 1;
  int foodbill;
  int foodtotal;
  String? rating;

  SodaModel(
      {required this.image,
      required this.price,
      required this.name,
      required this.rating,
      required this.selectitem,
      required this.checkadd,
      required this.foodbill,
      required this.foodtotal});
}
