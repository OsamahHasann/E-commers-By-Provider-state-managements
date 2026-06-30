import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../cart_data/cart_model.dart';
import '../../products/product_data/product_model.dart';
import '../cart_data/cart_database_helper.dart'; 


// THAT'S SQFLITE DATABASE CODE

// class CartProvider with ChangeNotifier {
//   final Map<String, CartModel> _cartItems = {};

//   int get itemCount {
//     return _cartItems.length;
//   }

//   Map<String, CartModel> get getItems {
//     return _cartItems;
//   }

//   double get totalPrice {
//     double total = 0.0;
//     _cartItems.forEach((key, cartItem) {
//       total += cartItem.price * cartItem.quantity;
//     });
//     return total;
//   }

//   Map<String, CartModel> get cartItems => _cartItems;

//   CartProvider() {
//     _loadCartFromDb(); 
//   }

//   Future<void> _loadCartFromDb() async {
//     final data = await CartDatabaseHelper.instance.getCartItems();
//     _cartItems.clear();
//     for (var item in data) {
//       _cartItems[item['id']] = CartModel(
//         id: item['id'],
//         title: item['title'],
//         price: item['price'],
//         image: item['image'],
//         quantity: item['quantity'],
//       );
//     }
//     notifyListeners();
//   }

//   Future<void> addItem(ProductModel product) async {
//     if (_cartItems.containsKey(product.id)) {
//       _cartItems[product.id]!.quantity += 1;
//       await CartDatabaseHelper.instance.updateQuantity(
//         product.id,
//         _cartItems[product.id]!.quantity,
//       );
//     } else {
//       final newCartItem = CartModel(
//         id: product.id,
//         title: product.name,
//         price: product.price,
//         image: product.image,
//         quantity: 1,
//       );
//       _cartItems[product.id] = newCartItem;
//       await CartDatabaseHelper.instance.insertOrUpdateCartItem({
//         'id': newCartItem.id,
//         'title': newCartItem.title,
//         'price': newCartItem.price,
//         'image': newCartItem.image,
//         'quantity': newCartItem.quantity,
//       });
//     }
//     notifyListeners();
//   }

//   Future<void> removeItem(String productId) async {
//     _cartItems.remove(productId);
//     await CartDatabaseHelper.instance.deleteCartItem(productId);
//     notifyListeners();
//   }
// }

class CartProvider with ChangeNotifier {
  Map<String, CartModel> _cartItems = {};
  Map<String, CartModel> get cartItems => _cartItems;
  Map<String, CartModel> get getItems => _cartItems;
  
  double get totalPrice {
    double total = 0.0;
    _cartItems.forEach((key, item) => total += item.price * item.quantity);
    return total;
  }

  CartProvider() { _loadCart(); }

  Future<void> _saveCart() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> encodedItems = _cartItems.values
        .map((item) => json.encode(item.toJson()))
        .toList();
    await prefs.setStringList('cart_items', encodedItems);
  }

  Future<void> _loadCart() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String>? savedItems = prefs.getStringList('cart_items');
    if (savedItems != null) {
      _cartItems = {
        for (var item in savedItems)
          json.decode(item)['id']: CartModel.fromJson(json.decode(item))
      };
      notifyListeners();
    }
  }

  Future<void> addItem(ProductModel product) async {
    if (_cartItems.containsKey(product.id)) {
      _cartItems[product.id]!.quantity += 1;
    } else {
      _cartItems[product.id] = CartModel(
        id: product.id, title: product.name, price: product.price, 
        image: product.image, quantity: 1);
    }
    await _saveCart(); 
    notifyListeners();
  }

  Future<void> removeItem(String productId) async {
    _cartItems.remove(productId);
    await _saveCart();
    notifyListeners();
  }

  int get itemCount {
    return _cartItems.length;
  }
}