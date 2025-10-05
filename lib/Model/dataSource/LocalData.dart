import 'dart:convert';

import 'package:flutter/services.dart';

class Localdata {
  Future<List> loadJsonAsset(String assetPath) async {
    final String jsonString = await rootBundle.loadString(assetPath);
    final data = jsonDecode(jsonString);
    return data ;
  }
}

