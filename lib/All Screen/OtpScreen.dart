import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinput/pinput.dart';
import 'package:Pizza/All%20Screen/AddProfile.dart';
import 'package:Pizza/All%20Screen/HomeScreen.dart';
import 'package:Pizza/All%20Screen/LoginScreen.dart';
import 'package:Pizza/BottomNavigation/BottomNavigation.dart';
import 'package:Pizza/Controller/LoginController.dart';
import 'package:Pizza/Drawer/ProfileScreen.dart';
import 'package:Pizza/ModelClass/UserModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OtpScreen extends StatefulWidget{
  String country;
  var phone = TextEditingController();
  String iso;
  OtpScreen({super.key, required this.country, required this.phone,required this.iso});
  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
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
  var data;
  LoginController logincontroller=Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          "OTP Verification",
          style: GoogleFonts.aBeeZee(
              color: Color(0xff293041),
              fontSize: 18,
              fontWeight: FontWeight.w400),
        ),
        leading: Icon(Icons.arrow_back_rounded, color: Colors.black),
      ),
      body: WillPopScope(
        onWillPop: () async{
           await Get.off(LoginScrren());
           return null!;
        },
        child: Container(
          child: Column(
            children: [
              SizedBox(
                height: 50,
              ),
              Center(
                  child: Text(
                "We have sent a verification code to",
                style:
                    GoogleFonts.aBeeZee(color: Color(0xff40495D), fontSize: 16),
              )),
              Center(
                child: Text(
                  ("${widget.country + " " + widget.phone.text}"),
                  style: GoogleFonts.aBeeZee(
                      color: Color(0xff293041),
                      fontSize: 16,
                      fontWeight: FontWeight.w600),
                ),
              ),
              SizedBox(
                height: 50,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Pinput(
                  pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
                  showCursor: true,
                  length: 6,
                  animationDuration: Duration(milliseconds: 300),
                  androidSmsAutofillMethod:
                      AndroidSmsAutofillMethod.smsRetrieverApi,
                  closeKeyboardWhenCompleted: true,
                  defaultPinTheme: PinTheme(
                      width: 55,
                      height: 55,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Color(0xffDAD9DD), width: 1),
                          borderRadius: BorderRadius.all(Radius.circular(15))),
                      textStyle:
                          TextStyle(color: Color(0xff293041), fontSize: 17)),
                  focusedPinTheme: PinTheme(
                      width: 55,
                      height: 55,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Color(0xff293041), width: 1),
                          borderRadius: BorderRadius.all(Radius.circular(15))),
                      textStyle:
                          TextStyle(color: Color(0xff293041), fontSize: 17)),
                  onCompleted: (value) {
                    data = value;
                  },
                ),
              ),
              SizedBox(
                height: 50,
              ),
              Center(
                child: Text(
                  "Didn't receive code?",
                  style: GoogleFonts.aBeeZee(
                    color: Color(0xff293041),
                    fontSize: 16,
                  ),
                ),
              ),
              Column(
                children: [
                  Center(
                    child: Text(
                      "Resend",
                      style: GoogleFonts.aBeeZee(
                          color: Color(0xff293041),
                          fontSize: 16,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  Center(
                      child: Container(
                    width: 50,
                    decoration: BoxDecoration(
                        border: Border.all(color: Color(0xff293041), width: 1)),
                  ))
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: ElevatedButton(
                    style: ButtonStyle(
                        minimumSize:
                            MaterialStateProperty.all(Size(double.infinity, 60)),
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(15)))),
                        backgroundColor:
                            MaterialStateProperty.all(Color(0xffEF505F))),
                    onPressed: () {
                      phoneotp();
                      logincontroller.LoginPhone="${ widget.phone.text}";
                      logincontroller.LoginCountryCode="${ widget.country}";
                      logincontroller.LoginIsoCode="${ widget.iso}";
                    },
                    child: Text(
                      "Submit",
                      style: TextStyle(fontSize: 16,color: Colors.white),
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void phoneotp() async {
    PhoneAuthCredential credential = PhoneAuthProvider.credential(verificationId: LoginScrren.varifyphoneotp, smsCode: data);

      await FirebaseAuth.instance.signInWithCredential(credential);
      logincontroller.user=FirebaseAuth.instance.currentUser!.uid;
      // logincontroller.userid=user;
      logincontroller.Setuid(logincontroller.user!);
      print("===)${ logincontroller.user}");
      FirstTimeUserProfile();

  }

  Future FirstTimeUserProfile()async{
    logincontroller.sharedPreferences= await SharedPreferences.getInstance();

    bool check=(logincontroller.sharedPreferences!.getBool("ok")??false);
    if(check){
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => BottomNavigation()));
    }else{
      await logincontroller.sharedPreferences!.setBool('ok', true);
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) =>  AddProfile()));
    }
  }
}
