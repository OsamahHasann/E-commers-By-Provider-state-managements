import 'package:e_commers_by_provider/features/products/product_data/product_model.dart';
import 'package:e_commers_by_provider/features/products/product_data/product_repository.dart';
import 'package:flutter/material.dart';

class ProductProvider with ChangeNotifier {
  final ProductRepository _repository = ProductRepository();
  late List<ProductModel> products = [];
  late ProductModel selectedProduct;
  

  ProductProvider() {
    fetchProducts();
  }

  List<ProductModel> get getProducts => products;

  void fetchProducts() {
    products = _repository.products();
    notifyListeners();
  }
}
