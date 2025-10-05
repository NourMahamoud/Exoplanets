import 'package:exoplents/Model/PlanetModel.dart';


abstract class  ApiConsumer {
  Future  postPlanet ({required PlanetModel user,required String endPoint});
  Future <Map<String,dynamic>> getdata({required String token,required String endPoint}) ;

}