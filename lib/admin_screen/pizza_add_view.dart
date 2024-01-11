import 'dart:io';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_picker/image_picker.dart';
import 'custom_text_field_widget.dart';

class PizzaAddView extends StatefulWidget {
  const PizzaAddView({super.key});

  @override
  State<PizzaAddView> createState() => _PizzaAddViewState();
}

class _PizzaAddViewState extends State<PizzaAddView> {
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

  TextEditingController nameController = TextEditingController();
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
              textFieldLabel(title: 'Select Shop'),
              const SizedBox(
                height: 6,
              ),
              Container(
                color: Colors.white,
                child: DropdownButton2(
                  hint: const Text(
                    'Select One',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  value: selectedValue,
                  underline: Container(),
                  items: items
                      .map(
                        (item) => DropdownMenuItem<String>(
                          value: item,
                          child: Text(
                            item,
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 15,
                            ),
                          ),
                        ),
                      )
                      .toList(),
                  onChanged: (String? value) {
                    setState(() {
                      selectedValue = value;
                    });
                  },
                  isExpanded: true,
                  iconStyleData: const IconStyleData(
                    icon: Padding(
                      padding: EdgeInsets.only(right: 12),
                      child: Icon(CupertinoIcons.chevron_down,
                          color: Colors.black),
                    ),
                    iconSize: 22,
                  ),
                  buttonStyleData: ButtonStyleData(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all(
                        color: Colors.black,
                      ),
                    ),
                    elevation: 0,
                  ),
                  dropdownStyleData: DropdownStyleData(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: Colors.white,
                      border: Border.all(
                        color: Colors.black,
                        width: 1,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 14,
              ),
              textFieldLabel(title: 'Pizza Name'),
              const SizedBox(
                height: 6,
              ),
              CustomTextField(
                controller: nameController,
                hintText: "Name",
                borderWidth: 1.5,
                borderColor: Colors.black45,
                borderRadius: 5,
                backgroundColor: Colors.white,
              ),
              const SizedBox(
                height: 14,
              ),
              textFieldLabel(title: 'Pizza Price'),
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
                     content: Text("Successfully Add Pizza"),
                   );
                   ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  },
                  child: const Text(
                    "Create Pizza",
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
        final profilePictureRef = FirebaseStorage.instance.ref().child(imagePath);
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
          FirebaseFirestore.instance.collection('pizza');

      EasyLoading.show();
      await categoryCollectionReference.doc(selectedValue).get().then(
        (documentSnapshot) async {
          if (documentSnapshot.exists) {
            List pizzaList = documentSnapshot["foodimagelist"];

            pizzaList.add({
              "checkadd": false,
              "food": "Pizza",
              "foodbill": 236,
              "foodtotal": 0,
              "id": pizzaList.length + 1,
              "image": downloadImageUrl,
              "name": nameController.text,
              "price": int.parse(priceController.text),
              "rating": 3.1,
              "selectitem": 1,
            });

            await categoryCollectionReference.doc(selectedValue).update(
              {"foodimagelist": FieldValue.arrayUnion(pizzaList)},


            );
          }
        },
      );
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
        "Create New Pizza",
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
