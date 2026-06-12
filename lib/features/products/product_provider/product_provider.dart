import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../product_data/product_model.dart';
import '../product_data/product_repository.dart';

class ProductProvider with ChangeNotifier {
  final ProductRepository _repository = ProductRepository();
  List<ProductModel> _products = [];
  List<String> _favoriteIds = [];
  late ProductModel selectedProduct;
  
  
  StreamSubscription? _productsSubscription;
  StreamSubscription? _favoritesSubscription;

  List<ProductModel> get getProducts => _products;

  ProductProvider() {
    _initStreams();
  }
  void _initStreams() {
    _productsSubscription = _repository.getProductsStream().listen((fetchedProducts) {
      _products = fetchedProducts;
      _updateProductsFavoriteStatus();
      notifyListeners();
    });

    FirebaseAuth.instance.authStateChanges().listen((user) {
      _favoritesSubscription?.cancel();
      if (user != null) {
        _favoritesSubscription = _repository.getFavoritesStream(user.uid).listen((favIds) {
          _favoriteIds = favIds;
          _updateProductsFavoriteStatus();
          notifyListeners();
        });
      } else {
        _favoriteIds = [];
        _updateProductsFavoriteStatus();
        notifyListeners();
      }
    });
  }

void _updateProductsFavoriteStatus() {
    for (var prod in _products) {
      prod.isFavorite = _favoriteIds.contains(prod.id);
    }
  }

  Future<void> toggleFavoriteStatus(ProductModel product) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      product.isFavorite = !product.isFavorite;
      notifyListeners();
      
      await _repository.toggleFavorite(user.uid, product.id, product.isFavorite);
    }
  }

  List<ProductModel> getProductsByCategory(String categoryName) {
    return _products.where((prod) => prod.category.toLowerCase() == categoryName.toLowerCase()).toList();
  }

  @override
  void dispose() {
    _productsSubscription?.cancel();
    _favoritesSubscription?.cancel();
    super.dispose();
  }
}