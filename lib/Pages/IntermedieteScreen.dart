import 'package:app_veterinaria/components/BranchSelectedDialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class IntemediateScreen extends StatefulWidget {
  final logado;
  const IntemediateScreen({super.key, required this.logado});

  @override
  State<IntemediateScreen> createState() => _IntemediateScreenState();
}

class _IntemediateScreenState extends State<IntemediateScreen> {
  @override
  void initState() {
    super.initState();
    //Open dialog after build
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   showDialog(
    //     context: context,
    //     builder: (context) {
    //       return BranchSelectionDialog(logado: widget.logado);
    //     },
    //   );
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Escolha a matriz'),
      ),
      body: Card(
        child: Column(
          children: [
            ListTile(
              visualDensity: VisualDensity.compact,
              tileColor: Colors.grey[300],
              contentPadding: EdgeInsets.symmetric(vertical: 1, horizontal: 40),
            ),
            ...widget.logado
                .asMap()
                .map(
                  (index, gado) => MapEntry(
                    index,
                    Container(
                      color: index % 2 == 0
                          ? Color.fromARGB(167, 32, 121, 66)
                          : Color.fromARGB(255, 202, 231, 190),
                      child: ListTile(
                        //leading: Icon(Icons.add_a_photo),
                        title: Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    gado.name == null || gado.name == ""
                                        ? "XXX-XXX"
                                        : gado.name,
                                    //style: TextStyle(color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                )
                .values
                .toList(),
          ],
        ),
      ),
    );
  }
}