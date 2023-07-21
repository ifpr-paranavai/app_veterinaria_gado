import 'package:app_veterinaria/DataBase/notes_database.dart';
import 'package:app_veterinaria/Pages/BottonNavBar.dart';
import 'package:app_veterinaria/Pages/Formularios/Gado/CadastroGado.dart';
import 'package:app_veterinaria/Pages/IntermedieteScreen.dart';
import 'package:app_veterinaria/Services/theme_services.dart';
import 'package:app_veterinaria/ui/MenuLateral.dart';
import 'package:app_veterinaria/Services/LoginResult.dart';
import 'package:app_veterinaria/ui/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

final gadoDatabase = NotesDatabase.instance;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: Themes.light,
      darkTheme: Themes.dark,
      themeMode: ThemeService().theme,
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
    var logado = await gadoDatabase.validadeLogin('usuario', _email, _password)
        as LoginResult;
    //logado is an object that have user and a list of headquaters
    if (logado.headquartersList.length > 0) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => IntemediateScreen(loginResult: logado),
        ),
      );
    } else {
      final snackBar = SnackBar(
        content: Text('Usuário ou senha inválidos'),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Form(
          key: _formKey,
          child: Container(
            padding: EdgeInsets.only(top: 60, left: 40, right: 40),
            color: Color.fromARGB(255, 176, 238, 172),
            child: ListView(
              children: <Widget>[
                SizedBox(
                  width: 128,
                  height: 128,
                  child: Image.asset("assets/LogoLogin.png"),
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  validator: (e) {
                    if (e!.isEmpty) {
                      return "Digite seu e-mail";
                    } else
                      return null;
                  },
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
                  style: TextStyle(
                      fontSize: 20, color: Color.fromARGB(255, 8, 8, 8)),
                  onChanged: _updateEmail,
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  validator: (e) {
                    if (e!.isEmpty) {
                      return "Digite sua senha";
                    } else
                      return null;
                  },
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
                  style: TextStyle(
                      fontSize: 20, color: Color.fromARGB(255, 8, 8, 8)),
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
                  height: 50,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 58, 182, 1),
                    borderRadius: BorderRadius.all(
                      Radius.circular(50),
                    ),
                  ),
                  child: SizedBox.expand(
                    child: TextButton(
                      child: Text(
                        "Login",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 20,
                        ),
                        textAlign: TextAlign.center,
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
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      _validadeLogin();
    }
  }
}
