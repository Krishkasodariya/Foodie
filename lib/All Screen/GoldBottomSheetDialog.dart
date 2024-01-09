import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class GoldBottomSheetDialog extends StatefulWidget {
  const GoldBottomSheetDialog({super.key});

  @override
  State<GoldBottomSheetDialog> createState() => _GoldBottomSheetDialogState();
}

class _GoldBottomSheetDialogState extends State<GoldBottomSheetDialog> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 600,
      child: Column(
        crossAxisAlignment:
        CrossAxisAlignment
            .start,
        children: [
          SizedBox(height: 15),
          Padding(
            padding:
            const EdgeInsets
                .only(
                left: 10,
                right: 10),
            child: Container(
              width:
              double.infinity,
              height: 150,
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius:
                    BorderRadius.all(
                        Radius.circular(
                            20)),
                    child: Image(
                        image: AssetImage(
                            "images/gold_bk2.webp"),
                        width: double
                            .infinity,
                        height:
                        150,
                        fit: BoxFit
                            .cover),
                  ),
                  Align(
                    alignment:
                    Alignment
                        .center,
                    child: Column(
                      mainAxisAlignment:
                      MainAxisAlignment
                          .center,
                      children: [
                        Text(
                          "Pizza",
                          style: GoogleFonts
                              .calistoga(
                            fontSize:
                            23,
                            color:
                            Colors.white,
                          ),
                        ),
                        Text(
                          "GOLD",
                          style: GoogleFonts
                              .lexend(
                            fontWeight:
                            FontWeight.w600,
                            fontSize:
                            30,
                            color:
                            Color(0xff887353),
                          ),
                        ),
                        SizedBox(
                          height:
                          5,
                        ),
                        Container(
                          width:
                          150,
                          height:
                          30,
                          decoration: BoxDecoration(
                              color:
                              Color(0xff1c1c1e),
                              border: Border.all(color: Color(0xff887353), width: 1),
                              borderRadius: BorderRadius.all(Radius.circular(15))),
                          child:
                          Row(
                            mainAxisAlignment:
                            MainAxisAlignment.center,
                            children: [
                              Icon(Icons.star_rate_rounded,
                                  size: 12,
                                  color: Color(0xffF4D9A9)),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                "B E N E F I T S",
                                style: GoogleFonts.lexend(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12,
                                  color: Color(0xff887353),
                                ),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Icon(Icons.star_rate_rounded,
                                  size: 12,
                                  color: Color(0xffF4D9A9)),
                            ],
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          SizedBox(height: 15),
          Padding(
            padding:
            const EdgeInsets
                .only(
                left: 10,
                right: 10),
            child: Text(
                "Free delivery",
                style: GoogleFonts.lexend(
                    color: Color(
                        0xff1F1F1F),
                    fontSize: 16,
                    fontWeight:
                    FontWeight
                        .w600)),
          ),
          SizedBox(height: 10),
          Padding(
            padding:
            const EdgeInsets
                .only(
                right: 10,
                left: 10),
            child: Row(
              mainAxisAlignment:
              MainAxisAlignment
                  .start,
              children: [
                Column(
                  crossAxisAlignment:
                  CrossAxisAlignment
                      .start,
                  children: [
                    Text(
                      "At restaurants under 10 km, \non orders above Rs.199",
                      style: GoogleFonts
                          .lexend(
                        fontWeight:
                        FontWeight
                            .w400,
                        fontSize:
                        15,
                        color: Color(
                            0xff8F94A4),
                      ),
                    ),
                    Text(
                      "Breakfast offer | 6AM-11AM",
                      style: GoogleFonts
                          .lexend(
                        fontWeight:
                        FontWeight
                            .w500,
                        fontSize:
                        15,
                        color: Color(
                            0xff7F5410),
                      ),
                    ),
                    Text(
                      "Free delivery above Rs.149 till 31 Aug",
                      style: GoogleFonts
                          .lexend(
                        fontWeight:
                        FontWeight
                            .w400,
                        fontSize:
                        15,
                        color: Color(
                            0xff7F5410),
                      ),
                    ),
                  ],
                ),
                Spacer(),
                Container(
                    width: 50,
                    height: 50,
                    decoration:
                    BoxDecoration(
                      shape: BoxShape
                          .circle,
                      gradient: LinearGradient(colors: [Color(0xffffffff),Color(
                          0xfffff2df)]),
                      border: Border.all(
                          color: Color(
                              0xff887353),
                          width:
                          1),
                    ),
                    child: Center(
                      child:
                      Padding(
                        padding: const EdgeInsets.all(6),
                        child: Image(
                          image: AssetImage(
                              "images/gold_scooter.webp"),
                          fit: BoxFit
                              .cover,
                        ),
                      ),
                    ))
              ],
            ),
          ),

          SizedBox(height: 50,),

          Padding(
            padding:
            const EdgeInsets
                .only(
                left: 10,
                right: 10),
            child: Text(
                "On time guarantee",
                style: GoogleFonts.lexend(
                    color: Color(
                        0xff1F1F1F),
                    fontSize: 16,
                    fontWeight:
                    FontWeight
                        .w600)),
          ),
          SizedBox(height: 10),
          Padding(
            padding:
            const EdgeInsets
                .only(
                right: 10,
                left: 10),
            child: Row(
              mainAxisAlignment:
              MainAxisAlignment
                  .start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "If your order isn't on time,you \nget acouponof up to 100% \nof your order value ",
                      style: GoogleFonts.lexend(
                        fontWeight:
                        FontWeight
                            .w400,
                        fontSize:
                        15,
                        color: Color(
                            0xff8F94A4),
                      ),

                    ),

                  ],
                ),
                Spacer(),
                Container(
                    width: 50,
                    height: 50,
                    decoration:
                    BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(colors: [Color(0xffffffff),Color(
                          0xfffff2df)]),
                      border: Border.all(
                          color: Color(
                              0xff887353),
                          width:
                          1),
                    ),
                    child: Center(
                      child:
                      Padding(
                        padding: const EdgeInsets.all(6),
                        child: Image(
                          image: AssetImage(
                              "images/gold_scooter.webp"),
                          fit: BoxFit
                              .cover,
                        ),
                      ),
                    ))
              ],
            ),
          ),

          SizedBox(height: 50,),

          Padding(
            padding:
            const EdgeInsets
                .only(
                left: 10,
                right: 10),
            child: Text(
                "On time guarantee",
                style: GoogleFonts.lexend(
                    color: Color(
                        0xff1F1F1F),
                    fontSize: 16,
                    fontWeight:
                    FontWeight
                        .w600)),
          ),
          SizedBox(height: 10),
          Padding(
            padding:
            const EdgeInsets
                .only(
                right: 10,
                left: 10),
            child: Row(
              mainAxisAlignment:
              MainAxisAlignment
                  .start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "If your order isn't on time,you \nget acouponof up to 100% \nof your order value ",
                      style: GoogleFonts.lexend(
                        fontWeight:
                        FontWeight
                            .w400,
                        fontSize:
                        15,
                        color: Color(
                            0xff8F94A4),
                      ),

                    ),

                  ],
                ),
                Spacer(),
                Container(
                    width: 50,
                    height: 50,
                    decoration:
                    BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(colors: [Color(0xffffffff),Color(
                          0xfffff2df)]),
                      border: Border.all(
                          color: Color(
                              0xff887353),
                          width:
                          1),
                    ),
                    child: Center(
                      child:
                      Padding(
                        padding: const EdgeInsets.all(6),
                        child: Image(
                          image: AssetImage(
                              "images/gold_scooter.webp"),
                          fit: BoxFit
                              .cover,
                        ),
                      ),
                    ))
              ],
            ),
          )
        ],
      ),
    );
  }
}
