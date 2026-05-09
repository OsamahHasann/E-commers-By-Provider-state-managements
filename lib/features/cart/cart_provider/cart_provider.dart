import 'package:e_commers_by_provider/features/products/product_data/product_model.dart';
import 'package:flutter/material.dart';

class CartProvider extends ChangeNotifier {
  final List<ProductModel> _items = [];
   double totalPrice = 0.0;

  List<ProductModel> get getItems => _items;

  void addItem(ProductModel item) {
    _items.add(item);
    totalPrice += item.price;
    notifyListeners();
  }

  void removeItem(ProductModel item) {
    _items.remove(item);
    totalPrice -= item.price;
    notifyListeners();
  }
  
  int get itemCount => _items.length;
  double get totalprice => totalPrice;
}