// flutter
import 'package:flutter/material.dart';

// packages
import 'package:firebase_auth/firebase_auth.dart';

// util
import 'package:botob/util/auth.dart';

class SignupModel {
  User? currentUser;
  bool isLoading = false;

  final AuthBase _auth = Auth();

  Future<void> signOut() async {
    await _auth.signOut();
  }

  /// Email & Password Sign Up
  Future<void> createUserWithEmailAndPassword({
    required BuildContext context,
    required String email,
    required String password,
    required String userName,
  }) async {
    try {
      isLoading = true;
      await _auth.createUserWithEmailAndPassword(
        email,
        password,
        userName,
      );
      if (context.mounted) {
        isLoading = false;
      }
    } catch (e) {
      isLoading = false;
      rethrow;
    }
  }

  /// Google Sign Up
  Future<void> createUserWithGoogle({
    required BuildContext context,
  }) async {
    try {
      isLoading = true;
      await _auth.signInWithGoogle();
      if (context.mounted) {
        isLoading = false;
      }
    } catch (e) {
      isLoading = false;
      rethrow;
    }
  }
}
