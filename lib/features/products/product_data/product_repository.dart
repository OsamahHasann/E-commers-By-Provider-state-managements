import 'package:cloud_firestore/cloud_firestore.dart';
import 'product_model.dart';

class ProductRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<List<ProductModel>> getProductsStream() {
    return _firestore.collection('products').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => ProductModel.fromDoc(doc)).toList();
    });
  }

  Stream<List<String>> getFavoritesStream(String uid) {
    return _firestore.collection('users').doc(uid).collection('favorites').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => doc.id).toList();
    });
  }

  Future<void> toggleFavorite(String uid, String productId, bool isFav) async {
    final favRef = _firestore.collection('users').doc(uid).collection('favorites').doc(productId);
    if (isFav) {
      await favRef.set({'addedAt': Timestamp.now()}); // استخدام set() مطلوب اختيارياً
    } else {
      await favRef.delete();
    }
  }
}