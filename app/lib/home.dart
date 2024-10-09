import 'package:flutter/material.dart';
import 'package:project_uff/google_sign_in_handler.dart';
import 'package:project_uff/interface.dart';
import 'package:provider/provider.dart';
import 'package:project_uff/usuario.dart';

class MyScreen extends StatelessWidget {
  const MyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              color: Color.fromARGB(255, 225, 230, 232),
              child: Align(
                alignment: Alignment.center,
                child: Image.asset('images/logo.png', fit: BoxFit.fill),
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Container(
              color: Color.fromARGB(255, 225, 230, 232),
              child: Center(
                child: AccountOptions(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class AccountOptions extends StatefulWidget {
  const AccountOptions({super.key});

  @override
  _AccountOptionsState createState() => _AccountOptionsState();
}

class _AccountOptionsState extends State<AccountOptions> {
  GoogleSignInHandler? googleSignInHandler;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Obtendo a instância de GoogleSignInHandler quando as dependências mudam
    googleSignInHandler =
        Provider.of<GoogleSignInHandler>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 400,
      height: 325,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(50),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(
            width: 300,
            height: 52,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromARGB(255, 0, 130, 35),
              ),
              onPressed: () => googleSignInHandler?.signInWithGoogle(context),
              child: Text(
                'Entrar com Conta Google',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontFamily: 'Montserrat',
                ),
              ),
            ),
          ),
          SizedBox(
            width: 300,
            height: 52,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromARGB(255, 0, 130, 35),
              ),
              onPressed: () {
                // Cria um usuário visitante e passa como parâmetro
                Usuario visitante = Usuario.visitante();
                
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => InterfacePage(visitante),
                  ),
                );
              },
              child: Text(
                'Entrar como visitante',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontFamily: 'Montserrat',
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
