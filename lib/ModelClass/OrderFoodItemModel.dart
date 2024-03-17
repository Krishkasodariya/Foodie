

class OrderFoodItemModel {
  String ?restaurantName;
  String ?image;
  String ?rating;
  String ?name;
  int ?price;
  String ?id;
  String ?food;
  bool ?checkadd = false;
  int ?selectitem = 1;
  int ?foodbill;
  int ?foodtotal;
  String ?pizzaSize;
  String ?base64;
  int ?customPizzametaPrice;
  int ?customPizzametaSelectitem;
  int ?customPizzametaTotal;
  int ?customPizzametaBill;


  OrderFoodItemModel({
    this.restaurantName,
      this.food,
      this.name,
      this.image,
      this.rating,
      this.price,
      this.checkadd,
      this.selectitem,
      this.foodbill,

    this.base64,
    this.pizzaSize,
    this.customPizzametaBill,
    this.customPizzametaPrice,
    this.customPizzametaSelectitem,
    this.customPizzametaTotal,
    this.foodtotal,
    this.id
    });

  Map<String, dynamic> toJson(){
    return {

      "restaurantName": restaurantName,
      "food": food,
      "name": name,
      "image": image,
      "rating": rating,
      "price": price,
      "checkadd": checkadd,
      "selectitem": selectitem,
      "foodbill": foodbill,
      "base64": base64,
      "pizzaSize": pizzaSize,
      "customPizzametaBill": customPizzametaBill,
      "customPizzametaPrice": customPizzametaPrice,
      "customPizzametaSelectitem": customPizzametaSelectitem,
      "customPizzametaTotal": customPizzametaTotal,
      "foodtotal": foodtotal,
      "id": id,

    };
  }

  factory OrderFoodItemModel.fromJson(Map<String, dynamic> data) {
    return OrderFoodItemModel(
restaurantName: data["restaurantName"],
        food: data["food"],
        name: data["name"],
        image: data["image"],
        rating: data["rating"],
        price: data["price"],
        checkadd: data["checkadd"],
        selectitem: data["selectitem"],
        foodbill: data["foodbill"],
      base64: data["base64"],
      pizzaSize: data["pizzaSize"],
      customPizzametaBill: data["customPizzametaBill"],
      customPizzametaPrice: data["customPizzametaPrice"],
      customPizzametaSelectitem: data["customPizzametaSelectitem"],
      customPizzametaTotal: data["customPizzametaTotal"],
      foodtotal: data["foodtotal"],
      id: data["id"],


       );
  }
}
