import 'package:app_veterinaria/Pages/Formularios/Breed/BreedList.dart';
import 'package:app_veterinaria/Pages/Formularios/Gado/CadastroGado.dart';
import 'package:app_veterinaria/Pages/Formularios/Gado/ListagemGado.dart';
import 'package:app_veterinaria/Pages/Formularios/Matriz/HeadquartersList.dart';
import 'package:app_veterinaria/Pages/Formularios/Notes/NoteCadastro.dart';
import 'package:app_veterinaria/Pages/Usuario/UserList.dart';
import 'package:app_veterinaria/components/BranchSelectedDialog.dart';
import 'package:flutter/material.dart';

import 'Formularios/Matriz/headquartersRegistration.dart';

class MenuLateral extends StatefulWidget {
  final farm;
  const MenuLateral({Key? key, required this.farm}) : super(key: key);
  @override
  State<MenuLateral> createState() => _MenuLateralState();
}

class _MenuLateralState extends State<MenuLateral> {
  var _farm;

  @override
  void initState() {
    super.initState();
    _farm = widget.farm;
  }

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
                    NetworkImage('https://via.placeholder.com/150x150'),
              ),
            ),
            ListTile(
              title: Text('Informações dos Usuarios'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => UserList()),
                ); // Código para navegar para outra tela
              },
            ),
            ListTile(
              title: Text('Informações das Raças'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => BreedList()),
                );
              },
            ),
            ListTile(
              title: Text('Informações do Gado'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => GadoList(farm: _farm)),
                ); // Código para navegar para outra tela
              },
            ),
            ListTile(
              title: Text('Informações da Matriz'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HeadquartersList()),
                ); // Código para navegar para outra tela
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
