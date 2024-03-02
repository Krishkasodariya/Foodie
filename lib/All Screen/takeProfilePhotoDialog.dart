import 'package:Pizza/Controller/LoginController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

class takeProfilePhotoDialog extends StatefulWidget {
  const takeProfilePhotoDialog({super.key});

  @override
  State<takeProfilePhotoDialog> createState() => _takeProfilePhotoDialogState();
}

class _takeProfilePhotoDialogState extends State<takeProfilePhotoDialog> {

  LoginController logincontroller=Get.find();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 190,
      decoration: BoxDecoration(
          color: Color(0xffF4F6FA),
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(15),
              topLeft: Radius.circular(15))),
      child: Padding(
        padding: const EdgeInsets.only(
            left: 10, right: 10, top: 10),
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(15),
                  topLeft: Radius.circular(15))),
          child: Column(
            children: [
              SizedBox(
                height: 30,
              ),
              Row(
                children: [
                  Container(
                    width: 4,
                    height: 30,
                    decoration: BoxDecoration(
                        color: Color(0xffEF4F5F),
                        borderRadius: BorderRadius.all(
                            Radius.circular(5))),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Text("Change photo",
                      style: GoogleFonts.lexend(
                          color: Colors.black,
                          fontSize: 21,
                          fontWeight: FontWeight.w500)),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    logincontroller.takephoto(ImageSource.camera);
                    logincontroller.changeColor = true;
                    Navigator.pop(context);
                  });
                },
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 10, right: 10),
                  child: Container(
                    width: double.infinity,
                    height: 45,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment:
                          MainAxisAlignment.start,
                          children: [
                            Container(
                              width: 36,
                              height: 36,
                              decoration: BoxDecoration(
                                  color: Color(0xffF2F4F7),
                                  shape: BoxShape.circle),
                              child: Icon(Icons.camera,
                                  color: Color(0xff787E91)),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 5),
                              child: Text(
                                "Camera",
                                style: GoogleFonts.nunito(
                                    fontSize: 18,
                                    color: Color(0xff313848),
                                    fontWeight:
                                    FontWeight.w600),
                              ),
                            ),
                            Spacer(),
                            Icon(
                              Icons.arrow_forward_ios,
                              color: Color(0xff313848),
                              size: 17,
                            )
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Padding(
                          padding:
                          const EdgeInsets.only(left: 45),
                          child: Container(
                            width: double.infinity,
                            height: 1,
                            decoration: BoxDecoration(
                                border: Border.symmetric(
                                    horizontal: BorderSide(
                                        color:
                                        Color(0xffEAEDF3),
                                        width: 1.5))),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 10, right: 10),
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      logincontroller.takephoto(ImageSource.gallery);
                      logincontroller.changeColor = true;
                      Navigator.pop(context);
                    });
                  },
                  child: Container(
                    width: double.infinity,
                    height: 45,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 36,
                              height: 36,
                              decoration: BoxDecoration(
                                  color: Color(0xffF2F4F7),
                                  shape: BoxShape.circle),
                              child: Icon(Icons.photo,
                                  color: Color(0xff787E91)),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 5),
                              child: Text(
                                "Gallery",
                                style: GoogleFonts.nunito(
                                    fontSize: 18,
                                    color: Color(0xff313848),
                                    fontWeight:
                                    FontWeight.w600),
                              ),
                            ),
                            Spacer(),
                            Icon(
                              Icons.arrow_forward_ios,
                              color: Color(0xff313848),
                              size: 17,
                            )
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Padding(
                          padding:
                          const EdgeInsets.only(left: 45),
                          child: Container(
                            width: double.infinity,
                            height: 1,
                            decoration: BoxDecoration(
                                border: Border.symmetric(
                                    horizontal: BorderSide(
                                        color:
                                        Color(0xffEAEDF3),
                                        width: 1.5))),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
