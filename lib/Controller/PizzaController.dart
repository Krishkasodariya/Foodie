
import 'dart:async';
import 'dart:developer';
import 'dart:ui';

import 'package:Pizza/All%20Screen/InternetDialog.dart';
import 'package:Pizza/ModelClass/FoodItemModel.dart';
import 'package:Pizza/ModelClass/Ingredient.dart';
import 'package:Pizza/ModelClass/OfferModel.dart';
import 'package:Pizza/ModelClass/OrderFoodItemModel.dart';
import 'package:Pizza/ModelClass/PizzaItemModelClass.dart';
import 'package:Pizza/ModelClass/PizzaMeta.dart';
import 'package:Pizza/ModelClass/PizzaSize.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class PizzaController extends GetxController {
  /*RxList<OrderFoodItemModel> yourOrderlist = <OrderFoodItemModel>[
    OrderFoodItemModel(
        id: 0,
        price: 0,
        checkadd: false,
        selectitem: 0,
        foodbill: 0,
        foodtotal: 0,
        food: "z",
        pizzasizelist: [
          PizzaSize(name: "S", check: false),
          PizzaSize(name: "M", check: true),
          PizzaSize(name: "L", check: false),
        ],
        ingredients: [
          Ingredient(
              image: "images/bolive.webp",
              position: [
                Offset(0.17, 0.35),
                Offset(0.4, 0.15),
                Offset(0.73, 0.33),
                Offset(0.60, 0.70),
                Offset(0.3, 0.65)
              ],
              checkIngredient: false),
          Ingredient(
              image: "images/tomato.webp",
              position: [
                Offset(0.20, 0.45),
                Offset(0.5, 0.2),
                Offset(0.55, 0.45),
                Offset(0.75, 0.50),
                Offset(0.3, 0.65)
              ],
              checkIngredient: false),
          Ingredient(
              image: "images/mashroom.webp",
              position: [
                Offset(0.17, 0.60),
                Offset(0.5, 0.35),
                Offset(0.3, 0.25),
                Offset(0.70, 0.55),
                Offset(0.45, 0.65)
              ],
              checkIngredient: false),
          Ingredient(
              image: "images/onion.webp",
              position: [
                Offset(0.4, 0.6),
                Offset(0.45, 0.4),
                Offset(0.2, 0.39),
                Offset(0.22, 0.65),
                Offset(0.75, 0.55)
              ],
              checkIngredient: false),
          Ingredient(
              image: "images/gcap.webp",
              position: [
                Offset(0.5, 0.75),
                Offset(0.4, 0.2),
                Offset(0.45, 0.45),
                Offset(0.65, 0.45),
                Offset(0.3, 0.55)
              ],
              checkIngredient: false),
          Ingredient(
              image: "images/potato.webp",
              position: [
                Offset(0.5, 0.7),
                Offset(0.17, 0.5),
                Offset(0.4, 0.20),
                Offset(0.7, 0.4),
                Offset(0.35, 0.55)
              ],
              checkIngredient: false),
          Ingredient(
              image: "images/rigan.webp",
              position: [
                Offset(0.65, 0.65),
                Offset(0.5, 0.15),
                Offset(0.3, 0.25),
                Offset(0.65, 0.35),
                Offset(0.4, 0.70)
              ],
              checkIngredient: false),
          Ingredient(
              image: "images/rcap.webp",
              position: [
                Offset(0.55, 0.75),
                Offset(0.45, 0.25),
                Offset(0.35, 0.30),
                Offset(0.65, 0.30),
                Offset(0.35, 0.60)
              ],
              checkIngredient: false),
          Ingredient(
              image: "images/kakadi.webp",
              position: [
                Offset(0.60, 0.60),
                Offset(0.5, 0.2),
                Offset(0.3, 0.25),
                Offset(0.65, 0.4),
                Offset(0.3, 0.65)
              ],
              checkIngredient: false),
        ],
        pizzametalist: [])
  ].obs;*/

  RxDouble offer = 0.0.obs;
  RxBool isalertset = false.obs;
  RxBool isdeviceconnected = false.obs;

  late StreamSubscription subscription;
  RxList<FoodItemModel> yourOrderBottomList = <FoodItemModel>[].obs;
  RxList<PizzaItemModel> likelist = <PizzaItemModel>[].obs;
  RxList<PizzaItemModel> pizzalist = <PizzaItemModel>[].obs;

  RxList<FoodItemModel> sodalist = <FoodItemModel>[].obs;
  RxList<FoodItemModel> foundsoda = <FoodItemModel>[].obs;

  RxInt pizzaindex = 0.obs;
  RxInt ingredientindex = 0.obs;
  RxInt total = 180.obs;
  RxInt customizepizzatotal = 180.obs;
  RxInt sizeindex = 1.obs;
  var position, size, imagedata;
  PizzaMeta? pizzaMeta;

  PizzaMeta? pizzaMetadata;

  List<PizzaSize>? addsizelist = [];
  List<Ingredient> addlistofingredient = [];

  RxList<FoodItemModel> pizzabottomlist = <FoodItemModel>[].obs;

  RxList<FoodItemModel> customizepizzalist = <FoodItemModel>[
    FoodItemModel(
        id: 0,
        price: 0,
        checkadd: false,
        selectitem: 0,
        foodbill: 0,
        foodtotal: 0,
        food: "z",
        pizzasizelist: [
          PizzaSize(name: "S", check: false),
          PizzaSize(name: "M", check: true),
          PizzaSize(name: "L", check: false),
        ],
        ingredients: [
          Ingredient(
              image: "images/bolive.webp",
              position: [
                Offset(0.17, 0.35),
                Offset(0.4, 0.15),
                Offset(0.73, 0.33),
                Offset(0.60, 0.70),
                Offset(0.3, 0.65)
              ],
              checkIngredient: false),
          Ingredient(
              image: "images/tomato.webp",
              position: [
                Offset(0.20, 0.45),
                Offset(0.5, 0.2),
                Offset(0.55, 0.45),
                Offset(0.75, 0.50),
                Offset(0.3, 0.65)
              ],
              checkIngredient: false),
          Ingredient(
              image: "images/mashroom.webp",
              position: [
                Offset(0.17, 0.60),
                Offset(0.5, 0.35),
                Offset(0.3, 0.25),
                Offset(0.70, 0.55),
                Offset(0.45, 0.65)
              ],
              checkIngredient: false),
          Ingredient(
              image: "images/onion.webp",
              position: [
                Offset(0.4, 0.6),
                Offset(0.45, 0.4),
                Offset(0.2, 0.39),
                Offset(0.22, 0.65),
                Offset(0.75, 0.55)
              ],
              checkIngredient: false),
          Ingredient(
              image: "images/gcap.webp",
              position: [
                Offset(0.5, 0.75),
                Offset(0.4, 0.2),
                Offset(0.45, 0.45),
                Offset(0.65, 0.45),
                Offset(0.3, 0.55)
              ],
              checkIngredient: false),
          Ingredient(
              image: "images/potato.webp",
              position: [
                Offset(0.5, 0.7),
                Offset(0.17, 0.5),
                Offset(0.4, 0.20),
                Offset(0.7, 0.4),
                Offset(0.35, 0.55)
              ],
              checkIngredient: false),
          Ingredient(
              image: "images/rigan.webp",
              position: [
                Offset(0.65, 0.65),
                Offset(0.5, 0.15),
                Offset(0.3, 0.25),
                Offset(0.65, 0.35),
                Offset(0.4, 0.70)
              ],
              checkIngredient: false),
          Ingredient(
              image: "images/rcap.webp",
              position: [
                Offset(0.55, 0.75),
                Offset(0.45, 0.25),
                Offset(0.35, 0.30),
                Offset(0.65, 0.30),
                Offset(0.35, 0.60)
              ],
              checkIngredient: false),
          Ingredient(
              image: "images/kakadi.webp",
              position: [
                Offset(0.60, 0.60),
                Offset(0.5, 0.2),
                Offset(0.3, 0.25),
                Offset(0.65, 0.4),
                Offset(0.3, 0.65)
              ],
              checkIngredient: false),
        ],
        pizzametalist: [])
  ].obs;

  RxBool isBootomSheet = false.obs;
  RxInt iscountfoodtotal = 0.obs;
  RxInt Customfoodtotal = 0.obs;
  RxInt finalfoodtotal = 0.obs;

  //RxBool cashOnDelivery = false.obs;
  RxBool checkbox = false.obs;
  RxInt donation = 0.obs;
  RxInt goldprimium = 0.obs;
  RxBool checkadd = false.obs;
  RxInt gst = 13.obs;
  RxInt deliveryfee = 18.obs;
  RxInt grandtotal = 0.obs;
  RxString orderMethod = "Cash".obs;

  //RxBool cashOnDelivery=false.obs;

  Function? reference;
  Function? likeupdate;
  Function? searchupdate;

  void UpdateLike(Function ref) {
    likeupdate = ref;
  }

  void Allupdate(Function ref) {
    reference = ref;
  }

  void Searchupdate(Function ref) {
    searchupdate = ref;
  }

  //----------------------------------------------------------PIZZA---------------------------------------------------------------)

  /*      print("=============================================)");
        print("==========)${addname.text = doc["Name"]}");
        print("==========)${addphonenumber.text = doc["Phone"]}");
        print("==========)${addemail.text = doc["Email"]}");
        print("==========)${imageurl = doc["Image"]}");

        addname.text = doc["Name"];
        addemail.text = doc["Email"];
        addphonenumber.text = doc["Phone"];
        imageurl = doc["Image"];

        changeName = doc["Name"];
        changePhoneNumber = doc["Phone"];
        changeEmail = doc["Email"];

        cartName.value=doc["Name"];
        cartPhone.value=doc["Phone"];
        print(changePhoneNumber);
        updateData!();*/

  Future<List<PizzaItemModel>> getPizzaData() async {
    try {
      await FirebaseFirestore.instance
          .collection("pizza")
          .get()
          .then((QuerySnapshot querySnapshot) {
        querySnapshot.docs.forEach((element) {
          Map<String, dynamic> data = element.data() as Map<String, dynamic>;

          log("${data}");

          RxList<FoodItemModel> food = <FoodItemModel>[].obs;
          List<dynamic> dynamicList = data['foodimagelist'];

          dynamicList.forEach((element) {
            print("------)${element["name"]}");
            food.add(FoodItemModel.fromJson(element));
            // print("---food.length----)${food.length}");
          });

          PizzaItemModel pizzaItem = PizzaItemModel(
            checklike: data['checklike'],
            name: data['name'],
            distance: data['distance'],
            price: data['price'],
            rating: data['rating'],
            time: data['time'],
            subname: data['subname'],
            foodimagelist: food,
          );

          // pizzalist.clear();
          // pizzalist.value=[];
          pizzalist.add(pizzaItem);
          print("--pizzalist-length---)${pizzalist.length}");
        });
      });
    } catch (e) {
      print("----444444---------${e}");
    }
    return pizzalist;
  }

  /*RxList<PizzaItemModel> pizzalist = [
    PizzaItemModel(
      checklike: false,
      name: "Domino's Pizza",
      distance: "2 Km",
      price: 200,
      rating: 4.5,
      time: "25-30 min",
      subname: "Italian Pizza",
      foodimagelist: [
        FoodItemModel(
          id: 1,
          name: "Farmhouse Pizza",
          price: 269,
          image: "images/p20.webp",
          checkadd: false,
          selectitem: 1,
          foodbill: 269,
          foodtotal: 0,
          rating: "4.3",
          food: "Pizza",
        ),
        FoodItemModel(
          id: 2,
          name: "Margherita Pizza",
          price: 109,
          image: "images/p1.webp",
          checkadd: false,
          selectitem: 1,
          foodbill: 109,
          foodtotal: 0,
          rating: "4.3",
          food: "Pizza",
        ),
        FoodItemModel(
          id: 3,
          name: "Peppy Paneer Pizza",
          price: 269,
          image: "images/p28.webp",
          checkadd: false,
          selectitem: 1,
          foodbill: 269,
          foodtotal: 0,
          rating: "4.3",
          food: "Pizza",
        ),
        FoodItemModel(
          id: 4,
          name: "Veggie Paradise Pizza",
          price: 269,
          image: "images/p15.webp",
          checkadd: false,
          selectitem: 1,
          foodbill: 269,
          foodtotal: 0,
          rating: "4.3",
          food: "Pizza",
        ),
        FoodItemModel(
          id: 5,
          name: "Indi Tandoori Paneer Pizza",
          price: 319,
          image: "images/p27.webp",
          checkadd: false,
          selectitem: 1,
          foodbill: 319,
          foodtotal: 0,
          rating: "4.3",
          food: "Pizza",
        ),
        FoodItemModel(
          id: 6,
          name: "Veg Loaded",
          price: 159,
          image: "images/p7.webp",
          checkadd: false,
          selectitem: 1,
          foodbill: 159,
          foodtotal: 0,
          rating: "4.3",
          food: "Pizza",
        )
      ].obs,
    ),
    PizzaItemModel(
        foodimagelist: [
          FoodItemModel(
            id: 7,
            name: "Tomatoes Pizza",
            price: 110,
            image: "images/p7.webp",
            checkadd: false,
            selectitem: 1,
            foodbill: 110,
            foodtotal: 0,
            rating: "4.3",
            food: "Pizza",
          ),
          FoodItemModel(
            id: 8,
            name: "Farm Villa Pizza",
            price: 235,
            image: "images/p17.webp",
            checkadd: false,
            selectitem: 1,
            foodbill: 235,
            foodtotal: 0,
            rating: "4.3",
            food: "Pizza",
          ),
          FoodItemModel(
            id: 9,
            name: "Garden Delight Pizza",
            price: 195,
            image: "images/p25.webp",
            checkadd: false,
            selectitem: 1,
            foodbill: 195,
            foodtotal: 0,
            rating: "4.3",
            food: "Pizza",
          ),
          FoodItemModel(
            id: 10,
            name: "Margherita Pizza",
            price: 145,
            image: "images/p1.webp",
            checkadd: false,
            selectitem: 1,
            foodbill: 145,
            foodtotal: 0,
            rating: "4.3",
            food: "Pizza",
          ),
          FoodItemModel(
            id: 11,
            name: "Paneer Special Pizza",
            price: 235,
            image: "images/p8.webp",
            checkadd: false,
            selectitem: 1,
            foodbill: 235,
            foodtotal: 0,
            rating: "4.3",
            food: "Pizza",
          ),
          FoodItemModel(
            id: 12,
            name: "English Retreat Pizza",
            price: 295,
            image: "images/p18.webp",
            checkadd: false,
            selectitem: 1,
            foodbill: 295,
            foodtotal: 0,
            rating: "4.3",
            food: "Pizza",
          ),
        ].obs,
        checklike: false,
        name: "La Pino'z Pizza",
        distance: "1 Km",
        price: 250,
        rating: 4.2,
        time: "20-25 min",
        subname: "Pure Veg Pizza"),
    PizzaItemModel(
        foodimagelist: [
          FoodItemModel(
            id: 13,
            name: "Mexican Fiesta",
            price: 319,
            image: "images/p26.webp",
            checkadd: false,
            selectitem: 1,
            foodbill: 319,
            foodtotal: 0,
            rating: "4.3",
            food: "Pizza",
          ),
          FoodItemModel(
            id: 14,
            name: "Margerita",
            price: 169,
            image: "images/p23.webp",
            checkadd: false,
            selectitem: 1,
            foodbill: 169,
            foodtotal: 0,
            rating: "4.3",
            food: "Pizza",
          ),
          FoodItemModel(
            id: 15,
            name: "Tandoori Paneer",
            price: 319,
            image: "images/p4.webp",
            checkadd: false,
            selectitem: 1,
            foodbill: 319,
            foodtotal: 0,
            rating: "4.3",
            food: "Pizza",
          ),
          FoodItemModel(
            id: 16,
            name: "Margerita",
            price: 200,
            image: "images/p1.webp",
            checkadd: false,
            selectitem: 1,
            foodbill: 200,
            foodtotal: 0,
            rating: "4.3",
            food: "Pizza",
          ),
          FoodItemModel(
            id: 17,
            name: "Veggie Supreme",
            price: 379,
            image: "images/p10.webp",
            checkadd: false,
            selectitem: 1,
            foodbill: 379,
            foodtotal: 0,
            rating: "4.3",
            food: "Pizza",
          ),
          FoodItemModel(
            id: 18,
            name: "Country Feast",
            price: 319,
            image: "images/p17.webp",
            checkadd: false,
            selectitem: 1,
            foodbill: 319,
            foodtotal: 0,
            rating: "4.3",
            food: "Pizza",
          )
        ].obs,
        checklike: false,
        name: "Pizza Hut",
        distance: "3 Km",
        price: 220,
        rating: 4.1,
        time: "25-30 min",
        subname: "Fast Food"),
    PizzaItemModel(
        foodimagelist: [
          FoodItemModel(
            id: 19,
            name: "Paneer Paprika Pizza",
            price: 365,
            image: "images/p25.webp",
            checkadd: false,
            selectitem: 1,
            foodbill: 365,
            foodtotal: 0,
            rating: "4.3",
            food: "Pizza",
          ),
          FoodItemModel(
            id: 20,
            name: "Bbq Paneer Pizza",
            price: 340,
            image: "images/p4.webp",
            checkadd: false,
            selectitem: 1,
            foodbill: 340,
            foodtotal: 0,
            rating: "4.3",
            food: "Pizza",
          ),
          FoodItemModel(
            id: 21,
            name: "Veggie Delight Pizza",
            price: 285,
            image: "images/p24.webp",
            checkadd: false,
            selectitem: 1,
            foodbill: 285,
            foodtotal: 0,
            rating: "4.3",
            food: "Pizza",
          ),
          FoodItemModel(
            id: 22,
            name: "Veggie Paradise Pizza",
            price: 269,
            image: "images/p15.webp",
            checkadd: false,
            selectitem: 1,
            foodbill: 269,
            foodtotal: 0,
            rating: "4.3",
            food: "Pizza",
          ),
          FoodItemModel(
            id: 23,
            name: "California Pizza",
            price: 365,
            image: "images/p23.webp",
            checkadd: false,
            selectitem: 1,
            foodbill: 365,
            foodtotal: 0,
            rating: "4.3",
            food: "Pizza",
          ),
          FoodItemModel(
            id: 24,
            name: "Cheese Pizza",
            price: 235,
            image: "images/p22.webp",
            checkadd: false,
            selectitem: 1,
            foodbill: 235,
            foodtotal: 0,
            rating: "4.3",
            food: "Pizza",
          )
        ].obs,
        checklike: false,
        name: "Woklee",
        distance: "1.7 Km",
        price: 190,
        rating: 4.1,
        time: "25-30 min",
        subname: "Pizza"),
    PizzaItemModel(
        foodimagelist: [
          FoodItemModel(
            id: 25,
            name: "Veggie Special Pizza",
            price: 240,
            image: "images/p2.webp",
            checkadd: false,
            selectitem: 1,
            foodbill: 240,
            foodtotal: 0,
            rating: "4.3",
            food: "Pizza",
          ),
          FoodItemModel(
            id: 26,
            name: "Cheezy Jalapeno",
            price: 175,
            image: "images/p10.webp",
            checkadd: false,
            selectitem: 1,
            foodbill: 175,
            foodtotal: 0,
            rating: "4.3",
            food: "Pizza",
          ),
          FoodItemModel(
            id: 27,
            name: "Heart Pizza",
            price: 320,
            image: "images/p32.webp",
            checkadd: false,
            selectitem: 1,
            foodbill: 320,
            foodtotal: 0,
            rating: "4.3",
            food: "Pizza",
          ),
          FoodItemModel(
            id: 28,
            name: "Margerita",
            price: 200,
            image: "images/p1.webp",
            checkadd: false,
            selectitem: 1,
            foodbill: 200,
            foodtotal: 0,
            rating: "4.3",
            food: "Pizza",
          ),
          FoodItemModel(
            id: 29,
            name: "Garden Fling",
            price: 400,
            image: "images/p6.webp",
            checkadd: false,
            selectitem: 1,
            foodbill: 400,
            foodtotal: 0,
            rating: "4.3",
            food: "Pizza",
          ),
          FoodItemModel(
            id: 30,
            name: "Hawaiian Veg Pizza",
            price: 240,
            image: "images/p15.webp",
            checkadd: false,
            selectitem: 1,
            foodbill: 240,
            foodtotal: 0,
            rating: "4.3",
            food: "Pizza",
          ),
        ].obs,
        checklike: false,
        name: "LaMilanoPizzeria",
        distance: "9 Km",
        price: 180,
        rating: 4.2,
        time: "25-30 min",
        subname: "Pizza"),
  ].obs;*/

  void Pizzaadd(int pizzaindex, int index) {
    pizzalist[pizzaindex].foodimagelist[index].checkadd = true;
    isBootomSheet.value = true;

    grandtotal.value = 0;
    Customfoodtotal.value = 0;
    iscountfoodtotal.value = 0;

    if (pizzalist[pizzaindex].foodimagelist[index].checkadd) {
      pizzabottomlist.add(pizzalist[pizzaindex].foodimagelist[index]);

      print("------------------------------)${pizzabottomlist.length}");
      print(
          "==============PizzaAdd=====id========)${pizzalist[pizzaindex].foodimagelist[index].id}");
      print(
          "==============PizzaAdd=====name========)${pizzalist[pizzaindex].foodimagelist[index].name}");
      print(
          "==============PizzaAdd=====price========)${pizzalist[pizzaindex].foodimagelist[index].price}");
      print(
          "==============PizzaAdd=====selectitem========)${pizzalist[pizzaindex].foodimagelist[index].selectitem}");
      print(
          "==============PizzaAdd=====foodbill========)${pizzalist[pizzaindex].foodimagelist[index].foodbill}");
    }
    if (pizzalist[pizzaindex].foodimagelist[index].selectitem == 0) {
      pizzalist[pizzaindex].foodimagelist[index].checkadd = false;
      pizzalist[pizzaindex].foodimagelist[index].selectitem = 1;
    }
    for (int i = 0; i < pizzabottomlist.length - 1; i++) {
      if (pizzalist[pizzaindex].foodimagelist[index].id ==
          pizzabottomlist[i].id) {
        pizzabottomlist.remove(pizzabottomlist[i]);
      }
    }

    for (int i = 0; i < pizzabottomlist.length; i++) {
      if (pizzabottomlist.isNotEmpty ||
          customizepizzalist[0].pizzametalist!.isNotEmpty) {
        iscountfoodtotal.value += pizzabottomlist[i].foodbill;
        print(iscountfoodtotal.value);
      }
    }

    for (int j = 0; j < customizepizzalist[0].pizzametalist!.length; j++) {
      if (customizepizzalist[0].pizzametalist!.isNotEmpty ||
          pizzabottomlist.isNotEmpty) {
        Customfoodtotal.value +=
            customizepizzalist[0].pizzametalist![j].customPizzametaBill;
      }
    }

    resetOffer();

    finalfoodtotal.value = Customfoodtotal.value + iscountfoodtotal.value;
    print("-------- finalfoodtotal.value---------)${finalfoodtotal.value}");

    grandtotal.value = finalfoodtotal.value +
        gst.value +
        deliveryfee.value +
        donation.value +
        goldprimium.value;
    update();
    print("add");
  }

  void Pizzaremove(int pizzaindex, int index) {
    grandtotal.value = 0;
    Customfoodtotal.value = 0;
    iscountfoodtotal.value = 0;

    pizzalist[pizzaindex].foodimagelist[index].selectitem--;
    isBootomSheet.value = false;

    for (int i = 0; i < pizzabottomlist.length; i++) {
      if (pizzalist[pizzaindex].foodimagelist[index].id ==
          pizzabottomlist[i].id) {
        pizzabottomlist[i].foodtotal -= pizzabottomlist[i].price;
        pizzabottomlist[i].foodbill = pizzabottomlist[i].foodtotal;
      }
    }

    if (pizzalist[pizzaindex].foodimagelist[index].selectitem == 0) {
      pizzalist[pizzaindex].foodimagelist[index].selectitem = 1;
      pizzalist[pizzaindex].foodimagelist[index].checkadd = false;

      for (int i = 0; i < pizzabottomlist.length; i++) {
        if (pizzalist[pizzaindex].foodimagelist[index].id ==
            pizzabottomlist[i].id) {
          pizzabottomlist[i].foodbill = pizzabottomlist[i].price;
          pizzabottomlist.remove(pizzalist[pizzaindex].foodimagelist[index]);
        }
      }
    }

    for (int i = 0; i < pizzalist[pizzaindex].foodimagelist.length; i++) {
      if (!pizzalist[pizzaindex].foodimagelist[index].checkadd ==
          pizzalist[pizzaindex].foodimagelist[i].checkadd) {
        isBootomSheet.value = true;
      }
    }

    if (pizzabottomlist.isNotEmpty ||
        customizepizzalist[0].pizzametalist!.isNotEmpty) {
      isBootomSheet.value = true;
    }

    for (int i = 0; i < pizzabottomlist.length; i++) {
      if (pizzabottomlist.isNotEmpty ||
          customizepizzalist[0].pizzametalist!.isNotEmpty) {
        iscountfoodtotal.value += pizzabottomlist[i].foodbill;
      }
    }
    for (int j = 0; j < customizepizzalist[0].pizzametalist!.length; j++) {
      if (customizepizzalist[0].pizzametalist!.isNotEmpty ||
          pizzabottomlist.isNotEmpty) {
        Customfoodtotal.value +=
            customizepizzalist[0].pizzametalist![j].customPizzametaBill;
      }
    }
    resetOffer();
    finalfoodtotal.value = Customfoodtotal.value + iscountfoodtotal.value;
    print(
        "!!!!!!!!!!!!!!!!!!!!!!!! finalfoodtotal.value!!!!!!!!!!!!!!!!!!!)${finalfoodtotal.value}");

    grandtotal.value = finalfoodtotal.value +
        gst.value +
        deliveryfee.value +
        donation.value +
        goldprimium.value;
    update();
    print(
        "==============Pizzaremove=====id========${pizzalist[pizzaindex].foodimagelist[index].id}");
    print(
        "==============Pizzaremove=====name========${pizzalist[pizzaindex].foodimagelist[index].name}");
    print(
        "==============Pizzaremove=====selectitem========${pizzalist[pizzaindex].foodimagelist[index].selectitem}");
    print("==============Pizzaremove=====index========${index}");
    print(
        "==============Pizzaremove=====price========${pizzalist[pizzaindex].foodimagelist[index].price}");
    print(
        "==============Pizzaremove=====foodbill========)${pizzalist[pizzaindex].foodimagelist[index].foodbill}");
    print(
        "==============Pizzaremove=====foodtotal========${pizzalist[pizzaindex].foodimagelist[index].foodtotal}");

    print("remove");
  }

  void Pizzaplus(int pizzaindex, int index) {
    grandtotal.value = 0;
    Customfoodtotal.value = 0;
    iscountfoodtotal.value = 0;

    pizzalist[pizzaindex].foodimagelist[index].selectitem++;

    if (pizzalist[pizzaindex].foodimagelist[index].selectitem == 0) {
      pizzalist[pizzaindex].foodimagelist[index].checkadd = false;
      pizzalist[pizzaindex].foodimagelist[index].selectitem = 1;
    }

    for (int i = 0; i < pizzabottomlist.length; i++) {
      if (pizzalist[pizzaindex].foodimagelist[index].id ==
          pizzabottomlist[i].id) {
        pizzabottomlist[i].foodtotal =
            pizzabottomlist[i].selectitem * pizzabottomlist[i].price;
        pizzabottomlist[i].foodbill = pizzabottomlist[i].foodtotal;
      }
      if (pizzabottomlist.isNotEmpty ||
          customizepizzalist[0].pizzametalist!.isNotEmpty) {
        iscountfoodtotal.value += pizzabottomlist[i].foodbill;
      }
    }

    for (int j = 0; j < customizepizzalist[0].pizzametalist!.length; j++) {
      if (customizepizzalist[0].pizzametalist!.isNotEmpty ||
          pizzabottomlist.isNotEmpty) {
        Customfoodtotal.value +=
            customizepizzalist[0].pizzametalist![j].customPizzametaBill;
      }
    }
    resetOffer();
    finalfoodtotal.value = Customfoodtotal.value + iscountfoodtotal.value;
    print("-------- finalfoodtotal.value---------)${finalfoodtotal.value}");

    print("plus");
    print(
        "==============Pizzaplus=====id========${pizzalist[pizzaindex].foodimagelist[index].id}");
    print(
        "==============Pizzaplus=====name========${pizzalist[pizzaindex].foodimagelist[index].name}");
    print(
        "==============Pizzaplus=====selectitem========${pizzalist[pizzaindex].foodimagelist[index].selectitem}");
    print("==============Pizzaplus=====index========${index}");
    print(
        "==============Pizzaplus=====price========${pizzalist[pizzaindex].foodimagelist[index].price}");
    print(
        "==============Pizzaplus=====foodbill========)${pizzalist[pizzaindex].foodimagelist[index].foodbill}");
    print(
        "==============Pizzaplus=====foodtotal========${pizzalist[pizzaindex].foodimagelist[index].foodtotal}");

    grandtotal.value = finalfoodtotal.value +
        gst.value +
        deliveryfee.value +
        donation.value +
        goldprimium.value;
    update();
  }

  void Pizzabottomremove(int pizzaindex, int index, BuildContext context) {
    pizzabottomlist[index].selectitem--;
    isBootomSheet.value = false;
    grandtotal.value = 0;
    Customfoodtotal.value = 0;
    iscountfoodtotal.value = 0;

    pizzabottomlist[index].foodtotal -= pizzabottomlist[index].price;
    pizzabottomlist[index].foodbill = pizzabottomlist[index].foodtotal;

    print(
        "========bottom======Pizzaremove=====id========${pizzabottomlist[index].id}");
    print(
        "========bottom======Pizzaremove=====name========${pizzabottomlist[index].name}");
    print(
        "=======bottom=======Pizzaremove=====selectitem========${pizzabottomlist[index].selectitem}");
    print("=====bottom=========Pizzaremove=====index========${index}");
    print(
        "=======bottom=======Pizzaremove=====price========${pizzabottomlist[index].price}");
    print(
        "========bottom======Pizzaremove=====foodbill========)${pizzabottomlist[index].foodbill}");
    print(
        "========bottom======Pizzaremove=====foodtotal========${pizzabottomlist[index].foodtotal}");

    if (pizzabottomlist[index].selectitem == 0) {
      pizzabottomlist[index].foodbill = pizzabottomlist[index].price;

      for (int i = 0; i < pizzalist.value.length; i++) {
        for (int j = 0; j < pizzalist[i].foodimagelist.value.length; j++) {
          if (pizzabottomlist.value[index].id ==
              pizzalist[i].foodimagelist[j].id) {
            pizzalist[i].foodimagelist[j].selectitem = 1;
            pizzalist[i].foodimagelist[j].checkadd = false;
          }
        }
      }
      pizzabottomlist.remove(pizzabottomlist[index]);
    }

    if (pizzabottomlist.isNotEmpty ||
        customizepizzalist[0].pizzametalist!.isNotEmpty) {
      isBootomSheet.value = true;
      iscountfoodtotal.value = 0;
    }

    for (int i = 0; i < pizzabottomlist.length; i++) {
      if (pizzabottomlist.isNotEmpty ||
          customizepizzalist[0].pizzametalist!.isNotEmpty) {
        iscountfoodtotal.value += pizzabottomlist[i].foodbill;
      }
    }

    for (int j = 0; j < customizepizzalist[0].pizzametalist!.length; j++) {
      if (customizepizzalist[0].pizzametalist!.isNotEmpty ||
          pizzabottomlist.isNotEmpty) {
        Customfoodtotal.value +=
            customizepizzalist[0].pizzametalist![j].customPizzametaBill;
      }
    }
    finalfoodtotal.value = Customfoodtotal.value + iscountfoodtotal.value;
    print("-------- finalfoodtotal.value---------)${finalfoodtotal.value}");

    resetOffer();
    grandtotal.value = finalfoodtotal.value +
        gst.value +
        deliveryfee.value +
        donation.value +
        goldprimium.value;

    update();
    reference!();
    print("bottomremove");
  }

  void Pizzabottomplus(int index) {
    pizzabottomlist[index].selectitem++;
    grandtotal.value = 0;
    Customfoodtotal.value = 0;
    iscountfoodtotal.value = 0;

    if (pizzabottomlist[index].selectitem == 0) {
      pizzabottomlist[index].selectitem = 1;
    }

    pizzabottomlist[index].foodtotal =
        pizzabottomlist[index].selectitem * pizzabottomlist[index].price;
    pizzabottomlist[index].foodbill = pizzabottomlist[index].foodtotal;

    for (int i = 0; i < pizzabottomlist.length; i++) {
      if (pizzabottomlist.isNotEmpty ||
          customizepizzalist[0].pizzametalist!.isNotEmpty) {
        iscountfoodtotal.value += pizzabottomlist[i].foodbill;
      }
    }

    for (int j = 0; j < customizepizzalist[0].pizzametalist!.length; j++) {
      if (customizepizzalist[0].pizzametalist!.isNotEmpty ||
          pizzabottomlist.isNotEmpty) {
        Customfoodtotal.value +=
            customizepizzalist[0].pizzametalist![j].customPizzametaBill;
      }
    }
    resetOffer();
    finalfoodtotal.value = Customfoodtotal.value + iscountfoodtotal.value;
    print("-------- finalfoodtotal.value---------)${finalfoodtotal.value}");

    print("bottomplus");

    print(
        "========bottom======Pizzaplus=====id========${pizzabottomlist[index].id}");
    print(
        "========bottom======Pizzaplus=====name========${pizzabottomlist[index].name}");
    print(
        "==============Pizzaplus=====selectitem========${pizzabottomlist[index].selectitem}");
    print("=====bottom=========Pizzaplus=====index========${index}");
    print(
        "=======bottom=======Pizzaplus=====price========${pizzabottomlist[index].price}");
    print(
        "========bottom======Pizzaplus=====foodbill========)${pizzabottomlist[index].foodbill}");
    print(
        "========bottom======Pizzaplus=====foodtotal========${pizzabottomlist[index].foodtotal}");

    print(
        "----------pizza--------iscountfoodtotal------------------------)${iscountfoodtotal.value}");
    grandtotal.value = finalfoodtotal.value +
        gst.value +
        deliveryfee.value +
        donation.value +
        goldprimium.value;
    update();
    reference!();
  }

  void Pizzaclear(BuildContext context) {
    for (int i = 0; i < pizzalist.length; i++) {
      for (int j = 0; j < pizzalist[i].foodimagelist.length; j++) {
        pizzalist[i].foodimagelist[j].checkadd = false;
        pizzalist[i].foodimagelist[j].selectitem = 1;

        for (int k = 0; k < pizzabottomlist.length; k++) {
          if (pizzabottomlist.isNotEmpty ||
              customizepizzalist[0].pizzametalist!.isNotEmpty) {
            pizzabottomlist[k].foodbill = pizzabottomlist[k].price;
          }
        }
      }
    }
    for (int i = 0; i < sodalist.length; i++) {
      sodalist[i].checkadd = false;
      sodalist[i].selectitem = 1;
    }
    isBootomSheet.value = false;
    pizzabottomlist.clear();
    customizepizzalist[0].pizzametalist!.clear();
    addsizelist!.clear();
    iscountfoodtotal.value = 0;

    print("------------pizzabottomlist-------------------)${pizzabottomlist!.length}");
    print("------------customizepizzalist[0].pizzametalist-------------------)${customizepizzalist[0].pizzametalist!.length}");
    print("------------pizzabottomlist-------------------)${addsizelist!.length}");

    Navigator.pop(context);
  }

  void Pizzatotalprice(){
    grandtotal.value = 0;
    Customfoodtotal.value = 0;
    iscountfoodtotal.value = 0;

    for (int i = 0; i < pizzabottomlist.length; i++){
      if (pizzabottomlist.isNotEmpty ||
          customizepizzalist[0].pizzametalist!.isNotEmpty) {
        iscountfoodtotal.value += pizzabottomlist[i].foodbill;
      }
    }

    for (int j = 0; j < customizepizzalist[0].pizzametalist!.length; j++) {
      if (customizepizzalist[0].pizzametalist!.isNotEmpty ||
          pizzabottomlist.isNotEmpty) {
        Customfoodtotal.value +=
            customizepizzalist[0].pizzametalist![j].customPizzametaBill;
      }
    }

    finalfoodtotal.value = Customfoodtotal.value + iscountfoodtotal.value;
    print("-------- finalfoodtotal.value---------)${finalfoodtotal.value}");
    print(
        "----------pizza--------iscountfoodtotal------------------------)${iscountfoodtotal.value}");
    grandtotal.value = finalfoodtotal.value +
        gst.value +
        deliveryfee.value +
        donation.value +
        goldprimium.value;
  }

  //----------------------------------------------------------SODA---------------------------------------------------------------)

/*  RxList<FoodItemModel> sodalist = [
    FoodItemModel(
      id: 31,
      image: "images/s1.webp",
      price: 30,
      name: "Pepsi Throwback",
      rating: 5.0,
      selectitem: 1,
      checkadd: false,
      foodtotal: 0,
      foodbill: 30,
      food: "soda",
    ),
    FoodItemModel(
      id: 32,
      image: "images/s3.webp",
      price: 20,
      name: "Cocacola",
      rating: 1.0,
      selectitem: 1,
      checkadd: false,
      foodtotal: 0,
      foodbill: 20,
      food: "soda",
    ),
    FoodItemModel(
        id: 33,
        image: "images/s4.webp",
        price: 10,
        name: "Gt Gin & Tonica",
        rating: "20 rating",
        food: "soda",
        selectitem: 1,
        checkadd: false,
        foodtotal: 0,
        foodbill: 10),
    FoodItemModel(
        id: 34,
        image: "images/s5.webp",
        price: 40,
        name: "Orange Soda",
        rating: "120 rating",
        food: "soda",
        selectitem: 1,
        checkadd: false,
        foodtotal: 0,
        foodbill: 40),
    FoodItemModel(
        id: 35,
        image: "images/s6.webp",
        price: 80,
        name: "Red Bull",
        rating: "200 rating",
        food: "soda",
        selectitem: 1,
        checkadd: false,
        foodtotal: 0,
        foodbill: 80),
    FoodItemModel(
        id: 36,
        image: "images/s7.webp",
        price: 30,
        name: "Scream",
        rating: "40 rating",
        food: "soda",
        selectitem: 1,
        checkadd: false,
        foodtotal: 0,
        foodbill: 30),
    FoodItemModel(
        id: 37,
        image: "images/s8.webp",
        price: 40,
        name: "Cocacola",
        rating: "120 rating",
        food: "soda",
        selectitem: 1,
        checkadd: false,
        foodtotal: 0,
        foodbill: 40),
    FoodItemModel(
        id: 38,
        image: "images/s10.webp",
        price: 50,
        name: "Black Berry",
        rating: "240 rating",
        food: "soda",
        selectitem: 1,
        checkadd: false,
        foodtotal: 0,
        foodbill: 50),
    FoodItemModel(
        id: 39,
        image: "images/s13.webp",
        price: 70,
        name: "Black Jamun",
        rating: "40 rating",
        food: "soda",
        selectitem: 1,
        checkadd: false,
        foodtotal: 0,
        foodbill: 70),
    FoodItemModel(
        id: 40,
        image: "images/s12.webp",
        price: 30,
        name: "Fruite Juice",
        rating: "440 rating",
        food: "soda",
        selectitem: 1,
        checkadd: false,
        foodtotal: 0,
        foodbill: 30),
    FoodItemModel(
        id: 41,
        image: "images/s11.webp",
        price: 10,
        name: "Pepsi",
        rating: "70 rating",
        food: "soda",
        selectitem: 1,
        checkadd: false,
        foodtotal: 0,
        foodbill: 10),
    FoodItemModel(
        id: 42,
        image: "images/s14.webp",
        price: 40,
        name: "Mango Masala",
        rating: "240 rating",
        food: "soda",
        selectitem: 1,
        checkadd: false,
        foodtotal: 0,
        foodbill: 40),
    FoodItemModel(
        id: 43,
        image: "images/s15.webp",
        price: 30,
        name: "Healthy Juice",
        rating: "40 rating",
        food: "soda",
        selectitem: 1,
        checkadd: false,
        foodtotal: 0,
        foodbill: 30),
    FoodItemModel(
        id: 44,
        image: "images/s16.webp",
        price: 70,
        name: "Malata",
        rating: "140 rating",
        food: "soda",
        selectitem: 1,
        checkadd: false,
        foodtotal: 0,
        foodbill: 70),
    FoodItemModel(
        id: 45,
        image: "images/s17.webp",
        price: 50,
        name: "Lemon Sharbat",
        rating: "320 rating",
        food: "soda",
        selectitem: 1,
        checkadd: false,
        foodtotal: 0,
        foodbill: 50),
    FoodItemModel(
        id: 46,
        image: "images/s18.webp",
        price: 20,
        name: "Beverly",
        rating: "100 rating",
        food: "soda",
        selectitem: 1,
        checkadd: false,
        foodtotal: 0,
        foodbill: 20),
    FoodItemModel(
        id: 47,
        image: "images/s19.webp",
        price: 50,
        name: "Pepsi",
        rating: "300 rating",
        food: "soda",
        selectitem: 1,
        checkadd: false,
        foodtotal: 0,
        foodbill: 50),
    FoodItemModel(
        id: 48,
        image: "images/s20.webp",
        price: 30,
        name: "Pulpy Orange",
        rating: "240 rating",
        food: "soda",
        selectitem: 1,
        checkadd: false,
        foodtotal: 0,
        foodbill: 30),
    FoodItemModel(
        id: 49,
        image: "images/s21.webp",
        price: 5,
        name: "Thums Up",
        rating: "440 rating",
        food: "soda",
        selectitem: 1,
        checkadd: false,
        foodtotal: 0,
        foodbill: 5),
    FoodItemModel(
        id: 50,
        image: "images/s22.webp",
        price: 30,
        name: "Tangerine",
        rating: "40 rating",
        food: "soda",
        selectitem: 1,
        checkadd: false,
        foodtotal: 0,
        foodbill: 30),
    FoodItemModel(
      id: 51,
      image: "images/s23.webp",
      price: 60,
      name: "Lime Soda",
      rating: "90 rating",
      food: "soda",
      selectitem: 1,
      checkadd: false,
      foodtotal: 0,
      foodbill: 60,
    ),
    FoodItemModel(
        id: 52,
        image: "images/s24.webp",
        price: 30,
        name: "Crush Lime",
        rating: "240 rating",
        food: "soda",
        selectitem: 1,
        checkadd: false,
        foodtotal: 0,
        foodbill: 30),
    FoodItemModel(
        id: 53,
        image: "images/s32.webp",
        price: 40,
        name: "Pepsi Cup",
        rating: "640 rating",
        food: "soda",
        selectitem: 1,
        checkadd: false,
        foodtotal: 0,
        foodbill: 40),
    FoodItemModel(
        id: 54,
        image: "images/s33.webp",
        price: 50,
        name: "Limbu Sharbat",
        rating: "70 rating",
        food: "soda",
        selectitem: 1,
        checkadd: false,
        foodtotal: 0,
        foodbill: 0),
    FoodItemModel(
        id: 55,
        image: "images/s34.webp",
        price: 20,
        name: "Thums Up",
        rating: "160 rating",
        food: "soda",
        selectitem: 1,
        checkadd: false,
        foodtotal: 0,
        foodbill: 20),
    FoodItemModel(
        id: 56,
        image: "images/s35.webp",
        price: 50,
        name: "Blue Berry",
        rating: "240 rating",
        food: "soda",
        selectitem: 1,
        checkadd: false,
        foodtotal: 0,
        foodbill: 50),
    FoodItemModel(
        id: 57,
        image: "images/s36.webp",
        price: 40,
        name: "Guava Soda",
        rating: "20 rating",
        food: "soda",
        selectitem: 1,
        checkadd: false,
        foodtotal: 0,
        foodbill: 40),
  ].obs;*/

  Future<List<FoodItemModel>> getSodaData()async{
    await FirebaseFirestore.instance
        .collection("coldDrink")
        .get()
        .then((QuerySnapshot querySnapshot){
      querySnapshot.docs.forEach((element) {
        Map<String,dynamic>data=element.data() as Map<String, dynamic>;

        log("${data}");
        sodalist.add(FoodItemModel.fromJson(data));

      });
    });

    return sodalist;
  }

  void Sodaadd(int index) {
    isBootomSheet.value = true;
    sodalist.value[index].checkadd = true;
    grandtotal.value = 0;
    Customfoodtotal.value = 0;
    iscountfoodtotal.value = 0;

    if (sodalist.value[index].checkadd) {
      pizzabottomlist.value.add(sodalist.value[index]);
    }

    for (int i = 0; i < pizzabottomlist.value.length; i++) {
      if (sodalist.value[index].id == pizzabottomlist.value[i].id) {
        pizzabottomlist[i].foodbill = pizzabottomlist[i].price;
      }
    }

    for (int i = 0; i < pizzabottomlist.value.length - 1; i++) {
      if (sodalist.value[index].id == pizzabottomlist.value[i].id) {
        pizzabottomlist.value.remove(pizzabottomlist.value[i]);
      }
    }

    for (int i = 0; i < pizzabottomlist.length; i++) {
      if (pizzabottomlist.isNotEmpty ||
          customizepizzalist[0].pizzametalist!.isNotEmpty) {
        iscountfoodtotal.value += pizzabottomlist[i].foodbill;
      }
    }

    for (int j = 0; j < customizepizzalist[0].pizzametalist!.length; j++) {
      if (customizepizzalist[0].pizzametalist!.isNotEmpty ||
          pizzabottomlist.isNotEmpty) {
        Customfoodtotal.value +=
            customizepizzalist[0].pizzametalist![j].customPizzametaBill;
      }
    }
    resetOffer();
    finalfoodtotal.value = Customfoodtotal.value + iscountfoodtotal.value;
    print("-------- finalfoodtotal.value---------)${finalfoodtotal.value}");

    grandtotal.value = finalfoodtotal.value +
        gst.value +
        deliveryfee.value +
        donation.value +
        goldprimium.value;

    update();
  }

  void Sodaplus(int index){
    grandtotal.value = 0;
    Customfoodtotal.value = 0;
    iscountfoodtotal.value = 0;

    sodalist.value[index].selectitem++;

    if (sodalist.value[index].selectitem == 0) {
      sodalist.value[index].checkadd = false;
      sodalist.value[index].selectitem = 1;
    }
    for (int i = 0; i < pizzabottomlist.length; i++) {
      if (sodalist.value[index].id == pizzabottomlist[i].id) {
        pizzabottomlist[i].foodtotal =
            pizzabottomlist[i].selectitem * pizzabottomlist[i].price;
        pizzabottomlist[i].foodbill = pizzabottomlist[i].foodtotal;
      }
      if (pizzabottomlist.isNotEmpty ||
          customizepizzalist[0].pizzametalist!.isNotEmpty) {
        iscountfoodtotal.value += pizzabottomlist[i].foodbill;
        print(iscountfoodtotal.value);
      }
    }

    for (int j = 0; j < customizepizzalist[0].pizzametalist!.length; j++) {
      if (customizepizzalist[0].pizzametalist!.isNotEmpty ||
          pizzabottomlist.isNotEmpty) {
        Customfoodtotal.value +=
            customizepizzalist[0].pizzametalist![j].customPizzametaBill;
      }
    }
    resetOffer();
    finalfoodtotal.value = Customfoodtotal.value + iscountfoodtotal.value;
    print("-------- finalfoodtotal.value---------)${finalfoodtotal.value}");

    grandtotal.value = finalfoodtotal.value +
        gst.value +
        deliveryfee.value +
        donation.value +
        goldprimium.value;
    update();
  }

  void Sodaremove(int index) {
    grandtotal.value = 0;
    Customfoodtotal.value = 0;
    iscountfoodtotal.value = 0;

    sodalist.value[index].selectitem--;
    isBootomSheet.value = false;

    for (int i = 0; i < pizzabottomlist.length; i++) {
      if (sodalist.value[index].id == pizzabottomlist[i].id) {
        pizzabottomlist[i].foodtotal -= pizzabottomlist[i].price;
        pizzabottomlist[i].foodbill = pizzabottomlist[i].foodtotal;
      }
    }
    if (sodalist.value[index].selectitem == 0) {
      sodalist.value[index].checkadd = false;
      sodalist.value[index].selectitem = 1;
      for (int i = 0; i < pizzabottomlist.value.length; i++) {
        if (sodalist.value[index].id == pizzabottomlist.value[i].id) {
          pizzabottomlist.value.remove(sodalist.value[index]);
        }
      }
    }
    for (int i = 0; i < sodalist.value.length; i++) {
      if (!sodalist.value[index].checkadd == sodalist.value[i].checkadd) {
        isBootomSheet.value = true;
      }
    }

    if (pizzabottomlist.isNotEmpty ||
        customizepizzalist[0].pizzametalist!.isNotEmpty) {
      isBootomSheet.value = true;
    }

    for (int i = 0; i < pizzabottomlist.length; i++) {
      if (pizzabottomlist.isNotEmpty ||
          customizepizzalist[0].pizzametalist!.isNotEmpty) {
        iscountfoodtotal.value += pizzabottomlist[i].foodbill;
      }
    }

    for (int j = 0; j < customizepizzalist[0].pizzametalist!.length; j++) {
      if (customizepizzalist[0].pizzametalist!.isNotEmpty ||
          pizzabottomlist.isNotEmpty) {
        Customfoodtotal.value +=
            customizepizzalist[0].pizzametalist![j].customPizzametaBill;
      }
    }
    resetOffer();
    finalfoodtotal.value = Customfoodtotal.value + iscountfoodtotal.value;
    print("-------- finalfoodtotal.value---------)${finalfoodtotal.value}");

    grandtotal.value = finalfoodtotal.value +
        gst.value +
        deliveryfee.value +
        donation.value +
        goldprimium.value;
    update();
  }

  void Sodabottompluse(int index) {
    grandtotal.value = 0;
    Customfoodtotal.value = 0;
    iscountfoodtotal.value = 0;
    pizzabottomlist[index].selectitem++;

    if (pizzabottomlist[index].selectitem == 0) {
      pizzabottomlist[index].selectitem = 1;
    }
    pizzabottomlist[index].foodtotal =
        pizzabottomlist[index].selectitem * pizzabottomlist[index].price;
    pizzabottomlist[index].foodbill = pizzabottomlist[index].foodtotal;

    for (int i = 0; i < pizzabottomlist.length; i++) {
      if (pizzabottomlist.isNotEmpty ||
          customizepizzalist[0].pizzametalist!.isNotEmpty) {
        iscountfoodtotal.value += pizzabottomlist[i].foodbill;
      }
    }

    for (int j = 0; j < customizepizzalist[0].pizzametalist!.length; j++) {
      if (customizepizzalist[0].pizzametalist!.isNotEmpty ||
          pizzabottomlist.isNotEmpty) {
        Customfoodtotal.value +=
            customizepizzalist[0].pizzametalist![j].customPizzametaBill;
      }
    }
    resetOffer();
    finalfoodtotal.value = Customfoodtotal.value + iscountfoodtotal.value;
    print("-------- finalfoodtotal.value---------)${finalfoodtotal.value}");

    grandtotal.value = finalfoodtotal.value +
        gst.value +
        deliveryfee.value +
        donation.value +
        goldprimium.value;

    reference!();
    update();
  }

//------------check---------------)
  void Sodabottomremove(int index, BuildContext context) {
    grandtotal.value = 0;
    Customfoodtotal.value = 0;
    iscountfoodtotal.value = 0;
    pizzabottomlist[index].selectitem--;
    isBootomSheet.value = false;

    pizzabottomlist[index].foodtotal -= pizzabottomlist[index].price;
    pizzabottomlist[index].foodbill = pizzabottomlist[index].foodtotal;

    if (pizzabottomlist.value[index].selectitem == 0) {
      /* for (int i = 0; i < pizzalist.length; i++) {
        for (int j = 0; j < pizzalist[i].foodimagelist.length; j++) {
          if (pizzabottomlist.value[index].id == pizzalist[i].foodimagelist[j].id) {
            pizzalist[i].foodimagelist[j].checkadd = false;
            pizzalist[i].foodimagelist[j].selectitem = 1;
            pizzabottomlist[index].foodbill = pizzabottomlist[index].price;
          }
        }
      }*/

      for (int i = 0; i < sodalist.value.length; i++) {
        if (pizzabottomlist.value[index].id == sodalist.value[i].id) {
          sodalist.value[i].selectitem = 1;
          sodalist.value[i].checkadd = false;
        }
      }

      pizzabottomlist.value.remove(pizzabottomlist.value[index]);
    }

    if (pizzabottomlist.isEmpty) {
      // Navigator.pop(context);
      isBootomSheet.value = false;
      iscountfoodtotal.value = 0;
    }

    for (int i = 0; i < pizzabottomlist.length; i++) {
      if (pizzabottomlist.isNotEmpty ||
          customizepizzalist[0].pizzametalist!.isNotEmpty) {
        iscountfoodtotal.value += pizzabottomlist[i].foodbill;
      }
    }
    for (int j = 0; j < customizepizzalist[0].pizzametalist!.length; j++) {
      if (customizepizzalist[0].pizzametalist!.isNotEmpty ||
          pizzabottomlist.isNotEmpty) {
        Customfoodtotal.value +=
            customizepizzalist[0].pizzametalist![j].customPizzametaBill;
      }
    }
    resetOffer();
    finalfoodtotal.value = Customfoodtotal.value + iscountfoodtotal.value;
    print("-------- finalfoodtotal.value---------)${finalfoodtotal.value}");

    grandtotal.value = finalfoodtotal.value +
        gst.value +
        deliveryfee.value +
        donation.value +
        goldprimium.value;

    reference!();
    update();
  }

  void Sodaclear(BuildContext context) {
    for (int i = 0; i < sodalist.length; i++) {
      sodalist[i].checkadd = false;
      sodalist[i].selectitem = 1;

      for (int k = 0; k < pizzabottomlist.length; k++) {
        if (pizzabottomlist.isNotEmpty ||
            customizepizzalist[0].pizzametalist!.isNotEmpty) {
          pizzabottomlist[k].foodbill = pizzabottomlist[k].price;
        }
      }
    }

    for (int i = 0; i < pizzalist.length; i++) {
      for (int j = 0; j < pizzalist[i].foodimagelist.length; j++) {
        pizzalist[i].foodimagelist[j].checkadd = false;
        pizzalist[i].foodimagelist[j].selectitem = 1;
      }
    }

    isBootomSheet.value = false;
    pizzabottomlist.clear();
    customizepizzalist[0].pizzametalist!.clear();

    addsizelist!.clear();
    iscountfoodtotal.value = 0;

    print(
        "------------pizzabottomlist-------------------)${pizzabottomlist!.length}");
    print(
        "------------customizepizzalist[0].pizzametalist-------------------)${customizepizzalist[0].pizzametalist!.length}");
    print(
        "------------pizzabottomlist-------------------)${addsizelist!.length}");
    reference!();
    Navigator.pop(context);
    update();
  }

  void Sodatotalprice() {
    grandtotal.value = 0;
    Customfoodtotal.value = 0;
    iscountfoodtotal.value = 0;

    for (int i = 0; i < pizzabottomlist.length; i++) {
      if (pizzabottomlist.isNotEmpty ||
          customizepizzalist[0].pizzametalist!.isNotEmpty) {
        iscountfoodtotal.value += pizzabottomlist[i].foodbill;
      }
    }

    for (int j = 0; j < customizepizzalist[0].pizzametalist!.length; j++) {
      if (customizepizzalist[0].pizzametalist!.isNotEmpty ||
          pizzabottomlist.isNotEmpty) {
        Customfoodtotal.value +=
            customizepizzalist[0].pizzametalist![j].customPizzametaBill;
      }
    }

    finalfoodtotal.value = Customfoodtotal.value + iscountfoodtotal.value;
    print("-------- finalfoodtotal.value---------)${finalfoodtotal.value}");

    grandtotal.value = finalfoodtotal.value +
        gst.value +
        deliveryfee.value +
        donation.value +
        goldprimium.value;

    update();
  }

  //----------------------------------------------------------CUSTOMPIZZA---------------------------------------------------------------)

  void custompizzaAdd() {
    grandtotal.value = 0;
    Customfoodtotal.value = 0;
    iscountfoodtotal.value = 0;

    customizepizzatotal.value = total.value;

    print(customizepizzatotal.value);

    customizepizzalist[0].pizzametalist?.add(PizzaMeta(
        customPizzametaSize: size,
        customPizzametaUint8list: imagedata,
        customPizzametaPosition: position,
        customPizzametaPrice: customizepizzatotal.value,
        customPizzametaSelectitem: 1,
        customPizzametaTotal: 0,
        customPizzametaBill: customizepizzatotal.value));
    addsizelist?.add(customizepizzalist[0].pizzasizelist![sizeindex.value]);
    //addlistofingredient.add(customizepizzalist[0].ingredients![ingredientindex.value]);

    for (int j = 0; j < customizepizzalist[0].pizzametalist!.length; j++) {
      if (customizepizzalist[0].pizzametalist!.isNotEmpty ||
          pizzabottomlist.isNotEmpty) {
        Customfoodtotal.value +=
            customizepizzalist[0].pizzametalist![j].customPizzametaBill;
      }
    }

    for (int i = 0; i < pizzabottomlist.length; i++) {
      if (pizzabottomlist.isNotEmpty ||
          customizepizzalist[0].pizzametalist!.isNotEmpty) {
        iscountfoodtotal.value += pizzabottomlist[i].foodbill;
      }
    }
    resetOffer();
    finalfoodtotal.value = Customfoodtotal.value + iscountfoodtotal.value;
    print("-------- finalfoodtotal.value---------)${finalfoodtotal.value}");

    grandtotal.value = finalfoodtotal.value +
        gst.value +
        deliveryfee.value +
        donation.value +
        goldprimium.value;
  }

  void custompizzaPlus(int index) {
    grandtotal.value = 0;
    Customfoodtotal.value = 0;
    iscountfoodtotal.value = 0;

    customizepizzalist[0].pizzametalist![index].customPizzametaSelectitem++;

    if (customizepizzalist[0].pizzametalist![index].customPizzametaSelectitem ==
        0) {
      customizepizzalist[0].pizzametalist![index].customPizzametaSelectitem = 1;
    }

    customizepizzalist[0].pizzametalist![index].customPizzametaTotal =
        customizepizzalist[0].pizzametalist![index].customPizzametaSelectitem *
            customizepizzalist[0].pizzametalist![index].customPizzametaPrice;
    customizepizzalist[0].pizzametalist![index].customPizzametaBill =
        customizepizzalist[0].pizzametalist![index].customPizzametaTotal;

    for (int j = 0; j < customizepizzalist[0].pizzametalist!.length; j++) {
      if (customizepizzalist[0].pizzametalist!.isNotEmpty ||
          pizzabottomlist.isNotEmpty) {
        Customfoodtotal.value +=
            customizepizzalist[0].pizzametalist![j].customPizzametaBill;
      }
    }

    for (int i = 0; i < pizzabottomlist.length; i++) {
      if (pizzabottomlist.isNotEmpty ||
          customizepizzalist[0].pizzametalist!.isNotEmpty) {
        iscountfoodtotal.value += pizzabottomlist[i].foodbill;
        print(iscountfoodtotal.value);
      }
    }
    resetOffer();
    finalfoodtotal.value = Customfoodtotal.value + iscountfoodtotal.value;
    print("-------- finalfoodtotal.value---------)${finalfoodtotal.value}");

    grandtotal.value = finalfoodtotal.value +
        gst.value +
        deliveryfee.value +
        donation.value +
        goldprimium.value;
    update();
  }

  void custompizzaRemove(int index) {
    grandtotal.value = 0;
    Customfoodtotal.value = 0;
    iscountfoodtotal.value = 0;

    customizepizzalist[0].pizzametalist![index].customPizzametaSelectitem--;
    isBootomSheet.value = false;

    customizepizzalist[0].pizzametalist![index].customPizzametaTotal -=
        customizepizzalist[0].pizzametalist![index].customPizzametaPrice;
    customizepizzalist[0].pizzametalist![index].customPizzametaBill =
        customizepizzalist[0].pizzametalist![index].customPizzametaTotal;

    if (customizepizzalist[0].pizzametalist![index].customPizzametaSelectitem ==
        0) {
      customizepizzalist[0]
          .pizzametalist!
          .remove(customizepizzalist[0].pizzametalist![index]);
      addsizelist!.remove(addsizelist![index]);
    }

    if (pizzabottomlist.isNotEmpty ||
        customizepizzalist[0].pizzametalist!.isNotEmpty) {
      isBootomSheet.value = true;
    }

    for (int j = 0; j < customizepizzalist[0].pizzametalist!.length; j++) {
      if (customizepizzalist[0].pizzametalist!.isNotEmpty ||
          pizzabottomlist.isNotEmpty) {
        Customfoodtotal.value +=
            customizepizzalist[0].pizzametalist![j].customPizzametaBill;
      }
    }

    for (int i = 0; i < pizzabottomlist.length; i++) {
      if (pizzabottomlist.isNotEmpty ||
          customizepizzalist[0].pizzametalist!.isNotEmpty) {
        iscountfoodtotal.value += pizzabottomlist[i].foodbill;
        print(iscountfoodtotal.value);
      }
    }
    resetOffer();
    finalfoodtotal.value = Customfoodtotal.value + iscountfoodtotal.value;
    print("-------- finalfoodtotal.value---------)${finalfoodtotal.value}");

    grandtotal.value = finalfoodtotal.value +
        gst.value +
        deliveryfee.value +
        donation.value +
        goldprimium.value;
    update();
  }

  //----------------------------------------------------------CART---------------------------------------------------------------)

  void functionGrandTotal(BuildContext context) {
    grandtotal.value = 0;
    Customfoodtotal.value = 0;
    iscountfoodtotal.value = 0;

    for (int i = 0; i < pizzabottomlist.length; i++) {
      if (pizzabottomlist.isNotEmpty ||
          customizepizzalist[0].pizzametalist!.isNotEmpty) {
        iscountfoodtotal.value += pizzabottomlist[i].foodbill;
      }
    }

    for (int j = 0; j < customizepizzalist[0].pizzametalist!.length; j++) {
      if (customizepizzalist[0].pizzametalist!.isNotEmpty ||
          pizzabottomlist.isNotEmpty) {
        Customfoodtotal.value +=
            customizepizzalist[0].pizzametalist![j].customPizzametaBill;
      }
    }

    finalfoodtotal.value = Customfoodtotal.value + iscountfoodtotal.value;
    print("-------- finalfoodtotal.value---------)${finalfoodtotal.value}");

    grandtotal.value = finalfoodtotal.value +
        gst.value +
        deliveryfee.value +
        donation.value +
        goldprimium.value;

    print("----------grandtotal----------------)${grandtotal.value}");
  }

  void functionPrimium() {
    grandtotal.value = 0;
    checkadd.value = !checkadd.value;
    goldprimium.value = checkadd.value ? 199 : 0;
    print(goldprimium.value);
    /* grandtotal.value = iscountfoodtotal.value +
        gst.value +
        deliveryfee.value +
        donation.value +
        goldprimium.value;*/

    finalfoodtotal.value = Customfoodtotal.value + iscountfoodtotal.value;
    print("-------- finalfoodtotal.value---------)${finalfoodtotal.value}");

    grandtotal.value = finalfoodtotal.value +
        gst.value +
        deliveryfee.value +
        donation.value +
        goldprimium.value;
  }

  void functionDonation(bool? value) {
    grandtotal.value = 0;
    checkbox.value = value!;
    donation.value = checkbox.value ? 2 : 0;
    print(donation.value);

    /* grandtotal.value = iscountfoodtotal.value +
        gst.value +
        deliveryfee.value +
        donation.value +
        goldprimium.value;*/
    finalfoodtotal.value = Customfoodtotal.value + iscountfoodtotal.value;
    print("-------- finalfoodtotal.value---------)${finalfoodtotal.value}");

    grandtotal.value = finalfoodtotal.value +
        gst.value +
        deliveryfee.value +
        donation.value +
        goldprimium.value;
  }

  void functionCartClear() {
    for (int i = 0; i < sodalist.length; i++) {
      sodalist[i].checkadd = false;
      sodalist[i].selectitem = 1;

      /* for (int k = 0; k < pizzabottomlist.length; k++) {
        if (pizzabottomlist.isNotEmpty || customizepizzalist[0].pizzametalist!.isNotEmpty) {
          pizzabottomlist[k].foodbill = pizzabottomlist[k].price;
        }
      }*/
    }

    for (int i = 0; i < pizzalist.length; i++) {
      for (int j = 0; j < pizzalist[i].foodimagelist.length; j++) {
        pizzalist[i].foodimagelist[j].checkadd = false;
        pizzalist[i].foodimagelist[j].selectitem = 1;
      }
    }

    isBootomSheet.value = false;
    pizzabottomlist.clear();
    customizepizzalist[0].pizzametalist!.clear();

    addsizelist!.clear();
    iscountfoodtotal.value = 0;

    print(
        "------------pizzabottomlist-------------------)${pizzabottomlist!.length}");
    print(
        "------------customizepizzalist[0].pizzametalist-------------------)${customizepizzalist[0].pizzametalist!.length}");
    print(
        "------------pizzabottomlist-------------------)${addsizelist!.length}");

    reference!();
    update();
  }

  //----------------------------------------------------------CONNECTIVITY---------------------------------------------------------------)

  void getconnectivity(BuildContext context) {
    subscription = Connectivity().onConnectivityChanged.listen((event) async {
      isdeviceconnected.value = await InternetConnectionChecker().hasConnection;

      if (!isdeviceconnected.value) {
        showDialog(
          context: context,
          builder: (context) {
            return InternetDialog();
          },
        );
        isalertset.value = true;
      }
    });
  }

  //----------------------------------------------------------DINNER SCREEN---------------------------------------------------------------)

  void dinnerLike(int index) {
    pizzalist[index].checklike = !pizzalist[index].checklike;
    if (pizzalist[index].checklike) {
      likelist.add(pizzalist[index]);
    } else {
      for (int i = 0; i < likelist.length; i++) {
        if (pizzalist[index].name == likelist[i].name) {
          likelist.remove(pizzalist[index]);
        }
      }
    }
    update();
  }

  //----------------------------------------------------------LIKE SCREEN---------------------------------------------------------------)

  void likeLike(int index) {
    likelist.value[index].checklike = !likelist.value[index].checklike;
    for (int i = 0; i < pizzalist.value.length; i++) {
      if (likelist.value[index].name == pizzalist.value[i].name) {
        pizzalist.value[i].checklike = false;
      }
    }

    for (int i = 0; i < likelist.value.length; i++) {
      if (!likelist.value[i].checklike) {
        likelist.value.remove(likelist.value[index]);
      }
    }

    likeupdate!();
  }

  RxList<OfferModel> offerlist = <OfferModel>[
    OfferModel(
        name: "10 % OFF up to 500",
        subname: "Add items worth Rs. 500 more to unlock",
        image: "images/offer.json",
        button: false),
    OfferModel(
        name: "Free Delivery",
        subname: "Add items worth Rs. 250 more to unlock",
        image: "images/freedelivery.json",
        button: false),
  ].obs;

  void resetOffer() {
    for (int i = 0; i < offerlist.length; i++) {
      if (offerlist.isNotEmpty) {
        offerlist[i].apply = false;
        print("================================");
      }
    }
  }

  void appliedOffer(int index, BuildContext context) {
    if (index == 0) {
      print('index-------)0');
      if (grandtotal.value >= 500) {
        offerlist.value[index].apply = !offerlist.value[index].apply;

        print('total-------)500');
        if (offerlist.value[index].apply) {
          print("77777777777777777----${grandtotal.value}");
          offer.value = grandtotal.value * 10 / 100;
          print("88888888888888888----${grandtotal.value}");
          print("qqqqqqqqqqqqqqqqqqqq----${offer.value}");
          grandtotal.value = grandtotal.value - offer.value.floor();
          reference!();
          update();
          refresh();
        } else {
          print("aaaaaaaaaaaaaaaaaaaaaaa----${offer.value}");
          grandtotal.value = grandtotal.value + offer.value.floor();
          print("6666666666666666----${grandtotal.value}");
          reference!();
          update();
          refresh();
        }
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("not valid offer")));
      }
    } else if (index == 1) {
      print('index-------)1');

      if (grandtotal.value >= 250) {
        offerlist.value[index].apply = !offerlist.value[index].apply;
        print('total-------)250');
        if (offerlist.value[index].apply) {
          print("----------------------)free delivery");
        } else {
          print("----------------------) not free delivery");
        }
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("not valid offer")));
      }
    }

    /*else if (index == 2) {
      print('index-------)0');
      if (pizzaController.grandtotal.value >= 1000) {
        setState(() {
          pizzaController.offerlist[index].apply =
              !pizzaController.offerlist[index].apply;
        });
        print('total-------)1000');
        if (pizzaController.offerlist[index].apply) {
          print("77777777777777777----${pizzaController.grandtotal.value}");
          pizzaController.offer.value =
              pizzaController.grandtotal.value * 15 / 100;
          print("88888888888888888----${pizzaController.grandtotal.value}");
          print("qqqqqqqqqqqqqqqqqqqq----${pizzaController.offer.value}");
          pizzaController.grandtotal.value = pizzaController.grandtotal.value -
              pizzaController.offer.value.floor();
          print("99999999999999999----${pizzaController.grandtotal.value}");
        } else {
          print("aaaaaaaaaaaaaaaaaaaaaaa----${pizzaController.offer.value}");
          pizzaController.grandtotal.value = pizzaController.grandtotal.value + pizzaController.offer.value.floor();
          print("6666666666666666----${pizzaController.grandtotal.value}");
        }
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("not valid offer")));
      }
    }
    else if (index == 3) {
      print('index-------)0');
      if (pizzaController.grandtotal.value >= 100) {

          setState(() {
            pizzaController.offerlist[index].apply =
            !pizzaController.offerlist[index].apply;
          });
          print('total-------)100');
          if(pizzaController.offerlist[index].apply) {

            print("------100----------------)free delivery");
          } else {

            print("-------100---------------) not free delivery");
          }

      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("not valid offer")));
      }
    }*/

    reference!();
    update();
  }

  void sodaSearch(String value) {
    RxList<FoodItemModel> sodaresult = <FoodItemModel>[].obs;

    sodaresult.value = sodalist
        .where((p0) => p0.name!.toLowerCase().contains(value.toLowerCase()))
        .toList();

    foundsoda.value = sodaresult;
    searchupdate!();
    update(foundsoda);
  }
}