import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthServices {
  static FirebaseAuth _auth = FirebaseAuth.instance;

  static Future<String> loginWithEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      return 'berhasil';
    } catch (error) {
      print(error.message);
      return error.message;
    }
  }

  static Stream<User> get firebaseUserStream => _auth.authStateChanges();
}
