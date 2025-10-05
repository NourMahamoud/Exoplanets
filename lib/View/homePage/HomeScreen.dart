import 'package:flutter/material.dart';

import '../AmateurViewer/Amateurpage.dart';
import '../Sentific/SentificPage.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    final headingFontSize = (width / 12).clamp(28.0, 96.0);
    final subtitleFontSize = (width / 28).clamp(14.0, 32.0);
    final bodyFontSize = (width / 48).clamp(12.0, 20.0);
    return Scaffold(
      appBar: AppBar(
        elevation: 0.1,
        backgroundColor: Color(0xff0c121e),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              width: 70,
              height: 60,
       decoration: BoxDecoration(
  image: DecorationImage(image: AssetImage('assets/Images/Space_Invaders3_1.png')) ,
  borderRadius: BorderRadius.circular(10) )
),


            TextButton(
              onPressed: () {},
              child: Text(
                'help',
                style: TextStyle(
                  color: Color(0xff2f5b87),
                  fontFamily: 'Albert',
                ),
              ),
            ),
            TextButton(
              onPressed: () {

              },
              child: Text(
                'about us',
                style: TextStyle(
                  color: Color(0xff2f5b87),
                  fontFamily: 'Albert',
                ),
              ),
            ),
            SizedBox(width: width * 0.5),
            TextButton(
              onPressed: () {},
              child: Text(
                'login',
                style: TextStyle(
                  color: Color(0xff2f5b87),
                  fontFamily: 'Albert',
                ),
              ),
            ),
            TextButton(
              onPressed: () {},
              child: Text(
                'Sign In ',
                style: TextStyle(
                  color: Color(0xff2f5b87),
                  fontFamily: 'Albert',
                ),
              ),
            ),
          ],
        ),
      ),
      body: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/Images/Frame_1.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: [
            Positioned(
              child: Image.asset('assets/Images/earth.png'),
              top: 100,
              left: width * 0.3,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'EX₂O',
                    style: TextStyle(
                      fontSize: 60,
                      color: Colors.white,
                      fontFamily: 'NASALIZA',
                    ),
                  ),
                  Container(
                    height: 3,
                    width: width * 0.3,
                    color: const Color(0xFFFF5722), // Orange line
                  ),
                  Container(
                    height: 3,
                    width: width * 0.2,
                    color: const Color(0xFFFF5722), // Orange line
                  ),
                  Container(
                    height: 3,
                    width: width * 0.1,
                    color: const Color(0xFFFF5722), // Orange line
                  ),
                  Container(
                    padding: EdgeInsets.all(width * 0.05),
                    child: RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: 'INVADE THE ',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 50,
                              fontFamily: 'Albert',
                            ),
                          ),
                          TextSpan(
                            text: ' SPACE',
                            style: TextStyle(
                              color: Colors.grey.shade50.withOpacity(0.3),
                              fontSize: 50,
                              fontFamily: 'Albert',
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: height *0.2,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AmateurScreen(),
                            ),
                          );
                        },
                        child: Text(
                          'EXPLORE',
                          style: TextStyle(
                            fontFamily: 'Anton',
                            fontSize: 45,
                            color: Colors.white,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xff18376b).withOpacity(0.78), // dark blue background
                          foregroundColor: Colors.white, // text color
                          side: const BorderSide(
                            color: Color(0xFF274472), // light blue border
                            width: 1.5,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10,),
                            side: BorderSide(color: Colors.white, width: 2)
                          ),
                          fixedSize: Size(width *0.25, height *0.15),
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                          elevation: 1, // flat, no shadow
                        ),
                      ),
                      SizedBox(width: width * 0.05),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (_)=>SentificScreen()));
                        },
                        child: Text(
                          'Scientific',
                          style: TextStyle(
                            fontFamily: 'Anton',
                            fontSize: 45,
                            color: Colors.white,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xff18376b).withOpacity(0.78), // dark blue background
                          foregroundColor: Colors.white, // text color
                          side: const BorderSide(
                            color: Color(0xFF274472), // light blue border
                            width: 1.5,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          fixedSize: Size(width *0.25, height *0.15),
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                          elevation: 1, // flat, no shadow
                        ),
                      ),
                    ],
                  ),

                  // Container(
                  //   child: CustomPaint(
                  //     painter: LinesCustomPatint(),
                  //   ),
                  // ),
                  // Text('ASTEROID DETECTION',style: TextStyle(fontSize: 50,color: Colors.white,fontWeight: FontWeight.bold),),
                  // SizedBox(height: height *0.05,),
                  // Text('AI-Powered Space Surveillance',style: TextStyle(fontSize: 30,color: Colors.white,fontWeight: FontWeight.bold),),
                  // SizedBox(height: height *0.03,),
                  // Text('Advanced neural networks scanning the cosmos for potentially hazardous objects. \nJoin scientists and amateur astronomers in protecting our planet.',softWrap: true,style: TextStyle(color: Colors.white,fontSize: 20), textAlign: TextAlign.center,) ,
                  // SizedBox(height: height *0.2,),
                  // Center(
                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  //
                  //     children: [
                  //       ElevatedButton(onPressed: (){
                  //         Navigator.push(context, MaterialPageRoute(builder: (context)=>AmateurPage()));
                  //       }, child: RichText(text: TextSpan(
                  //         style: TextStyle(),
                  //         children: [
                  //           TextSpan(text: 'Amateur ',style: TextStyle(color: Colors.purpleAccent,fontSize: 30)),
                  //           TextSpan(text: 'Mode',style: TextStyle(color: Colors.black,fontSize: 30))
                  //         ]
                  //       )),
                  //         style: ElevatedButton.styleFrom(backgroundColor: Colors.white, fixedSize: Size(width *0.2, height*0.06)),
                  //       ),
                  //       ElevatedButton(onPressed: (){}, child: RichText(text: TextSpan(
                  //         style: TextStyle(),
                  //         children: [
                  //           TextSpan(text: 'Scientists ',style: TextStyle(color: Colors.purpleAccent,fontSize: 30)),
                  //           TextSpan(text: 'Mode',style: TextStyle(color: Colors.black,fontSize: 30)),
                  //
                  //       ])),style: ElevatedButton.styleFrom(backgroundColor: Colors.white,fixedSize: Size(width *0.2, height*0.06)),),
                  //     ],
                  //
                  //   ),
                  // )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
