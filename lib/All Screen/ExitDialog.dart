import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ExitDialog extends StatefulWidget {
  const ExitDialog({super.key});

  @override
  State<ExitDialog> createState() => _ExitDialogState();
}

class _ExitDialogState extends State<ExitDialog> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
        backgroundColor: Colors.white,
        insetPadding: EdgeInsets.only(left: 15, right: 15),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(25))),
        child: Container(
          width: double.infinity,
          height: 350,
          child: Column(
            children: [
              SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        Navigator.pop(context);
                      });
                    },
                    child: Image(
                      image: AssetImage("images/close.webp"),
                      width: 25,
                      height: 25,
                        color: Color(0xff313848),
                    ),
                  ),
                ),
              ),

              Image(image: AssetImage("images/exit_photo.webp"),width: 150,height: 150,),
              Text("Exit App?",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Color(0xff313848),
                    fontSize: 25,
                  )),
              SizedBox(
                height: 8,
              ),
              Text("Are you sure You Want to exit?",
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    color:Color(0xff313848),
                    fontSize: 18,
                  )),
              SizedBox(
                height: 10,
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
                  onPressed: () {
                    Navigator.of(context).pop(true);
                  },
                  child: Text(
                    "Okay",
                    style: TextStyle(fontSize: 16,color: Colors.white),
                  )),

            ],
          ),
        ));
  }
}
