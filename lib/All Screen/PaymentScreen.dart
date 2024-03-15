import 'package:Pizza/All%20Screen/CookingScreen.dart';
import 'package:Pizza/Controller/GoogleMapController.dart';
import 'package:Pizza/Controller/LoginController.dart';
import 'package:Pizza/Controller/OrderController.dart';
import 'package:Pizza/Controller/PizzaController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen>{
  Razorpay razorpay = Razorpay();
  TextEditingController paymentController = TextEditingController();
  PizzaController pizzaController=Get.find();
  LoginController loginController =Get.find();
  OrderController orderController=Get.find();
  GoogleMapControllerScreen googleMapControllerScreen = Get.find();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    paymentController.text="${pizzaController.grandtotal.value}";
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    razorpay.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 190,
      child: Column(
          children: [
        SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 10,right: 10),
          child: Row(
            children: [
              Text(
                "Online Payment ",
                style: GoogleFonts.lexend(
                  fontWeight: FontWeight.w400,
                  fontSize: 17,
                  color: Color(0xff313848),
                ),
              ),
              Spacer(),
              GestureDetector(
                onTap: () {
                  setState((){
                    Navigator.pop(context);
                  });
                },
                child:Image(
                  image: AssetImage("images/close.webp"),
                  width: 23,
                  height: 23,
                  color: Color(0xff313848),
                ),
              ),
            ],
          ),
        ),

        SizedBox(height: 20),

        Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: Container(
            height: 50,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
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
                readOnly: true,
                autofocus: false,
                controller: paymentController,
                cursorColor: Color(0xff7E8286),
                decoration: InputDecoration(
                  icon:Image(
                    image: AssetImage("images/payment.webp"),
                    width: 27,
                    height: 27,
                    color: Color(0xffEF505F),
                  ),
                  hintText: "Enter Amount...",
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
        Spacer(),
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
                payAmount();
              },
              child: Text(
                "Pay Amount",
                style: TextStyle(fontSize: 16, color: Colors.white),
              )),
        ),
      ]),
    );
  }

  void payAmount() {
    var options = {
      'key': 'rzp_test_h26N4DQazh4l0W',
      'amount': (int.parse(paymentController.text)*100).toString(),
      'name': loginController.addname.text.toString(),
      'description': 'Fine T-Shirt',
      'timeout': 600,
      'prefill': {
        'contact': loginController.addphonenumber.text,
        'email': loginController.addemail.text
      },
      'theme': {'color': '#EF505F'},
    };
    razorpay.open(options);
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    print("------------success---------------------)${response}");
    paymentController.text = "";
    orderController.addUserOrderData();
    orderController.addAllUserOrderData();

    Navigator.push(
        context,
        PageTransition(
            child: CookingScreen(
                total: pizzaController
                    .grandtotal.value),
            type:
            PageTransitionType.rightToLeft));

    pizzaController.resetOffer();
    pizzaController.functionCartClear();
    googleMapControllerScreen.visibleAddress.value=false;
    googleMapControllerScreen.selectAddress.value = false;
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    print("-----------error----------------------)${response}");

    // Do something when payment fails
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    // Do something when an external wallet is selected
  }
}
