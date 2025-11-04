import 'package:flutter/cupertino.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthProvider extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  bool _isLoading = false;
  String _errorMessage = "";

  bool get isLoading => _isLoading;

  String get errorMessage => _errorMessage;

  void clearError() {
    _errorMessage = "";
  }

  Future<void> register(String email, String password) async {
    _isLoading = true;
    _errorMessage = "";
    notifyListeners();

    try {
      await _auth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );
    } on FirebaseAuthException catch (e) {
      _errorMessage = e.message ?? "Terjadi Kesalahan";
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> signIn(String email, String password) async {
    _isLoading = true;
    _errorMessage = '';
    notifyListeners();

    bool isSuccess = false;
    try {
      await _auth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );
      isSuccess = true;
    } on FirebaseAuthException catch (e) {
      _errorMessage = e.message ?? "Terjadi kesalahan";
      isSuccess = false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }

    return isSuccess;
  }

  Future<void> signOut() async{
    await _auth.signOut();
  }
}
