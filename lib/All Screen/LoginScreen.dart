import 'dart:math';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:lottie/lottie.dart';
import 'package:Pizza/All%20Screen/AddProfile.dart';
import 'package:Pizza/All%20Screen/OtpScreen.dart';
import 'package:Pizza/BottomNavigation/BottomNavigation.dart';
import 'package:Pizza/Controller/LoginController.dart';
import 'package:Pizza/ModelClass/UserModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScrren extends StatefulWidget {
  static String varifyphoneotp = "";

  const LoginScrren({super.key});

  @override
  State<LoginScrren> createState() => _LoginScrrenState();
}

class _LoginScrrenState extends State<LoginScrren> {
  LoginController logincontroller = Get.find();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    logincontroller.Getuid();
    logincontroller.profileData();
    logincontroller.savemodel(UserModel(
        name: logincontroller.addname.text,
        phonenumber: logincontroller.addphonenumber.text,
        email: logincontroller.addemail.text,
        image: logincontroller.imageurl,
        uid: logincontroller.userid,
        isocode: logincontroller.LoginIsoCode,
        dialcode: logincontroller.LoginCountryCode));
    logincontroller.getmodel();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: WillPopScope(
        onWillPop: () async{
          return await true;
        },
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              Container(
                width: double.infinity,
                height: 240,
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(50),
                      bottomLeft: Radius.circular(50)),
                  child: Image(
                    image: AssetImage("images/login_back.png"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Expanded(
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  child: ListView(
                    physics: BouncingScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    children: [
                      Center(
                        child: Text(
                          "India's #1 Food Delivery \n       and Dining App",
                          style: GoogleFonts.lexend(
                              color: Colors.black,
                              fontSize: 23,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                      SizedBox(
                        height: 23,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 20, right: 20),
                              child: Container(
                                height: 1,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                  color: Color(0xffDAD9DD),
                                  width: 1,
                                )),
                              ),
                            ),
                          ),
                          Text(
                            "Log in or sign up",
                            style: GoogleFonts.nunito(
                                color: Color(0xff5F666D),
                                fontSize: 18,
                                fontWeight: FontWeight.w500),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 20, right: 20),
                              child: Container(
                                height: 1,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                  color: Color(0xffDAD9DD),
                                  width: 1,
                                )),
                              ),
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        child: Container(
                          width: double.infinity,
                          height: 55,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                              border:
                                  Border.all(color: Color(0xffc5c5c5), width: 1),
                              boxShadow: [
                                BoxShadow(
                                    color: Color(0xffeeeeee),
                                    spreadRadius: 2,
                                    blurRadius: 4,
                                    blurStyle: BlurStyle.outer)
                              ]),
                          child: Stack(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 10, right: 10),
                                child: InternationalPhoneNumberInput(
                                  onInputChanged: (value) {
                                    logincontroller.LoginCountryCode =
                                        "${value.dialCode}";
                                    logincontroller.LoginIsoCode =
                                        "${value.isoCode}";
                                    logincontroller.number = PhoneNumber(
                                        isoCode: value.isoCode,
                                        dialCode: value.dialCode,
                                        phoneNumber: logincontroller.phone.text);
                                  },
                                  initialValue: logincontroller.number,
                                  textFieldController: logincontroller.phone,
                                  selectorConfig: SelectorConfig(
                                      selectorType:
                                          PhoneInputSelectorType.BOTTOM_SHEET),
                                  inputDecoration: InputDecoration(
                                    hintText: "Enter Mobile Number",
                                    hintStyle: TextStyle(
                                      fontSize: 16,
                                      color: Colors.grey,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    border: InputBorder.none,
                                  ),
                                  textStyle: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 16),
                                  selectorTextStyle: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 16),
                                  searchBoxDecoration: InputDecoration(
                                    hintText: "Search Your Country",
                                    hintStyle: TextStyle(
                                      fontSize: 16,
                                      color: Colors.grey,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    border: InputBorder.none,
                                  ),
                                  textAlignVertical: TextAlignVertical.top,
                                  ignoreBlank: false,
                                  autoValidateMode: AutovalidateMode.disabled,
                                  cursorColor: Colors.black,
                                ),
                              ),
                              Positioned(
                                  left: 120,
                                  top: 8,
                                  bottom: 8,
                                  child: Container(
                                    height: 40,
                                    width: 1,
                                    color: Colors.black.withOpacity(0.13),
                                  ))
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        child: ElevatedButton(
                            style: ButtonStyle(
                                minimumSize: MaterialStateProperty.all(
                                    Size(double.infinity, 60)),
                                shape: MaterialStateProperty.all(
                                    RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(15)))),
                                backgroundColor:
                                    MaterialStateProperty.all(Color(0xffEF505F))),
                            onPressed: (){
                                if (logincontroller.phone.text.isEmpty){
                                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                      behavior: SnackBarBehavior.floating,
                                      backgroundColor:Color(0xffffeeee),
                                      duration: Duration(milliseconds: 2000),
                                      elevation: 5,
                                      width: 200,
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(25)),
                                      content: Center(
                                          child: Text(
                                            "Enter Phone Number",
                                            style: TextStyle(color: Color(0xffEF505F), fontSize: 16),
                                          ))));
                                }else if(logincontroller.phone.text.isNotEmpty){
                                  print("------------phone.text.isNotEmpty----");
                                  PhoneAuthentication();
                                }
                            },
                            child: Text(
                              "Continue",
                              style: TextStyle(fontSize: 16,color: Colors.white),
                            ))
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 20, right: 20),
                              child: Container(
                                height: 1,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                  color: Color(0xffDAD9DD),
                                  width: 1,
                                )),
                              ),
                            ),
                          ),
                          Text(
                            "or",
                            style: GoogleFonts.nunito(
                                color: Color(0xff5F666D),
                                fontSize: 18,
                                fontWeight: FontWeight.w500),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 20, right: 20),
                              child: Container(
                                height: 1,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                  color: Color(0xffDAD9DD),
                                  width: 1,
                                )),
                              ),
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          Spacer(),
                          GestureDetector(
                            onTap: (){
                              EasyLoading.dismiss();
                            },
                            child: Container(
                              width: 55,
                              height: 55,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15)),
                                  border: Border.all(
                                      color: Color(0xffc5c5c5), width: 1),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Color(0xffd7d7d7),
                                        spreadRadius: 0.2,
                                        blurRadius: 3,
                                        blurStyle: BlurStyle.outer)
                                  ]),
                              child: Padding(
                                padding: const EdgeInsets.all(13),
                                child: Image(
                                  image: AssetImage("images/apple.png"),
                                ),
                              ),
                            ),
                          ),
                          Spacer(),
                          GestureDetector(
                            onTap: (){
                              googlesign();
                            },
                            child: Container(
                              width: 55,
                              height: 55,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15)),
                                  border: Border.all(
                                      color: Color(0xffc5c5c5), width: 1),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Color(0xffd7d7d7),
                                        spreadRadius: 0.2,
                                        blurRadius: 3,
                                        blurStyle: BlurStyle.outer)
                                  ]),
                              child: Padding(
                                padding: const EdgeInsets.all(15),
                                child: Image(
                                  image: AssetImage("images/google.png"),
                                ),
                              ),
                            ),
                          ),
                          Spacer(),
                          Container(
                            width: 55,
                            height: 55,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15)),
                                border: Border.all(
                                    color: Color(0xffc5c5c5), width: 1),
                                boxShadow: [
                                  BoxShadow(
                                      color: Color(0xffd7d7d7),
                                      spreadRadius: 0.2,
                                      blurRadius: 3,
                                      blurStyle: BlurStyle.outer)
                                ]),
                            child: Icon(
                              Icons.more_horiz_rounded,
                              size: 35,
                            ),
                          ),
                          Spacer(),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Center(
                            child: Text(
                              "By continuing, you agree to our",
                              style: GoogleFonts.nunito(
                                  fontSize: 17,
                                  color: Color(0xff595D64),
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 30, right: 30),
                            child: Row(
                              children: [
                                Column(
                                  children: [
                                    Text(
                                      "Terms of Service",
                                      style: GoogleFonts.nunito(
                                          fontSize: 13,
                                          color: Color(0xff595D64),
                                          fontWeight: FontWeight.w400),
                                    ),
                                    Container(
                                      width: 80,
                                      height: 1,
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                        color: Color(0xffDAD9DD),
                                        width: 1,
                                      )),
                                    )
                                  ],
                                ),
                                Spacer(),
                                Column(
                                  children: [
                                    Text(
                                      "Privacy Policy",
                                      style: GoogleFonts.nunito(
                                          fontSize: 13,
                                          color: Color(0xff595D64),
                                          fontWeight: FontWeight.w400),
                                    ),
                                    Container(
                                      width: 80,
                                      height: 1,
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                        color: Color(0xffDAD9DD),
                                        width: 1,
                                      )),
                                    )
                                  ],
                                ),
                                Spacer(),
                                Column(
                                  children: [
                                    Text(
                                      "Content Policies",
                                      style: GoogleFonts.nunito(
                                          fontSize: 13,
                                          color: Color(0xff595D64),
                                          fontWeight: FontWeight.w400),
                                    ),
                                    Container(
                                      width: 80,
                                      height: 1,
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                        color: Color(0xffDAD9DD),
                                        width: 1,
                                      )),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),

                        ],
                      ),
                      SizedBox(
                        height: 20,
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future FirstTimeUserProfile() async{
    logincontroller.sharedPreferences= await SharedPreferences.getInstance();
    bool check = (logincontroller.sharedPreferences!.getBool("okk") ?? false);
    if (check){
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => BottomNavigation()));
    } else{
      await logincontroller.sharedPreferences!.setBool('okk', true);
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => AddProfile()));
    }
  }

  void PhoneAuthentication() async {
    EasyLoading.show();
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: ("${logincontroller.LoginCountryCode + logincontroller.phone.text}"),
      verificationCompleted: (phoneAuthCredential) {
        EasyLoading.dismiss();
        print("wwwwwwwwwwwwwwwwwwwwwwwwwwwwww");
      },
      verificationFailed: (error) {
        if (error.code == 'invalid-phone-number'){
          EasyLoading.dismiss();
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              behavior: SnackBarBehavior.floating,
              backgroundColor:Color(0xffffeeee),
              duration: Duration(milliseconds: 2000),
              elevation: 5,
              width: 200,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25)),
              content: Center(
                  child: Text(
                "Invalid-phone-number",
                style: TextStyle(color: Color(0xffEF505F), fontSize: 16),
              ))));
        }
      },
      codeSent: (verificationId, forceResendingToken){
        EasyLoading.dismiss();
          LoginScrren.varifyphoneotp = verificationId;
          Get.off(OtpScreen(
            iso: logincontroller.LoginIsoCode,
            country: logincontroller.LoginCountryCode,
            phone: logincontroller.phone,
          ));
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              behavior: SnackBarBehavior.floating,
              backgroundColor:Color(0xffffeeee),
              duration: Duration(milliseconds: 2000),
              elevation: 5,
              width: 200,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25)),
              content: Center(
                  child: Text(
                    "Otp Send",
                    style: TextStyle(color: Color(0xffEF505F), fontSize: 16),
                  ))));
      },
      codeAutoRetrievalTimeout: (verificationId) {},
    );
  }

  Future googlesign() async{

    EasyLoading.show();
    GoogleSignInAccount? googleuser = await GoogleSignIn().signIn();
    GoogleSignInAuthentication? authentication =
        await googleuser!.authentication;
    AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: authentication.accessToken,
        idToken: authentication.idToken);

    UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);
    FirstTimeUserProfile();

    print("======)uid${userCredential.user!.uid}======)");
    print("======)email${userCredential.user!.email}======)");

    logincontroller.Setuid(userCredential.user!.uid);

    // logincontroller.userid=userCredential.user!.uid;
    logincontroller.LoginEmail = "${userCredential.user!.email}";
    EasyLoading.dismiss();

  }
}
