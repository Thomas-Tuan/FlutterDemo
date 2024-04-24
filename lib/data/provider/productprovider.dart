import 'dart:io';
import 'package:flutter/material.dart';
import 'package:myapp/api/api.dart';
import 'package:myapp/data/model/productmodel.dart';

class ProductProvider extends ChangeNotifier {
  List<Product> _product = [];
  List<Product> get product => _product;
  ProductProvider() {
    fetchAllProduct();
  }
  Future<void> fetchAllProduct() async {
    _product = await APIRepository().fetchProduct();
    notifyListeners();
  }

  Future<void> addProduct(
    String proName,
    String proDes,
    File? proImg,
    double price,
    int cateId,
  ) async {
    await APIRepository().addProduct(
      proName,
      proDes,
      proImg,
      price,
      cateId,
    );
    await fetchAllProduct();
  }

  Future<void> editProduct(
    int id,
    String proName,
    String proDes,
    File? proImg,
    double price,
    int cateId,
    String srcImgPro,
  ) async {
    await APIRepository()
        .editProduct(id, proName, proDes, proImg, price, cateId, srcImgPro);
    await fetchAllProduct();
  }

  Future<void> delProduct(
    int id,
  ) async {
    await APIRepository().delProduct(
      id,
    );
    await fetchAllProduct();
  }
}
