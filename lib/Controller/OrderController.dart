import 'dart:async';
import 'dart:convert';
import 'package:Pizza/Controller/GoogleMapController.dart';
import 'package:Pizza/Controller/LoginController.dart';
import 'package:Pizza/Controller/PizzaController.dart';
import 'package:Pizza/ModelClass/FoodItemModel.dart';
import 'package:Pizza/ModelClass/MainOrderFoodItemModel.dart';
import 'package:Pizza/ModelClass/OrderFoodItemModel.dart';
import 'package:Pizza/ModelClass/PizzaMeta.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

class OrderController extends GetxController {
  LoginController loginController = Get.find();
  PizzaController pizzaController = Get.find();
  GoogleMapControllerScreen GoogleMapController = Get.find();
  RxBool favouriteOrder = false.obs;
  RxBool deliveryViewDetail = false.obs;
  RxBool viewDetail = false.obs;
  RxBool apply = false.obs;
  RxBool cooking = true.obs;
  RxBool pending = false.obs;
  RxBool processing = false.obs;
  RxBool deliver = false.obs;

  RxList<MainOrderFoodItemModel> paymentHistoryDataList =
      <MainOrderFoodItemModel>[].obs;

  RxList<MainOrderFoodItemModel> orderDatalist = <MainOrderFoodItemModel>[].obs;
  RxList<MainOrderFoodItemModel> favouriteOrderDatalist =
      <MainOrderFoodItemModel>[].obs;
  RxList<MainOrderFoodItemModel> orderAllDatalist =
      <MainOrderFoodItemModel>[].obs;
  var uuid = Uuid();
  var orderId;

  Function? refreshData;

  void RefreshOrder(Function ref) {
    refreshData = ref;
  }

  void addUserOrderData() async {
    try {
      orderId = uuid.v4();

      int milliseconds = DateTime.now().microsecondsSinceEpoch;
      DateTime orderdate = DateTime.now();

      String formattedTime = DateFormat('hh:mm a').format(orderdate);
      CollectionReference userCollectionReference = await FirebaseFirestore.instance.collection("userOrderHistory");
      DocumentReference userDocumentReference = await userCollectionReference.doc(loginController.userid);

      CollectionReference orderCollectionReference = await userDocumentReference.collection("order");
      DocumentReference orderDocumentReference = await orderCollectionReference.doc();

      final pizzaBottomListData =
          pizzaController.pizzabottomlist.map((element) {
        FoodItemModel foodItem = FoodItemModel(
          restaurantName: element.restaurantName,
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

        PizzaMeta foodItem1 = PizzaMeta(
          pizzaSize: element.pizzaSize,
          base64: base64Image,
          customPizzametaPrice: element.customPizzametaPrice,
          customPizzametaSelectitem: element.customPizzametaSelectitem,
          customPizzametaTotal: element.customPizzametaTotal,
          customPizzametaBill: element.customPizzametaBill,
        );

        return foodItem1.toJson();
      });

      final docData = {
        "orderId": orderId,
        "milliseconds": milliseconds,
        "viewDetail": viewDetail.value,
        "apply": apply.value,
        "favouriteOrder": favouriteOrder.value,
        "uid": loginController.userid,
        "subTotal": pizzaController.finalfoodtotal.value,
        "gst": 13,
        "deliveryFee": 18,
        "grandTotal": pizzaController.grandtotal.value,
        "date": "${orderdate.day}-${orderdate.month}-${orderdate.year}",
        "time": "${formattedTime}",
        "address": GoogleMapController.areaController.text,
        "nearAddress": GoogleMapController.nearController.text,
        "name": loginController.cartName.value,
        "phoneNumber": "+91${loginController.cartPhone.value}",
        "orderData": [...pizzaBottomListData, ...pizzaMetaListData],
        "latitude": GoogleMapController.latitude,
        "longitude": GoogleMapController.longitude,
      };

      print("${formattedTime}");

      orderDocumentReference
          .set(docData)
          .then((value) => print("okkkkkkkkkkkkkkkkkkk"));
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<List<MainOrderFoodItemModel>> getUserOrderData() async {
    CollectionReference userCollectionReference = await FirebaseFirestore.instance.collection("userOrderHistory");
    DocumentReference userDocumentReference = await userCollectionReference.doc(loginController.userid);

    await userDocumentReference
        .collection("order")
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((element) {
        Map<String, dynamic> data = element.data() as Map<String, dynamic>;

        RxList<OrderFoodItemModel> orderdata = <OrderFoodItemModel>[].obs;

        List<dynamic> dynamicList = data['orderData'];

        dynamicList.forEach((element) {
          orderdata.add(OrderFoodItemModel.fromJson(element));
        });

        MainOrderFoodItemModel mainOrderFoodItemModel = MainOrderFoodItemModel(
          orderId: data['orderId'],
          milliseconds: data['milliseconds'],
          datalist: orderdata,
          apply: data['apply'],
          viewDetail: data['viewDetail'],
          favouriteOrder: data['favouriteOrder'],
          date: data['date'],
          deliveryFee: data['deliveryFee'],
          grandTotal: data['grandTotal'],
          gst: data['gst'],
          subTotal: data['subTotal'],
          time: data['time'],
          uid: data['uid'],
          address: data['address'],
          nearAddress: data['nearAddress'],
          name: data['name'],
          phoneNumber: data['phoneNumber'],
          latitude: data['latitude'],
          longitude: data['longitude'],
        );
        orderDatalist.add(mainOrderFoodItemModel);
      });
    });

    return orderDatalist;
  }

  void addAllUserOrderData() async {
    try {
      orderId = uuid.v4();

      int milliseconds = DateTime.now().microsecondsSinceEpoch;
      DateTime orderdate = DateTime.now();
      String formattedTime = DateFormat('hh:mm a').format(orderdate);

      CollectionReference userCollectionReference =
          await FirebaseFirestore.instance.collection("allUserOrderHistory");
      DocumentReference userDocumentReference =
          await userCollectionReference.doc();

      final pizzaBottomListData =
          pizzaController.pizzabottomlist.map((element) {
        FoodItemModel foodItem = FoodItemModel(
          restaurantName: element.restaurantName,
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

      final docData = {
        "orderId": orderId,
        "milliseconds": milliseconds,
        "viewDetail": viewDetail.value,
        "apply": apply.value,
        "favouriteOrder": favouriteOrder.value,
        "uid": loginController.userid,
        "subTotal": pizzaController.finalfoodtotal.value,
        "gst": 13,
        "deliveryFee": 18,
        "grandTotal": pizzaController.grandtotal.value,
        "date": "${orderdate.day}-${orderdate.month}-${orderdate.year}",
        "time": "${formattedTime}",
        "address": GoogleMapController.areaController.text,
        "nearAddress": GoogleMapController.nearController.text,
        "name": loginController.cartName.value,
        "phoneNumber": "+91${loginController.cartPhone.value}",
        "orderData": [...pizzaBottomListData, ...pizzaMetaListData],
        "latitude": GoogleMapController.latitude,
        "longitude": GoogleMapController.longitude,
      };

      print("${formattedTime}");

      userDocumentReference
          .set(docData)
          .then((value) => print("okkkkkkkkkkkkkkkkkkk"));
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<List<MainOrderFoodItemModel>> getAllUserOrderData() async {
    CollectionReference userCollectionReference =
        await FirebaseFirestore.instance.collection("allUserOrderHistory");

    await userCollectionReference.get().then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((element) {
        Map<String, dynamic> data = element.data() as Map<String, dynamic>;

        print(data);

        RxList<OrderFoodItemModel> orderdata = <OrderFoodItemModel>[].obs;
        List<dynamic> dynamicList = data['orderData'];

        dynamicList.forEach((element) {
          orderdata.add(OrderFoodItemModel.fromJson(element));
        });
        MainOrderFoodItemModel mainOrderFoodItemModel = MainOrderFoodItemModel(
          orderId: data['orderId'],
          milliseconds: data['milliseconds'],
          datalist: orderdata,
          apply: data['apply'],
          viewDetail: data['viewDetail'],
          favouriteOrder: data['favouriteOrder'],
          date: data['date'],
          deliveryFee: data['deliveryFee'],
          grandTotal: data['grandTotal'],
          gst: data['gst'],
          subTotal: data['subTotal'],
          time: data['time'],
          uid: data['uid'],
          address: data['address'],
          nearAddress: data['nearAddress'],
          name: data['name'],
          phoneNumber: data['phoneNumber'],
          latitude: data['latitude'],
          longitude: data['longitude'],
        );
        orderAllDatalist.add(mainOrderFoodItemModel);
      });
    });

    return orderAllDatalist;
  }

  void add_Favourite_User_OrderData(int index) async {
    try {
      CollectionReference userFavouriteCollectionReference =
          await FirebaseFirestore.instance
              .collection("userFavouriteOrderHistory");
      DocumentReference userFavouriteDocumentReference =
          await userFavouriteCollectionReference.doc(loginController.userid);

      CollectionReference orderFavouriteCollectionReference =
          await userFavouriteDocumentReference.collection("favouriteOrder");
      DocumentReference orderFavouriteDocumentReference =
          await orderFavouriteCollectionReference.doc();

      final favouriteOrderListData =
          orderDatalist[index].datalist!.map((element) {
        OrderFoodItemModel foodItem = OrderFoodItemModel(
          restaurantName: element.restaurantName,
          pizzaSize: element.pizzaSize,
          base64: element.base64,
          customPizzametaBill: element.customPizzametaBill,
          customPizzametaPrice: element.customPizzametaPrice,
          customPizzametaSelectitem: element.customPizzametaSelectitem,
          customPizzametaTotal: element.customPizzametaTotal,
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

      final docData = {
        "orderId": orderDatalist[index].orderId,
        "milliseconds": orderDatalist[index].milliseconds,
        "viewDetail": orderDatalist[index].viewDetail,
        "apply": orderDatalist[index].apply,
        "favouriteOrder": orderDatalist[index].favouriteOrder,
        "uid": orderDatalist[index].uid,
        "subTotal": orderDatalist[index].subTotal,
        "gst": 13,
        "deliveryFee": 18,
        "grandTotal": orderDatalist[index].grandTotal,
        "date": orderDatalist[index].date,
        "time": orderDatalist[index].time,
        "favouriteOrderData": [...favouriteOrderListData],
      };

      orderFavouriteDocumentReference
          .set(docData)
          .then((value) => print("okkkkkkkkkkkkkkkkkkk"));
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<List<MainOrderFoodItemModel>> getFavouriteUserOrderData() async {
    CollectionReference userCollectionReference = await FirebaseFirestore
        .instance
        .collection("userFavouriteOrderHistory");
    DocumentReference userDocumentReference =
        await userCollectionReference.doc(loginController.userid);

    await userDocumentReference
        .collection("favouriteOrder")
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((element) {
        Map<String, dynamic> data = element.data() as Map<String, dynamic>;
        RxList<OrderFoodItemModel> favouriteOrderdata =
            <OrderFoodItemModel>[].obs;

        List<dynamic> dynamicList = data['favouriteOrderData'];

        dynamicList.forEach((element) {
          favouriteOrderdata.add(OrderFoodItemModel.fromJson(element));
        });

        MainOrderFoodItemModel mainOrderFoodItemModel = MainOrderFoodItemModel(
          orderId: data['orderId'],
          milliseconds: data['milliseconds'],
          datalist: favouriteOrderdata,
          apply: data['apply'],
          viewDetail: data['viewDetail'],
          favouriteOrder: data['favouriteOrder'],
          date: data['date'],
          deliveryFee: data['deliveryFee'],
          grandTotal: data['grandTotal'],
          gst: data['gst'],
          subTotal: data['subTotal'],
          time: data['time'],
          uid: data['uid'],
        );
        favouriteOrderDatalist.add(mainOrderFoodItemModel);
      });
    });

    return favouriteOrderDatalist;
  }

//------------------------------------------------------YOUR ORDER SCREEN----------------------------------------------------
  void order_Fill_Like_OrderData(int index) async {
    print("-----------------)order_Fill_Like_OrderData");
    CollectionReference userCollectionReference =
        await FirebaseFirestore.instance.collection("userOrderHistory");
    DocumentReference userDocumentReference =
        await userCollectionReference.doc(loginController.userid);

    await userDocumentReference
        .collection("order").where("orderId", isEqualTo:orderDatalist[index].orderId )
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((element) async {
        Map<String, dynamic> data = element.data() as Map<String, dynamic>;

       // if (orderDatalist[index].orderId == data['orderId']) {
          await userDocumentReference
              .collection("order")
              .doc(element.id)
              .update({"favouriteOrder": true});
       // }
      });
    });
  }

  void order_Remove_Like_OrderData(int index) async {

    try{
      print("-----------------)order_Remove_Like_OrderData");
      CollectionReference userCollectionReference =
      await FirebaseFirestore.instance.collection("userOrderHistory");
      DocumentReference userDocumentReference =
      await userCollectionReference.doc(loginController.userid);

      await userDocumentReference
          .collection("order").where("orderId", isEqualTo:orderDatalist[index].orderId )
          .get()
          .then((QuerySnapshot querySnapshot) {
        querySnapshot.docs.forEach((element) async {
          Map<String, dynamic> data = element.data() as Map<String, dynamic>;

          //if (orderDatalist[index].orderId == data['orderId']) {
            await userDocumentReference
                .collection("order")
                .doc(element.id)
                .update({"favouriteOrder": false});
          //}
        });
      });

    }catch(e){
      print("=============order_Remove_Like_OrderData======================)${e}");
    }


  }

  void remove_Favourite_User_OrderData(int index) async {
    try{
      print("----------------)remove_Favourite_User_OrderData");
      CollectionReference userFavouriteCollectionReference = await FirebaseFirestore.instance.collection("userFavouriteOrderHistory");
      DocumentReference userFavouriteDocumentReference = await userFavouriteCollectionReference.doc(loginController.userid);

      await userFavouriteDocumentReference
          .collection("favouriteOrder").where("orderId", isEqualTo:orderDatalist[index].orderId )
          .get()
          .then((QuerySnapshot querySnapshot) {
        querySnapshot.docs.forEach((element) async {
          Map<String, dynamic> data = element.data() as Map<String, dynamic>;

          //if (orderDatalist[index].orderId == data['orderId']) {
            await userFavouriteDocumentReference
                .collection("favouriteOrder")
                .doc(element.id)
                .delete();
         // }
        });
      });



    }catch(e){
      print("==============remove_Favourite_User_OrderData=================)${e}");
    }

  }

  //------------------------------------------------------FAVOURITE ORDER SCREEN--------------------------------------------

  void remove_Favourite_User_Favourite_OrderData(int index) async {
    try {
     // print("----${favouriteOrderDatalist[index].grandTotal}----------------)remove_Favourite_User_Favourite_OrderData");
      CollectionReference userFavouriteCollectionReference = await FirebaseFirestore.instance.collection("userFavouriteOrderHistory");
      DocumentReference userFavouriteDocumentReference = await userFavouriteCollectionReference.doc(loginController.userid);

      await userFavouriteDocumentReference
          .collection("favouriteOrder").where("orderId", isEqualTo:favouriteOrderDatalist[index].orderId)
          .get()
          .then((QuerySnapshot querySnapshot) {
        querySnapshot.docs.forEach((element) async {
          Map<String, dynamic> data = element.data() as Map<String, dynamic>;

          //if (favouriteOrderDatalist[index].orderId == data['orderId']) {
            await userFavouriteDocumentReference
                .collection("favouriteOrder")
                .doc(element.id)
                .delete();
         // }
        });
      });

    } catch (e) {
      print("================remove_Favourite_User_Favourite_OrderData================)${e}");
    }
  }

  void order_Remove_Like_Favourite_OrderData(int index) async {

    try{
      //print("-----${favouriteOrderDatalist[index].grandTotal}---------------)order_Remove_Like_Favourite_OrderData");
      CollectionReference userCollectionReference = await FirebaseFirestore.instance.collection("userOrderHistory");
      DocumentReference userDocumentReference = await userCollectionReference.doc(loginController.userid);

      await userDocumentReference
          .collection("order").where("orderId", isEqualTo:favouriteOrderDatalist[index].orderId)
          .get()
          .then((QuerySnapshot querySnapshot) {
        querySnapshot.docs.forEach((element) async {
          Map<String, dynamic> data = element.data() as Map<String, dynamic>;

          //if (favouriteOrderDatalist[index].orderId == data['orderId']) {
            await userDocumentReference
                .collection("order")
                .doc(element.id)
                .update({"favouriteOrder": false});
        //  }
        });
      });

    }catch(e){
      print("============order_Remove_Like_Favourite_OrderData====================)${e}");
    }

  }

//------------------------------------------------------REAL TIME------------------------------------

  void tracking_Order() async {
    try {
      orderId = uuid.v4();

      int milliseconds = DateTime.now().microsecondsSinceEpoch;
      DateTime orderdate = DateTime.now();
      String formattedTime = DateFormat('hh:mm a').format(orderdate);

      CollectionReference userCollectionReference =
          await FirebaseFirestore.instance.collection("trackingOrder");
      DocumentReference userDocumentReference =
          await userCollectionReference.doc();

      final pizzaBottomListData =
          pizzaController.pizzabottomlist.map((element) {
        FoodItemModel foodItem = FoodItemModel(
          restaurantName: element.restaurantName,
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

      final docData = {
        "orderId": orderId,
        "milliseconds": milliseconds,
        "apply": apply.value,
        "viewDetail": viewDetail.value,
        "cooking": cooking.value,
        "pending": pending.value,
        "processing": processing.value,
        "deliver": deliver.value,
        "uid": loginController.userid,
        "subTotal": pizzaController.finalfoodtotal.value,
        "gst": 13,
        "deliveryFee": 18,
        "grandTotal": pizzaController.grandtotal.value,
        "date": "${orderdate.day}-${orderdate.month}-${orderdate.year}",
        "time": "${formattedTime}",
        "address": GoogleMapController.areaController.text,
        "nearAddress": GoogleMapController.nearController.text,
        "userName": loginController.cartName.value,
        "userImage": loginController.imageurl,
        "userPhoneNumber": "+91${loginController.cartPhone.value}",
        "orderData": [...pizzaBottomListData, ...pizzaMetaListData],
        "userLatitude": GoogleMapController.latitude,
        "userLongitude": GoogleMapController.longitude,
        "deliveryViewDetail": deliveryViewDetail.value,
        "deliveryName": "",
        "deliveryUid": "",
        "deliveryPhone": "",
        "deliveryEmail": "",
        "deliveryImage": "",
        "deliveryLatitude": 0.0,
        "deliveryLongitude": 0.0,
      };

      print("${formattedTime}");

      userDocumentReference
          .set(docData)
          .then((value) => print("okkkkkkkkkkkkkkkkkkk"));
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<List<MainOrderFoodItemModel>> getUserPaymentHistoryData() async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    User? user = _auth.currentUser;
    if (user == null) return [];

    var userCollectionReference = await FirebaseFirestore.instance
        .collection("allUserOrderHistory")
        .where("uid", isEqualTo: user.uid);

    await userCollectionReference.get().then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((element) {
        Map<String, dynamic> data = element.data() as Map<String, dynamic>;

        print(data);

        RxList<OrderFoodItemModel> orderdata = <OrderFoodItemModel>[].obs;
        List<dynamic> dynamicList = data['orderData'];

        dynamicList.forEach((element) {
          orderdata.add(OrderFoodItemModel.fromJson(element));
        });
        MainOrderFoodItemModel mainOrderFoodItemModel = MainOrderFoodItemModel(
          orderId: data['orderId'],
          milliseconds: data['milliseconds'],
          datalist: orderdata,
          apply: data['apply'],
          viewDetail: data['viewDetail'],
          favouriteOrder: data['favouriteOrder'],
          date: data['date'],
          deliveryFee: data['deliveryFee'],
          grandTotal: data['grandTotal'],
          gst: data['gst'],
          subTotal: data['subTotal'],
          time: data['time'],
          uid: data['uid'],
          address: data['address'],
          nearAddress: data['nearAddress'],
          name: data['name'],
          phoneNumber: data['phoneNumber'],
          latitude: data['latitude'],
          longitude: data['longitude'],
        );
        paymentHistoryDataList.add(mainOrderFoodItemModel);
      });
    });

    return paymentHistoryDataList;
  }
}
