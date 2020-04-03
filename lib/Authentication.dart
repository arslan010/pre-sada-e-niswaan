import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthImplementation {

  Future<String> SignIn(String email, String password);
  Future<String> SignUp(String email, String password);
  Future<String> getCurrentUser();
  Future <void> signOut();
}

class Auth implements AuthImplementation {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<String> SignIn(String email, String password) async {
    FirebaseUser userSignin = (await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password) as FirebaseUser);
    return userSignin.uid;
  }

  Future<String> SignUp(String email, String password) async {
    FirebaseUser userSignup = (await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password) as FirebaseUser);
    return userSignup.uid;
  }

  Future<String> getCurrentUser() async {
    FirebaseUser currentUser = await _firebaseAuth.currentUser();
    return currentUser.uid;
  }

  Future <void> signOut() async {
    _firebaseAuth.signOut();
  }
}
