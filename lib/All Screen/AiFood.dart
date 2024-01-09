

import 'package:Pizza/ModelClass/AiChatbot.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class AiFood extends StatefulWidget {
  const AiFood({super.key});

  @override
  State<AiFood> createState() => _AiFoodState();
}

class _AiFoodState extends State<AiFood> {
  TextEditingController controller = TextEditingController();

  FocusNode focusNode = FocusNode();
  List<String> inputTags = [];
  RxString response = "".obs;

  bool check=false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      /* appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(
              context,
            );
            setState(() {});
          },
          child: Icon(
            Icons.arrow_back_rounded,
            size: 25,
            color: Colors.black,
          ),
        ),
        title: Text("Cooking With AI",
            style: GoogleFonts.nunito(
                color: Color(0xff293041),
                fontSize: 20,
                fontWeight: FontWeight.w500)),
      ),*/
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.only(top: 25, left: 10, right: 10),
            child: Text(
              "Find the best recipe for cooking!",
              maxLines: 3,
              style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff313848)),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: Row(
              children: [
                Flexible(
                  flex: 1,
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(10),
                            topLeft: Radius.circular(10)),
                        color: Colors.white,
                        border: Border.all(color: Color(0xffe7e7e7), width: 1),
                        boxShadow: [
                          BoxShadow(
                              color: Color(0xfff5f5f5),
                              spreadRadius: 1,
                              blurRadius: 5,
                              blurStyle: BlurStyle.outer)
                        ]),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: TextFormField(
                        autofocus: false,
                        focusNode: focusNode,
                        controller: controller,
                        onFieldSubmitted: (value) {
                          setState(() {
                            inputTags.add(value);
                            print(inputTags);
                            print(value);
                            focusNode.requestFocus();
                          });
                          controller.clear();
                        },
                        cursorColor: Color(0xff7E8286),
                        decoration: InputDecoration(
                          icon: Image(
                            image: AssetImage("images/search.webp"),
                            width: 25,
                            height: 25,
                            color: Color(0xffEF4F5F),
                          ),
                          hintText: "Enter Ingredients...",
                          hintStyle: GoogleFonts.nunito(
                            fontSize: 17,
                            color: Color(0xff7E8286),
                          ),
                          border: InputBorder.none,
                        ),
                        style: GoogleFonts.nunito(
                            fontSize: 17,
                            color: Colors.black,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 50,
                  decoration: BoxDecoration(
                      color: Color(0xffEF4F5F),
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(10),
                          bottomRight: Radius.circular(10))),
                  child: IconButton(
                    onPressed: (){
                      setState((){
                        inputTags.add(controller.text);
                        focusNode.requestFocus();
                      });
                      controller.clear();
                      print("-----inputTags---------${inputTags}");
                    },
                    icon:Icon(
                      Icons.add,
                      color: Colors.white,
                    ),
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: Wrap(
              runSpacing: 5,
              spacing: 0,
              children: [
                for (int i = 0; i < inputTags.length; i++)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: Chip(
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      elevation: 2,
                      side: BorderSide(width: 1, color: Color(0xffEF4F5F)),
                      label: Text(inputTags[i]),
                      labelStyle: GoogleFonts.lexend(
                          fontSize: 14,
                          color: Color(0xff313848),
                          fontWeight: FontWeight.w400),
                      backgroundColor: Color(0xffFFF6F7),
                      deleteIcon:
                          Icon(Icons.close, size: 18, color: Color(0xff313848)),
                      onDeleted: () {
                        setState(() {
                          inputTags.remove(inputTags[i]);
                        });
                      },
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                    ),
                  ),
              ],
            ),
          ),


             Obx(()=> Expanded(
                child:!check?Container(
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child:
                      SingleChildScrollView(
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Text(
                              response.value,
                              style: TextStyle(fontSize: 16),
                            ),
                          )
                        ),
                  ),
                ):Lottie.asset("images/search.json",width: 180,height: 180),
                           ),
             ),


          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
            child: ElevatedButton(
                style: ButtonStyle(
                    minimumSize:
                        MaterialStateProperty.all(Size(double.infinity, 50)),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15)))),
                    backgroundColor:
                        MaterialStateProperty.all(Color(0xffEF505F))),
                onPressed: () async {
                  setState((){
                    response.value="";
                  });
                  check=true;
                  response.value=await AiChatbot().getGeminiData(inputTags,context);
                  check=false;
                },
                child: Text(
                  "Create Recipe",
                  style: TextStyle(fontSize: 16, color: Colors.white),
                )),
          ),
        ]),
      ),
    );
  }


}
