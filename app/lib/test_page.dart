import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project_uff/google_sign_in_handler.dart';
import 'package:provider/provider.dart';

class TestPage extends StatefulWidget {
  const TestPage({super.key});

  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  GoogleSignInHandler? googleSignInHandler;
  final auth = FirebaseAuth.instance;

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
            Text("Email: ${auth.currentUser!.email}"),
            Text("Nome: ${auth.currentUser!.displayName}"),
            SizedBox(
              height: 40,
              child: ElevatedButton(
                onPressed: () => googleSignInHandler!.signInWithGoogle(context), // Pass context
                child: const Text("Deslogar"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
