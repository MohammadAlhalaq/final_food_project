import 'package:final_food_project/pages/auth/login_screen.dart';
import 'package:final_food_project/utils/helpers.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class FbAuthController with Helpers {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String displayUserName = 'Loading';

  /// CREATE ACCOUNT
  Future<bool> createAccount(
    BuildContext context, {
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      await _auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) {
        displayUserName = name;
        _auth.currentUser!.updateDisplayName(name);
      });
      Get.to(LoginScreen());
      return true;
    } on FirebaseAuthException catch (e) {
      print('Exception Message: ${e.message}');
      showSnackBar(context,
          message: e.message ?? 'Something went wrong, try again!',
          error: true);
      _controllerExceptionCode(e.code);
    } catch (e) {}
    return false;
  }

  /// SIGN-IN
  Future<bool> signIn(BuildContext context,
      {required String email, required String password}) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return await _handleEmailValidation(context, userCredential);
    } on FirebaseAuthException catch (e) {
      showSnackBar(context,
          message: e.message ?? 'Something went wrong, try again!',
          error: true);
      _controllerExceptionCode(e.code);
    } catch (e) {
      print(e);
    }
    return false;
  }

  /// IS-LOGGED-IN
  bool isLoggedIn() => _auth.currentUser != null;

  /// PASSWORD-RESET
  Future<bool> passwordReset(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      return true;
    } on FirebaseAuthException catch (e) {
      _controllerExceptionCode(e.code);
    } catch (e) {
      print(e);
    }
    return false;
  }

  /// HANDLE-CHECK-EMAIL
  Future<bool> _handleEmailValidation(
      BuildContext context, UserCredential userCredential) async {
    if (userCredential.user != null && !userCredential.user!.emailVerified) {
      await userCredential.user!.sendEmailVerification();
      showSnackBar(context,
          message: 'Please, check your email to verify it.', error: true);
      return false;
    }
    return true;
  }

  /// SIGN-OUT
  Future<void> signOut() async {
    _auth.signOut();
  }

  /// CONTROLLER-EXCEPTION-CODE
  void _controllerExceptionCode(String code) {
    if (code == 'email-already-in-use') {
      print('email-already-in-use');
    } else if (code == 'invalid-email') {
      print('invalid-email');
    } else if (code == 'operation-not-allowed') {
      print('operation-not-allowed');
    } else if (code == 'weak-password') {
      print('weak-password');
    } else if (code == 'user-disabled') {
      print('user-disabled');
    } else if (code == 'user-not-found') {
      print('user-not-found');
    } else if (code == 'wrong-password') {
      print('wrong-password');
    } else if (code == 'auth/missing-android-pkg-name') {
      print('auth/missing-android-pkg-name');
    } else if (code == 'auth/missing-continue-uri') {
      print('auth/missing-continue-uri');
    } else if (code == 'auth/missing-ios-bundle-id') {
      print('auth/missing-ios-bundle-id');
    } else if (code == 'auth/invalid-continue-uri') {
      print('auth/invalid-continue-uri');
    } else if (code == 'auth/unauthorized-continue-uri') {
      print('auth/unauthorized-continue-uri');
    } else if (code == 'auth/user-not-found') {
      print('auth/user-not-found');
    }
  }
}
