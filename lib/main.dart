import 'package:csv/csv.dart';
import 'package:exoplents/View/homePage/HomeScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'Model/dataSource/LocalData.dart';

void main (){

  runApp(Myapp()) ;
}
class Myapp extends StatefulWidget {
  const Myapp({super.key});

  @override
  State<Myapp> createState() => _MyappState();
}

class _MyappState extends State<Myapp> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Homescreen() );
      // Scaffold(
      //   body: Container(
      //     child: SingleChildScrollView(
      //       child: Column(
      //         children: [
      //           SizedBox(
      //               height: 500,
      //               width: 500,
      //               child: Flutter3DViewer.obj(
      //                   src: 'assets/Jet/Airplane.obj',
      //                 scale: 10,
      //               )),
      //         ],
      //       ),
      //     ),
      //   ),
      // ),
   // );
  }
}
