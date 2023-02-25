import 'package:app_veterinaria/Pages/Formularios/Gado/CadastroGado.dart';
import 'package:app_veterinaria/Pages/ItemBorderBox.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BottonNavBar extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<BottonNavBar> {
  int _selectedIndex = 0;
  final _pageOptions = [
    //CadastroGado(),
    SearchPage(),
    SettingsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Exemplo de BottomNavigationBar'),
      ),
      body: _pageOptions[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (int index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.square_favorites),
            label: 'Formulário',
            activeIcon:
                Icon(CupertinoIcons.square_favorites, color: Colors.blue),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            //title: Text(''),
            label: 'Pesquisar',
            activeIcon: Icon(Icons.search, color: Colors.blue),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            //title: Text('Settings'),
            label: 'Configurações',
            activeIcon: Icon(Icons.search, color: Colors.blue),
          ),
        ],
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Home Page'),
    );
  }
}

class SearchPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Search Page'),
    );
  }
}

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Settings Page'),
    );
  }
}
