import 'package:Pizza/ModelClass/PizzaItemModelClass.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotted_dashed_line/dotted_dashed_line.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_fonts/google_fonts.dart';

class AddRestaurants extends StatefulWidget {
  final PizzaItemModel? restaurantDetail;

  const AddRestaurants({super.key, this.restaurantDetail});

  @override
  State<AddRestaurants> createState() => _AdminDinnerScreenState();
}

class _AdminDinnerScreenState extends State<AddRestaurants> {
  String? selectedImagePath;
  String? downloadImageUrl;

  String? selectedValue;

  TextEditingController nameController = TextEditingController();
  TextEditingController priceController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState

    nameController = TextEditingController(text: widget.restaurantDetail?.name);
    priceController = TextEditingController(text: widget.restaurantDetail?.price.toString());
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
            widget.restaurantDetail == null
                ? "Open New Restaurants"
                : "Edit Restaurant",
            style: GoogleFonts.nunito(
                color: const Color(0xff293041),
                fontSize: 20,
                fontWeight: FontWeight.w500)),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 20,
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
                  widget.restaurantDetail == null
                      ? "ADD NEW ONE"
                      : "EDIT NEW ONE",
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
                            widget.restaurantDetail == null
                                ? "Open New Restaurants"
                                : "Edit Restaurant",
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
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          child: Text(
                            "Restaurants Name",
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
                                controller: nameController,
                                cursorColor: Color(0xff7E8286),
                                decoration: InputDecoration(
                                  icon: Image(
                                    image: AssetImage("images/bank.webp"),
                                    width: 23,
                                    height: 23,
                                    color: Color(0xffEF4F5F),
                                  ),
                                  hintText: "Enter Restaurants Name",
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
                                autofocus: false,
                                controller: priceController,
                                cursorColor: Color(0xff7E8286),
                                decoration: InputDecoration(
                                  icon: const Image(
                                    image: AssetImage("images/coin.webp"),
                                    width: 25,
                                    height: 25,
                                    color: Color(0xffEF4F5F),
                                  ),
                                  hintText: "Enter Starting Price",
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
                                    const Size(double.infinity, 50)),
                                shape: MaterialStateProperty.all(
                                    const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.only(
                                            bottomRight: Radius.circular(25),
                                            bottomLeft: Radius.circular(25)))),
                                backgroundColor: MaterialStateProperty.all(
                                    const Color(0xffEF505F))),
                            onPressed: () {
                              if (widget.restaurantDetail == null) {
                                addRestauratnsData();
                              } else {
                                updateRestauratnsData(widget.restaurantDetail!);
                              }

                              Navigator.pop(context);
                            },
                            child: Text(
                              widget.restaurantDetail == null
                                  ? "Create New Restaurants"
                                  : "Edit Restaurant",
                              style: const TextStyle(
                                  fontSize: 16, color: Colors.white),
                            )),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  addRestauratnsData() async {
    try {
      final CollectionReference addCollectionReference =
      FirebaseFirestore.instance.collection('pizza');
      EasyLoading.show();

      final resData = {
        "checklike": false,
        "distance": "2km",
        "name": nameController.text,
        "price": int.parse(priceController.text),
        "foodimagelist": [],
        "rating": 3.1,
        "subname": "Pizza",
        "time": "25 - 30 min"
      };

      await addCollectionReference.doc("${nameController.text}").set(resData);

      /*await categoryCollectionReference.doc(selectedValue).update(
              {"foodimagelist": FieldValue.arrayUnion(pizzaList)},);*/

      EasyLoading.dismiss();
    } catch (e) {
      print("ADD PIZZA ERROR : $e");
    }
  }

  updateRestauratnsData(PizzaItemModel restaurantDetail) async {
    try {
      final CollectionReference addCollectionReference =
      FirebaseFirestore.instance.collection('pizza');

      EasyLoading.show();

      await addCollectionReference
          .where("name", isEqualTo: restaurantDetail.name)
          .get()
          .then((value) async {
        final resData = {
          "checklike": false,
          "distance": "2km",
          "name": nameController.text,
          "price": int.parse(priceController.text),
          "foodimagelist": value.docs[0]['foodimagelist'],
          "rating": 3.1,
          "subname": "Pizza",
          "time": "25 - 30 min"
        };
        await addCollectionReference.doc(value.docs[0].id).set(resData);

        EasyLoading.dismiss();
      });
    } catch (e) {
      print("ADD PIZZA ERROR : $e");
    }
  }
}