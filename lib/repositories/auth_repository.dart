import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';

class AuthRepository {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<void> signIn(String email, String password) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      print("errorfrom_fb:");
      print(e.code);

      throw _handleFirebaseAuthException(e);
    } on PlatformException catch (_) {
      throw ('No internet connection. Please check your network.');
    } catch (e) {
      throw ('An unknown error occurred.');
    }
  }

  Future<void> signUp(String email, String password) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      print("errorfrom_fb:");
      print(e.message);
      throw Exception(_handleFirebaseAuthException(e));
    } on PlatformException catch (e) {
      print("errorfrom_fb:");
      print(e.message);

      throw Exception('No internet connection. Please check your network.');
    } catch (e) {
      print("errorfrom_fb:");
      print(e);

      throw Exception('An unknown error occurred.');
    }
  }

  String _handleFirebaseAuthException(FirebaseAuthException e) {
    switch (e.code) {
      case 'invalid-email':
        return 'The email address is not valid.';
      case 'user-not-found':
        return 'No user found for that email.';
      case 'wrong-password':
        return 'Incorrect password. Please try again.';
      case 'email-already-in-use':
        return 'The email address is already in use.';
      default:
        return 'Invalid Email or password.';
    }
  }
}

