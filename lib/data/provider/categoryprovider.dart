import 'dart:io';
import 'package:flutter/material.dart';
import 'package:myapp/api/api.dart';
import 'package:myapp/data/model/categorymodel.dart';

class CategoryProvider extends ChangeNotifier {
  List<Category> _categories = [];
  List<Category> get categories => _categories;
  CategoryProvider() {
    fetchAllCategories();
  }
  Future<void> fetchAllCategories() async {
    _categories = await APIRepository().fetchCategories();
    notifyListeners();
  }

  Future<void> addCategory(
      String cateName, String cateDes, File? cateImg) async {
    await APIRepository().addCategory(cateName, cateDes, cateImg);
    await fetchAllCategories();
  }

  Future<void> editCategory(
      int id, String cateName, String cateDes, File? cateImg) async {
    await APIRepository().editCategory(id, cateName, cateDes, cateImg);
    await fetchAllCategories();
  }

  Future<void> delCategory(
    int id,
  ) async {
    await APIRepository().delCategory(
      id,
    );
    await fetchAllCategories();
  }
}
