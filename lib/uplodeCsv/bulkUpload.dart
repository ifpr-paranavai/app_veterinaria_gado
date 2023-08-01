import 'dart:convert';
import 'dart:io';
import 'package:csv/csv.dart';
import 'package:excel/excel.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show SystemUiOverlayStyle, rootBundle;
import 'package:gsheets/gsheets.dart';

class bulkUpload extends StatefulWidget {
  final farm;
  const bulkUpload({Key? key, required this.farm}) : super(key: key);

  @override
  State<bulkUpload> createState() => _bulkUploadState();
}

class _bulkUploadState extends State<bulkUpload> {
  List<List<dynamic>> _data = [];
  String? filePath;

  // Declare a list to store the Excel data
  List<List<dynamic>> dataOfExcel = [];

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
            child: const Text("Upload File"),
            onPressed: () {
              _pickFile();
            },
          ),
          Expanded(
            child: SingleChildScrollView(
              child: dataOfExcel.isNotEmpty
                  ? DataTable(
                      columns: [
                        DataColumn(label: Text('$dataOfExcel[0]')),
                        DataColumn(label: Text('Column 2')),
                        DataColumn(label: Text('Column 3')),
                        DataColumn(label: Text('Column 3')),
                        // Add more DataColumn widgets for additional columns
                      ],
                      rows: buildDataRowList(),
                    )
                  : Text('No data available.'),
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
          DataCell(Text('Invalid Row', textAlign: TextAlign.center)),
          DataCell(Text('Invalid Row', textAlign: TextAlign.center)),
          DataCell(Text('Invalid Row', textAlign: TextAlign.center)),
          DataCell(Text('Invalid Row', textAlign: TextAlign.center)),
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
            if (cellValue is String) {
              cellValue = cellValue
                  .replaceAll("<si><t>", "")
                  .replaceAll("</t></si>", "");
            }
            rowValues.add(cellValue);
          }

          this.dataOfExcel.add(rowValues);
        }
      }

      this.setState(() {
        _data = dataOfExcel;
      });

      // Now dataOfExcel contains the values of cells from row 13 to 57 and columns B to P

    } catch (e) {
      print(e);
    }
  }
}
