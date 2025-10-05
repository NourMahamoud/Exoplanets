import 'package:exoplents/utlis/customwdiget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../ModelView/SceintificProvider.dart';
class SentificScreen extends StatelessWidget {
  const SentificScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(create: (_) => SentififProvider(),
      child: Sentificpage(),
    );
  }
}

class Sentificpage extends StatelessWidget {
   Sentificpage({super.key});
  String data  = '';
  @override
  Widget build(BuildContext context) {
    final p =  Provider.of<SentififProvider>(context);
    double height = MediaQuery
        .of(context)
        .size
        .height;
    double width = MediaQuery
        .of(context)
        .size
        .width;

    return Scaffold(
      appBar: AppBar(
        elevation: 0.1,
        backgroundColor: Color(0xff0c121e),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CircleAvatar(
              backgroundImage: AssetImage('assets/invader.png'),
              radius: 20,
            ),
            TextButton(onPressed: () {},
                child: Text('help', style: TextStyle(
                    color: Color(0xff2f5b87), fontFamily: 'Albert'))),
            TextButton(onPressed: () {},
                child: Text('about us', style: TextStyle(
                    color: Color(0xff2f5b87), fontFamily: 'Albert'))),
            SizedBox(width: width * 0.5,),
            TextButton(onPressed: () {},
                child: Text('login', style: TextStyle(
                    color: Color(0xff2f5b87), fontFamily: 'Albert'))),
            TextButton(onPressed: () {},
                child: Text('Sign In ', style: TextStyle(
                    color: Color(0xff2f5b87), fontFamily: 'Albert'))),

          ],
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(width * 0.01),
        width: width,
        height: height,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/Images/Frame_1.png'),
                fit: BoxFit.cover)
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('MANAGE YOUR DATA', style: TextStyle(
                  fontFamily: 'Anton', fontSize: 30, color: Colors.white),),
              SizedBox(height: height * 0.05,),
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
              Container(
              padding: EdgeInsets.all(width *0.05),
              width: width * 0.4,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Color(0xff18376b).withOpacity(0.3),
              ),
              child: Column(
                  children: [
              Row(
              children: [
              Text('Add Your CSV', style: TextStyle(color: Color(0xff2f5b87), fontSize: 20, fontFamily: 'Anton'),),
              SizedBox(width: width * 0.01,),
              ElevatedButton(onPressed: () {
                SentififProvider().pickCsvFile()  ;
              },
                child: Text('Upload',
                  style: TextStyle(color: Colors.white, fontSize: 20, fontFamily: 'Anton'),),
                 style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xff18376b).withOpacity(0.78), // dark blue background
                foregroundColor: Colors.white, // text color
                side: const BorderSide(
                  color: Color(0xFF274472), // light blue border
                  width: 1.5,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                elevation: 0, // flat, no shadow
              ), ),
                ],
              ) ,
                   CustomTextFormField(
                          controller: p.transit_daepth,
                          hintText: 'Transit depth',
                          labelText: 'Transit depth',
                          backgroundColor: Colors.black54,
                        ),
                        CustomTextFormField(
                          controller: p.transit_duration,
                          hintText: 'Transit duration',
                          labelText: 'Transit duration',
                          backgroundColor: Colors.black54,
                        ),
                        CustomTextFormField(
                          controller: p.planet_to_star_ratio,
                          hintText: 'Planet-to-star radius ratio',
                          labelText: 'Planet-to-star radius ratio',
                          backgroundColor: Colors.black54,
                        ),
                        CustomTextFormField(
                          controller: p.orbital_period,
                          hintText: 'Orbital period',
                          labelText: 'Orbital period',
                          backgroundColor: Colors.black54,
                        ),
                        CustomTextFormField(
                          controller: p.planet_reduise,
                          hintText: 'Planet radius',
                          labelText: 'Planet radius',
                          backgroundColor: Colors.black54,
                        ),

                        CustomTextFormField(
                          controller: p.dis,
                          hintText: 'distance ',
                          labelText: 'distance ',
                          backgroundColor: Colors.black54,
                        ),
                        CustomTextFormField(
                          controller: p.str,
                          hintText: 'Stellar radius',
                          labelText: 'Stellar radius',
                          backgroundColor: Colors.black54,
                        ),CustomTextFormField(
                          controller: p.transit_epoche,
                          hintText: 'transit_epoch',
                          labelText: 'transit_epoch',
                          backgroundColor: Colors.black54,
                        ),CustomTextFormField(
                          controller: p.temp,
                          hintText: 'Temperature',
                          labelText: 'Temperature',
                          backgroundColor: Colors.black54,
                        ),
                    SizedBox(height: 20,),
                    ElevatedButton(onPressed: (){
                     final data =  SentififProvider().sendDataToApi() ;

                    }, child: Text('Detection',style: TextStyle(color: Colors.white,fontSize: 20),) , style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange
                    ), ) ,

            ],
          ),

        ),
        SizedBox(width: width * 0.05,),

        Column(
          children: [
            Container(
              padding: EdgeInsets.all(width *0.05),
              width: width * 0.4,
              height: height * 0.3,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Color(0xff18376b).withOpacity(0.3),
              ),        ),
            SizedBox(height: height * 0.05,),
            Container(
              padding: EdgeInsets.all(width *0.05),
              width: width * 0.4,
              height: height * 0.6,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Color(0xff18376b).withOpacity(0.3),
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                     Text(''),
                  ],
                ),
              ),
            ),
          ],
        ),
        ],
      ) ,
              SizedBox(height: 30,) ,
              Container(
                height: height,
                width: width,
                child: GridView(gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                children: [
                  Image.asset('assets/Images/Confusion_matrix.png'),
                  Image.asset('assets/Images/Feature_importances.png'),
                  Image.asset('assets/Images/SHAP.png'),
                  Image.asset('assets/Images/RecallCurve.png'),
                ],),
              )
      ],
    ),)
    ,
    )
    );
  }
}
