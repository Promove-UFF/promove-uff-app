import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project_uff/interface.dart';
import 'package:project_uff/home.dart';
import 'package:project_uff/usuario.dart';

class GoogleSignInHandler {
  BuildContext? context;
  GoogleSignInHandler();

  final auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();
  UserCredential? userCredential;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> signInWithGoogle(BuildContext context) async {
    this.context = context;
    if (auth.currentUser != null){
      try {
        await auth.signOut();
        await googleSignIn.signOut();
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MyScreen()
          ),
        );
        debugPrint('Deslogado');
      } catch (e) {
        debugPrint("ERRO deslogando:\n$e");
      }
    } else {
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
      final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      userCredential = await auth.signInWithCredential(credential);

      if (googleUser != null) {
        Usuario usuario = await _saveOrGetUser(googleUser);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => InterfacePage(usuario),
          ),
        );
      }
    }
  }

  Future<Usuario> _saveOrGetUser(GoogleSignInAccount googleUser) async {
    final usersCollection = _firestore.collection('users');
    final userDoc = usersCollection.doc(googleUser.id);
    final docSnapshot = await userDoc.get();
    
    if (!docSnapshot.exists) {
      // Se o usuário não existir, adiciona e retorna o novo objeto Usuario
      Usuario newUser = Usuario(
        id: googleUser.id,
        nome: googleUser.displayName ?? '',
        email: googleUser.email,
        fotoUrl: googleUser.photoUrl,
        isProfessor: false, // Defina com base na lógica de professor
      );
      await userDoc.set(newUser.toFirestore());
      debugPrint('Usuário salvo no Firestore');
      return newUser;
    } else {
      // Se o usuário já existir, retorna um objeto Usuario
      return Usuario.fromFirestore(docSnapshot.data() as Map<String, dynamic>, googleUser.id);
    }
  }
}
