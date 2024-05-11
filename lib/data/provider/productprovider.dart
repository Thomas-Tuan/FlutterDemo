import 'dart:io';
import 'package:flutter/material.dart';
import 'package:myapp/api/api.dart';
import 'package:myapp/data/model/productmodel.dart';

class ProductProvider extends ChangeNotifier {
  List<Product> _product = [];
  List<Product> get product => _product;
  Map<String, Map<String, int>> priceFilters = {
    '100.000 - 200.000': {'min': 100000, 'max': 200000},
    '200.000 - 300.000': {'min': 200000, 'max': 300000},
    '300.000 - 500.000': {'min': 300000, 'max': 500000},
    '> 500.000': {'min': 500000, 'max': 520000},
  };
  Map<String, bool> selectedPriceFilters = {
    '100.000 - 200.000': false,
    '200.000 - 300.000': false,
    '300.000 - 500.000': false,
    '> 500.000': false,
  };
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

  void updatePriceFilter(String key, bool value) {
    selectedPriceFilters[key] = value;
    notifyListeners();
  }

  List<String> getSelectedPriceRanges() {
    return selectedPriceFilters.entries
        .where((entry) => entry.value)
        .map((entry) => entry.key)
        .toList();
  }
}
