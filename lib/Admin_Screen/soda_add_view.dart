import 'dart:io';
import 'dart:math';
import 'package:Pizza/Controller/PizzaController.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_picker/image_picker.dart';
import 'custom_text_field_widget.dart';

class SodaAddView extends StatefulWidget {
  const SodaAddView({super.key});

  @override
  State<SodaAddView> createState() => _SodaAddViewState();
}

class _SodaAddViewState extends State<SodaAddView> {
  String? selectedImagePath;
  String? downloadImageUrl;

  String? selectedValue;

  List<String> items = [
    "Domino's Pizza",
    "La Pino'z Pizza",
    "LaMilanoPizzeria",
    "Pizza Hut",
    "Woklee"
  ];

  TextEditingController coldDrinkController = TextEditingController();
  TextEditingController priceController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEAE5FD),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: createClubAppbar(),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              textFieldLabel(title: 'Cold Drink Name'),
              const SizedBox(
                height: 6,
              ),
              CustomTextField(
                controller: coldDrinkController,
                hintText: "Name",
                borderWidth: 1.5,
                borderColor: Colors.black45,
                borderRadius: 5,
                backgroundColor: Colors.white,
              ),
              const SizedBox(
                height: 14,
              ),
              textFieldLabel(title: 'Cold Drink Price'),
              const SizedBox(
                height: 6,
              ),
              CustomTextField(
                controller: priceController,
                hintText: "Price",
                borderWidth: 1.5,
                borderColor: Colors.black45,
                borderRadius: 5,
                backgroundColor: Colors.white,
              ),
              const SizedBox(
                height: 14,
              ),
              textFieldLabel(title: 'Select Image'),
              const SizedBox(
                height: 6,
              ),
              selectedImagePath == null
                  ? DottedBorder(
                      borderType: BorderType.Oval,
                      dashPattern: const [5],
                      child: CircleAvatar(
                        backgroundColor: Colors.white,
                        child: IconButton(
                          onPressed: () async {
                            await pickAttachment();
                          },
                          icon: const Icon(Icons.add),
                        ),
                      ),
                    )
                  : GestureDetector(
                      onTap: () async {
                        await pickAttachment();
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(6),
                        child: Image.file(
                          File(selectedImagePath!),
                          height: 240,
                          width: double.maxFinite,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
              const SizedBox(
                height: 25,
              ),
              ElevatedButton(
                  style: ButtonStyle(
                    minimumSize: MaterialStateProperty.all(
                        const Size(double.infinity, 50)),
                    shape: MaterialStateProperty.all(
                      const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(25),
                        ),
                      ),
                    ),
                    backgroundColor: MaterialStateProperty.all(
                      const Color(0xffEF505F),
                    ),
                  ),
                  onPressed: () async {
                    await addDataFirebase();
                    const snackBar = SnackBar(
                      content: Text("Successfully Add Cold Drink"),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  },
                  child: const Text(
                    "Create Cold Drink",
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  )),
            ],
          ),
        ),
      ),
    );
  }

  pickAttachment() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null && image.path.isNotEmpty) {
      await setAttachmentImagePath(image.path);
    }
  }

  setAttachmentImagePath(String? value) async {
    selectedImagePath = value;
    setState(() {});
    if (value != null) {
      EasyLoading.show();

      try {
        String randomString = getRandomId();
        String imagePath = "profile_picture_images/$randomString.jpg";
        final profilePictureRef =
            FirebaseStorage.instance.ref().child(imagePath);
        await profilePictureRef.putFile(File(value));
        downloadImageUrl = await profilePictureRef.getDownloadURL();

        EasyLoading.dismiss();
      } on FirebaseException catch (e) {
        print("ERROR : $e");
        return;
      } catch (e) {
        print("ERROR : $e");
        return;
      }
    }
    setState(() {});
  }

  addDataFirebase() async {
    try {
      final CollectionReference categoryCollectionReference =
          FirebaseFirestore.instance.collection('coldDrink');

      EasyLoading.show();
      String docId = categoryCollectionReference.doc().id;

      Map<String, dynamic> coldDrink = {
        "id": 1,
        "image": downloadImageUrl,
        "price": int.parse(priceController.text),
        "name": coldDrinkController.text,
        "rating": "50 rating",
        "selectitem": 1,
        "checkadd": false,
        "foodtotal": 0,
        "foodbill": int.parse(priceController.text),
        "food": "soda",
      };

      await categoryCollectionReference.doc(docId).set(coldDrink);
      
      EasyLoading.dismiss();
    } catch (e) {
      print("ADD PIZZA ERROR : $e");
    }
  }
}

String getRandomId() {
  var random = Random();
  var id = "";
  for (var i = 0; i < 5; i++) {
    id += random.nextInt(10).toString();
  }

  DateTime dateTime = DateTime.now();

  return "${id}_${dateTime.millisecondsSinceEpoch}";
}

Widget createClubAppbar() {
  return SafeArea(
    child: AppBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      centerTitle: true,
      title: const Text(
        "Add New ColdDrink",
        style: TextStyle(
          fontWeight: FontWeight.w800,
          fontSize: 18,
          color: Colors.black,
        ),
      ),
    ),
  );
}

Widget textFieldLabel({required String title}) {
  return Text(
    title,
    style: const TextStyle(
      fontWeight: FontWeight.w700,
      fontSize: 15,
      color: Colors.black,
    ),
  );
}
