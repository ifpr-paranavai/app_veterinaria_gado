import 'package:app_veterinaria/Pages/Formularios/CadastroGado.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class ItemBorderBox extends StatefulWidget {
  const ItemBorderBox({super.key});

  @override
  State<ItemBorderBox> createState() => _ItemBorderBoxState();
}

class _ItemBorderBoxState extends State<ItemBorderBox> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CadastroGado(),
                ),
              );
              // Código da ação
            },
            child: Container(
              width: double.infinity,
              height: 200,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                image: DecorationImage(
                  image: NetworkImage(
                      "https://cdn-icons-png.flaticon.com/512/17/17004.png"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
