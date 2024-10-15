import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:project_uff/google_sign_in_handler.dart';
import 'package:project_uff/home.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    MultiProvider(
      providers: [
        Provider<GoogleSignInHandler>(
            create: (context) => GoogleSignInHandler()),
      ],
      child: MaterialApp(
        title: 'Projeto Uff',
        debugShowCheckedModeBanner: false,
        home: MyScreen(),
      ),
    ),
  );
}