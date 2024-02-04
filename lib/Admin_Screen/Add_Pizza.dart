import 'dart:io';
import 'dart:math';
import 'package:Pizza/Controller/PizzaController.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotted_dashed_line/dotted_dashed_line.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

import '../All Screen/takeProfilePhotoDialog.dart';


class PizzaAddView extends StatefulWidget {
  String ?name;
   PizzaAddView({super.key,this.name});

  @override
  State<PizzaAddView> createState() => _PizzaAddViewState();
}

class _PizzaAddViewState extends State<PizzaAddView> {
  String? selectedImagePath;
  String? downloadImageUrl;

  String? selectedValue;

  TextEditingController nameController = TextEditingController();
  TextEditingController priceController = TextEditingController();

  PizzaController pizzaController=Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:  Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: GestureDetector(
          onTap: (){
            Navigator.pop(context,);
            setState(() {});
          },
          child: Icon(
            Icons.arrow_back_rounded,
            size: 25,
            color: Colors.black,
          ),
        ),

        title: Text("Create New Pizza",
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
                    padding: const EdgeInsets.only(
                        left: 10, right: 10),
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
                  "ADD NEW ONE",
                  style: GoogleFonts.nunito(
                      color: Color(0xff7e878d),
                      fontSize: 15.2,
                      fontWeight: FontWeight.w500),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 20, right: 20),
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
                            "Add New Pizza",
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
                      child: selectedImagePath == null
                          ? Container(
                          width: 110,
                          height: 110,
                          decoration: BoxDecoration(
                            color: Color(0xffE9E9F7),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.add,
                            color: Color(0xffB1BBDA),
                            size: 60,
                          ))
                          : ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(60)),
                        child: Container(
                            width: 110,
                            height: 110,
                            decoration: BoxDecoration(
                              color: Color(0xffE9E9F7),
                              shape: BoxShape.circle,
                            ),
                            child:  Image.file(
                              File(selectedImagePath!),
                              height: 240,
                              width: double.maxFinite,
                              fit: BoxFit.fill,
                            ),),
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
                                decoration: BoxDecoration(
                                    color: Color(0xffF4F6FA),
                                    borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(15),
                                        topLeft: Radius.circular(15))),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 10, right: 10, top: 10),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.only(
                                            topRight: Radius.circular(15),
                                            topLeft: Radius.circular(15))),
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          height: 30,
                                        ),
                                        Row(
                                          children: [
                                            Container(
                                              width: 4,
                                              height: 30,
                                              decoration: BoxDecoration(
                                                  color: Color(0xffEF4F5F),
                                                  borderRadius: BorderRadius.all(
                                                      Radius.circular(5))),
                                            ),
                                            SizedBox(
                                              width: 15,
                                            ),
                                            Text("Change photo",
                                                style: GoogleFonts.lexend(
                                                    color: Colors.black,
                                                    fontSize: 21,
                                                    fontWeight: FontWeight.w500)),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 15,
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              pickAttachment(ImageSource.camera);
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
                                                    MainAxisAlignment.start,
                                                    children: [
                                                      Container(
                                                        width: 36,
                                                        height: 36,
                                                        decoration: BoxDecoration(
                                                            color: Color(0xffF2F4F7),
                                                            shape: BoxShape.circle),
                                                        child: Icon(Icons.camera,
                                                            color: Color(0xff787E91)),
                                                      ),
                                                      Padding(
                                                        padding: const EdgeInsets.only(
                                                            left: 5),
                                                        child: Text(
                                                          "Camera",
                                                          style: GoogleFonts.nunito(
                                                              fontSize: 18,
                                                              color: Color(0xff313848),
                                                              fontWeight:
                                                              FontWeight.w600),
                                                        ),
                                                      ),
                                                      Spacer(),
                                                      Icon(
                                                        Icons.arrow_forward_ios,
                                                        color: Color(0xff313848),
                                                        size: 17,
                                                      )
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 5,
                                                  ),
                                                  Padding(
                                                    padding:
                                                    const EdgeInsets.only(left: 45),
                                                    child: Container(
                                                      width: double.infinity,
                                                      height: 1,
                                                      decoration: BoxDecoration(
                                                          border: Border.symmetric(
                                                              horizontal: BorderSide(
                                                                  color:
                                                                  Color(0xffEAEDF3),
                                                                  width: 1.5))),
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
                                                            color: Color(0xffF2F4F7),
                                                            shape: BoxShape.circle),
                                                        child: Icon(Icons.photo,
                                                            color: Color(0xff787E91)),
                                                      ),
                                                      Padding(
                                                        padding: const EdgeInsets.only(
                                                            left: 5),
                                                        child: Text(
                                                          "Gallery",
                                                          style: GoogleFonts.nunito(
                                                              fontSize: 18,
                                                              color: Color(0xff313848),
                                                              fontWeight:
                                                              FontWeight.w600),
                                                        ),
                                                      ),
                                                      Spacer(),
                                                      Icon(
                                                        Icons.arrow_forward_ios,
                                                        color: Color(0xff313848),
                                                        size: 17,
                                                      )
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 5,
                                                  ),
                                                  Padding(
                                                    padding:
                                                    const EdgeInsets.only(left: 45),
                                                    child: Container(
                                                      width: double.infinity,
                                                      height: 1,
                                                      decoration: BoxDecoration(
                                                          border: Border.symmetric(
                                                              horizontal: BorderSide(
                                                                  color:
                                                                  Color(0xffEAEDF3),
                                                                  width: 1.5))),
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
                            "Pizza Name",
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
                                borderRadius: BorderRadius.all(Radius.circular(15)),
                                color: Colors.white,
                                border:
                                Border.all(color: Color(0xffe7e7e7), width: 1),
                                boxShadow: [
                                  BoxShadow(
                                      color: Color(0xfff5f5f5),
                                      spreadRadius: 1,
                                      blurRadius: 5,
                                      blurStyle: BlurStyle.outer)
                                ]),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 10, right: 10),
                              child: TextField(
                                autofocus: false,
                                controller: nameController,
        
                                cursorColor: Color(0xff7E8286),
                                decoration: InputDecoration(
                                  icon: Image(
                                    image: AssetImage("images/bank.webp"),
                                    width: 23,
                                    height: 23,
                                    color: Color(0xffEF4F5F),
                                  ),
                                  hintText: "Enter Pizza Name",
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
                                borderRadius: BorderRadius.all(Radius.circular(15)),
                                color: Colors.white,
                                border:
                                Border.all(color: Color(0xffe7e7e7), width: 1),
                                boxShadow: [
                                  BoxShadow(
                                      color: Color(0xfff5f5f5),
                                      spreadRadius: 1,
                                      blurRadius: 5,
                                      blurStyle: BlurStyle.outer)
                                ]),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 10, right: 10),
                              child: TextField(
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
                                  hintText: "Enter Pizz Price",
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
                                minimumSize:
                                MaterialStateProperty.all(Size(double.infinity, 50)),
                                shape: MaterialStateProperty.all(RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                        bottomRight: Radius.circular(25),
                                        bottomLeft: Radius.circular(25)))),
                                backgroundColor:
                                MaterialStateProperty.all(Color(0xffEF505F))),
                            onPressed: () {
                              addPizza();
                              Navigator.pop(context);
                            },
                            child: Text(
                              "Create New Pizza",
                              style: TextStyle(fontSize: 16,color: Colors.white),
                            )),

                      ],
                    ),

        
                  ],
                ),
              ),
            ),


        SizedBox(
          height: 40,
        )
        
          ],
        ),
      )

    );
  }

  pickAttachment(ImageSource source) async{
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: source);
    if (image != null && image.path.isNotEmpty) {
      await setAttachmentImagePath(image.path);
    }
  }

  setAttachmentImagePath(String? value) async {
    selectedImagePath = value;
    setState(() {});
    if (value == null) {
      return;
    }
      EasyLoading.show();
      try {
        String randomString = getRandomId();
        String imagePath = "ItemPhoto/$randomString.png";
        final profilePictureRef = FirebaseStorage.instance.ref().child(imagePath);
        await profilePictureRef.putFile(File(value));
        downloadImageUrl = await profilePictureRef.getDownloadURL();
        EasyLoading.dismiss();
      } on FirebaseException catch (e) {
        print("ERROR : $e");
        return;
      } catch (e) {
        print("ERROR : $e");
        return;
      }

    setState(() {});
  }

  addPizza()async{
    try {
      var uuid = Uuid();
      var pizzaid = uuid.v4();
      final CollectionReference categoryCollectionReference = FirebaseFirestore.instance.collection('pizza');
      EasyLoading.show();
      await categoryCollectionReference.doc("${widget.name}").get().then(
        (documentSnapshot)async {
          if (documentSnapshot.exists){
            List pizzaList = documentSnapshot["foodimagelist"];
            pizzaList.add({
              "checkadd": false,
              "food": "Pizza",
              "foodbill":  int.parse(priceController.text),
              "foodtotal": 0,
              "id":pizzaid,
              "image": downloadImageUrl,
              "name": nameController.text,
              "price": int.parse(priceController.text),
              "rating": "3.1",
              "selectitem": 1,
            });
            print("11111111111111");
            print(widget.name);

            await categoryCollectionReference.doc("${widget.name}").update(
              {"foodimagelist": FieldValue.arrayUnion(pizzaList)},);

          }
        },
      );
      EasyLoading.dismiss();
    } catch (e) {
      print("ADD PIZZA ERROR : $e");
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
}





Widget textFieldLabel({required String title}){
  return Text(
    title,
    style: const TextStyle(
      fontWeight: FontWeight.w700,
      fontSize: 15,
      color: Colors.black,
    ),
  );
}
