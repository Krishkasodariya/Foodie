


import 'dart:convert';
import 'package:Pizza/Controller/LoginController.dart';
import 'package:Pizza/Controller/PizzaController.dart';
import 'package:Pizza/ModelClass/FoodItemModel.dart';
import 'package:Pizza/ModelClass/MainOrderFoodItemModel.dart';
import 'package:Pizza/ModelClass/OrderFoodItemModel.dart';
import 'package:Pizza/ModelClass/PizzaMeta.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class OrderController extends GetxController {

  LoginController loginController = Get.find();
  PizzaController pizzaController =Get.find();
  RxBool favouriteOrder=false.obs;
  RxBool viewDetail=false.obs;
  RxBool apply=false.obs;

  RxList<MainOrderFoodItemModel> orderDatalist = <MainOrderFoodItemModel>[].obs;
  RxList<MainOrderFoodItemModel> orderAllDatalist = <MainOrderFoodItemModel>[].obs;

  void addUserOrderData() async{
    try {
      int milliseconds = DateTime.now().microsecondsSinceEpoch;
      DateTime orderdate = DateTime.now();

      String formattedTime  = DateFormat('hh:mm a').format(orderdate);
      CollectionReference userCollectionReference = await FirebaseFirestore.instance.collection("userOrderHistory");
      DocumentReference userDocumentReference =await userCollectionReference.doc(loginController.userid);

      CollectionReference orderCollectionReference =await userDocumentReference.collection("order");
      DocumentReference orderDocumentReference =await orderCollectionReference.doc();

      final pizzaBottomListData = pizzaController.pizzabottomlist.map((element) {
        FoodItemModel foodItem = FoodItemModel(
          image: element.image,
          rating: element.rating,
          name: element.name,
          price: element.price,
          id: element.id,
          food: element.food,
          checkadd: element.checkadd,
          selectitem: element.selectitem,
          foodbill: element.foodbill,
          foodtotal: element.foodtotal,
        );

        return foodItem.toJson();
      });

      final pizzaMetaListData =
      pizzaController.customizepizzalist[0].pizzametalist!.map((element) {
        String base64Image = base64Encode(element.customPizzametaUint8list!);

        PizzaMeta foodItem = PizzaMeta(
          pizzaSize: element.pizzaSize,
          base64: base64Image,
          customPizzametaPrice: element.customPizzametaPrice,
          customPizzametaSelectitem: element.customPizzametaSelectitem,
          customPizzametaTotal: element.customPizzametaTotal,
          customPizzametaBill: element.customPizzametaBill,
        );

        return foodItem.toJson();

      });

      final docData={

        "milliseconds":milliseconds,
        "viewDetail":viewDetail.value,
        "apply":apply.value,
        "favouriteOrder":favouriteOrder.value,
        "uid": loginController.userid,
        "subTotal": pizzaController.finalfoodtotal.value,
        "gst": 13,
        "deliveryFee": 18,
        "grandTotal": pizzaController.grandtotal.value,
        "date": "${orderdate.day}-${orderdate.month}-${orderdate.year}",
        "time": "${formattedTime}",
        "orderData": [...pizzaBottomListData, ...pizzaMetaListData],
      };

      print( "${formattedTime}");

      orderDocumentReference
          .set(docData)
          .then((value) => print("okkkkkkkkkkkkkkkkkkk"));
    } catch (e) {
      print('Error: $e');
    }
  }
  Future<List<MainOrderFoodItemModel>> getUserOrderData() async{

    CollectionReference userCollectionReference = await FirebaseFirestore.instance.collection("userOrderHistory");
    DocumentReference userDocumentReference = await userCollectionReference.doc(loginController.userid);

        await userDocumentReference
            .collection("order")
            .get()
            .then((QuerySnapshot querySnapshot){
              querySnapshot.docs.forEach((element){

                Map<String,dynamic> data = element.data() as Map<String, dynamic>;
                RxList<OrderFoodItemModel> orderdata = <OrderFoodItemModel>[].obs;

                List<dynamic> dynamicList = data['orderData'];

                dynamicList.forEach((element){
                  orderdata.add(OrderFoodItemModel.fromJson(element));
                });

                MainOrderFoodItemModel mainOrderFoodItemModel=MainOrderFoodItemModel(
                  milliseconds: data['milliseconds'],
                  datalist:orderdata,
                  apply:data['apply'],
                  viewDetail: data['viewDetail'],
                  favouriteOrder: data['favouriteOrder'],
                  date: data['date'],
                  deliveryFee:  data['deliveryFee'],
                  grandTotal:  data['grandTotal'],
                  gst: data['gst'],
                  subTotal:  data['subTotal'],
                  time: data['time'],
                  uid: data['uid'],
                );
                orderDatalist.add(mainOrderFoodItemModel);
              });
        });

    return orderDatalist;
  }

  void addAllUserOrderData()async{

    try {
      int milliseconds = DateTime.now().microsecondsSinceEpoch;
      DateTime orderdate = DateTime.now();
      String formattedTime  = DateFormat('hh:mm a').format(orderdate);

      CollectionReference userCollectionReference = await FirebaseFirestore.instance.collection("allUserOrderHistory");
      DocumentReference userDocumentReference =await userCollectionReference.doc();

      final pizzaBottomListData = pizzaController.pizzabottomlist.map((element){
        FoodItemModel foodItem = FoodItemModel(
          image: element.image,
          rating: element.rating,
          name: element.name,
          price: element.price,
          id: element.id,
          food: element.food,
          checkadd: element.checkadd,
          selectitem: element.selectitem,
          foodbill: element.foodbill,
          foodtotal: element.foodtotal,
        );

        return foodItem.toJson();
      });
      final pizzaMetaListData = pizzaController.customizepizzalist[0].pizzametalist!.map((element) {
        String base64Image = base64Encode(element.customPizzametaUint8list!);

        PizzaMeta foodItem = PizzaMeta(
          pizzaSize: element.pizzaSize,
          base64: base64Image,
          customPizzametaPrice: element.customPizzametaPrice,
          customPizzametaSelectitem: element.customPizzametaSelectitem,
          customPizzametaTotal: element.customPizzametaTotal,
          customPizzametaBill: element.customPizzametaBill,
        );

        return foodItem.toJson();

      });

      final docData={
        "milliseconds":milliseconds,
        "viewDetail":viewDetail.value,
        "apply":apply.value,
        "favouriteOrder":favouriteOrder.value,
        "uid": loginController.userid,
        "subTotal": pizzaController.finalfoodtotal.value,
        "gst": 13,
        "deliveryFee": 18,
        "grandTotal": pizzaController.grandtotal.value,
        "date": "${orderdate.day}-${orderdate.month}-${orderdate.year}",
        "time": "${formattedTime}",
        "orderData": [...pizzaBottomListData, ...pizzaMetaListData],
      };

      print( "${formattedTime}");

      userDocumentReference
          .set(docData)
          .then((value) => print("okkkkkkkkkkkkkkkkkkk"));
    } catch (e) {
      print('Error: $e');
    }
  }
  Future<List<MainOrderFoodItemModel>> getAllUserOrderData() async{

    CollectionReference userCollectionReference = await FirebaseFirestore.instance.collection("allUserOrderHistory");


    await userCollectionReference
        .get()
        .then((QuerySnapshot querySnapshot){
      querySnapshot.docs.forEach((element){

        Map<String,dynamic> data = element.data() as Map<String, dynamic>;

        print(data);

        RxList<OrderFoodItemModel> orderdata = <OrderFoodItemModel>[].obs;
        List<dynamic> dynamicList = data['orderData'];

        dynamicList.forEach((element){
          orderdata.add(OrderFoodItemModel.fromJson(element));
        });
        MainOrderFoodItemModel mainOrderFoodItemModel=MainOrderFoodItemModel(
          milliseconds: data['milliseconds'],
          datalist:orderdata,
          apply:data['apply'],
          viewDetail: data['viewDetail'],
          favouriteOrder: data['favouriteOrder'],
          date: data['date'],
          deliveryFee:  data['deliveryFee'],
          grandTotal:  data['grandTotal'],
          gst: data['gst'],
          subTotal:  data['subTotal'],
          time: data['time'],
          uid: data['uid'],
        );
        orderAllDatalist.add(mainOrderFoodItemModel);
      });
    });

    return orderAllDatalist;
  }


}
