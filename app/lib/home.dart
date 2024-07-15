import 'package:flutter/material.dart';
import 'package:project_uff/database/db.dart';
import 'interface.dart';

class Info {
  TextEditingController nome = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController senha = TextEditingController();
  TextEditingController confir_senha = TextEditingController();
  TextEditingController curso = TextEditingController();
  bool obscured = true;
}

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        Expanded(
          flex: 1,
          child: Container(
            color: Color.fromARGB(255, 225, 230, 232),
            child: Align(
              alignment: Alignment.center,
              child: Image.asset('images/logo.png', fit: BoxFit.fill)
            )
          )
        ),
        Expanded(
          flex: 3,
          child: Container(
            color: Color.fromARGB(255, 225, 230, 232),
            child: Center(
              child: CentralBox(),
            ),
          )
        )
      ])
      );
  }
}

class CentralBox extends StatefulWidget {
  const CentralBox({super.key});

  @override
  State<CentralBox> createState() => _CentralBoxState();
}

class _CentralBoxState extends State<CentralBox> {
  int page = 0;
  Info? info = null;
  final DB db = DB.instance;

  void setPage(int pagec){
    setState(() {
      page = pagec;
      info = null;
    });
  }

  void setInfo(Info infoc, int pagec){
    setState(() {
      page = pagec;
      info = infoc;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (page == 0){
      return Initial(changePage: setPage);
    } else if (page == 1){
      return Verification(changePage: setPage);
    } else if (page == 2){
      return Login(changePage: setPage, db: db);
    } else if (page == 3){
      return Register(changePage: setPage, changePageInfo: setInfo, info: info, db: db);
    } else{
      return Student(changePage: setPage,changePageInfo: setInfo, info: info!, db: db);
    }
  }
}

class Initial extends StatelessWidget {
  final void Function(int) changePage;

  const Initial({super.key, required this.changePage});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 400,
      height: 325,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(50)
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
        SizedBox(
          width: 300,
          height: 52,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Color.fromARGB(255, 0, 130, 35)),
            onPressed: () {
              changePage(2);
            },
            child: Text('Sou professor', style: TextStyle(color: Colors.white, fontSize: 25, fontFamily: 'Montserrat'))
          )
        ),
        SizedBox(
          width: 300,
          height: 52,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Color.fromARGB(255, 0, 130, 35)),
            onPressed: () {
              changePage(1);
            },
            child: Text('Outro', style: TextStyle(color: Colors.white, fontSize: 25, fontFamily: 'Montserrat'))
          )
        )
      ]),
    );
  }
}

class Verification extends StatelessWidget {
  final void Function(int) changePage;

  const Verification({super.key, required this.changePage});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 400,
      height: 325,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(50)
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
        SizedBox(
          width: 300,
          height: 52,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Color.fromARGB(255, 0, 130, 35)),
            onPressed: () {
              changePage(2);
            },
            child: Text('Login', style: TextStyle(color: Colors.white, fontSize: 25, fontFamily: 'Montserrat'))
          )
        ),
        SizedBox(
          width: 300,
          height: 52,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Color.fromARGB(255, 0, 130, 35)),
            onPressed: () {
              changePage(3);
            },
            child: Text('Cadastrar-se', style: TextStyle(color: Colors.white, fontSize: 25, fontFamily: 'Montserrat'))
          )
        )
      ]),
    );
  }
}

class Login extends StatefulWidget {
  final void Function(int) changePage;
  final DB db;

  const Login({super.key, required this.changePage, required this.db});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController email = TextEditingController();
  TextEditingController senha = TextEditingController();
  bool obscured = true;

  void changeVisibility(){
    setState(() {
      obscured = !obscured;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 400,
      height: 325,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(50)
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
        SizedBox(
          width: 300,
          height: 52,
          child: Material(
            color: Colors.transparent,
            child: TextField(
              keyboardType: TextInputType.text,
              controller: email,
              decoration: InputDecoration(
                filled: true,
                fillColor: Color.fromARGB(255, 0, 130, 35),
                hintText: 'Email',
                hintStyle: TextStyle(color: Colors.white, fontSize: 25, fontFamily: 'Montserrat'),
                contentPadding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 20.0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                  borderSide: BorderSide(
                    color: Color.fromARGB(255, 0, 130, 35),
                    width: 2.0,
                  ),
                ),
              ),
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white, fontSize: 25, fontFamily: 'Montserrat'),
            )
          )
        ),
        SizedBox(
          width: 300,
          height: 52,
          child: Material(
            color: Colors.transparent,
            child: TextField(
              keyboardType: TextInputType.text,
              controller: senha,
              obscureText: obscured,
              decoration: InputDecoration(
                filled: true,
                fillColor: Color.fromARGB(255, 0, 130, 35),
                hintText: 'Senha',
                hintStyle: TextStyle(color: Colors.white, fontSize: 25, fontFamily: 'Montserrat'),
                contentPadding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 20.0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                  borderSide: BorderSide(
                    color: Color.fromARGB(255, 0, 130, 35),
                    width: 2.0,
                  ),
                ),
                suffixIcon: senha.text.isNotEmpty
                  ? IconButton(
                    icon: Icon(
                      obscured ? Icons.visibility : Icons.visibility_off,
                      color: Colors.white,
                    ),
                    onPressed: changeVisibility,
                  ) : null,
              ),
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white, fontSize: 25, fontFamily: 'Montserrat'),
              onChanged: (text) {setState(() {});},
            )
          )
        ),
        SizedBox(
          width: 174,
          height: 35.5,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Color.fromARGB(255, 77, 154, 79)),
            onPressed: () async {
              if (email.text.isNotEmpty && senha.text.isNotEmpty){
                var usuarios = await widget.db.getUsuarios();
                bool ver = true;
                usuarios.map((u) {
                  if (senha.text == u['senha'] && email.text == u['email']){
                    int n = u['tipo'] as int;
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => InterfacePage(n),
                      ),
            );
                    ver = false;
                  }
                }).toList();
                if(ver){
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Email ou Senha Incorretos'), backgroundColor: Colors.red, showCloseIcon: true, duration: Duration(seconds: 2))
                  );
                }
              } else {
                if (email.text.isEmpty){
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Preencher campo de email'), backgroundColor: Colors.red, showCloseIcon: true, duration: Duration(seconds: 2))
                  );
                }
                if (senha.text.isEmpty){
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Preencher campo de senha'), backgroundColor: Colors.red, showCloseIcon: true, duration: Duration(seconds: 2))
                  );
                }
              }
            },
            child: Text('Entrar', style: TextStyle(color: Colors.white, fontSize: 25, fontFamily: 'Montserrat'))
          )
        )
      ]),
    );
  }
}

class Register extends StatefulWidget {
  final void Function(int) changePage;
  final void Function(Info, int) changePageInfo;
  final Info? info;
  final DB db;

  const Register({super.key, required this.changePage, required this.changePageInfo, this.info, required this.db});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  Info info = Info();
  bool aluno = false;
  bool func = false;
  bool obscured = true;

  @override
  Widget build(BuildContext context) {
    if (widget.info != null){
      info = widget.info!;
    }
    return Container(
      width: 442.5,
      height: 634,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(50)
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
        SizedBox(
          width: 300,
          height: 52,
          child: Material(
            color: Colors.transparent,
            child: TextField(
              keyboardType: TextInputType.text,
              controller: info.nome,
              decoration: InputDecoration(
                filled: true,
                fillColor: Color.fromARGB(255, 0, 130, 35),
                hintText: 'Nome',
                hintStyle: TextStyle(color: Colors.white, fontSize: 25, fontFamily: 'Montserrat'),
                contentPadding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 20.0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                  borderSide: BorderSide(
                    color: Color.fromARGB(255, 0, 130, 35),
                    width: 2.0,
                  ),
                ),
              ),
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white, fontSize: 25, fontFamily: 'Montserrat'),
            )
          )
        ),
        SizedBox(
          width: 300,
          height: 52,
          child: Material(
            color: Colors.transparent,
            child: TextField(
              keyboardType: TextInputType.text,
              controller: info.email,
              decoration: InputDecoration(
                filled: true,
                fillColor: Color.fromARGB(255, 0, 130, 35),
                hintText: 'Email',
                hintStyle: TextStyle(color: Colors.white, fontSize: 25, fontFamily: 'Montserrat'),
                contentPadding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 20.0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                  borderSide: BorderSide(
                    color: Color.fromARGB(255, 0, 130, 35),
                    width: 2.0,
                  ),
                ),
              ),
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white, fontSize: 25, fontFamily: 'Montserrat'),
            )
          )
        ),
        SizedBox(
          width: 300,
          height: 52,
          child: Material(
            color: Colors.transparent,
            child: TextField(
              keyboardType: TextInputType.text,
              controller: info.senha,
              obscureText: info.obscured,
              decoration: InputDecoration(
                filled: true,
                fillColor: Color.fromARGB(255, 0, 130, 35),
                hintText: 'Senha',
                hintStyle: TextStyle(color: Colors.white, fontSize: 25, fontFamily: 'Montserrat'),
                contentPadding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 20.0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                  borderSide: BorderSide(
                    color: Color.fromARGB(255, 0, 130, 35),
                    width: 2.0,
                  ),
                ),
                suffixIcon: info.senha.text.isNotEmpty
                  ? IconButton(
                    icon: Icon(
                      info.obscured ? Icons.visibility : Icons.visibility_off,
                      color: Colors.white,
                    ),
                    onPressed: (){
                      setState(() {
                        info.obscured = !info.obscured;
                      });
                    },
                  ) : null,
              ),
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white, fontSize: 25, fontFamily: 'Montserrat'),
              onChanged: (text) {setState(() {});},
            )
          )
        ),
        SizedBox(
          width: 300,
          height: 52,
          child: Material(
            color: Colors.transparent,
            child: TextField(
              keyboardType: TextInputType.text,
              controller: info.confir_senha,
              obscureText: obscured,
              decoration: InputDecoration(
                filled: true,
                fillColor: Color.fromARGB(255, 0, 130, 35),
                hintText: 'Confirmar Senha',
                hintStyle: TextStyle(color: Colors.white, fontSize: 25, fontFamily: 'Montserrat'),
                contentPadding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 20.0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                  borderSide: BorderSide(
                    color: Color.fromARGB(255, 0, 130, 35),
                    width: 2.0,
                  ),
                ),
                suffixIcon: info.confir_senha.text.isNotEmpty
                  ? IconButton(
                    icon: Icon(
                      obscured ? Icons.visibility : Icons.visibility_off,
                      color: Colors.white,
                    ),
                    onPressed: (){
                      setState(() {
                        obscured = !obscured;
                      });
                    },
                  ) : null,
              ),
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white, fontSize: 25, fontFamily: 'Montserrat'),
              onChanged: (text) {setState(() {});},
            )
          )
        ),
        SizedBox(
          width: 250,
          height: 84,
          child: Column(children: [
            Text('É aluno da UFF?', style: TextStyle(color: Colors.black, fontSize: 25, fontFamily: 'Montserrat', decoration: TextDecoration.none)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
              Container(
                child: Row(children: [
                Material(
                  color: Colors.transparent,
                  child: Checkbox(
                    activeColor: Colors.black,
                    value: aluno, 
                    onChanged: (bool? val) {
                      setState(() {
                        aluno = true;
                      });
                      widget.changePageInfo(info, 4);
                    }
                  )
                ),
                Text('Sim', style: TextStyle(color: Colors.black, fontSize: 20, fontFamily: 'Montserrat', decoration: TextDecoration.none))
              ])
            ),
              Container(
                child: Row(children: [
                Material(
                  color: Colors.transparent,
                  child: Checkbox(
                    activeColor: Colors.black,
                    value: !aluno, 
                    onChanged: (bool? val) {
                      setState(() {
                        aluno = false;
                      });
                    }
                  )
                ),
                Text('Não', style: TextStyle(color: Colors.black, fontSize: 20, fontFamily: 'Montserrat', decoration: TextDecoration.none))
              ])
            )
            ])
          ])
        ),
        SizedBox(
          width: 250,
          height: 84,
          child: Column(children: [
            Text('É funcionário da UFF?', style: TextStyle(color: Colors.black, fontSize: 25, fontFamily: 'Montserrat', decoration: TextDecoration.none)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
              Container(
                child: Row(children: [
                Material(
                  color: Colors.transparent,
                  child: Checkbox(
                    activeColor: Colors.black,
                    value: func, 
                    onChanged: (bool? val) {
                      setState(() {
                        func = true;
                      });
                    }
                  )
                ),
                Text('Sim', style: TextStyle(color: Colors.black, fontSize: 20, fontFamily: 'Montserrat', decoration: TextDecoration.none))
              ])
            ),
              Container(
                child: Row(children: [
                Material(
                  color: Colors.transparent,
                  child: Checkbox(
                    activeColor: Colors.black,
                    value: !func, 
                    onChanged: (bool? val) {
                      setState(() {
                        func = false;
                      });
                    }
                  )
                ),
                Text('Não', style: TextStyle(color: Colors.black, fontSize: 20, fontFamily: 'Montserrat', decoration: TextDecoration.none))
              ])
            )
            ])
          ])
        ),
        SizedBox(
          width: 174,
          height: 35.5,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Color.fromARGB(255, 77, 154, 79)),
            onPressed: () {
              if (info.nome.text.isNotEmpty && info.email.text.isNotEmpty && info.senha.text.isNotEmpty && info.confir_senha.text.isNotEmpty){
                if (info.senha.text == info.confir_senha.text){
                  widget.db.setUsuarios(info.nome.text, info.email.text, info.senha.text, 'NULL', (func) ? 1 : 0);
                  widget.changePage(0);
                } else{
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Senhas diferentes'), backgroundColor: Colors.red, showCloseIcon: true, duration: Duration(seconds: 2))
                  );
                }
              } else {
                if (info.nome.text.isEmpty){
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Preencher campo de nome'), backgroundColor: Colors.red, showCloseIcon: true, duration: Duration(seconds: 2))
                  );
                }
                if (info.email.text.isEmpty){
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Preencher campo de email'), backgroundColor: Colors.red, showCloseIcon: true, duration: Duration(seconds: 2))
                  );
                }
                if (info.senha.text.isEmpty){
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Preencher campo de senha'), backgroundColor: Colors.red, showCloseIcon: true, duration: Duration(seconds: 2))
                  );
                }
                if (info.confir_senha.text.isEmpty){
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Preencher campo de confirmar senha'), backgroundColor: Colors.red, showCloseIcon: true, duration: Duration(seconds: 2))
                  );
                }
              }
            },
            child: Text('Concluir', style: TextStyle(color: Colors.white, fontSize: 25, fontFamily: 'Montserrat'))
          )
        )
      ]),
    );
  }
}

class Student extends StatefulWidget {
  final void Function(int) changePage;
  final void Function(Info, int) changePageInfo;
  final Info info;
  final DB db;

  const Student({super.key, required this.changePage,required this.changePageInfo, required this.info, required this.db});

  @override
  State<Student> createState() => _StudentState();
}

class _StudentState extends State<Student> {
  TextEditingController curso = TextEditingController();
  bool aluno = true;
  bool obscured = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 442.5,
      height: 634,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(50)
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
        SizedBox(
          width: 300,
          height: 52,
          child: Material(
            color: Colors.transparent,
            child: TextField(
              keyboardType: TextInputType.text,
              controller: widget.info.nome,
              decoration: InputDecoration(
                filled: true,
                fillColor: Color.fromARGB(255, 0, 130, 35),
                hintText: 'Nome',
                hintStyle: TextStyle(color: Colors.white, fontSize: 25, fontFamily: 'Montserrat'),
                contentPadding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 20.0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                  borderSide: BorderSide(
                    color: Color.fromARGB(255, 0, 130, 35),
                    width: 2.0,
                  ),
                ),
              ),
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white, fontSize: 25, fontFamily: 'Montserrat'),
            )
          )
        ),
        SizedBox(
          width: 300,
          height: 52,
          child: Material(
            color: Colors.transparent,
            child: TextField(
              keyboardType: TextInputType.text,
              controller: widget.info.email,
              decoration: InputDecoration(
                filled: true,
                fillColor: Color.fromARGB(255, 0, 130, 35),
                hintText: 'Email',
                hintStyle: TextStyle(color: Colors.white, fontSize: 25, fontFamily: 'Montserrat'),
                contentPadding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 20.0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                  borderSide: BorderSide(
                    color: Color.fromARGB(255, 0, 130, 35),
                    width: 2.0,
                  ),
                ),
              ),
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white, fontSize: 25, fontFamily: 'Montserrat'),
            )
          )
        ),
        SizedBox(
          width: 300,
          height: 52,
          child: Material(
            color: Colors.transparent,
            child: TextField(
              keyboardType: TextInputType.text,
              controller: widget.info.senha,
              obscureText: widget.info.obscured,
              decoration: InputDecoration(
                filled: true,
                fillColor: Color.fromARGB(255, 0, 130, 35),
                hintText: 'Senha',
                hintStyle: TextStyle(color: Colors.white, fontSize: 25, fontFamily: 'Montserrat'),
                contentPadding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 20.0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                  borderSide: BorderSide(
                    color: Color.fromARGB(255, 0, 130, 35),
                    width: 2.0,
                  ),
                ),
                suffixIcon: widget.info.senha.text.isNotEmpty
                  ? IconButton(
                    icon: Icon(
                      widget.info.obscured ? Icons.visibility : Icons.visibility_off,
                      color: Colors.white,
                    ),
                    onPressed: (){
                      setState(() {
                        widget.info.obscured = !widget.info.obscured;
                      });
                    },
                  ) : null,
              ),
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white, fontSize: 25, fontFamily: 'Montserrat'),
              onChanged: (text) {setState(() {});},
            )
          )
        ),
        SizedBox(
          width: 300,
          height: 52,
          child: Material(
            color: Colors.transparent,
            child: TextField(
              keyboardType: TextInputType.text,
              controller: widget.info.confir_senha,
              obscureText: obscured,
              decoration: InputDecoration(
                filled: true,
                fillColor: Color.fromARGB(255, 0, 130, 35),
                hintText: 'Confirmar Senha',
                hintStyle: TextStyle(color: Colors.white, fontSize: 25, fontFamily: 'Montserrat'),
                contentPadding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 20.0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                  borderSide: BorderSide(
                    color: Color.fromARGB(255, 0, 130, 35),
                    width: 2.0,
                  ),
                ),
                suffixIcon: widget.info.confir_senha.text.isNotEmpty
                  ? IconButton(
                    icon: Icon(
                      obscured ? Icons.visibility : Icons.visibility_off,
                      color: Colors.white,
                    ),
                    onPressed: (){
                      setState(() {
                        obscured = !obscured;
                      });
                    },
                  ) : null,
              ),
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white, fontSize: 25, fontFamily: 'Montserrat'),
              onChanged: (text) {setState(() {});},
            )
          )
        ),
        SizedBox(
          width: 250,
          height: 84,
          child: Column(children: [
            Text('É aluno da UFF?', style: TextStyle(color: Colors.black, fontSize: 25, fontFamily: 'Montserrat', decoration: TextDecoration.none)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
              Container(
                child: Row(children: [
                Material(
                  color: Colors.transparent,
                  child: Checkbox(
                    activeColor: Colors.black,
                    value: aluno, 
                    onChanged: (bool? val) {
                      setState(() {
                        aluno = true;
                      });
                    }
                  )
                ),
                Text('Sim', style: TextStyle(color: Colors.black, fontSize: 20, fontFamily: 'Montserrat', decoration: TextDecoration.none))
              ])
            ),
              Container(
                child: Row(children: [
                Material(
                  color: Colors.transparent,
                  child: Checkbox(
                    activeColor: Colors.black,
                    value: !aluno, 
                    onChanged: (bool? val) {
                      setState(() {
                        aluno = false;
                      });
                      widget.changePageInfo(widget.info, 3);
                    }
                  )
                ),
                Text('Não', style: TextStyle(color: Colors.black, fontSize: 20, fontFamily: 'Montserrat', decoration: TextDecoration.none))
              ])
            )
            ])
          ])
        ),
        SizedBox(
          width: 300,
          height: 52,
          child: Material(
            color: Colors.transparent,
            child: TextField(
              keyboardType: TextInputType.text,
              controller: curso,
              decoration: InputDecoration(
                filled: true,
                fillColor: Color.fromARGB(255, 0, 130, 35),
                hintText: 'Curso',
                hintStyle: TextStyle(color: Colors.white, fontSize: 25, fontFamily: 'Montserrat'),
                contentPadding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 20.0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                  borderSide: BorderSide(
                    color: Color.fromARGB(255, 0, 130, 35),
                    width: 2.0,
                  ),
                ),
              ),
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white, fontSize: 25, fontFamily: 'Montserrat'),
            )
          )
        ),
        SizedBox(
          width: 174,
          height: 35.5,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Color.fromARGB(255, 77, 154, 79)),
            onPressed: () {
              if (widget.info.nome.text.isNotEmpty && widget.info.email.text.isNotEmpty && widget.info.senha.text.isNotEmpty && widget.info.confir_senha.text.isNotEmpty && curso.text.isNotEmpty){
                if (widget.info.senha.text == widget.info.confir_senha.text){
                  widget.db.setUsuarios(widget.info.nome.text, widget.info.email.text, widget.info.senha.text, widget.info.curso.text, 0);
                  widget.changePage(0);
                } else{
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Senhas diferentes'), backgroundColor: Colors.red, showCloseIcon: true, duration: Duration(seconds: 2))
                  );
                }
              } else {
                if (widget.info.nome.text.isEmpty){
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Preencher campo de nome'), backgroundColor: Colors.red, showCloseIcon: true, duration: Duration(seconds: 2))
                  );
                }
                if (widget.info.email.text.isEmpty){
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Preencher campo de email'), backgroundColor: Colors.red, showCloseIcon: true, duration: Duration(seconds: 2))
                  );
                }
                if (widget.info.senha.text.isEmpty){
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Preencher campo de senha'), backgroundColor: Colors.red, showCloseIcon: true, duration: Duration(seconds: 2))
                  );
                }
                if (widget.info.confir_senha.text.isEmpty){
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Preencher campo de confirmar senha'), backgroundColor: Colors.red, showCloseIcon: true, duration: Duration(seconds: 2))
                  );
                }
                if (curso.text.isEmpty){
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Preencher campo de curso'), backgroundColor: Colors.red, showCloseIcon: true, duration: Duration(seconds: 2))
                  );
                }
              }
            },
            child: Text('Concluir', style: TextStyle(color: Colors.white, fontSize: 25, fontFamily: 'Montserrat'))
          )
        )
      ]),
    );
  }
}