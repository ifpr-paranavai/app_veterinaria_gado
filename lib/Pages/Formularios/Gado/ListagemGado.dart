import 'package:app_veterinaria/Pages/Formularios/CadastroGado.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class GadoList extends StatefulWidget {
  const GadoList({super.key});

  @override
  State<GadoList> createState() => _GadoListState();
}

class _GadoListState extends State<GadoList> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(
        title: Text('Listagem de Gado'),
        backgroundColor: Colors.grey[800],
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Colors.grey[850],
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(30.0)),
                      ),
                      child: TextField(
//                        maxLength: 300,
                        decoration: InputDecoration(
                          hintText: "Procurar...",
                          border: InputBorder.none,
                          suffixIcon: Icon(Icons.search),
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 24.0, vertical: 14),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: buildGadoList(),
            ),
          ],
        ),
      ),
    ));
  }

  buildGadoList() {
    return ListView(
      children: <Widget>[
        ListTile(
          leading: Icon(Icons.add_a_photo),
          title: Text('Pretona', style: TextStyle(color: Colors.white)),
          subtitle: Text('Bovino', style: TextStyle(color: Colors.white)),
          trailing: Icon(Icons.arrow_forward_ios,
              color: Color.fromARGB(255, 255, 255, 255)),
          onTap: () => {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => CadastroGado()),
            )
          },
        ),
      ],
    );
  }
}
