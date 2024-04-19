import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:myapp/data/model/productmodel.dart';

class ReadData {
  Future<List<Product>> loadData() async {
    var data = await rootBundle.loadString("assets/files/productlist.json");
    var dataJson = jsonDecode(data);
    return (dataJson['data'] as List).map((e) => Product.fromJson(e)).toList();
  }

  Future<Iterable<Product>> loadDataByCat(int catId) async {
    var data = await rootBundle.loadString("assets/files/productlist.json");
    var dataJson = jsonDecode(data);
    return (dataJson['data'] as List)
        .map((e) => Product.fromJson(e))
        .where((element) => element.catId == catId)
        .toList();
  }
}
