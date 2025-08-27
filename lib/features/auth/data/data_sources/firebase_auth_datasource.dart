// ignore_for_file: unused_field, body_might_complete_normally_nullable, unused_local_variable

import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthDatasource {
  final FirebaseAuth _firebaseAuth;

  FirebaseAuthDatasource(this._firebaseAuth);

  //get
  User? geturrentUser() {
    return _firebaseAuth.currentUser;
  }

  //login
  Future<User?> signIn(String email, String password) async {
    final result = await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    return result.user;
  }

  //register
  Future<User?> signUp(String email, String password) async {
    final result = await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    return result.user;
  }

  //logout
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }
}
