import 'package:app_veterinaria/Pages/Formularios/CadastroGado.dart';
import 'package:app_veterinaria/Pages/Formularios/Gado/ListagemGado.dart';
import 'package:flutter/material.dart';

class MenuLateral extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gere Vete'),
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text('Joao P.'),
              accountEmail: Text('seu@email.com'),
              currentAccountPicture: CircleAvatar(
                backgroundImage:
                    //NetworkImage('https://photos.google.com/photo/AF1QipOl2kKKfj_F_C2rmRRbePcTc5mj3eFf3lp3ioD8'),
                    NetworkImage('https://via.placeholder.com/150x150'),
              ),
            ),
            ListTile(
              title: Text('Informações do Gado'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => GadoList()),
                ); // Código para navegar para outra tela
              },
            ),
            ListTile(
              title: Text('Página 2'),
              onTap: () {
                // Código para navegar para outra tela
              },
            ),
            ListTile(
              title: Text('Página 3'),
              onTap: () {
                // Código para navegar para outra tela
              },
            ),
          ],
        ),
      ),
      body: Container(
        child: Center(
          child: Text('Conteúdo da tela principal'),
        ),
      ),
    );
  }
}
