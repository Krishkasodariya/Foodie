import 'dart:convert';
import 'dart:io';
import 'package:Pizza/ModelClass/UserModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginController extends GetxController {
  XFile? file;
  final ImagePicker picker = ImagePicker();
  String filename = DateTime.now().millisecondsSinceEpoch.toString();

  SharedPreferences? sharedPreferences;


  RxString cartName="".obs;
  RxString cartPhone="".obs;

  var changeName = "";
  var changePhoneNumber;
  var changeEmail = "";
  bool changeColor = false;
  var userid = "";
  var LoginEmail = "";
  var LoginPhone = "";
  var LoginCountryCode = "";
  var LoginIsoCode = "";
  PhoneNumber number =
      PhoneNumber(isoCode: 'IN', dialCode: "+91", phoneNumber: "");
  String imageurl = "";
  var addname = TextEditingController();
  var addemail = TextEditingController();
  var addphonenumber = TextEditingController();
  String? user;
  var phone = new TextEditingController();
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  Function? reference;
  Function? updateData;

  void AllUpdate(Function ref){
    reference = ref;
  }

  void profileUpdate(Function ref){
    updateData = ref;
  }

  Future adduserdetail(UserModel user) async {
    print("object");
    FirebaseFirestore.instance
        .collection("user")
        .doc(userid)
        .set(user.toJson())
        .then((value) => print("useradd"));
  }

  Future<void> savemodel(UserModel user) async {
    sharedPreferences = await SharedPreferences.getInstance();
    String jsonencode = jsonEncode(user.toJson());
    await sharedPreferences!.setString("savedata", jsonencode);
    print("setdata");
  }
  Future<UserModel?> getmodel() async {
    sharedPreferences = await SharedPreferences.getInstance();
    Map<String, dynamic> jsondecode =
        jsonDecode(sharedPreferences!.getString("savedata")!);
    UserModel user = UserModel.fromJson(jsondecode);
    if (jsondecode.isNotEmpty) {
      addname.text = user.name!;
      addphonenumber.text = user.phonenumber!;
      addemail.text = user.email!;
      imageurl = user.image!;
    }
    print("getdata");
    return null;
  }
  Future addphoto() async {
    if (file == null) {
      return;
    }
    Reference storage = FirebaseStorage.instance.ref();
    Reference imagedir = storage.child("images");
    Reference upload = imagedir.child(filename);
    try {
      await upload.putFile(File(file!.path));
      print("111111111111${file!.path}");
      imageurl = await upload.getDownloadURL();
      print("-----------logincontroller.imageurl----------------)${imageurl}");
      print("22222222222${file!.path}");
      reference!();
    } catch (e) {
      print('========)${e}');
    }
  }

  Future takephoto(ImageSource source) async {
    file = await picker.pickImage(source: source);
    print("-----file!.path------${file!.path}");
    addphoto();
    reference!();
  }

  Future profileData() async {
    FirebaseFirestore.instance
        .collection('user')
        .where("Uid", isEqualTo: "${userid}")
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        print("=============================================)");
        print("==========)${addname.text = doc["Name"]}");
        print("==========)${addphonenumber.text = doc["Phone"]}");
        print("==========)${addemail.text = doc["Email"]}");
        print("==========)${imageurl = doc["Image"]}");

        addname.text = doc["Name"];
        addemail.text = doc["Email"];
        addphonenumber.text = doc["Phone"];
        imageurl = doc["Image"];

        changeName = doc["Name"];
        changePhoneNumber = doc["Phone"];
        changeEmail = doc["Email"];

        cartName.value=doc["Name"];
        cartPhone.value=doc["Phone"];
        print(changePhoneNumber);
        updateData!();
      });
    });
  }

  Future Setuid(String uid) async {
    sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences!.setString("uid", uid);
  }

  Future Getuid() async {
    try {
      sharedPreferences = await SharedPreferences.getInstance();
      userid = sharedPreferences!.getString("uid")!;
    } catch (e) {
      print(e);
    }
  }

/*Future<void>getdata()async{
    userid=await Getuid();
}*/
  Future<void> logout() async {
    await GoogleSignIn().signOut();
    firebaseAuth.signOut();
    // FirebaseAuth.instance.signOut();
    addname.text = "";
    addphonenumber.text = "";
    addemail.text = "";
    imageurl = "";
    userid = "";
    LoginIsoCode = "";
    LoginPhone = "";
    LoginCountryCode = "";
    LoginEmail = "";
    phone.text = "";
    print("-----11------)${sharedPreferences!.get("savedata")}");
    print("----11-------)${sharedPreferences!.get("uid")}");
    sharedPreferences!.remove("savedata");
    sharedPreferences!.remove("uid");
    // sharedPreferences!.remove("che");
    // sharedPreferences!.remove("uid");
    // sharedPreferences!.clear();

    print("-----22------)${sharedPreferences!.get("savedata")}");
    print("----22-------)${sharedPreferences!.get("uid")}");
  }
}
