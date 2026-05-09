import 'package:e_commers_by_provider/features/products/product_data/product_model.dart';
import 'package:flutter/material.dart';

class FavoriteProvider with ChangeNotifier {

final List<ProductModel> _favoriteProducts = [];
 void toggleFavorite(ProductModel product) {
    if (_favoriteProducts.contains(product)) {
      _favoriteProducts.remove(product);
      product.isFavorite = false;
    } else {
      _favoriteProducts.add(product);
      product.isFavorite = true;
    }
    notifyListeners();
  }

  List<ProductModel> get favoriteProducts => _favoriteProducts;

}
