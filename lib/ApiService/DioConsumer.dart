import 'package:dio/dio.dart';

import '../Model/PlanetModel.dart';
import 'ApiConsumer.dart';


class  DioConsumer extends ApiConsumer {
  final Dio dio = Dio();
  @override
  Future  postPlanet({required PlanetModel user, required String endPoint}) async {
    try {
      final response  = await dio.post(
          'http://0.0.0.0:8000/predict-single/',
          data: {
            "transit_depth": 4500,
            "orbital_period": 5.2,
            "planet_radius": 11.0,
            "stellar_radius": 1.3,
            "distance": 400,
            "temperature": 1300,
            "stellar_temperature": 5900
          },
        );
       if (response.statusCode == 200) {
         print('Dio Done');
         print(response);
         return response.data;
       }else {
         print("Dio Filed");
         return response.statusCode ;
       }
    }catch (e){
      print(e.toString());
      return e.toString() ;
    }
  }

  @override
  Future<Map<String, dynamic>> getdata({required String token, required String endPoint}) {
    // TODO: implement getdata
    throw UnimplementedError();
  }


}
void main ()async{
  try {
    final response  = await Dio().post(
      'http://0.0.0.0:8000/predict-single/',
      data: {
        "transit_depth": 4500,
        "orbital_period": 5.2,
        "planet_radius": 11.0,
        "stellar_radius": 1.3,
        "distance": 400,
        "temperature": 1300,
        "stellar_temperature": 5900
      },
    );
    if (response.statusCode == 200) {
      print('Dio Done');
      print(response);
      return response.data;
    }else {
      print("Dio Filed");

    }
  }catch (e){
    print(e.toString());
  }
}