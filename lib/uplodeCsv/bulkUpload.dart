import 'dart:convert';
import 'dart:io';
import 'package:app_veterinaria/DataBase/notes_database.dart';
import 'package:app_veterinaria/Pages/Formularios/QualificacaoAnimal/ListaQulificacaoAnimal.dart';
import 'package:csv/csv.dart';
import 'package:excel/excel.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show SystemUiOverlayStyle, rootBundle;
import 'package:gsheets/gsheets.dart';

import '../Model/qualificacaoAnimal.dart';

final db = NotesDatabase.instance;

class bulkUpload extends StatefulWidget {
  final farm;
  const bulkUpload({Key? key, required this.farm}) : super(key: key);

  @override
  State<bulkUpload> createState() => _bulkUploadState();
}

class _bulkUploadState extends State<bulkUpload> {
  bool hasData = false;
  List<List<dynamic>> _data = [];
  String? filePath;
  var _farm;

  // Declare a list to store the Excel data
  List<List<dynamic>> dataOfExcel = [];

  @override
  void initState() {
    super.initState();
    _farm = widget.farm;
  }

  // This function is triggered when the button is pressed

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.white,
          statusBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.light,
        ),
        title: const Text(
          "Bulk Upload",
          style: TextStyle(
            color: Colors.white,
            fontSize: 20.0,
          ),
        ),
      ),
      body: Column(
        children: [
          ElevatedButton(
            child: const Text("Visualizar a lista de medições"),
            onPressed: () {
              _navigateListQuafAni();
            },
          ),
          ElevatedButton(
            child: const Text("Upload File"),
            onPressed: () {
              _pickFile();
            },
          ),
          hasData
              ? ElevatedButton(
                  child: const Text("Salvar dados"),
                  onPressed: () async {
                    for (List<dynamic> rowData in dataOfExcel) {
                      String? identificadorAnimal;
                      String? dataAmostra;
                      String? valor;
                      int? fazendaId;

                      for (int i = 1; i < rowData.length; i++) {
                        dynamic item = rowData[i];
                        if (rowData.length == 14) {
                          // Defina os valores para cada campo da tabela
                          identificadorAnimal = rowData[0].toString();
                          dataAmostra = item.toString();
                          valor = item.toString();
                        }

                        QualificacaoAnimal qualificacaoAnimal =
                            QualificacaoAnimal(
                          identificadorAnimal: identificadorAnimal,
                          dataAmostra: dataAmostra,
                          valor: valor,
                          fazendaId: _farm.id,
                        );

                        await db.create(qualificacaoAnimal,
                            'excel_qualificacao_animal_individual');
                      }
                    }
                  },
                )
              : Container(),
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical, // Rolagem vertical
              child: SizedBox(
                width: double.infinity,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal, // Rolagem horizontal
                  child: dataOfExcel.isNotEmpty
                      ? DataTable(
                          columns: [
                            DataColumn(label: Text('Nroa analisados')),
                            DataColumn(label: Text('20/07/23')),
                            DataColumn(label: Text('21/06/23')),
                            DataColumn(label: Text('18/05/23')),
                            DataColumn(label: Text('20/04/23')),
                            DataColumn(label: Text('21/03/23')),
                            DataColumn(label: Text('23/02/23')),
                            DataColumn(label: Text('19/01/23')),
                            DataColumn(label: Text('16/12/22')),
                            // Adicione mais DataColumn widgets para colunas adicionais
                          ],
                          rows: buildDataRowList(),
                        )
                      : Text('No data available.'),
                ),
              ),
            ),
          ),
          Container(
            child: ElevatedButton(
              onPressed: () async {
                // Your iteration logic here
                for (var element in dataOfExcel.skip(1)) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(element.toString()),
                  ));
                }
              },
              child: const Text("Iterate Data"),
            ),
          ),
        ],
      ),
    );
  }

  List<DataRow> buildDataRowList() {
    return this.dataOfExcel.map((rowValues) {
      if (rowValues.length != 3) {
        // Handle the case when the row has an incorrect number of cells
        // For example, you can skip the row or fill missing cells with default values.
        return DataRow(cells: [
          DataCell(Text(rowValues[0].toString(), textAlign: TextAlign.center)),
          DataCell(Text(rowValues[1].toString(), textAlign: TextAlign.center)),
          DataCell(Text(rowValues[2].toString(), textAlign: TextAlign.center)),
          DataCell(Text(rowValues[3].toString(), textAlign: TextAlign.center)),
          DataCell(Text(rowValues[4].toString(), textAlign: TextAlign.center)),
          DataCell(Text(rowValues[5].toString(), textAlign: TextAlign.center)),
          DataCell(Text(rowValues[6].toString(), textAlign: TextAlign.center)),
          DataCell(Text(rowValues[7].toString(), textAlign: TextAlign.center)),
          DataCell(Text(rowValues[8].toString(), textAlign: TextAlign.center)),
        ]);
      }

      return DataRow(
        cells: rowValues.map((cellValue) {
          return DataCell(
            Text(
              cellValue.toString(),
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 15, color: Colors.black),
            ),
          );
        }).toList(),
      );
    }).toList();
  }

  void _pickFile() async {
    final result = await FilePicker.platform.pickFiles(allowMultiple: false);

    // If no file is picked
    if (result == null) return;

    // We will log the name and path of the first picked file (if multiple are selected)
    print(result.files.first.name);

    try {
      final filePath = result.files.first.path!;
      var bytes = File(filePath).readAsBytesSync();
      var excel = Excel.decodeBytes(bytes);

      for (var table in excel.tables.keys) {
        print(table); //sheet Name
        print(excel.tables[table]!.maxCols);
        print(excel.tables[table]!.maxRows);

        // Clear the previous data before processing a new sheet
        this.dataOfExcel.clear();

        // Iterate through rows, starting from index 13 (row 14) to index 57 (row 58)
        for (var rowIndex = 12; rowIndex <= 56; rowIndex++) {
          var row = excel.tables[table]!.rows[rowIndex];

          // Iterate through columns, starting from index 2 (column B) to index 16 (column P)
          List<dynamic> rowValues = [];
          for (var colIndex = 2; colIndex <= 15; colIndex++) {
            var cellValue = row[colIndex]?.value;
            if (cellValue is SharedString) {
              String stringValue =
                  cellValue.toString(); // Converter para uma string
              stringValue = stringValue
                  .replaceAll("<si><t>", "")
                  .replaceAll("</t></si>", "");
              // Agora stringValue contém o valor da string sem as tags <si><t> e </t></si>
              cellValue = stringValue;
            }
            rowValues.add(cellValue);
          }

          this.dataOfExcel.add(rowValues);
        }
      }

      this.setState(() {
        _data = dataOfExcel;
      });

      hasData = true;

      print(dataOfExcel[0][0]);

      // Now dataOfExcel contains the values of cells from row 13 to 57 and columns B to P

    } catch (e) {
      print(e);
    }
  }

  _navigateListQuafAni() {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => ListagemQualificacaoAnimal(farmId: _farm)),
    );
  }
}
