import 'package:app_veterinaria/DataBase/notes_database.dart';
import 'package:app_veterinaria/Pages/BottonNavBar.dart';
import 'package:app_veterinaria/Pages/Formularios/Gado/CadastroGado.dart';
import 'package:app_veterinaria/Pages/MenuLateral.dart';
import 'package:flutter/material.dart';

final gadoDatabase = NotesDatabase.instance;
void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: LoginScreen(),
    );
  }
}

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  late String _password;
  late String _email;

  void _validadeLogin() async {
    var logado = await gadoDatabase.validadeLogin('usuario', _email, _password);

    if (logado == true) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => MenuLateral(),
        ),
      );
    } else {
      final snackBar = SnackBar(
        content: Text('Usuário ou senha inválidos'),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  // @override
  // Widget build(BuildContext context) {
  //   return Container(
  //     child: Scaffold(
  //       appBar: AppBar(
  //         title: Text('Login'),
  //       ),
  //       body: Form(
  //         key: _formKey,
  //         child: Column(
  //           children: <Widget>[
  //             TextFormField(
  //               validator: (input) {
  //                 if (input!.isEmpty) {
  //                   return 'Por favor insira um email';
  //                 }
  //                 return null;
  //               },
  //               onSaved: (input) => _email = input!,
  //               decoration: InputDecoration(
  //                 labelText: 'Email',
  //               ),
  //             ),
  //             TextFormField(
  //               validator: (input) {
  //                 if (input!.length < 6) {
  //                   return 'A senha deve ter pelo menos 6 caracteres';
  //                 }
  //                 return null;
  //               },
  //               onSaved: (input) => _password = input!,
  //               decoration: InputDecoration(
  //                 labelText: 'Senha',
  //               ),
  //               obscureText: true,
  //             ),
  //             ElevatedButton(
  //               onPressed: _submit,
  //               child: Text('Entrar'),
  //             ),
  //           ],
  //         ),
  //       ),
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(top: 60, left: 40, right: 40),
        color: Colors.white,
        child: ListView(
          children: <Widget>[
            SizedBox(
              width: 128,
              height: 128,
              child: Image.asset("assets/logo.png"),
            ),
            SizedBox(
              height: 20,
            ),
            TextFormField(
              autofocus: true,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                labelText: "E-mail",
                labelStyle: TextStyle(
                  color: Colors.black38,
                  fontWeight: FontWeight.w400,
                  fontSize: 20,
                ),
              ),
              style:
                  TextStyle(fontSize: 20, color: Color.fromARGB(255, 8, 8, 8)),
              onChanged: _updateEmail,
            ),
            SizedBox(
              height: 10,
            ),
            TextFormField(
              // autofocus: true,
              keyboardType: TextInputType.text,
              obscureText: true,
              decoration: InputDecoration(
                labelText: "Senha",
                labelStyle: TextStyle(
                  color: Colors.black38,
                  fontWeight: FontWeight.w400,
                  fontSize: 20,
                ),
              ),
              style:
                  TextStyle(fontSize: 20, color: Color.fromARGB(255, 8, 8, 8)),
              onChanged: _updatePassword,
            ),
            Container(
              height: 40,
              alignment: Alignment.centerRight,
              child: TextButton(
                child: Text(
                  "Recuperar Senha",
                  textAlign: TextAlign.right,
                ),
                onPressed: () {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) => ResetPasswordPage(),
                  //   ),
                  // );
                },
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Container(
              height: 60,
              alignment: Alignment.centerLeft,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  stops: [0.3, 1],
                  colors: [
                    Color.fromARGB(215, 64, 43, 255),
                    Color.fromARGB(255, 28, 2, 90),
                  ],
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(5),
                ),
              ),
              child: SizedBox.expand(
                child: TextButton(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        "Login",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 20,
                        ),
                        textAlign: TextAlign.left,
                      ),
                      // Container(
                      //   child: SizedBox(
                      //     child: Image.asset("assets/bone.png"),
                      //     height: 28,
                      //     width: 28,
                      //   ),
                      // )
                    ],
                  ),
                  onPressed: () {
                    _submit();
                  },
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            // Container(
            //   height: 60,
            //   alignment: Alignment.centerLeft,
            //   decoration: BoxDecoration(
            //     color: Color(0xFF3C5A99),
            //     borderRadius: BorderRadius.all(
            //       Radius.circular(5),
            //     ),
            //   ),
            //   child: SizedBox.expand(
            //     child: TextButton(
            //       child: Row(
            //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //         children: <Widget>[
            //           Text(
            //             "Login com Facebook",
            //             style: TextStyle(
            //               fontWeight: FontWeight.bold,
            //               color: Colors.white,
            //               fontSize: 20,
            //             ),
            //             textAlign: TextAlign.left,
            //           ),
            //           // Container(
            //           //   child: SizedBox(
            //           //     child: Image.asset("assets/fb-icon.png"),
            //           //     height: 28,
            //           //     width: 28,
            //           //   ),
            //           // )
            //         ],
            //       ),
            //       onPressed: () {},
            //     ),
            //   ),
            // ),
            SizedBox(
              height: 10,
            ),
            Container(
              height: 40,
              child: TextButton(
                child: Text(
                  "Cadastre-se",
                  textAlign: TextAlign.center,
                ),
                onPressed: () {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) => SignupPage(),
                  //   ),
                  // );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _updateEmail(String value) {
    setState(() {
      _email = value;
    });
  }

  void _updatePassword(String value) {
    setState(() {
      _password = value;
    });
  }

  void _submit() {
    //if (_formKey.currentState!.validate()) {
    //  _formKey.currentState!.save();
    _validadeLogin();
    //}
  }
}
