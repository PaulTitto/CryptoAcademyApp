import 'package:flutter/cupertino.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthProvider extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  User? _user;
  User? get user => _user;

  bool _isLoading = false;
  String _errorMessage = "";

  bool get isLoading => _isLoading;

  String get errorMessage => _errorMessage;

  void clearError() {
    _errorMessage = "";
  }


  Future<UserCredential?> signInWithGoogle() async {
    _isLoading = true;
    _errorMessage = '';
    notifyListeners();

    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      if (googleUser == null) {
        _isLoading = false;
        notifyListeners();
        return null;
      }

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      UserCredential userCredential = await _auth.signInWithCredential(credential);
      _user = userCredential.user;
      return userCredential;

    } on FirebaseAuthException catch (e) {
      _errorMessage = e.message ?? "Terjadi kesalahan Google Sign-In";
      return null;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
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
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );

      _user = userCredential.user;
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
