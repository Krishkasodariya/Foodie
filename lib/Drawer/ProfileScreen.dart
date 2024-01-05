import 'package:Pizza/BottomNavigation/BottomNavigation.dart';
import 'package:Pizza/Controller/GoogleMapController.dart';
import 'package:Pizza/Controller/LoginController.dart';
import 'package:Pizza/ModelClass/UserModel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

class ProfileScreen extends StatefulWidget{
  const ProfileScreen({super.key});
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  PickedFile? storeimage;
  LoginController logincontroller = Get.find();
  var countrydata = "";
  GoogleMapControllerScreen googleMapControllerScreen=Get.find();
   ScrollController scrollController = ScrollController();
  FocusNode namefocusNode = FocusNode();
  FocusNode phonefocusNode = FocusNode();
  //FocusNode emailfocusNode = FocusNode();


  @override
  void initState() {
    //TODO: implement initState
    super.initState();
    logincontroller.AllUpdate(ref);
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
  Widget build(BuildContext context){
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor:googleMapControllerScreen.changeProfileHeight.value?Colors.transparent: Colors.white,
      appBar: googleMapControllerScreen.changeProfileHeight.value?
          null: AppBar(
        backgroundColor: Colors.white,
        leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
              setState(() {
                googleMapControllerScreen.changeProfileHeight.value=false;
              });
            },
            child: Icon(
              Icons.arrow_back_rounded,
              color: Colors.black,
              size: 23,
            )),
        title: Text("Complete your profile",
            style: GoogleFonts.lexend(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.w400)),
        elevation: 0,
      ),

      body: NotificationListener(
        onNotification: (notification){
          if (notification is ScrollUpdateNotification){
            namefocusNode.unfocus();
            phonefocusNode.unfocus();
          }
          return false;
        },
        child: SingleChildScrollView(
          controller: scrollController,
          physics: BouncingScrollPhysics(),
          padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: WillPopScope(
            onWillPop: (){
              Get.back();
              googleMapControllerScreen.changeProfileHeight.value=false;
              return Future.value(true);
            },
            child: Container(
              width: MediaQuery.of(context).size.width,
              height:googleMapControllerScreen.changeProfileHeight.value?500: MediaQuery.of(context).size.height,
              child: Column(
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Center(
                    child: logincontroller.imageurl.isEmpty
                        ? Container(
                            width: 110,
                            height: 110,
                            decoration: BoxDecoration(
                              color: Color(0xffE9E9F7),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.person,
                              color: Color(0xffB1BBDA),
                              size: 60,
                            ))
                        : ClipRRect(
                            borderRadius: BorderRadius.all(Radius.circular(60)),
                            child: Container(
                                width: 110,
                                height: 110,
                                decoration: BoxDecoration(
                                  color: Color(0xffE9E9F7),
                                  shape: BoxShape.circle,
                                ),
                                child: Image(
                                  image: NetworkImage(logincontroller.imageurl),
                                  fit: BoxFit.cover,
                                )),
                          ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 2),
                    child: GestureDetector(
                      onTap: () {
                        showModalBottomSheet(
                          backgroundColor: Color(0xffF4F6FA),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(20),
                                  topLeft: Radius.circular(20))),
                          context: context,
                          builder: (context) {
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
                                            logincontroller
                                                .takephoto(ImageSource.camera);
                                            logincontroller.changeColor = true;
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
                                              logincontroller
                                                  .takephoto(ImageSource.gallery);
                                              logincontroller.changeColor = true;
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
                          },
                        );
                      },
                      child: Text("Change photo",
                          style: GoogleFonts.nunito(
                              color: Color(0xffEF4F5F),
                              fontSize: 16,
                              fontWeight: FontWeight.w500)),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: Column(
                      children: [
                        TextField(
                          focusNode: namefocusNode,
                          onChanged: (value) {
                            setState(() {
                              logincontroller.changeColor = true;
                              logincontroller.changeName = value;
                            });
                          },
                          controller: logincontroller.addname,
                          decoration: InputDecoration(
                              label: Text("Name",
                                  style: TextStyle(
                                    color: Color(0xffA2A7B4),
                                  )),
                              enabledBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Color(0xffa2a7b4), width: 1),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Color(0xffEF4F5F), width: 1),
                              )),
                          style: GoogleFonts.nunito(
                              fontSize: 17,
                              fontWeight: FontWeight.w600,
                              color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  // -------------------------------)
                  Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        child: InternationalPhoneNumberInput(
                          focusNode: phonefocusNode,
                          onInputChanged: (value){
                            setState((){
                              logincontroller.changePhoneNumber = value;
                              logincontroller.changeColor = true;
                              logincontroller.LoginCountryCode = "${value.dialCode}";
                              logincontroller.LoginIsoCode = "${value.isoCode}";
                              logincontroller.number = PhoneNumber(
                                  isoCode: value.isoCode,
                                  dialCode: value.dialCode,
                                  phoneNumber: "");
                            });
                          },
                          initialValue: logincontroller.number,
                          textFieldController: logincontroller.addphonenumber,
                          selectorConfig: SelectorConfig(
                              selectorType: PhoneInputSelectorType.BOTTOM_SHEET),
                          inputDecoration: InputDecoration(
                            hintText: "Enter Mobile Number",
                            hintStyle: TextStyle(
                              fontSize: 16,
                              color: Colors.grey,
                              fontWeight: FontWeight.w500,
                            ),
                            border: InputBorder.none,
                          ),
                          textStyle: GoogleFonts.nunito(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: Colors.black),
                          selectorTextStyle: GoogleFonts.nunito(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: Colors.black),
                          searchBoxDecoration: InputDecoration(
                              enabledBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Color(0xffa2a7b4), width: 1),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Color(0xffEF4F5F), width: 1),
                              )),
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
                  Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.symmetric(
                              horizontal:
                                  BorderSide(color: Color(0xffa2a7b4), width: 0.5))),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: TextFormField(
                      //focusNode: emailfocusNode,
                      onChanged: (value) {
                        setState(() {
                          logincontroller.changeEmail = value;
                          logincontroller.changeColor = true;
                        });
                      },
                      controller: logincontroller.addemail,
                      decoration: InputDecoration(
                          label: Text("Email",
                              style: TextStyle(
                                color: Color(0xffA2A7B4),
                              )),
                          enabledBorder: UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: Color(0xffa2a7b4), width: 1),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: Color(0xffEF4F5F), width: 1),
                          )),
                      style: GoogleFonts.nunito(
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                          color: Colors.black),
                    ),
                  ),
                  Spacer(),
                  Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: ElevatedButton(
                        style: ButtonStyle(
                            minimumSize:
                                MaterialStateProperty.all(Size(double.infinity, 50)),
                            shape: MaterialStateProperty.all(RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(Radius.circular(15)))),
                            backgroundColor: logincontroller.changeColor
                                ? MaterialStateProperty.all(Color(0xffEF505F))
                                : MaterialStateProperty.all(Color(0xff9196A5))),
                        onPressed: () {
                          //print("---------)addddd");
                          if (logincontroller.addname.text.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                behavior: SnackBarBehavior.floating,
                                backgroundColor: Color(0xffffeeee),
                                duration: Duration(milliseconds: 2000),
                                elevation: 5,
                                width: 200,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25)),
                                content: Center(
                                    child: Text(
                                  "Enter Name",
                                  style: TextStyle(
                                      color: Color(0xffEF505F), fontSize: 16),
                                ))));
                          } else if (logincontroller.addphonenumber.text.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                behavior: SnackBarBehavior.floating,
                                backgroundColor: Color(0xffffeeee),
                                duration: Duration(milliseconds: 2000),
                                elevation: 5,
                                width: 200,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25)),
                                content: Center(
                                    child: Text(
                                  "Enter Phone Number",
                                  style: TextStyle(
                                      color: Color(0xffEF505F), fontSize: 16),
                                ))));
                          } else if (logincontroller.addemail.text.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                behavior: SnackBarBehavior.floating,
                                backgroundColor: Color(0xffffeeee),
                                duration: Duration(milliseconds: 2000),
                                elevation: 5,
                                width: 200,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25)),
                                content: Center(
                                    child: Text(
                                  "Enter Email",
                                  style: TextStyle(
                                      color: Color(0xffEF505F), fontSize: 16),
                                ))));
                          } else if (!RegExp(r'\S+@\S+\.\S+').hasMatch( logincontroller.changeEmail)) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                behavior: SnackBarBehavior.floating,
                                backgroundColor: Color(0xffffeeee),
                                duration: Duration(milliseconds: 2000),
                                elevation: 5,
                                width: 200,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25)),
                                content: Center(
                                    child: Text(
                                  "Invalid Email Address",
                                  style: TextStyle(
                                      color: Color(0xffEF505F), fontSize: 16),
                                ))));
                          } else if (logincontroller.imageurl.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                behavior: SnackBarBehavior.floating,
                                backgroundColor: Color(0xffffeeee),
                                duration: Duration(milliseconds: 2000),
                                elevation: 5,
                                width: 200,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25)),
                                content: Center(
                                    child: Text(
                                  "Enter Photo",
                                  style: TextStyle(
                                      color: Color(0xffEF505F), fontSize: 16),
                                ))));
                          } else {
                            logincontroller.addphoto();
                            print("1234567890poiuytrewq");
                            logincontroller.adduserdetail(UserModel(
                                name: logincontroller.addname.text,
                                dialcode: logincontroller.LoginCountryCode,
                                phonenumber: "${logincontroller.addphonenumber.text}",
                                email: logincontroller.addemail.text,
                                image: logincontroller.imageurl,
                                uid: logincontroller.userid,
                                isocode: logincontroller.LoginIsoCode));

                            print("---------)update");
                            print("---------)imageurl  ${logincontroller.imageurl}");

                            logincontroller.cartName.update((val){

                             val=logincontroller.addname.text;
                             logincontroller.cartName.value=val;

                            });

                            logincontroller.cartPhone.update((val) {
                              val=logincontroller.addphonenumber.text;
                              logincontroller.cartPhone.value=val;
                            });

                            Get.back();
                            Get.to(BottomNavigation());

                          }
                        },
                        child: Text(
                          "Update Profile",
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        )),
                  ),
                  Spacer(),
                  SizedBox(
                    height: 20,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Future updateuserdetail(UserModel user) async {
  //   FirebaseFirestore.instance
  //       .collection("user")
  //       .doc(logincontroller.userid)
  //       .update(user.toJson())
  //       .then((value) => print("useradd"));
  // }

/*  Future adduserdetail(UserModel user) async {
    print("object");
    FirebaseFirestore.instance
        .collection("user")
        .doc(logincontroller.userid)
        .set(user.toJson())
        .then((value) => print("useradd"));
  }*/

  /*Future dataofmobile() async {
    FirebaseFirestore.instance
        .collection('user')
        .where(
          "Uid",
          isEqualTo: "${logincontroller.userid}",
        )
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        // print("=============================================)");
        // print("==========)${updatename.text = doc["Name"]}");
        // print("==========)${updatephonenumber.text = doc["Phone"]}");
        // print("==========)${updateemail.text = doc["Email"]}");
        // print("==========)${imageurl=doc["Image"]}");
        setState(() {
          logincontroller.updatename.text = doc["Name"];
          logincontroller.updatephonenumber.text = doc["Phone"];
          logincontroller.updateemail.text = doc["Email"];
          logincontroller.imageurl=doc["Image"];
        });
      });
    });
  }
*/

  void ref() {
    setState(() {});
  }
}
