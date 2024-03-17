import 'dart:async';
import 'package:Pizza/Controller/GoogleMapController.dart';
import 'package:Pizza/GoogleMapData/AddressDetails.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:lottie/lottie.dart';
import 'package:google_api_headers/google_api_headers.dart';

import 'Detail_table.dart';
import 'UpdateAddressDetails.dart';

class GoogleMapScreen extends StatefulWidget {
  final List<Detail_table>? snapshot;
  int? index;

  GoogleMapScreen({super.key, this.index, this.snapshot});

  @override
  State<GoogleMapScreen> createState() => _GoogleMapScreenState();
}

class _GoogleMapScreenState extends State<GoogleMapScreen> {
  GoogleMapControllerScreen googleMapControllerscreen = Get.find();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    googleMapControllerscreen.defaultLocation();
    googleMapControllerscreen.Allupdate(ref);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xffF2F4F7),
        elevation: 0,
        title: Text("Confirm delivery location",
            style: GoogleFonts.nunito(
                color: Colors.black,
                fontSize: 19,
                fontWeight: FontWeight.w500)),
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(
              context,
            );
            setState(() {});
          },
          child: Icon(
            Icons.arrow_back_rounded,
            size: 23,
            color: Colors.black,
          ),
        ),
      ),
      body: WillPopScope(
        onWillPop: () {
          setState(() {
            googleMapControllerscreen.editAddress = false;
          });
          return Future.value(true);
        },
        child: Stack(children: [
          Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height,
            child: GoogleMap(
              //myLocationEnabled: true,
              initialCameraPosition:
                  CameraPosition(target: LatLng(10, 10), zoom: 10),
              buildingsEnabled: true,

              onMapCreated: (controller) {
                setState(() {
                  googleMapControllerscreen.googleMapController = controller;
                });
              },
              onCameraMove: (position) {
                googleMapControllerscreen.draggedLatlng = position.target;
                print("----****${googleMapControllerscreen.draggedLatlng}");
              },
              onCameraIdle: () {
                googleMapControllerscreen.getplacemark(googleMapControllerscreen.draggedLatlng);
              },

              zoomControlsEnabled: false,
              mapType: MapType.normal,
            ),
          ),
          Center(child: Lottie.asset("images/pin.json", width: 50, height: 50)),

          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: GestureDetector(
                  onTap: () async {
                    googleMapControllerscreen.gotoUserCurrentPosition();
                  },
                  child: Container(
                    width: 220,
                    height: 40,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black26,
                            blurRadius: 5,
                            spreadRadius: 1)
                      ],
                      color: Color(0xffFFF6F7),
                      border: Border.all(color: Color(0xffEF4F5F)),
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: Row(
                        children: [
                          Icon(Icons.location_searching,
                              color: Color(0xffEF4F5F), size: 20),
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Text("Use current location",
                                style: GoogleFonts.nunito(
                                    color: Color(0xffEF4F5F),
                                    fontSize: 17,
                                    fontWeight: FontWeight.w500)),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                height: 150,
                color: Colors.white,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10, top: 15),
                      child: Row(
                        children: [
                          Icon(
                            Icons.location_on_rounded,
                            color: Color(0xffEF505F),
                            size: 28,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Text(
                              "${googleMapControllerscreen.place.name}",
                              style: GoogleFonts.nunito(
                                  fontSize: 20,
                                  color: Color(0xff313848),
                                  fontWeight: FontWeight.w700),
                            ),
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
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              "${googleMapControllerscreen.place.street}, ${googleMapControllerscreen.place.subLocality}, ${googleMapControllerscreen.place.locality}",
                              style: GoogleFonts.nunito(
                                  fontSize: 14,
                                  color: Color(0xff6F6F74),
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Spacer(),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 10, right: 10, bottom: 10),
                      child: ElevatedButton(
                          style: ButtonStyle(
                              minimumSize: MaterialStateProperty.all(
                                  Size(double.infinity, 50)),
                              shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(15)))),
                              backgroundColor:
                                  MaterialStateProperty.all(Color(0xffEF505F))),
                          onPressed: () async {
                            showModalBottomSheet(
                              backgroundColor: Colors.white,
                              isScrollControlled: true,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(20),
                                    topLeft: Radius.circular(20)),
                              ),
                              context: context,
                              builder: (context) {

                                if (googleMapControllerscreen.editAddress) {
                                  if (widget.snapshot != null && widget.index != null && googleMapControllerscreen.place != null) {
                                    return UpdateAddressDetails(snapshot: widget.snapshot!, index: widget.index!,palce: googleMapControllerscreen.place);
                                  } else {
                                    return Container(child: Text('Snapshot or index is null.'),);
                                  }
                                } else {
                                  if (googleMapControllerscreen.place != null) {
                                    return AddressDetails(palce: googleMapControllerscreen.place,);
                                  } else {
                                    return Container(
                                      child: Text('Place is null.'),
                                    );
                                  }
                                }


                              },
                            );
                          },
                          child: googleMapControllerscreen.editAddress
                              ? Text(
                                  "Update Complete Address",
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.white),
                                )
                              : Text(
                                  "Enter Complete Address",
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.white),
                                )),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ]),
      ),
    );
  }

  void ref() {
    setState(() {});
  }

//=======================================================)
}
