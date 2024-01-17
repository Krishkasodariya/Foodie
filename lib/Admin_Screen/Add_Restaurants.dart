import 'dart:io';
import 'dart:math';
import 'package:Pizza/Admin_Screen/pizza_add_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_picker/image_picker.dart';
import 'custom_text_field_widget.dart';

class AddRestaurants extends StatefulWidget {
  const AddRestaurants({super.key});

  @override
  State<AddRestaurants> createState() => _AdminDinnerScreenState();
}

class _AdminDinnerScreenState extends State<AddRestaurants> {
  String? selectedImagePath;
  String? downloadImageUrl;

  String? selectedValue;

  List<String> items = [
    "Domino's Pizza",
    "La Pino'z Pizza",
    "LaMilanoPizzeria",
    "Pizza Hut",
    "Woklee"
  ];
  TextEditingController coldDrinkController = TextEditingController();
  TextEditingController priceController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              textFieldLabel(title: 'Cold Drink Name'),
              const SizedBox(
                height: 6,
              ),
              CustomTextField(
                controller: coldDrinkController,
                hintText: "Name",
                borderWidth: 1.5,
                borderColor: Colors.black45,
                borderRadius: 5,
                backgroundColor: Colors.white,
              ),
              const SizedBox(
                height: 14,
              ),
              textFieldLabel(title: 'Cold Drink Price'),
              const SizedBox(
                height: 6,
              ),
              CustomTextField(
                controller: priceController,
                hintText: "Price",
                borderWidth: 1.5,
                borderColor: Colors.black45,
                borderRadius: 5,
                backgroundColor: Colors.white,
              ),
              const SizedBox(
                height: 14,
              ),
              textFieldLabel(title: 'Select Image'),
              const SizedBox(
                height: 6,
              ),

              const SizedBox(
                height: 25,
              ),
              ElevatedButton(
                  style: ButtonStyle(
                    minimumSize: MaterialStateProperty.all(
                        const Size(double.infinity, 50)),
                    shape: MaterialStateProperty.all(
                      const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(25),
                        ),
                      ),
                    ),
                    backgroundColor: MaterialStateProperty.all(
                      const Color(0xffEF505F),
                    ),
                  ),
                  onPressed: () async {
                    await addDataFirebase();
                    const snackBar = SnackBar(
                      content: Text("Successfully Add Cold Drink"),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  },
                  child: const Text(
                    "Create Cold Drink",
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  )),
            ],
          ),
        ),
      ),
    );
  }


  addDataFirebase() async {
    try {
      final CollectionReference addCollectionReference =
          FirebaseFirestore.instance.collection('pizza');
      EasyLoading.show();

      final resData = {
        "checklike": false,
        "distance": "2km",
        "name": coldDrinkController.text,
        "price": int.parse(priceController.text),
        "foodimagelist":[],
        "rating": 3.1,
        "subname": "Pizza",
        "time": "25 - 30 min"
      };

      await addCollectionReference.doc("${coldDrinkController.text}").set(resData);

      /*await categoryCollectionReference.doc(selectedValue).update(
              {"foodimagelist": FieldValue.arrayUnion(pizzaList)},);*/

      EasyLoading.dismiss();
    } catch (e) {
      print("ADD PIZZA ERROR : $e");
    }
  }
}
