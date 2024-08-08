import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:project_uff/home.dart';
import 'package:project_uff/login_page.dart';
import 'package:project_uff/test_page.dart';

class GoogleSignInHandler {
  BuildContext? context;
  GoogleSignInHandler();

  final auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();
  UserCredential? userCredential;

  Future<void> signInWithGoogle(BuildContext context) async {
    this.context = context;
    if (auth.currentUser != null) {
      try {
        await auth.signOut();
        await googleSignIn.signOut();
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => LoginPage(),
          ),
        );
        debugPrint('Deslogado');
      } catch (e) {
        debugPrint("ERRO deslogando:\n$e");
      }
    } else {
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      debugPrint('googleUser: $googleUser');
      debugPrint('googleAuth: $googleAuth');
      userCredential = await auth.signInWithCredential(credential);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => TestPage(),
        ),
      );
    }
  }

  Future<bool> checkUserLoggedIn() async {
    return auth.currentUser != null;
  }
}
