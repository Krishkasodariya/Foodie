import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class AdDialogScreen extends StatefulWidget {
  const AdDialogScreen({super.key});

  @override
  State<AdDialogScreen> createState() => _AdDialogScreenState();
}

class _AdDialogScreenState extends State<AdDialogScreen> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.only(
          left: 15, right: 15),
      backgroundColor: Colors.white,
      child: Container(
        width: double.infinity,
        height: 350,
        child: Column(
          children: [
            SizedBox(
              height: 15,
            ),
            Padding(
              padding:
              const EdgeInsets.only(
                  right: 10),
              child: Align(
                alignment:
                Alignment.centerRight,
                child: GestureDetector(
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
            Lottie.asset(
                "images/loading.json",
                width: 130,
                height: 130),
            Text("AD is Loading?",
                style: TextStyle(
                  fontWeight:
                  FontWeight.w600,
                  color: Color(0xff313848),
                  fontSize: 25,
                )),
            SizedBox(
              height: 8,
            ),
            Text(
                "waiting for a few second?",
                style: TextStyle(
                  fontWeight:
                  FontWeight.w400,
                  color: Color(0xff313848),
                  fontSize: 18,
                )),
            SizedBox(
              height: 10,
            ),
            Spacer(),
            ElevatedButton(
                style: ButtonStyle(
                    minimumSize:
                    MaterialStateProperty.all(
                        Size(
                            double
                                .infinity,
                            50)),
                    shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                                bottomRight:
                                Radius.circular(
                                    25),
                                bottomLeft:
                                Radius.circular(
                                    25)))),
                    backgroundColor:
                    MaterialStateProperty.all(
                        Color(0xffEF505F))),
                onPressed: () {

                },
                child: Text(
                  "Okay",
                  style: TextStyle(
                      fontSize: 16,
                      color: Colors.white),
                )),
          ],
        ),
      ),
    );
  }
}
