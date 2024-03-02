import 'package:Pizza/GoogleMapData/DetailDao.dart';
import 'package:Pizza/GoogleMapData/Detail_table.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../Controller/GoogleMapController.dart';


class AddressDetails extends StatefulWidget {
  Placemark palce;

  AddressDetails({super.key, required this.palce});

  @override
  State<AddressDetails> createState() => _AddressDetailsState();
}

class _AddressDetailsState extends State<AddressDetails> {
  late final Detaildao detaildao = Get.find();
  String order = "Myself";
  List<Address> addresstype = [
    Address(name: "Home", check: false),
    Address(name: "Work", check: false),
    Address(name: "Hotel", check: false),
    Address(name: "Other", check: false),
  ];
  late Placemark data;
  int currentindex = 0;


  GoogleMapControllerScreen googleMapControllerScreen=Get.find();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("1111");
    data = widget.palce;

    googleMapControllerScreen.flatController.text = "${data.name}";
    googleMapControllerScreen.areaController.text = "${data.street}, ${data.subLocality}, ${data.locality}";
    googleMapControllerScreen.nearController.text = "${data.thoroughfare}";

  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child:   Container(
      width: double.infinity,
      height: 500,
      decoration: BoxDecoration(
          color: Color(0xffffffff),
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(20), topLeft: Radius.circular(20))),
      child:
      Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        SizedBox(
          height: 15,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: Row(
            children: [
              Text(
                "Enter Address details",
                style: GoogleFonts.lexend(
                    color: Color(0XFF383c4a),
                    fontSize: 20,
                    fontWeight: FontWeight.w500),
              ),
              Spacer(),
              GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                    FocusScope.of(context).unfocus();
                    setState(() {});
                  },
                  child: Image(
                    image: AssetImage("images/close.webp"),
                    width: 27,
                    height: 27,
                  ))
            ],
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: Container(
            width: double.infinity,
            height: 1,
            decoration: BoxDecoration(
                border: Border.symmetric(
                    horizontal:
                    BorderSide(color: Color(0xffEAEDF3), width: 1.5))),
          ),
        ),
        SizedBox(
          height: 15,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Text(
                "Who are you ordering for?",
                style: GoogleFonts.lexend(
                    color: Color(0XFF383c4a),
                    fontSize: 15,
                    fontWeight: FontWeight.w500),
              ),
            ),
            Row(
              children: [
                Radio(
                  activeColor: Color(0xffEF4F5F),
                  value: "Myself",
                  groupValue: order,
                  onChanged: (value) {
                    setState(() {
                      order = value!;
                    });
                  },
                ),
                Text(
                  "Myself",
                  style: GoogleFonts.lexend(
                      color: Color(0XFF383c4a),
                      fontSize: 15,
                      fontWeight: FontWeight.w400),
                ),
                Radio(
                  activeColor: Color(0xffEF4F5F),
                  value: "Someone else",
                  groupValue: order,
                  onChanged: (value) {
                    setState(() {
                      order = value!;
                    });
                  },
                ),
                Text(
                  "Someone else",
                  style: GoogleFonts.lexend(
                      color: Color(0XFF383c4a),
                      fontSize: 15,
                      fontWeight: FontWeight.w400),
                ),
              ],
            ),
            SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                "Save address as:-",
                style: GoogleFonts.lexend(
                    color: Colors.black26,
                    fontSize: 15,
                    fontWeight: FontWeight.w400),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Container(
                width: double.infinity,
                height: 26,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: addresstype.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          currentindex = index;
                          print(currentindex);
                        });
                      },
                      child: Container(
                        width: 60,
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                                color: currentindex == index
                                    ? Color(0xffffc0c6)
                                    : Colors.black12,
                                blurRadius: 2,
                                spreadRadius: 0.1)
                          ],
                          color: currentindex == index
                              ? Color(0xffFFF6F7)
                              : Color(0xffffffff),
                          border: Border.all(
                              color: currentindex == index
                                  ? Color(0xffEF4F5F)
                                  : Color(0xffBCBEC5)),
                          borderRadius:
                          BorderRadius.all(Radius.circular(10)),
                        ),
                        child: Center(
                          child: Text(addresstype[index].name,
                              style: GoogleFonts.nunito(
                                  color: Color(0xff313848),
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500)),
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return SizedBox(
                      width: 5,
                    );
                  },
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Container(
                width: double.infinity,
                height: 50,
                child: TextFormField(
                  controller: googleMapControllerScreen.flatController,
                  onTap: () {},
                  decoration: InputDecoration(
                    contentPadding:
                    EdgeInsets.only(bottom: 10, left: 15, right: 10),
                    labelStyle: TextStyle(color: Colors.black),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black26),
                        borderRadius:
                        BorderRadius.all(Radius.circular(10))),
                    focusedBorder: OutlineInputBorder(
                        borderRadius:
                        BorderRadius.all(Radius.circular(10))),
                    labelText: "Flat / House no / Floor / Building ",
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Container(
                width: double.infinity,
                height: 50,
                child: TextFormField(
                  controller: googleMapControllerScreen.areaController,
                  onTap: () {},
                  decoration: InputDecoration(
                    contentPadding:
                    EdgeInsets.only(bottom: 10, left: 15, right: 10),
                    labelStyle: TextStyle(color: Colors.black),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black26),
                        borderRadius:
                        BorderRadius.all(Radius.circular(10))),
                    focusedBorder: OutlineInputBorder(
                        borderRadius:
                        BorderRadius.all(Radius.circular(10))),
                    labelText: "Area / Sector / Locality ",
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Container(
                width: double.infinity,
                height: 50,
                child: TextFormField(
                  controller: googleMapControllerScreen.nearController,
                  onTap: () {},
                  decoration: InputDecoration(
                    contentPadding:
                    EdgeInsets.only(bottom: 10, left: 15, right: 10),
                    labelStyle: TextStyle(color: Colors.black),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black26),
                        borderRadius:
                        BorderRadius.all(Radius.circular(10))),
                    focusedBorder: OutlineInputBorder(
                        borderRadius:
                        BorderRadius.all(Radius.circular(10))),
                    labelText: "Nearby landmark (optional)",
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding:
              const EdgeInsets.only(left: 10, right: 10, bottom: 10),
              child: ElevatedButton(
                  style: ButtonStyle(
                      minimumSize: MaterialStateProperty.all(
                          Size(double.infinity, 50)),
                      shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                              borderRadius:
                              BorderRadius.all(Radius.circular(15)))),
                      backgroundColor:
                      MaterialStateProperty.all(Color(0xffEF505F))),
                  onPressed: () async {
                    print("AAAAAAAAA");
                    _adddata();
                    Navigator.pop(context);
                    Navigator.pop(context);

                    print("-----)$order");
                    print("-----)${addresstype[currentindex].name}");
                  },
                  child: Text(
                    "Save Address",
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  )),
            ),
          ],
        )
      ]),
    ));
  }

  void _adddata() async {

    await detaildao.adddetail(Detail_table(
        order,
        addresstype[currentindex].name,
      googleMapControllerScreen.flatController.text,
      googleMapControllerScreen.areaController.text,
      googleMapControllerScreen.nearController.text,
        googleMapControllerScreen.draggedLatlng.latitude,
        googleMapControllerScreen.draggedLatlng.longitude,

    ));


  }
}

class Address {
  bool check = false;
  String name;

  Address({required this.name, required this.check});
}
