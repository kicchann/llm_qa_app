// flutter
import 'package:flutter/material.dart';

// packages
import 'package:firebase_auth/firebase_auth.dart';

// util
import 'package:botob/util/auth.dart';

class SignInModel {
  User? currentUser;

  final AuthBase _auth = Auth();

  Future<void> signInWithEmailAndPassword({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    currentUser = await _auth.signInWithEmailAndPassword(email, password);
  }

  Future<void> signInWithGoogle({
    required BuildContext context,
  }) async {
    currentUser = await _auth.signInWithGoogle();
  }
}
