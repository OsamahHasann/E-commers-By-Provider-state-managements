import 'package:e_commers_by_provider/features/products/product_data/product_model.dart';
import 'package:e_commers_by_provider/features/products/product_data/product_repository.dart';
import 'package:flutter/material.dart';

class ProductProvider with ChangeNotifier {
  final ProductRepository _repository = ProductRepository();
  List<ProductModel> products = [];
  late ProductModel selectedProduct;
  
  bool _isLoading = false;
  String _errorMessage = '';

  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;

  ProductProvider() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      fetchProducts();
    });
  }

  List<ProductModel> get getProducts => products;

   Future<void> fetchProducts() async {
    _isLoading = true;
    _errorMessage = '';
    notifyListeners();

    try {
      products = await _repository.products();
    } catch (e) {
      _errorMessage = e.toString().replaceAll("Exception:", "");
    } finally {
      _isLoading = false;
      notifyListeners(); 
    }
  }
  
  List<ProductModel> getProductsByCategory(String categoryName) {
    return products.where((prod) => prod.category.toLowerCase() == categoryName.toLowerCase()).toList();
  }
}