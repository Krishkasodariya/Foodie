import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:Pizza/All%20Screen/CartScreen.dart';
import 'package:Pizza/Controller/PizzaController.dart';
import 'package:Pizza/ModelClass/Ingredient.dart';
import 'package:Pizza/ModelClass/PizzaMeta.dart';

class CustomizePizza extends StatefulWidget {
  const CustomizePizza({super.key});

  @override
  State<CustomizePizza> createState() => _CustomizePizzaState();
}

class _CustomizePizzaState extends State<CustomizePizza>
    with TickerProviderStateMixin {
  bool checkEnabled = false;
  List<Ingredient> listofingredient = [];
  PizzaController pizzaController = Get.find();
  List<Animation> animationlist = [];

  Animation<double>? pizzaScaleAnimation;
  Animation<double>? pizzaOpacityAnimation;
  Animation<double>? pizzaBoxEnterScaleAnimation;
  Animation<double>? pizzaBoxExitScaleAnimation;
  Animation<double>? pizzaBoxGoToCartAnimation;

  BoxConstraints Width = new BoxConstraints(maxWidth: 240);
  BoxConstraints Height = new BoxConstraints(maxHeight: 240);

  AnimationController? IngredientAnimationController;
  AnimationController? RotationPizzaAnimationController;
  AnimationController? PizzaBoxAnimationController;

  double IngredientWidth = 35;
  double IngredientHeight = 35;

  GlobalKey keyPizza = GlobalKey();

  ValueNotifier valueNotifier = new ValueNotifier(false);
  OverlayEntry? overlayEntry;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    IngredientAnimationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 900));
    RotationPizzaAnimationController = AnimationController(
        vsync: this,
        duration: Duration(milliseconds: 900),
        value: Width.maxWidth);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    IngredientAnimationController!.dispose();
    RotationPizzaAnimationController!.dispose();
    PizzaBoxAnimationController!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        if (checkEnabled) {

        } else {
          checkEnabled=true;
          Navigator.pop(context);
          Navigator.pop(context);
          resetdata();
          checkEnabled=false;
        }
        return Future.value(false);
      },
      child: Scaffold(
        appBar: AppBar(
          leading: GestureDetector(
            onTap: () {
              if (checkEnabled) {

              } else {
                checkEnabled = true;
                Navigator.pop(context,);
                Navigator.pop(context);
                resetdata();
                checkEnabled = false;
              }
            },
            child: Icon(
              Icons.arrow_back_rounded,
              size: 27,
              color: Colors.black,
            ),
          ),
          toolbarHeight: 50,
          elevation: 0,
          flexibleSpace: Opacity(
            opacity: 0.1,
            child: Container(
              color: Color(0xffFFF6F7),
              child: Image(
                image: AssetImage("images/bg1.webp"),
                fit: BoxFit.cover,
                width: MediaQuery
                    .of(context)
                    .size
                    .width,
                height: 230,
              ),
            ),
          ),
          backgroundColor: CupertinoColors.white,
          title: Text("Customize Pizza",
              style: TextStyle(color: Colors.black, fontSize: 19)),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: GestureDetector(
                onTap: () {
                  if (checkEnabled) {} else {
                    checkEnabled = true;
                    Navigator.push(context, PageTransition(
                        type: PageTransitionType.rightToLeft,
                        child: CartScreen()));
                    checkEnabled = false;
                  }
                  setState(() {});
                },
                child: Container(
                    width: 38,
                    height: 38,
                    decoration: BoxDecoration(
                        color: Color(0xffE9E9F7), shape: BoxShape.circle),
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Center(
                        child: Image(
                          image: AssetImage("images/cart.webp"),
                          color: Color(0xffB1BBDA),
                        ),
                      ),
                    )),
              ),
            ),
          ],
        ),
        body: Stack(
          alignment: Alignment.center,
          children: [
            Container(
                width: MediaQuery
                    .of(context)
                    .size
                    .width,
                height: MediaQuery
                    .of(context)
                    .size
                    .height,
                child: Stack(
                  children: [
                    Container(
                      color: Color(0xffFFF6F7),
                      child: Opacity(
                        opacity: 0.2,
                        child: Image(
                          image: AssetImage("images/bg1.webp"),
                          fit: BoxFit.cover,
                          width: MediaQuery
                              .of(context)
                              .size
                              .width,
                          height: 230,
                        ),
                      ),
                    ),
                    Column(
                      children: [
                        Container(
                          width: MediaQuery
                              .of(context)
                              .size
                              .width,
                          height: MediaQuery
                              .of(context)
                              .size
                              .height / 5,
                        ),
                        Expanded(
                          child: Container(
                            width: MediaQuery
                                .of(context)
                                .size
                                .width,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(30),
                                  topRight: Radius.circular(30)),
                              boxShadow: [
                                BoxShadow(
                                    color: Color(0xffffbcc2),
                                    blurRadius: 5,
                                    blurStyle: BlurStyle.outer)
                              ],
                            ),
                            child: ListView(
                              children: [
                                Column(
                                  children: [
                                    SizedBox(
                                      height: 150,
                                    ),
                                    Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 15, right: 15),
                                          child: Text(
                                            "Customize pizza",
                                            style: GoogleFonts.nunito(
                                                color: Color(0xff293041),
                                                fontSize: 20,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ),
                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 10, right: 20),
                                            child: Container(
                                              height: 1,
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                    color: Color(0xffd5d5d5),
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
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment
                                          .center,
                                      children: [
                                        Image(
                                          image: AssetImage(
                                              "images/rupee.webp"),
                                          width: 19,
                                          height: 19,
                                          color: Color(0xff1F1F1F),
                                        ),
                                        Text("${pizzaController.total.value}",
                                            style: GoogleFonts.nunito(
                                                color: Color(0xff1F1F1F),
                                                fontSize: 20,
                                                fontWeight: FontWeight.w600)),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Center(
                                      child: Container(
                                        width: 140,
                                        height: 50,
                                        child: Align(
                                          child: ListView.separated(
                                            itemCount: pizzaController
                                                .customizepizzalist[0]
                                                .pizzasizelist!
                                                .length,
                                            scrollDirection: Axis.horizontal,
                                            itemBuilder: (context, index) {
                                              return GestureDetector(
                                                onTap: () =>
                                                checkEnabled
                                                    ? null
                                                    : FunctionSize(index),
                                                child: Container(
                                                  width: 40,
                                                  height: 40,
                                                  decoration: pizzaController
                                                      .sizeindex == index
                                                      ? BoxDecoration(
                                                      color:
                                                      Color(0xffececec),
                                                      shape: BoxShape.circle)
                                                      : BoxDecoration(
                                                      shape: BoxShape.circle),
                                                  child: Center(
                                                      child: Text(
                                                        pizzaController
                                                            .customizepizzalist[0]
                                                            .pizzasizelist![index]
                                                            .name,
                                                        style: TextStyle(
                                                            color: pizzaController
                                                                .sizeindex ==
                                                                index
                                                                ? Colors.brown
                                                                : Colors.black,
                                                            fontWeight:
                                                            pizzaController
                                                                .sizeindex ==
                                                                index
                                                                ? FontWeight
                                                                .w500
                                                                : FontWeight
                                                                .w100,
                                                            fontSize:
                                                            pizzaController
                                                                .sizeindex ==
                                                                index
                                                                ? 16
                                                                : 14),
                                                      )),
                                                ),
                                              );
                                            },
                                            separatorBuilder: (context, index) {
                                              return SizedBox(
                                                width: 10,
                                              );
                                            },
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 10, right: 10),
                                      child: Container(
                                        width: double.infinity,
                                        height: 60,
                                        child: ListView.separated(
                                          itemCount: pizzaController
                                              .customizepizzalist[0]
                                              .ingredients!.length,
                                          scrollDirection: Axis.horizontal,
                                          itemBuilder: (context, index) {
                                            final child = GestureDetector(
                                              onTap: () =>
                                              checkEnabled
                                                  ? null
                                                  : FunctionIngredient(index),
                                              child: Container(
                                                width: 50,
                                                height: 50,
                                                decoration: BoxDecoration(
                                                    color: Color(0xfff5eed3),
                                                    shape: BoxShape.circle,
                                                    border: pizzaController
                                                        .customizepizzalist[0]
                                                        .ingredients![index]
                                                        .checkIngredient
                                                        ? Border.all(
                                                        color: Colors.red,
                                                        width: 2)
                                                        : Border.all(
                                                        color:
                                                        Color(0xfff5eed3),
                                                        width: 2)),
                                                child: Center(
                                                  child: Padding(
                                                    padding:
                                                    const EdgeInsets.all(4.0),
                                                    child: Image(
                                                      image: AssetImage(
                                                          "${pizzaController
                                                              .customizepizzalist[0]
                                                              .ingredients![index]
                                                              .image}"),
                                                      width: 50,
                                                      height: 50,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            );

                                            return Draggable<Ingredient>(
                                                child: child,
                                                feedback: child,
                                                data: pizzaController
                                                    .customizepizzalist[0]
                                                    .ingredients![index]);
                                          },
                                          separatorBuilder:
                                              (BuildContext context,
                                              int index) {
                                            return SizedBox(
                                              width: 12,
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 10, right: 10),
                                      child: ElevatedButton(
                                          style: ButtonStyle(
                                              minimumSize: MaterialStateProperty
                                                  .all(
                                                  Size(double.infinity, 50)),
                                              shape: MaterialStateProperty.all(
                                                  RoundedRectangleBorder(
                                                      borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(
                                                              25)))),
                                              backgroundColor:
                                              MaterialStateProperty.all(
                                                  Color(0xffEF505F))),
                                          onPressed: checkEnabled
                                              ? null
                                              : FunctionAddToCraft,
                                          child: Text(
                                            "Add to Cart",
                                            style: TextStyle(fontSize: 16,
                                                color: Colors.white),
                                          )),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                )),
            Positioned(
              top: 10,
              child: Align(
                alignment: Alignment.topCenter,
                child: Column(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    AnimatedOpacity(
                      duration: Duration(milliseconds: 50),
                      opacity: pizzaController.pizzaMeta != null ? 0 : 1,
                      child: RepaintBoundary(
                        key: keyPizza,
                        child: LayoutBuilder(
                          builder: (context, constraints) {
                            return Column(
                              //child column  -------------------------------)
                              children: [
                                Stack(
                                  children: [
                                    Container(
                                      width: Width.maxWidth,
                                      height: Height.maxHeight,
                                      child: DragTarget<Ingredient>(
                                        onAccept: (value) {
                                          setState(() {
                                            valueNotifier.value = true;
                                            addIngredient(value);
                                            value.checkIngredient = true;
                                            print("===============)${value.checkIngredient}}");
                                            //  print(listofingredient.length);
                                            Future.delayed(Duration(milliseconds: 1000));
                                            valueNotifier.value = false;
                                            print("===)onAccept");
                                            addpizzaAnimation();
                                            IngredientAnimationController!.forward(from: 0.0);
                                          });
                                        },
                                        onWillAccept: (value) {
                                          setState(() {});
                                          valueNotifier.value = true;
                                          print("===)onWillAccept");

                                          for (Ingredient i in listofingredient) {
                                            if (i.compare(value!)) {
                                              return false;
                                            }
                                          }
                                          return true;
                                        },
                                        onLeave: (value) {
                                          setState(() {});
                                          valueNotifier.value = false;
                                          print("===)onLeave");
                                        },
                                        builder: (context, candidateData, rejectedData) {
                                          return ValueListenableBuilder(
                                            valueListenable: valueNotifier,
                                            builder: (context, value, child) {
                                              return LayoutBuilder(
                                                builder: (context,
                                                    constraints) {
                                                  Width = constraints;
                                                  Height = constraints;
                                                  return RotationTransition(
                                                    turns: CurvedAnimation(
                                                        parent:
                                                        RotationPizzaAnimationController!,
                                                        curve:
                                                        Curves.fastOutSlowIn),
                                                    child: Stack(
                                                      alignment: Alignment
                                                          .center,
                                                      children: [
                                                        Image(
                                                          image: AssetImage(
                                                              "images/dish.webp"),
                                                          width: valueNotifier.value
                                                              ? Width.maxWidth
                                                              : Width.maxWidth -
                                                              10,
                                                          height: valueNotifier
                                                              .value
                                                              ? Height.maxHeight
                                                              : Height
                                                              .maxHeight -
                                                              10,
                                                          fit: BoxFit.cover,
                                                        ),
                                                        Image(
                                                          image: AssetImage(
                                                              "images/pizza.webp"),
                                                          width: valueNotifier
                                                              .value
                                                              ? Width.maxWidth
                                                              : Width.maxWidth -
                                                              10,
                                                          height: valueNotifier
                                                              .value
                                                              ? Height.maxHeight
                                                              : Height
                                                              .maxHeight -
                                                              10,
                                                          fit: BoxFit.cover,
                                                        ),
                                                      ],
                                                    ),
                                                  );
                                                },
                                              );
                                            },
                                          );
                                        },
                                      ),
                                    ),
                                    AnimatedBuilder(
                                      animation: IngredientAnimationController!,
                                      builder:
                                          (BuildContext context,
                                          Widget? child) {
                                        return buidPizza();
                                      },
                                    )
                                  ],
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget buidPizza() {
    List<Widget> elements = [];

    if (animationlist.isNotEmpty) {
      for (int i = 0; i < listofingredient.length; i++) {
        Ingredient ingredient = listofingredient[i];

        for (int j = 0; j < ingredient.position.length; j++) {
          final animation = animationlist[j];
          final position = ingredient.position[j];
          final positionx = position.dx;
          final positiony = position.dy;

          if (i == listofingredient.length - 1 &&
              IngredientAnimationController!.isAnimating) {
            double fromx = 0.0,
                fromy = 0.0;
            if (j < 1) {
              fromx = -Width.maxWidth * (1 - animation.value);
            } else if (j < 2) {
              fromx = Width.maxWidth * (1 - animation.value);
            } else if (j < 4) {
              fromy = -Height.maxHeight * (1 - animation.value);
            } else {
              fromy = Height.maxHeight * (1 - animation.value);
            }

            if (animation.value > 0) {
              elements.add(Transform(
                transform: Matrix4.identity()
                  ..translate(fromx + Width.maxWidth * positionx,
                      fromy + Height.maxHeight * positiony),
                child: Image.asset(
                  ingredient.image,
                  width: IngredientWidth,
                  height: IngredientHeight,
                ),
              ));
            }
          } else {
            elements.add(Transform(
              transform: Matrix4.identity()
                ..translate(
                    Width.maxWidth * positionx, Height.maxHeight * positiony),
              child: Image.asset(
                ingredient.image,
                width: IngredientWidth,
                height: IngredientHeight,
              ),
            ));
          }
        }
      }
      return Stack(
        children: elements,
      );
    }
    return SizedBox.fromSize();
  }

  void addpizzaAnimation() {
    animationlist.clear();
    animationlist.add(CurvedAnimation(
        parent: IngredientAnimationController!,
        curve: Interval(0.0, 0.8, curve: Curves.decelerate)));
    animationlist.add(CurvedAnimation(
        parent: IngredientAnimationController!,
        curve: Interval(0.2, 0.8, curve: Curves.decelerate)));
    animationlist.add(CurvedAnimation(
        parent: IngredientAnimationController!,
        curve: Interval(0.4, 1.0, curve: Curves.decelerate)));
    animationlist.add(CurvedAnimation(
        parent: IngredientAnimationController!,
        curve: Interval(0.1, 0.7, curve: Curves.decelerate)));
    animationlist.add(CurvedAnimation(
        parent: IngredientAnimationController!,
        curve: Interval(0.3, 1.0, curve: Curves.decelerate)));
  }

  void addIngredient(Ingredient ingredient) {
    setState(() {
      listofingredient.add(ingredient);
      pizzaController.total.value += 10;
    });
  }

  void removeIngredient(Ingredient ingredient) {
    setState(() {
      listofingredient.remove(ingredient);
      pizzaController.total.value -= 10;
    });
  }

  Future<void> pizzaBoxAnimationFunction() async {
    RenderRepaintBoundary boundary = await keyPizza.currentContext!
        .findRenderObject() as RenderRepaintBoundary;
    ui.Image image = await boundary.toImage(pixelRatio: 3.0);
    ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    setState(() {
      pizzaController.position = boundary.localToGlobal(Offset.zero);
      pizzaController.size = boundary.size;
      pizzaController.imagedata = byteData!.buffer.asUint8List();

      print("------pizzaController.imagedata-----${pizzaController.imagedata}");

      pizzaController.pizzaSize = pizzaController.customizepizzalist[0].pizzasizelist![pizzaController.sizeindex.value].name;
      pizzaController.base64=base64Encode(pizzaController.imagedata);


      pizzaController.pizzaMeta = PizzaMeta(
          pizzaSize: pizzaController.pizzaSize,
          customPizzametaSize: pizzaController.size,
          customPizzametaUint8list: pizzaController.imagedata,
          customPizzametaPosition: pizzaController.position,
          customPizzametaPrice: pizzaController.customizepizzatotal.value,
          customPizzametaSelectitem: 1,
          customPizzametaTotal: 0,
          base64:pizzaController.base64,
          customPizzametaBill: pizzaController.customizepizzatotal.value);

      pizzaController.custompizzaAdd();
      print("------ pizzaController.base64-----${ pizzaController.base64}");
    });

    print("=====getimagebytedata=====");
    setState(() {
      if (overlayEntry == null) {
        print("=====overlayEntry=====");
        overlayEntry = OverlayEntry(
          builder: (context) {
            //final pizzaMeta = this.pizzaController.pizzaMeta;
            if (pizzaController.pizzaMeta != null) {
              return Positioned(
                width: pizzaController.pizzaMeta!.customPizzametaSize!.width,
                height: pizzaController.pizzaMeta!.customPizzametaSize!.height,
                left: pizzaController.pizzaMeta!.customPizzametaPosition!.dx,
                top: pizzaController.pizzaMeta!.customPizzametaPosition!.dy,
                child: AnimatedBuilder(
                  animation: PizzaBoxAnimationController!,
                  builder: (context, child) {
                    final moveTox = pizzaBoxGoToCartAnimation!.value > 0
                        ? pizzaController.pizzaMeta!.customPizzametaPosition
                        !.dx +
                        pizzaController.pizzaMeta!.customPizzametaSize!.width /
                            2 *
                            pizzaBoxGoToCartAnimation!.value
                        : 0.0;
                    final moveToy = pizzaBoxGoToCartAnimation!.value > 0
                        ? -pizzaController.pizzaMeta!.customPizzametaSize
                        !.height /
                        1.5 *
                        pizzaBoxGoToCartAnimation!.value
                        : 0.0;
                    return Opacity(
                      opacity: 1 - pizzaBoxGoToCartAnimation!.value,
                      child: Transform(
                        transform: Matrix4.identity()
                          ..scale(pizzaBoxExitScaleAnimation!.value)
                          ..translate(moveTox, moveToy)
                          ..rotateZ(pizzaBoxGoToCartAnimation!.value),
                        alignment: Alignment.center,
                        child: Transform.scale(
                          alignment: Alignment.center,
                          scale: 1 - pizzaBoxGoToCartAnimation!.value,
                          child: Stack(
                            children: [
                              build_box(),
                              Opacity(
                                opacity: 1 - pizzaOpacityAnimation!.value,
                                child: Transform(
                                  transform: Matrix4.identity()
                                    ..scale(pizzaScaleAnimation!.value)
                                    ..translate(
                                        0.0,
                                        25 * (1 - pizzaOpacityAnimation!.value)),
                                  alignment: Alignment.center,
                                  child: Image(
                                    image: MemoryImage(
                                        pizzaController.pizzaMeta!
                                            .customPizzametaUint8list!),
                                    width: 260,
                                    height: 260,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              );
            } else {
              return Container(
                width: 200,
                height: 200,
                // color: Colors.red,
              );
            }
          },
        );
        Overlay.of(context).insert(overlayEntry!);
      }
    });
  }

  Widget build_box() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final boxwidth = constraints.maxWidth / 2;
        final boxheight = constraints.maxHeight / 2;
        final boxClosingvalue =
        ui.lerpDouble(-45.0, -125.0, 1 - pizzaOpacityAnimation!.value);

        return Opacity(
          opacity: pizzaBoxEnterScaleAnimation!.value,
          child: Transform.scale(
            scale: pizzaBoxEnterScaleAnimation!.value,
            child: Stack(
              children: [
                Center(
                  child: Transform(
                    alignment: Alignment.topCenter,
                    transform: Matrix4.identity()
                      ..setEntry(3, 2, 0.0045)
                      ..rotateX(degreesToReds(-45.0)),
                    child: Image(
                      image: AssetImage("images/box_inside.webp"),
                      width: boxwidth,
                      height: boxheight,
                    ),
                  ),
                ),
                if (boxClosingvalue! >= -125)
                  Center(
                    child: Transform(
                      alignment: Alignment.topCenter,
                      transform: Matrix4.identity()
                        ..setEntry(3, 2, 0.0045)
                        ..rotateX(degreesToReds(boxClosingvalue)),
                      child: Image(
                        image: AssetImage("images/pizza_box.webp"),
                        width: boxwidth,
                        height: boxheight,
                      ),
                    ),
                  )
              ],
            ),
          ),
        );
      },
    );
  }

  void resetdata() {
    for (int i = 0; i <
        pizzaController.customizepizzalist[0].ingredients!.length; i++) {
      if (pizzaController.customizepizzalist[0].ingredients![i].checkIngredient) {
        setState(() {
          pizzaController.customizepizzalist[0].ingredients![i].checkIngredient = false;
        });
      }
    }
    setState(() {
      if (overlayEntry != null) {
        overlayEntry!.remove();
      }

      pizzaController.sizeindex.value=1;
      pizzaController.total.value = 180;
      Width = BoxConstraints(maxWidth: 240);
      Height = BoxConstraints(maxHeight: 240);
      overlayEntry = null;
      pizzaController.pizzaMeta = null;
      listofingredient.clear();
    });
    print("=======resetdata========");
  }

  void FunctionAddToCraft() async {
    checkEnabled = true;

    setState(() {
      PizzaBoxAnimationController =
          AnimationController(
              vsync: this,
              duration: Duration(
                  milliseconds: 4000));

      pizzaScaleAnimation = Tween(
          begin: 1.0, end: 0.5)
          .animate(CurvedAnimation(
          parent:
          PizzaBoxAnimationController!,
          curve: Interval(0.0, 0.2)));

      pizzaBoxEnterScaleAnimation =
          CurvedAnimation(
              parent:
              PizzaBoxAnimationController!,
              curve: Interval(0.0, 0.2));

      pizzaOpacityAnimation = CurvedAnimation(
          parent:
          PizzaBoxAnimationController!,
          curve: Interval(0.2, 0.4));

      pizzaBoxExitScaleAnimation = Tween(
          begin: 1.0, end: 1.3)
          .animate(CurvedAnimation(
          parent:
          PizzaBoxAnimationController!,
          curve: Interval(0.5, 0.7)));

      pizzaBoxGoToCartAnimation =
          CurvedAnimation(
              parent:
              PizzaBoxAnimationController!,
              curve: Interval(0.8, 1.0));

      PizzaBoxAnimationController!
          .forward();
    });

    await pizzaBoxAnimationFunction();

    pizzaController.isBootomSheet.value = true;

    PizzaBoxAnimationController!
        .addStatusListener((status) {
      if (status ==
          AnimationStatus.completed) {
        setState(() {
          resetdata();
          checkEnabled = false;
        });
      }
    });
  }

  FunctionIngredient(int index) {
    checkEnabled = true;

    setState(() {
      pizzaController.ingredientindex.value = index;
    });

    if (pizzaController.customizepizzalist[0].ingredients![index]
        .checkIngredient) {
      setState(() {
        addpizzaAnimation();
        IngredientAnimationController!.reverse(from: 0.0);
        removeIngredient(
            pizzaController.customizepizzalist[0]
                .ingredients![index]);
        pizzaController
            .customizepizzalist[0]
            .ingredients![index]
            .checkIngredient = false;
      });
      print(
          "==========)${pizzaController.customizepizzalist[0]
              .ingredients![index].image}");
    }
    else {
      setState(() {
        addpizzaAnimation();
        IngredientAnimationController!.forward(from: 0.0);
        addIngredient(
            pizzaController.customizepizzalist[0].ingredients![index]);
        pizzaController.customizepizzalist[0].ingredients![index]
            .checkIngredient = true;
      });
    }


    checkEnabled = false;
  }

  FunctionSize(int index) {
    checkEnabled = true;

    setState(() {
      pizzaController.sizeindex.value = index;
    });
    if (index == 0) {
      Width = BoxConstraints(
          maxWidth: 200);
      Height = BoxConstraints(
          maxHeight: 200);
      IngredientWidth = 25;
      IngredientHeight = 25;
      RotationPizzaAnimationController!
          .forward(from: 0.0);
      pizzaController.total.value = 150 + 10 * listofingredient.length;
    }
    else if (index == 1) {
      Width = BoxConstraints(
          maxWidth: 240);
      Height = BoxConstraints(
          maxHeight: 240);
      IngredientWidth = 30;
      IngredientHeight = 30;
      RotationPizzaAnimationController!
          .forward(from: 0.0);

      pizzaController.total.value = 180 +
          10 *
              listofingredient
                  .length;
    }
    else if (index == 2) {
      Width = BoxConstraints(
          maxWidth: 260);
      Height = BoxConstraints(
          maxHeight: 260);
      IngredientWidth = 33;
      IngredientHeight = 33;
      RotationPizzaAnimationController!
          .forward(from: 0.0);
      pizzaController.total.value = 210 +
          10 *
              listofingredient
                  .length;
    }

    checkEnabled = false;
  }


}

double degreesToReds(double deg) {
  return (deg * pi) / 180.0;
}