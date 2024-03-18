import 'dart:async';
import 'dart:ui';
import 'package:Pizza/Controller/TrackingController.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ViewTrackingOrder extends StatefulWidget {
  var order;

  ViewTrackingOrder({super.key, this.order});

  @override
  State<ViewTrackingOrder> createState() => _ViewTrackingOrderState();
}

class _ViewTrackingOrderState extends State<ViewTrackingOrder> {
  BitmapDescriptor markerIcon = BitmapDescriptor.defaultMarker;
  TrackingController trackingController = Get.find();
  late Timer timer;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    timer=Timer.periodic(Duration(seconds: 10), (timer) {
      trackingController.subscribeToLocationUpdates(widget.order);
    });

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xffEF4F5F),
        elevation: 0,
        title: Text("Confirm delivery location",
            style: GoogleFonts.nunito(
                color: Colors.white,
                fontSize: 19,
                fontWeight: FontWeight.w500)),
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context,);
            setState(() {});
          },
          child: Icon(
            Icons.arrow_back_rounded,
            size: 23,
            color: Colors.white,
          ),
        ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: GoogleMap(
          //myLocationEnabled: true,
          initialCameraPosition: CameraPosition(target:  trackingController.deliverTarget, zoom: 15),
          buildingsEnabled: true,
          onMapCreated: (GoogleMapController controller) {
            setState(() {
              trackingController.googleMapController = controller;
            });
          },
          markers: trackingController.markers,
          zoomControlsEnabled: false,
          mapType: MapType.normal,
          //  markers: marker,
        ),
      ),
    );
  }

  void ref(){
    setState(() {

    });
  }
}
