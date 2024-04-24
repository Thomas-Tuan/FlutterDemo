import 'package:flutter/material.dart';
import 'package:flutter_cart/flutter_cart.dart';
import 'package:myapp/data/model/productmodel.dart';

class CartProvider extends ChangeNotifier {
  final FlutterCart _cart = FlutterCart();

  FlutterCart get cart => _cart; // Provide access to the FlutterCart instance

  int get cartItemCount => _cart.getCartItemCount();

  void addItem(Product product) {
    _cart.addToCart(
      productId: product.id,
      unitPrice: product.price,
      quantity: 1,
      productName: product.name,
      productDetailsObject: product.img,
    );
    notifyListeners(); // Notify listeners of changes
  }

  void removeItem(int productId) {
    _cart.deleteItemFromCart(productId);
    notifyListeners();
  }

  void clearCart() {
    _cart.deleteAllCart();
    notifyListeners();
  }

  void incrementQuantity(int index) {
    _cart.incrementItemToCart(index);
    notifyListeners();
  }

  void decrementQuantity(int index) {
    _cart.decrementItemFromCart(index);
    notifyListeners();
  }

  double get totalPrice {
    return _cart.getTotalAmount();
  }
}
