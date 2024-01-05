// import 'package:flutter/material.dart';
// import 'package:flutter_compass/flutter_compass.dart';
// import 'dart:math';
//
// //flutter_compass: ^0.8.0
//
// class Demo extends StatefulWidget {
//   const Demo({super.key});
//   @override
//   State<Demo> createState() => _DemoState();
// }
// class _DemoState extends State<Demo> {
//   double? heading = 0;
//   double ?absHeading=0;
//   double ?angle=0;
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     print("11111");
//     FlutterCompass.events!.listen((event) {
//       setState(() {
//         heading = event.heading!;
//         print("----heading-----)${heading}");
//         absHeading= heading!.abs() - 180;
//        print("----Absheading-----)${absHeading}");
//         angle=absHeading!.abs() + 180;
//         print("----angle-----)${angle}");
//       });
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black,
//       body: Container(
//         width: MediaQuery.of(context).size.width,
//         height: MediaQuery.of(context).size.height,
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             heading != null
//                 ? heading! > 0 ?
//
//             Text(
//               "${heading!.ceil()}",
//                     style: TextStyle(
//                         color: Colors.white,
//                         fontSize: 26,
//                         fontWeight: FontWeight.bold),
//                   ):Text(
//               "${angle!.ceil()}",
//               style: TextStyle(
//                   color: Colors.white,
//                   fontSize: 26,
//                   fontWeight: FontWeight.bold),
//             )
//                 : Text("aa"),
//             SizedBox(
//               height: 50,
//             ),
//             Padding(
//               padding: const EdgeInsets.all(10.0),
//               child: Stack(
//                 alignment: Alignment.center,
//                 children: [
//                   Image(image: AssetImage("images/cadrant.png")),
//                   Transform.rotate(
//                       angle: heading! * (pi / 180),
//                       child: Image.asset("images/compass.png",scale: 1.1,))
//                 ],
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
