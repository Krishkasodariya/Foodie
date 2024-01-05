import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DonationBottomsheetDialog extends StatefulWidget {
  const DonationBottomsheetDialog({super.key});

  @override
  State<DonationBottomsheetDialog> createState()=> _DonationBottomsheetDialogState();
}

class _DonationBottomsheetDialogState extends State<DonationBottomsheetDialog> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 540,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(20),
            topLeft: Radius.circular(20)),
      ),
      child: Column(
        crossAxisAlignment:
        CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            height: 180,
            decoration: BoxDecoration(
              borderRadius:
              BorderRadius.only(
                  topRight: Radius
                      .circular(20),
                  topLeft:
                  Radius.circular(
                      20)),
              color: Color(0xffFFF5EC),
            ),
            child: Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                Align(
                  alignment: Alignment
                      .centerLeft,
                  child: Padding(
                    padding:
                    const EdgeInsets
                        .only(
                        left: 10),
                    child: Text(
                        "feeding india ",
                        style: GoogleFonts.oleoScript(
                            color: Color(
                                0xff1F1F1F),
                            fontSize: 20,
                            fontWeight:
                            FontWeight
                                .w500)),
                  ),
                ),
                Align(
                  alignment: Alignment
                      .centerLeft,
                  child: Padding(
                    padding:
                    const EdgeInsets
                        .only(
                        left: 40),
                    child: Text(
                        "A PIZZA GIVEBACK",
                        style: GoogleFonts.lexend(
                            color: Color(
                                0xff1F1F1F),
                            fontSize: 7,
                            fontWeight:
                            FontWeight
                                .w700)),
                  ),
                ),
                Spacer(),
                Image(
                    image: AssetImage(
                        "images/donation.jpeg")),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding:
            const EdgeInsets.only(
                right: 10, left: 10),
            child: Column(
              crossAxisAlignment:
              CrossAxisAlignment
                  .start,
              children: [
                Text(
                  "About Feeding India",
                  style:
                  GoogleFonts.lexend(
                    fontWeight:
                    FontWeight.w600,
                    fontSize: 16,
                    color:
                    Color(0xff313848),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  "It is a not-for profit social organisation working to solve hunger, malnutrition and food wastage in india",
                  style:
                  GoogleFonts.lexend(
                    fontWeight:
                    FontWeight.w400,
                    fontSize: 15,
                    color:
                    Color(0xff8F94A4),
                  ),
                  maxLines: 3,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Feeding India Donation",
                  style:
                  GoogleFonts.lexend(
                    fontWeight:
                    FontWeight.w600,
                    fontSize: 16,
                    color:
                    Color(0xff313848),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  "Your contribution will help us serve regular meals to marginalized communities across India",
                  style:
                  GoogleFonts.lexend(
                    fontWeight:
                    FontWeight.w400,
                    fontSize: 15,
                    color:
                    Color(0xff8F94A4),
                  ),
                  maxLines: 3,
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  "All donations made by Indian taxpayers are eligible for tax deduction under Section 80G of the Income Tax Act, 1961, as per the applicable statute. Accordingly,the required detais for the issuance of requisite From 10BE ('Donation Certificate') including but not limited to PAN details may be collected on behalf of Feeding India. Please refer the link https://www.feedingindia.org/terms/donor for detailed terms & conditions and timelines of Donation Certificates.",
                  style:
                  GoogleFonts.lexend(
                    fontWeight:
                    FontWeight.w400,
                    fontSize: 8,
                    color:
                    Color(0xff8F94A4),
                  ),
                  maxLines: 6,
                ),

              ],
            ),
          ),
          Spacer(),
          Padding(
            padding:
            EdgeInsets.only(left: 10, right: 10,bottom: 10),
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
                  Navigator.pop(context);
                },
                child: Text(
                  "Sound Fill Good",
                  style: TextStyle(fontSize: 16, color: Colors.white),
                )),
          ),
        ],
      ),
    );
  }
}
