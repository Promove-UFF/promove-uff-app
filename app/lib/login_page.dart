import 'package:project_uff/google_sign_in_handler.dart';
import 'package:provider/provider.dart';
import 'package:sign_in_button/sign_in_button.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  GoogleSignInHandler? googleSignInHandler;

  getDependencies() {
    googleSignInHandler = Provider.of<GoogleSignInHandler>(context, listen: false);
  }

  @override
  void initState() {
    getDependencies();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 40,
              child: SignInButton(
                Buttons.googleDark,
                text: "Entrar com o Google",
                onPressed: () => googleSignInHandler!.signInWithGoogle(context), // Pass context
              ),
            ),
          ],
        ),
      ),
    );
  }
}
