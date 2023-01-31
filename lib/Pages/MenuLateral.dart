import 'package:app_veterinaria/Pages/Formularios/CadastroGado.dart';
import 'package:flutter/material.dart';

class MenuLateral extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Navbar Lateral'),
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text('Seu nome'),
              accountEmail: Text('seu@email.com'),
              currentAccountPicture: CircleAvatar(
                backgroundImage:
                    NetworkImage('https://via.placeholder.com/150x150'),
              ),
            ),
            ListTile(
              title: Text('Página 1'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CadastroGado()),
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
