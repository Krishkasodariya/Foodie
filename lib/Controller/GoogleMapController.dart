import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
class GoogleMapControllerScreen extends GetxController{
  RxString area="".obs;
  RxString addresstype="".obs;
  SharedPreferences ?sharedPreferences;
  Function? reference;
  Function? update1;
  RxString draggedAddress = "".obs;
  RxBool selectAddress=false.obs;
  RxBool visibleAddress=false.obs;
  RxBool changeAddressHeight=false.obs;
  RxBool changeProfileHeight=false.obs;

  Placemark place = Placemark();
  late GoogleMapController googleMapController;
  void Allupdate(Function ref){
    reference = ref;
  }



  void HomeLocationupdate(Function ref){
    update1 = ref;
  }
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

    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    return position;
  }

  Future gotoUserCurrentPosition() async {
    Position currentposition = await determineCurrentPosition();
    gotoSpecificPosition(
        LatLng(currentposition.latitude, currentposition.longitude));
  }

  Future gotoSpecificPosition(LatLng position) async {
    googleMapController.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(target: position, zoom: 18)));

    await getplacemark(position);
  }

  Future getplacemark(LatLng position) async {
    List<Placemark> placemark =
    await placemarkFromCoordinates(position.latitude, position.longitude);

    place = placemark[0];

      String currentAddress =
          "name:-- ${place.name},locality:--  ${place.locality},postalCode:--  ${place.postalCode},country:--  ${place.country},street:-- ${place.street},subLocality:-- ${place.subLocality},administrativeArea:-- ${place.administrativeArea},subAdministrativeArea:-- ${place.subAdministrativeArea}";
      print("--------------------)$currentAddress");

      draggedAddress.value = currentAddress;
    reference!();
  }

  Future SetLocationData(String sector,String locality)async{
    sharedPreferences =await SharedPreferences.getInstance();
    await sharedPreferences!.setString("sector", sector);
    await sharedPreferences!.setString("locality", locality);
    addresstype.value=sector;
    area.value=locality;
    print("--Set--)${addresstype}");
    print("--Set--)${area}");
    // update1!();
  }

  Future GetLocationData()async{
    try{
      sharedPreferences = await SharedPreferences.getInstance();
      addresstype.value=sharedPreferences!.getString("sector")!;
      area.value=sharedPreferences!.getString("locality")!;
      print("--Get--)${addresstype}");
      print("--Get--)${area}");
      //update1!();
    }catch(e){
      print(e);
    }
  }


}