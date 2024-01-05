import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';

class RatingScreen extends StatefulWidget {
  const RatingScreen({super.key});

  @override
  State<RatingScreen> createState() => _RatingScreenState();
}

class _RatingScreenState extends State<RatingScreen> {

  var ratingindex = 0.0;
  @override
  Widget build(BuildContext context) {
    return Dialog(
        backgroundColor: Colors.white,
        insetPadding: EdgeInsets.only(left: 15, right: 15),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(25))),
        child: Container(
          width: double.infinity,
          height: 380,
          decoration: BoxDecoration(
              color:  Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(25)),
              //boxShadow: [BoxShadow(color: Color(0xffB8CFEA), blurRadius: 10)]
          ),
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 15),
                child: Align(
                  alignment: Alignment.centerRight,
                  child:  GestureDetector(
                    onTap: () {
                      setState(() {
                        Navigator.pop(
                            context);
                      });
                    },
                    child: Image(
                      image: AssetImage(
                          "images/close.png"),
                      width: 25,
                      height: 25,
                      color:
                      Color(0xff313848),
                    ),
                  ),
                ),
              ),
              Center(
                  child: Image(
                    image: AssetImage("images/star.png"),
                    width: 100,
                    height: 100,
                  )),
              SizedBox(
                height: 20,
              ),
              Text("Rate This App",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Color(0xff313848),
                    fontSize: 22,
                  )),
              SizedBox(
                height: 8,
              ),
              Text("Tap a star to give your rating.",
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    color: Color(0xff313848),
                    fontSize: 18,
                  )),
              SizedBox(
                height: 25,
              ),
              RatingBar.builder(
                  glow: false,
                  minRating: 1,
                  updateOnDrag: true,
                  itemSize: 50,
                  initialRating: ratingindex,
                  unratedColor: Color(0xffB1BBDA),
                  itemBuilder: (context, index) {
                    return Icon(Icons.star_rounded, color: Color(0xffFFD93B));
                  },
                  onRatingUpdate: (value) {
                    setState(() {
                      ratingindex = value;
                      print(ratingindex);
                    });
                  }),

              Spacer(),
              ElevatedButton(
                style: ButtonStyle(
                    minimumSize: MaterialStatePropertyAll(Size(double.infinity, 50)),
                    shape: MaterialStatePropertyAll(
                        RoundedRectangleBorder(
                            borderRadius:
                            BorderRadius.only(bottomRight: Radius.circular(25),bottomLeft: Radius.circular(25)))),
                    backgroundColor:
                    MaterialStatePropertyAll( Color(0xffEF4F5F),),
                    elevation: MaterialStatePropertyAll(0)),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Rating - ${ratingindex}")));
                  Navigator.pop(context);
                },
                child: Text("Rate Now",
                    style: GoogleFonts.nunito(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.white)),
              ),
            ],
          ),
        ));
  }
}
