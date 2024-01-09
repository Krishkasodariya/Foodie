
import 'package:Pizza/GoogleMapData/NetworkUtils.dart';
import 'package:Pizza/GoogleMapData/SearchLocationBottomPlace.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SearchLocation extends StatefulWidget {
  const SearchLocation({super.key});

  @override
  State<SearchLocation> createState() => _SearchLocationState();
}

const String kGoogleApiKey = 'AIzaSyBlpz67sTT_ZPj3p512jy5z-m-GJPHUd98';
class _SearchLocationState extends State<SearchLocation> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        FocusScope.of(context).unfocus();
        Navigator.pop(context);
        return null!;
      },
      child: Container(
        width: double.infinity,
        height: 600,
        decoration: BoxDecoration(
            color: Color(0xffF4F6FA),
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(20), topLeft: Radius.circular(20))),
        child: Column(
          children: [
            SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Row(
                children: [
                  Text(
                    "Select a Location",
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
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                  color: Colors.white,
                  border: Border.all(color: Color(0xffe7e7e7), width: 1),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: TextFormField(
                    autofocus: false,
                    onTap: () {},
                    cursorColor: Color(0xff7E8286),
                    decoration: InputDecoration(
                      icon: Image(
                        image: AssetImage("images/search.webp"),
                        width: 25,
                        height: 25,
                        color: Color(0xffEF4F5F),
                      ),
                      hintText: "Search the locaion",
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
              height: 15,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(20),
                        topLeft: Radius.circular(20)),
                    color: Colors.white,
                  ),
                  child: Column(children: [
                    SizedBox(
                      height: 20,
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          placeAutoComplete("Dubai");
                          print("aa");
                        });

                      },
                      child: Container(
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 20, right: 20),
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
                                  Spacer(),
                                  Icon(
                                    Icons.arrow_forward_ios,
                                    color: Color(0xff787878),
                                    size: 17,
                                  ),
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
                                        horizontal: BorderSide(
                                            color: Color(0xffEAEDF3), width: 1.5))),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    SizedBox(
                      height: 5,
                    ),
                    SearchLocationBottomPlace(
                      location: "Surat,Gujarat,India",
                      press: () {},
                    )
                  ]),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
  void placeAutoComplete(String query) async{
    Uri uri = Uri.https("maps.googleapis.com", 'maps/api/place/autocomplete/json',
        {
          "input":query,
          "key":kGoogleApiKey,
        });
    String ?response= await NetworkUtils.fetchurl(uri);
    if(response!=null){
      print("---------response------------)$response");

    }
  }
}
