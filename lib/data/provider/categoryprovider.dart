import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:myapp/data/model/categorymodel.dart';

class ReadData {
  Future<List<Category>> loadData() async {
    var data = await rootBundle.loadString("assets/files/categorylist.json");
    var dataJson = jsonDecode(data);
    return (dataJson['data'] as List).map((e) => Category.fromJson(e)).toList();
  }
}
