import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'dart:html' as html;
import 'dart:typed_data';

class SentififProvider extends ChangeNotifier {
  final Dio dio = Dio();
  late final  TextEditingController transit_daepth ;
 late final  TextEditingController transit_duration ;
 late final  TextEditingController planet_to_star_ratio ;
 late final  TextEditingController orbital_period ;
 late  final  TextEditingController planet_reduise ;
 late  final  TextEditingController stt ;
 late  final  TextEditingController str ;
 late final  TextEditingController transit_epoche;
 late final  TextEditingController temp ;
 late  final  TextEditingController dis ;
 SentififProvider(){
   transit_daepth =  TextEditingController() ;
   transit_duration =  TextEditingController() ;
   planet_reduise =TextEditingController() ;
   planet_to_star_ratio =  TextEditingController() ;
   orbital_period =  TextEditingController() ;
   stt = TextEditingController() ;
   str = TextEditingController() ;
   transit_epoche = TextEditingController() ;
   temp = TextEditingController() ;
   dis = TextEditingController() ;

 }

  void pickCsvFile() {
    html.FileUploadInputElement uploadInput = html.FileUploadInputElement();
    uploadInput.accept = '.csv';
    uploadInput.click();

    uploadInput.onChange.listen((event) {
      final files = uploadInput.files;
      if (files != null && files.isNotEmpty) {
        final file = files[0] ;
        print('User selected file: ${file.name}');
      }
    });
  }




  Future uploadFileToApi(html.File file) async {
    final reader = html.FileReader();
    reader.readAsArrayBuffer(file);
    await reader.onLoad.first;

    final data = reader.result as Uint8List;

    FormData formData = FormData.fromMap({
      'file': MultipartFile.fromBytes(
        data,
        filename: file.name,
        // contentType غير مطلوب في الويب
      ),
    });

    try {
      final response = await dio.post(
        'https://127.0.0.1:8000',
        data: formData,
        options: Options(
          headers: {
            'Content-Type': 'multipart/form-data',
          },
        ),
      );

      print('Upload status: ${response.statusCode}');
      print('Response: ${response.data}');
    } catch (e) {
      print('Upload failed: =======================================');
      print('Upload failed: $e');
    }
  }
  Future<void> sendDataToApi() async {
    try {
      // جهز البيانات كـ Map
      final data = {
        'transit_depth': transit_daepth.text,
        'transit_duration': transit_duration.text,
        'planet_radius': planet_reduise.text,
        'planet_to_star_ratio': planet_to_star_ratio.text,
        'orbital_period': orbital_period.text,
        'stt': stt.text,
        'str': str.text,
        'transit_epoche': transit_epoche.text,
        'temperature': temp.text,
        'distance': dis.text,
      };

      // إرسال البيانات للـ API
      final response = await dio.post(
        '', // استبدلي بالرابط الحقيقي
        data: data,
        options: Options(
          headers: {
            'Content-Type': 'application/json', // لو الـ API يتوقع JSON
          },
        ),
      );
      print('Response status: ${response.statusCode}');
      print('Response data: ${response.data}');

      return response.data ;

    } catch (e) {
      print('Failed to send data: $e');
    }
  }

}


