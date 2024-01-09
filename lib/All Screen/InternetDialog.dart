import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:lottie/lottie.dart';
import 'package:Pizza/Controller/PizzaController.dart';

class InternetDialog extends StatefulWidget {
  const InternetDialog({super.key});

  @override
  State<InternetDialog> createState() => _InternetDialogState();
}

class _InternetDialogState extends State<InternetDialog> {
  PizzaController pizzaController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Dialog(
        backgroundColor: Colors.white,
        insetPadding: EdgeInsets.only(left: 15, right: 15),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(25))),
        child: Container(
          width: double.infinity,
          height: 400,
          child: Column(

            children: [
              SizedBox(
                height: 15,
              ),
              Row(
              mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          Navigator.pop(context);
                        });
                      },
                      child: Align(
                        child: Image(
                          image: AssetImage("images/close.webp"),
                          width: 25,
                          height: 25,
                          color: Color(0xff313848),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 25,
              ),
              Image(
                image: AssetImage("images/internet.webp"),
                width: 150,
                height: 150,
              ),
              SizedBox(
                height: 25,
              ),
              Text("No Network Available",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Color(0xff313848),
                    fontSize: 25,
                  )),
              SizedBox(
                height: 8,
              ),
              Text(
                  "No internet connection found. Check \n                  your connection",
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    color: Color(0xff313848),
                    fontSize: 16,
                  )),
              SizedBox(
                height: 20,
              ),
              Spacer(),
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
                  onPressed: () async {
                    pizzaController.isdeviceconnected.value =
                        await InternetConnectionChecker().hasConnection;
                    Navigator.of(context).pop(true);
                    setState(() {
                      pizzaController.isalertset.value = false;
                    });

                    if (!pizzaController.isdeviceconnected.value) {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return InternetDialog();
                        },
                      );
                      setState(() {
                        pizzaController.isalertset.value = true;
                      });
                    }
                  },
                  child: Text(
                    "Refresh",
                    style: TextStyle(fontSize: 16,color: Colors.white),
                  )),
            ],
          ),
        ));
  }
}
