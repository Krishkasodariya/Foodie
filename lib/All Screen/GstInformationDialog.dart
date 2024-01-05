import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class GstInformationDialog extends StatefulWidget {
  const GstInformationDialog({super.key});

  @override
  State<GstInformationDialog> createState() => _GstInformationDialogState();
}

class _GstInformationDialogState extends State<GstInformationDialog> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      insetPadding: EdgeInsets.only(left: 15, right: 15),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25))),
      child: Container(
        width: double.infinity,
        height: 286,
        child: Column(children: [
          SizedBox(
            height: 15,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10,right: 10),
            child: Text(
              "Pizza has no role to play in taxes and charges being levied upon by the govt. and restaurants",
              style: GoogleFonts.lexend(
                  color: Color(0xff464F62),
                  fontSize: 14,
                  fontWeight: FontWeight.w400),
              maxLines: 2,
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10,right: 10),
            child: Column(
              children: [
                Container(
                  height: 1,
                  decoration: BoxDecoration(
                      border: Border.all(
                    color: Color(0xffDAD9DD),
                    width: 1,
                  )),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(right: 10,left: 10),
            child: Row(
              children: [
                Text(
                  "GST on item total",
                  style: GoogleFonts.lexend(
                    fontWeight: FontWeight.w500,
                    fontSize: 15,
                    color: Color(0xff313848),
                  ),
                ),
                Spacer(),
                Padding(
                  padding: const EdgeInsets.only(bottom: 5),
                  child: Row(
                    children: [
                      Image(
                        image: AssetImage("images/rupee.png"),
                        width: 16,
                        height: 16,
                        color: Color(0xff1F1F1F),
                      ),
                      Text("5.75",
                          style: GoogleFonts.lexend(
                              color: Color(0xff1F1F1F),
                              fontSize: 16,
                              fontWeight: FontWeight.w400)),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10,right: 10),
            child: Row(
              children: [
                Text(
                  "Restaurants packaging charges ",
                  style: GoogleFonts.lexend(
                    fontWeight: FontWeight.w500,
                    fontSize: 15,
                    color: Color(0xff313848),
                  ),
                ),
                Spacer(),
                Padding(
                  padding: const EdgeInsets.only(bottom: 5),
                  child: Row(
                    children: [
                      Image(
                        image: AssetImage("images/rupee.png"),
                        width: 16,
                        height: 16,
                        color: Color(0xff1F1F1F),
                      ),
                      Text("6.00",
                          style: GoogleFonts.lexend(
                              color: Color(0xff1F1F1F),
                              fontSize: 16,
                              fontWeight: FontWeight.w400)),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Padding(
            padding: const EdgeInsets.only(right: 10 ,left: 10),
            child: Row(
              children: [
                Text(
                  "Other restaurants charges ",
                  style: GoogleFonts.lexend(
                    fontWeight: FontWeight.w500,
                    fontSize: 15,
                    color: Color(0xff313848),
                  ),
                ),
                Spacer(),
                Padding(
                  padding: const EdgeInsets.only(bottom: 5),
                  child: Row(
                    children: [
                      Image(
                        image: AssetImage("images/rupee.png"),
                        width: 16,
                        height: 16,
                        color: Color(0xff1F1F1F),
                      ),
                      Text("1.25",
                          style: GoogleFonts.lexend(
                              color: Color(0xff1F1F1F),
                              fontSize: 16,
                              fontWeight: FontWeight.w400)),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10,right: 10),
            child: Column(
              children: [
                Container(
                  height: 1,
                  decoration: BoxDecoration(
                      border: Border.all(
                    color: Color(0xffDAD9DD),
                    width: 1,
                  )),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 7,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10,right: 10),
            child: Row(
              children: [
                Text(
                  "Total",
                  style: GoogleFonts.lexend(
                    fontWeight: FontWeight.w500,
                    fontSize: 15,
                    color: Color(0xff313848),
                  ),
                ),
                Spacer(),
                Padding(
                  padding: const EdgeInsets.only(bottom: 5),
                  child: Row(
                    children: [
                      Image(
                        image: AssetImage("images/rupee.png"),
                        width: 16,
                        height: 16,
                        color: Color(0xff1F1F1F),
                      ),
                      Text("13",
                          style: GoogleFonts.lexend(
                              color: Color(0xff1F1F1F),
                              fontSize: 16,
                              fontWeight: FontWeight.w400)),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 15,
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
                Navigator.pop(context);
              },
              child: Text(
                "Okay",
                style: TextStyle(fontSize: 16,color: Colors.white),
              )),
        ]),
      ),
    );
  }
}
