import 'package:Pizza/Controller/LoginController.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class TrackingController extends GetxController{

  Set<Marker> markers = {};
   GoogleMapController ?googleMapController;
  LatLng deliverTarget= LatLng(10, 10);
  LatLng userTarget = LatLng(10,10);

  LoginController loginController=Get.find();

  Future determineCurrentPosition() async{
    bool serviceEnabled;
    LocationPermission locationPermission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      return Future.error("Location service is disable");
    }

    locationPermission = await Geolocator.checkPermission();
    if (locationPermission == LocationPermission.denied) {
      locationPermission = await Geolocator.requestPermission();
      if (locationPermission == LocationPermission.denied) {
        return Future.error("Location permission is disable");
      }
    }

    if (locationPermission == LocationPermission.deniedForever) {
      return Future.error("Location permission is disable forever");
    }
  }

  Future gotoSpecificPosition(LatLng position) async {
    if(googleMapController!=null){
      googleMapController!.animateCamera(CameraUpdate.newCameraPosition(
          CameraPosition(target: position, zoom: 16)));
    }
  }

/*  void defaultLocation(){
    defaultLatlng = LatLng(10, 10);
    draggedLatlng = defaultLatlng;
    cameraPosition = CameraPosition(target: defaultLatlng, zoom: 18);
    gotoUserCurrentPosition();
  }*/

  void subscribeToLocationUpdates(var order) {
    determineCurrentPosition();
    print("____________________((((((((((((((((${order['orderId']}");
    FirebaseFirestore.instance
        .collection('trackingOrder')
        .where("uid", isEqualTo: loginController.userid).where("orderId",isEqualTo:order['orderId'] )
        .snapshots()
        .listen((QuerySnapshot snapshot) {
      snapshot.docs.forEach((DocumentSnapshot doc) {

        print("------)${doc.data()}");
        double deliveryLatitude = doc['deliveryLatitude'] ;
        double deliveryLongitude = doc['deliveryLongitude'];
        deliverTarget = LatLng(deliveryLatitude, deliveryLongitude);
        print("----deliveryLatitude--------)${deliveryLatitude}");
        print("----deliveryLongitude--------)${deliveryLongitude}");
        updateDeliveryBoyMarker(deliverTarget);

        double userLatitude = doc['userLatitude'];
        double userLongitude = doc['userLongitude'];
        userTarget = LatLng(userLatitude, userLongitude);
        print("----userLatitude--------)${userLatitude}");
        print("----userLongitude--------)${userLongitude}");
        userMarker(userTarget);

        gotoSpecificPosition(deliverTarget);

      });
    });
  }

  void updateDeliveryBoyMarker(LatLng latLng) {

    markers.clear();
      markers.add(Marker(
        markerId: MarkerId("Delivery"),
        position: latLng,
        icon: BitmapDescriptor.defaultMarker,
        infoWindow: InfoWindow(title: "Delivery Boy"),
      ));

  }

  void userMarker(LatLng latLng) {

      markers.add(Marker(
        markerId: MarkerId("User"),
        position: latLng,
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
        infoWindow: InfoWindow(title: "Customer"),
      ));

  }


}