import 'package:flutter/material.dart';

class BranchSelectionDialog extends StatelessWidget {
  final List<dynamic> logado;

  const BranchSelectionDialog({Key? key, required this.logado})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Selecione a martriz'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            visualDensity: VisualDensity.compact,
            tileColor: Colors.grey[200],
          ),
          for (var farm in logado)
            ListTile(
              title: Text(farm.name),
              onTap: () {
                // do something with the selected breed
                Navigator.pop(context);
              },
            ),
        ],
      ),
    );
  }
}
