import 'package:flutter/foundation.dart';

import '../consts/imports.dart';

class AuthService {
  final _auth = FirebaseAuth.instance;

  Future<User?> createUserWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      final cred = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      return cred.user;
    } catch (ex) {
      if (kDebugMode) {
        print("Error: $ex");
      }
      return null;
    }
  }

  Future<User?> loginUserWithEmailAndPassword(
      {required String email,
      required String password}) async {
    try {
      final cred = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return cred.user;
    } catch (ex) {
      if (kDebugMode) {
        print("Error: $ex");
      }
    }
    return null;
  }
}
