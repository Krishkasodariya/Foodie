import 'dart:io';
import 'dart:math';
import 'package:Pizza/Controller/PizzaController.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:uuid/uuid.dart';

import 'package:dotted_dashed_line/dotted_dashed_line.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import '../ModelClass/FoodItemModel.dart';

class SodaAddView extends StatefulWidget {
  final FoodItemModel? editItemId;

  const SodaAddView({super.key, this.editItemId});

  @override
  State<SodaAddView> createState() => _SodaAddViewState();
}

class _SodaAddViewState extends State<SodaAddView> {
  String? selectedImagePath;
  String? downloadImageUrl;

  String? selectedValue;

  TextEditingController coldDrinkController = TextEditingController();
  TextEditingController priceController = TextEditingController();

  PizzaController pizzaController = Get.find();

  @override
  void initState() {
    // TODO: implement initState
    if (widget.editItemId != null &&
        selectedImagePath == null &&
        downloadImageUrl == null) {
      downloadImageUrl = widget.editItemId?.image;
      coldDrinkController =
          TextEditingController(text: widget.editItemId?.name);
      priceController = TextEditingController(
          text: widget.editItemId?.price.toString() ?? "20");
      setState(() {});
    }
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(
                context,
              );
              setState(() {});
            },
            child: const Icon(
              Icons.arrow_back_rounded,
              size: 25,
              color: Colors.black,
            ),
          ),
          title: Text(
              widget.editItemId == null
                  ? "Create New Cold drinks"
                  : "Edit cold drink",
              style: GoogleFonts.nunito(
                  color: Color(0xff293041),
                  fontSize: 20,
                  fontWeight: FontWeight.w500)),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: Container(
                        height: 1,
                        decoration: BoxDecoration(
                            border: Border.all(
                              color: Color(0xffDAD9DD),
                              width: 1,
                            )),
                      ),
                    ),
                  ),
                  Text(
                    widget.editItemId == null ? "ADD NEW ONE" : "Edit",
                    style: GoogleFonts.nunito(
                        color: Color(0xff7e878d),
                        fontSize: 15.2,
                        fontWeight: FontWeight.w500),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: Container(
                        height: 1,
                        decoration: BoxDecoration(
                            border: Border.all(
                              color: Color(0xffDAD9DD),
                              width: 1,
                            )),
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 25,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 15),
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                      boxShadow: [
                        BoxShadow(
                            color: Color(0xffE9E9F7),
                            blurRadius: 10,
                            spreadRadius: 4)
                      ]),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 25,
                      ),
                      Row(
                        children: [
                          Container(
                            width: 4,
                            height: 30,
                            decoration: BoxDecoration(
                                color: Color(0xffEF4F5F),
                                borderRadius:
                                BorderRadius.all(Radius.circular(5))),
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          Center(
                            child: Text(
                              widget.editItemId == null
                                  ? "Add New Cold drinks"
                                  : "Edit cold drink",
                              style: GoogleFonts.lexend(
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      DottedDashedLine(
                        height: 1,
                        width: double.infinity,
                        axis: Axis.horizontal,
                        dashColor: Color(0xffEF4F5F),
                        strokeWidth: 1.2,
                        dashSpace: 0,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Center(
                        child: selectedImagePath == null &&
                            downloadImageUrl == null
                            ? Container(
                          width: 110,
                          height: 110,
                          decoration: const BoxDecoration(
                            color: Color(0xffE9E9F7),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.add,
                            color: Color(0xffB1BBDA),
                            size: 60,
                          ),
                        )
                            : ClipRRect(
                          borderRadius:
                          const BorderRadius.all(Radius.circular(60)),
                          child: Container(
                            width: 110,
                            height: 110,
                            decoration: const BoxDecoration(
                              color: Color(0xffE9E9F7),
                              shape: BoxShape.circle,
                            ),
                            child: downloadImageUrl != null &&
                                selectedImagePath == null
                                ? Image.network(
                              "$downloadImageUrl",
                              height: 240,
                              width: double.maxFinite,
                              fit: BoxFit.fill,
                            )
                                : Image.file(
                              File(selectedImagePath!),
                              height: 240,
                              width: double.maxFinite,
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 2),
                        child: GestureDetector(
                          onTap: () {
                            showModalBottomSheet(
                              backgroundColor: Color(0xffF4F6FA),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(20),
                                      topLeft: Radius.circular(20))),
                              context: context,
                              builder: (context) {
                                return Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: 190,
                                  decoration: const BoxDecoration(
                                      color: Color(0xffF4F6FA),
                                      borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(15),
                                          topLeft: Radius.circular(15))),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10, right: 10, top: 10),
                                    child: Container(
                                      decoration: const BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.only(
                                              topRight: Radius.circular(15),
                                              topLeft: Radius.circular(15))),
                                      child: Column(
                                        children: [
                                          const SizedBox(
                                            height: 30,
                                          ),
                                          Row(
                                            children: [
                                              Container(
                                                width: 4,
                                                height: 30,
                                                decoration: const BoxDecoration(
                                                    color: Color(0xffEF4F5F),
                                                    borderRadius:
                                                    BorderRadius.all(
                                                        Radius.circular(
                                                            5))),
                                              ),
                                              const SizedBox(
                                                width: 15,
                                              ),
                                              Text("Change photo",
                                                  style: GoogleFonts.lexend(
                                                      color: Colors.black,
                                                      fontSize: 21,
                                                      fontWeight:
                                                      FontWeight.w500)),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 15,
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                pickAttachment(ImageSource.camera);
                                                Navigator.pop(context);
                                              });
                                            },
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 10, right: 10),
                                              child: Container(
                                                width: double.infinity,
                                                height: 45,
                                                child: Column(
                                                  children: [
                                                    Row(
                                                      mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .start,
                                                      children: [
                                                        Container(
                                                          width: 36,
                                                          height: 36,
                                                          decoration: BoxDecoration(
                                                              color: Color(
                                                                  0xffF2F4F7),
                                                              shape: BoxShape
                                                                  .circle),
                                                          child: Icon(
                                                              Icons.camera,
                                                              color: Color(
                                                                  0xff787E91)),
                                                        ),
                                                        Padding(
                                                          padding:
                                                          const EdgeInsets
                                                              .only(
                                                              left: 5),
                                                          child: Text(
                                                            "Camera",
                                                            style: GoogleFonts.nunito(
                                                                fontSize: 18,
                                                                color: Color(
                                                                    0xff313848),
                                                                fontWeight:
                                                                FontWeight
                                                                    .w600),
                                                          ),
                                                        ),
                                                        Spacer(),
                                                        Icon(
                                                          Icons
                                                              .arrow_forward_ios,
                                                          color:
                                                          Color(0xff313848),
                                                          size: 17,
                                                        )
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height: 5,
                                                    ),
                                                    Padding(
                                                      padding:
                                                      const EdgeInsets.only(
                                                          left: 45),
                                                      child: Container(
                                                        width: double.infinity,
                                                        height: 1,
                                                        decoration: BoxDecoration(
                                                            border: Border.symmetric(
                                                                horizontal: BorderSide(
                                                                    color: Color(
                                                                        0xffEAEDF3),
                                                                    width:
                                                                    1.5))),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 15,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 10, right: 10),
                                            child: GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  pickAttachment(ImageSource.gallery);
                                                  Navigator.pop(context);
                                                });
                                              },
                                              child: Container(
                                                width: double.infinity,
                                                height: 45,
                                                child: Column(
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Container(
                                                          width: 36,
                                                          height: 36,
                                                          decoration: BoxDecoration(
                                                              color: Color(
                                                                  0xffF2F4F7),
                                                              shape: BoxShape
                                                                  .circle),
                                                          child: Icon(
                                                              Icons.photo,
                                                              color: Color(
                                                                  0xff787E91)),
                                                        ),
                                                        Padding(
                                                          padding:
                                                          const EdgeInsets
                                                              .only(
                                                              left: 5),
                                                          child: Text(
                                                            "Gallery",
                                                            style: GoogleFonts.nunito(
                                                                fontSize: 18,
                                                                color: Color(
                                                                    0xff313848),
                                                                fontWeight:
                                                                FontWeight
                                                                    .w600),
                                                          ),
                                                        ),
                                                        Spacer(),
                                                        Icon(
                                                          Icons
                                                              .arrow_forward_ios,
                                                          color:
                                                          Color(0xff313848),
                                                          size: 17,
                                                        )
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height: 5,
                                                    ),
                                                    Padding(
                                                      padding:
                                                      const EdgeInsets.only(
                                                          left: 45),
                                                      child: Container(
                                                        width: double.infinity,
                                                        height: 1,
                                                        decoration: BoxDecoration(
                                                            border: Border.symmetric(
                                                                horizontal: BorderSide(
                                                                    color: Color(
                                                                        0xffEAEDF3),
                                                                    width:
                                                                    1.5))),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                          child: Text("Change photo",
                              style: GoogleFonts.nunito(
                                  color: Color(0xffEF4F5F),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500)),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 10, right: 10),
                            child: Text(
                              "Cold drink Name",
                              style: GoogleFonts.nunito(
                                  fontSize: 18,
                                  color: Color(0xff313848),
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10, right: 10),
                            child: Container(
                              height: 50,
                              decoration: BoxDecoration(
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(15)),
                                  color: Colors.white,
                                  border: Border.all(
                                      color: Color(0xffe7e7e7), width: 1),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Color(0xfff5f5f5),
                                        spreadRadius: 1,
                                        blurRadius: 5,
                                        blurStyle: BlurStyle.outer)
                                  ]),
                              child: Padding(
                                padding:
                                const EdgeInsets.only(left: 10, right: 10),
                                child: TextField(
                                  autofocus: false,
                                  controller: coldDrinkController,
                                  cursorColor: Color(0xff7E8286),
                                  decoration: InputDecoration(
                                    icon: Image(
                                      image: AssetImage("images/bsoda.webp"),
                                      width: 23,
                                      height: 23,
                                      color: Color(0xffEF4F5F),
                                    ),
                                    hintText: "Enter Cold drink Name",
                                    hintStyle: GoogleFonts.nunito(
                                      fontSize: 17,
                                      color: Color(0xff7E8286),
                                    ),
                                    border: InputBorder.none,
                                  ),
                                  style: GoogleFonts.nunito(
                                      fontSize: 17,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w400),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          DottedDashedLine(
                              height: 1,
                              width: double.infinity,
                              axis: Axis.horizontal,
                              dashColor: Color(0xffDAD9DD),
                              strokeWidth: 1,
                              dashSpace: 3),
                          SizedBox(
                            height: 15,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10, right: 10),
                            child: Text(
                              "Price",
                              style: GoogleFonts.nunito(
                                  fontSize: 18,
                                  color: Color(0xff313848),
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10, right: 10),
                            child: Container(
                              height: 50,
                              decoration: BoxDecoration(
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(15)),
                                  color: Colors.white,
                                  border: Border.all(
                                      color: Color(0xffe7e7e7), width: 1),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Color(0xfff5f5f5),
                                        spreadRadius: 1,
                                        blurRadius: 5,
                                        blurStyle: BlurStyle.outer)
                                  ]),
                              child: Padding(
                                padding:
                                const EdgeInsets.only(left: 10, right: 10),
                                child: TextField(
                                  keyboardType: TextInputType.number,
                                  autofocus: false,
                                  controller: priceController,
                                  cursorColor: Color(0xff7E8286),
                                  decoration: InputDecoration(
                                    icon: Image(
                                      image: AssetImage("images/coin.webp"),
                                      width: 25,
                                      height: 25,
                                      color: Color(0xffEF4F5F),
                                    ),
                                    hintText: "Enter Soda Price",
                                    hintStyle: GoogleFonts.nunito(
                                      fontSize: 17,
                                      color: Color(0xff7E8286),
                                    ),
                                    border: InputBorder.none,
                                  ),
                                  style: GoogleFonts.nunito(
                                      fontSize: 17,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w400),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                          ElevatedButton(
                              style: ButtonStyle(
                                  minimumSize: MaterialStateProperty.all(
                                      Size(double.infinity, 50)),
                                  shape: MaterialStateProperty.all(
                                      const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.only(
                                              bottomRight: Radius.circular(25),
                                              bottomLeft:
                                              Radius.circular(25)))),
                                  backgroundColor: MaterialStateProperty.all(
                                      const Color(0xffEF505F))),
                              onPressed: () {
                                if (widget.editItemId == null) {
                                  addSoda();
                                } else {
                                  updateSoda(widget.editItemId);
                                }

                                Navigator.pop(context);
                              },
                              child: Text(
                                widget.editItemId==null ? "Create New Cold drink" : "Edit Cold Drink",
                                style: const TextStyle(
                                    fontSize: 16, color: Colors.white),
                              )),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 40,
              )
            ],
          ),
        ));
  }

  pickAttachment(ImageSource source) async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: source);
    if (image != null && image.path.isNotEmpty) {
      await setAttachmentImagePath(image.path);
    }
  }

  setAttachmentImagePath(String? value) async {
    selectedImagePath = value;
    setState(() {});
    if (value != null) {
      EasyLoading.show();

      try {
        String randomString = getRandomId();
        String imagePath = "ItemPhoto/$randomString.jpg";
        final profilePictureRef =
        FirebaseStorage.instance.ref().child(imagePath);
        await profilePictureRef.putFile(File(value));
        downloadImageUrl = await profilePictureRef.getDownloadURL();
        setState(() {});
        EasyLoading.dismiss();
      } on FirebaseException catch (e) {
        print("ERROR : $e");
        return;
      } catch (e) {
        print("ERROR : $e");
        return;
      }
    }
    setState(() {});
  }

  addSoda() async {
    var uuid = Uuid();
    var sodaid = uuid.v4();
    try {
      final CollectionReference categoryCollectionReference =
      FirebaseFirestore.instance.collection('coldDrink');

      EasyLoading.show();
      String docId = categoryCollectionReference.doc().id;

      Map<String, dynamic> coldDrink = {
        "restaurantName":"SodaBar",
        "id": sodaid,
        "image": downloadImageUrl,
        "price": int.parse(priceController.text),
        "name": coldDrinkController.text,
        "rating": "50 rating",
        "selectitem": 1,
        "checkadd": false,
        "foodtotal": 0,
        "foodbill": int.parse(priceController.text),
        "food": "soda",
      };

      await categoryCollectionReference.doc(docId).set(coldDrink);

      EasyLoading.dismiss();
    } catch (e) {
      print("ADD PIZZA ERROR : $e");
    }
  }

  updateSoda(FoodItemModel? editItemId) async {
    try {
      final CollectionReference categoryCollectionReference =
      FirebaseFirestore.instance.collection('coldDrink');

      EasyLoading.show();
      String? docId;

      var query =
      categoryCollectionReference.where('id', isEqualTo: editItemId?.id);

      query.get().then(
            (querySnapshot) async {
          for (var element in querySnapshot.docs) {
            docId = element.id;
            print("sdfghjkhfgdg : ${element.id}");
            Map<String, dynamic> coldDrink = {
              "restaurantName":"SodaBar",
              "id": editItemId?.id,
              "image": downloadImageUrl,
              "price": int.parse(priceController.text),
              "name": coldDrinkController.text,
              "rating": "50 rating",
              "selectitem": 1,
              "checkadd": false,
              "foodtotal": 0,
              "foodbill": int.parse(priceController.text),
              "food": "soda",
            };

            await categoryCollectionReference.doc(docId).update(coldDrink);
            EasyLoading.dismiss();
          }
        },
      );
    } catch (e) {
      print("ADD PIZZA ERROR : $e");
    }
  }
}

String getRandomId() {
  var random = Random();
  var id = "";
  for (var i = 0; i < 5; i++) {
    id += random.nextInt(10).toString();
  }

  DateTime dateTime = DateTime.now();

  return "${id}_${dateTime.millisecondsSinceEpoch}";
}

Widget createClubAppbar() {
  return SafeArea(
    child: AppBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      centerTitle: true,
      title: const Text(
        "Add New ColdDrink",
        style: TextStyle(
          fontWeight: FontWeight.w800,
          fontSize: 18,
          color: Colors.black,
        ),
      ),
    ),
  );
}

Widget textFieldLabel({required String title}) {
  return Text(
    title,
    style: const TextStyle(
      fontWeight: FontWeight.w700,
      fontSize: 15,
      color: Colors.black,
    ),
  );
}