import 'package:app_veterinaria/Pages/Formularios/Breed/BreedList.dart';
import 'package:app_veterinaria/Pages/Formularios/Gado/CadastroGado.dart';
import 'package:app_veterinaria/Pages/Formularios/Gado/ListagemGado.dart';
import 'package:app_veterinaria/Pages/Formularios/Historic/HistoricRegistration.dart';
import 'package:app_veterinaria/Pages/Formularios/Historic/ListagemHistoricoAnimal.dart';
import 'package:app_veterinaria/Pages/Formularios/Matriz/HeadquartersList.dart';
import 'package:app_veterinaria/Pages/Formularios/Notes/NoteCadastro.dart';
import 'package:app_veterinaria/Pages/Formularios/Pesagem/CadastroPesagem.dart';
import 'package:app_veterinaria/Pages/Formularios/Pesagem/ListagemPesagemAnimal.dart';
import 'package:app_veterinaria/Pages/Formularios/event/ListagemEventos.dart';
import 'package:app_veterinaria/Pages/Formularios/vacina/CadastroVacina.dart';
import 'package:app_veterinaria/Pages/Formularios/vacina/ListagemVacinaAnimal.dart';
import 'package:app_veterinaria/Pages/RodaReproducao/RodaReproducaoScreen.dart';
import 'package:app_veterinaria/Pages/Usuario/UserList.dart';
import 'package:app_veterinaria/components/BranchSelectedDialog.dart';
import 'package:app_veterinaria/uplodeCsv/bulkUpload.dart';
import 'package:flutter/material.dart';

import '../Pages/Formularios/Matriz/headquartersRegistration.dart';
import '../Pages/Sincronizar/Synchronize.dart';

class MenuLateral extends StatefulWidget {
  final farm;
  final user;
  const MenuLateral({Key? key, required this.farm, required this.user})
      : super(key: key);
  @override
  State<MenuLateral> createState() => _MenuLateralState();
}

class _MenuLateralState extends State<MenuLateral> {
  var _farm;
  var _userLoged;

  @override
  void initState() {
    super.initState();
    _farm = widget.farm;
    _userLoged = widget.farm;
  }

  // Lista de quadrados com ícone de boi
  final List<Map<String, dynamic>> boiItems = [
    {'title': 'Informações dos Usuarios', 'icon': Icons.insert_emoticon},
    {'title': 'Informações das Raças', 'icon': Icons.pets},
    {'title': 'Informações do Gado', 'icon': Icons.donut_small},
    {'title': 'Pesagem do animal', 'icon': Icons.accessibility},
    {'title': 'Histórico do animal', 'icon': Icons.h_plus_mobiledata},
    {'title': 'Vacinas', 'icon': Icons.vaccines},
    {'title': 'Eventos', 'icon': Icons.calendar_month_outlined},
    {'title': 'Qualificação Animal', 'icon': Icons.document_scanner_outlined},
    {'title': 'Roda da Reprodução', 'icon': Icons.read_more},
    {
      'title': 'Sincronizar Dados',
      'icon': IconData(0xf04ce, fontFamily: 'MaterialIcons')
    },
    // Adicione mais itens de acordo com suas necessidades
  ];

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
              title: Text('Pesagem do animal'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ListagemPesagemAnimal(farm: _farm)),
                ); // Código para navegar para outra tela
              },
            ),
            // ListTile(
            //   title: Text('Qualidade do leite'),
            //   onTap: () {
            //     // Navigator.push(
            //     //     context, MaterialPageRoute(builder: (context) => {}));
            //   },
            // ),
            ListTile(
              title: Text('Informações da Matriz'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => HeadquartersList(userLoged: _userLoged)),
                ); // Código para navegar para outra tela
              },
            ),
            ListTile(
              title: Text('Historico dos Animais'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => HistoricRegistration()),
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
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, // Defina o número de colunas desejado
            ),
            itemCount: boiItems.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  // Ação a ser executada quando o quadrado for clicado
                  _onBoiItemClicked(index);
                },
                child: Card(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          boiItems[index]['icon'],
                          size: 50,
                        ),
                        SizedBox(height: 10),
                        Text(
                          boiItems[index]['title'],
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  void _onBoiItemClicked(int index) {
    // Ação a ser executada quando um quadrado for clicado
    switch (index) {
      case 0:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => UserList()),
        );
        break;
      case 1:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => BreedList()),
        );
        break;
      case 2:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => GadoList(farm: _farm)),
        );
        break;
      case 3:
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ListagemPesagemAnimal(farm: _farm)),
        );
        break;
      case 4:
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ListagemHistoricoAnimal(farm: _farm)),
        );
        break;
      case 5:
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ListagemVacinaAnimal(farm: _farm)),
        );
        break;
      case 6:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ListagemEventos(farm: _farm)),
        );
        break;
      case 7:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => bulkUpload(farm: _farm)),
        );
        break;
      case 8:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => RodaReproducaoScreen()),
        );
        break;
      case 9:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Synchronize(farm: _farm)),
        );
        break;
      // Adicione mais casos de acordo com os itens adicionados acima
      default:
        // Caso nenhum tratamento específico seja necessário
        break;
    }
  }
}
