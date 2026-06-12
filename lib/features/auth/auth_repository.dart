import 'package:firebase_auth/firebase_auth.dart';

class AuthRepository {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Stream<User?> get authStateChanges => _auth.authStateChanges();

   Future<UserCredential> signUpWithEmailAndPassword(String email, String password) async {
    try {
      return await _auth.createUserWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      throw Exception(_handleAuthError(e.code));
    }
  }

 
  Future<UserCredential> loginWithEmailAndPassword(String email, String password) async {
    try {
      return await _auth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      throw Exception(_handleAuthError(e.code));
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }

  
  String _handleAuthError(String code) {
    switch (code) {
      case 'weak-password': return 'كلمة المرور ضعيفة جداً.';
      case 'email-already-in-use': return 'البريد الإلكتروني مستخدم بالفعل.';
      case 'user-not-found': return 'لا يوجد مستخدم بهذا البريد الإلكتروني.';
      case 'wrong-password': return 'كلمة المرور غير صحيحة.';
      case 'invalid-email': return 'صيغة البريد الإلكتروني غير صحيحة.';
      default: return 'حدث خطأ ما، يرجى المحاولة لاحقاً.';
    }
  }
}