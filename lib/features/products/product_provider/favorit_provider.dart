import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../product_data/product_model.dart';

class FavoriteProvider with ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  
  List<String> _favoriteProductIds = [];
  List<String> get favoriteProductIds => _favoriteProductIds;

  FavoriteProvider() {
    _loadFavorites();
  }

  void _loadFavorites() {
    _auth.authStateChanges().listen((user) {
      if (user != null) {
        _firestore.collection('users').doc(user.uid).collection('favorites')
            .snapshots().listen((snapshot) {
          _favoriteProductIds = snapshot.docs.map((doc) => doc.id).toList();
          notifyListeners(); 
        });
      } else {
        _favoriteProductIds = [];
        notifyListeners();
      }
    });
  }

  Future<void> toggleFavorite(ProductModel product) async {
    final user = _auth.currentUser;
    if (user == null) return;

    final favRef = _firestore.collection('users').doc(user.uid)
        .collection('favorites').doc(product.id);

    if (_favoriteProductIds.contains(product.id)) {
      await favRef.delete();
    } else {
      await favRef.set({'addedAt': FieldValue.serverTimestamp()});
    }
  }
}