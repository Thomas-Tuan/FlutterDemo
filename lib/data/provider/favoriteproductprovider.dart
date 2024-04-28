import 'package:flutter/material.dart';
import 'package:myapp/data/model/productmodel.dart';

class FavoriteProductProvider extends ChangeNotifier {
  List<Product> _product = [];
  List<Product> get product => _product;

  bool isFavorite(Product product) {
    return _product.any((p) => p.id == product.id);
  }

  void addFavorite(Product product) {
    if (!isFavorite(product)) {
      _product.add(product);
      notifyListeners();
    }
  }

  void removeFavorite(Product product) {
    _product.removeWhere((p) => p.id == product.id);
    notifyListeners();
  }

  void toggleFavorite(Product product) {
    if (isFavorite(product)) {
      removeFavorite(product);
    } else {
      addFavorite(product);
    }
  }
}
