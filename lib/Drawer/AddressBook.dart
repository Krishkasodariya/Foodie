import 'dart:ui';
import 'package:Pizza/Controller/BottomController.dart';
import 'package:Pizza/Controller/GoogleMapController.dart';
import 'package:Pizza/GoogleMapData/DetailDao.dart';
import 'package:Pizza/GoogleMapData/Detail_database.dart';
import 'package:Pizza/GoogleMapData/Detail_table.dart';
import 'package:Pizza/GoogleMapData/GoogleMapScreen.dart';
import 'package:Pizza/GoogleMapData/UpdateAddressDetails.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';

class AddressBook extends StatefulWidget {
  const AddressBook({super.key});

  @override
  State<AddressBook> createState() => _AddressBookState();
}

class _AddressBookState extends State<AddressBook> {
  BottomController bottomController = Get.find();
  late final Detaildao detaildao = Get.find();
  GoogleMapControllerScreen googleMapControllerScreen = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: googleMapControllerScreen.changeAddressHeight.value
          ? Colors.transparent
          : Color(0xffF4F6FA),
      appBar: googleMapControllerScreen.changeAddressHeight.value
          ? null
          : AppBar(
              backgroundColor: Color(0xffF2F4F7),
              elevation: 0,
              title: Text("My Address",
                  style: GoogleFonts.nunito(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.w500)),
              leading: GestureDetector(
                onTap: () {
                  Navigator.pop(
                    context,
                  );
                  setState(() {
                    googleMapControllerScreen.changeAddressHeight.value = false;

                    googleMapControllerScreen.Allupdate(ref);
                  });
                },
                child: Icon(
                  Icons.arrow_back_rounded,
                  size: 25,
                  color: Colors.black,
                ),
              ),
            ),
      body: Obx(
        () => WillPopScope(
          onWillPop: () {
            googleMapControllerScreen.changeAddressHeight.value = false;
            Navigator.pop(context);
            return Future.value(true);
          },
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: googleMapControllerScreen.changeAddressHeight.value
                ? 400
                : MediaQuery.of(context).size.height,
            child: FutureBuilder(
              future: $FloorDetaildatabase.databaseBuilder('detail.db').build(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  Get.put(snapshot.data!.detaildao);
                  return Container(
                    child: Column(
                      children: [
                        Padding(
                          padding: googleMapControllerScreen
                                  .changeAddressHeight.value
                              ? EdgeInsets.only(left: 20, top: 15, bottom: 15)
                              : EdgeInsets.all(0),
                          child: Align(
                            alignment: AlignmentDirectional.centerStart,
                            child: googleMapControllerScreen
                                    .changeAddressHeight.value
                                ? Text(
                                    "Select Address  ",
                                    style: GoogleFonts.lexend(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 18,
                                      color: Color(0xff313848),
                                    ),
                                  )
                                : Text(""),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 15, right: 15),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  PageTransition(
                                      type: PageTransitionType.rightToLeft,
                                      child: GoogleMapScreen()));
                            },
                            child: Container(
                              width: double.infinity,
                              height: 50,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20)),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Color(0xffE9E9F7),
                                        blurRadius: 10,
                                        spreadRadius: 2)
                                  ]),
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(left: 10, right: 10),
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: 15,
                                    ),
                                    Icon(
                                      Icons.add,
                                      color: Color(0xffEF4F5F),
                                    ),
                                    SizedBox(
                                      width: 15,
                                    ),
                                    Text(
                                      "Add address",
                                      style: GoogleFonts.nunito(
                                          fontSize: 18,
                                          color: Color(0xffEF4F5F),
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Expanded(
                          child: StreamBuilder<List<Detail_table>>(
                            stream: detaildao.getalldetail(),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                return ListView.separated(
                                    padding: EdgeInsets.only(bottom: 20),
                                    itemCount: snapshot.data!.length,
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding: const EdgeInsets.only(
                                            left: 15, right: 15),
                                        child: GestureDetector(
                                          onTap: () {
                                            googleMapControllerScreen.SetLocationData(
                                                "${snapshot.data![index].addresstype}",
                                                "${snapshot.data![index].area}");
                                            googleMapControllerScreen.selectAddress.value = true;
                                            googleMapControllerScreen.visibleAddress.value = true;
                                            Get.back();
                                            setState(() {});
                                          },
                                          child: Container(
                                            padding: EdgeInsets.only(
                                                top: 15, bottom: 15),
                                            width: double.infinity,
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(20))),
                                            child: Column(children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 15, right: 15),
                                                child: Row(
                                                  children: [
                                                    Icon(
                                                      CupertinoIcons.house,
                                                      size: 20,
                                                      color: Color(0xff313848),
                                                    ),
                                                    SizedBox(
                                                      width: 13,
                                                    ),
                                                    Text(
                                                      snapshot.data![index]
                                                          .addresstype,
                                                      style: GoogleFonts.nunito(
                                                          fontSize: 20,
                                                          color:
                                                              Color(0xff313848),
                                                          fontWeight:
                                                              FontWeight.w700),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Row(
                                                children: [
                                                  SizedBox(width: 48),
                                                  Flexible(
                                                    child: Container(
                                                      child: Text(
                                                        " ${snapshot.data![index].flat}, ${snapshot.data![index].area}, ${snapshot.data![index].near}",
                                                        maxLines: 2,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style:
                                                            GoogleFonts.nunito(
                                                                fontSize: 14,
                                                                color: Color(
                                                                    0xff6F6F74),
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Row(
                                                children: [
                                                  SizedBox(width: 48),
                                                  GestureDetector(
                                                    onTap: () {
                                                      showModalBottomSheet(
                                                        backgroundColor:
                                                            Colors.white,
                                                        isScrollControlled:
                                                            true,
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius.only(
                                                                  topRight: Radius
                                                                      .circular(
                                                                          20),
                                                                  topLeft: Radius
                                                                      .circular(
                                                                          20)),
                                                        ),
                                                        context: context,
                                                        builder: (context) {
                                                          return UpdateAddressDetails(
                                                              snapshot: snapshot
                                                                  .data!,
                                                              index: index);
                                                        },
                                                      );
                                                    },
                                                    child: Container(
                                                      width: 25,
                                                      height: 25,
                                                      decoration: BoxDecoration(
                                                          shape:
                                                              BoxShape.circle,
                                                          border: Border.all(
                                                              color: Color(
                                                                  0xffB3B6BF),
                                                              width: 1)),
                                                      child: Center(
                                                        child: Icon(
                                                            Icons
                                                                .mode_edit_outlined,
                                                            color: Color(
                                                                0xffEF4F5F),
                                                            size: 16),
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(width: 8),
                                                  GestureDetector(
                                                    onTap: () {
                                                      setState(() {
                                                        detaildao.deletedetail(
                                                            snapshot
                                                                .data![index]);
                                                      });
                                                    },
                                                    child: Container(
                                                      width: 25,
                                                      height: 25,
                                                      decoration: BoxDecoration(
                                                          shape:
                                                              BoxShape.circle,
                                                          border: Border.all(
                                                              color: Color(
                                                                  0xffB3B6BF),
                                                              width: 1)),
                                                      child: Center(
                                                        child: Icon(
                                                            Icons
                                                                .delete_outline_rounded,
                                                            color: Color(
                                                                0xffEF4F5F),
                                                            size: 16),
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(width: 8),
                                                  Container(
                                                    width: 25,
                                                    height: 25,
                                                    decoration: BoxDecoration(
                                                        shape: BoxShape.circle,
                                                        border: Border.all(
                                                            color: Color(
                                                                0xffB3B6BF),
                                                            width: 1)),
                                                    child: Center(
                                                        child: Image(
                                                      image: AssetImage(
                                                          "images/share1.webp"),
                                                      width: 14,
                                                      height: 14,
                                                      color: Color(0xffEF4F5F),
                                                    )),
                                                  ),
                                                  SizedBox(width: 10),
                                                ],
                                              )
                                            ]),
                                          ),
                                        ),
                                      );
                                    },
                                    separatorBuilder: (context, index) {
                                      return SizedBox(
                                        height: 10,
                                      );
                                    });
                              } else {
                                return Center(
                                    child: Text(snapshot.hasError.toString()));
                                //Center(child: CircularProgressIndicator());
                              }
                            },
                          ),
                        )
                      ],
                    ),
                  );
                } else if (snapshot.hasError) {
                  return Text(
                    "Error",
                  );
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              },
            ),
          ),
        ),
      ),
    );
  }

  void ref() {
    setState(() {});
  }
}
