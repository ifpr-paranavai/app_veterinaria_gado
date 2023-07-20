import 'package:app_veterinaria/Model/gado.dart';
import 'package:app_veterinaria/Model/historico.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl/intl.dart';

import '../../../DataBase/notes_database.dart';

final database = NotesDatabase.instance;

class HistoricRegistration extends StatefulWidget {
  final Historico? historico;

  const HistoricRegistration({super.key, this.historico});

  @override
  State<HistoricRegistration> createState() => _HistoricRegistrationState();
}

class _HistoricRegistrationState extends State<HistoricRegistration> {
  @override
  void initState() {
    super.initState();

    fetchAutoCompleteData();
    if (widget.historico != null) {
      _getGadoName(widget.historico!.idAnimal).then((value) {
        setState(() {
          _selectedAnimalName = value;
        });
      });
      setState(() {
        _id = widget.historico!.id;
      });
      setState(() {
        _descricao = widget.historico!.descricao;
      });
      _diaOcorrencia.text = widget.historico?.diaOcorrencia != null
          ? DateFormat('dd/MM/yyyy').format(widget.historico!.diaOcorrencia!)
          : DateFormat('dd/MM/yyyy').format(DateTime.now());
      _selectedAnimalId = widget.historico!.idAnimal;
      _descricaoController.text = widget.historico?.descricao ?? '';
    }
  }

  final _formKey = GlobalKey<FormState>();

  Future<void> _save() async {
    if (true) {
      print("CHegou aqui");
      Historico historico = Historico(
        id: _id,
        descricao: _descricao,
        diaOcorrencia: _diaOcorrencia.text != ""
            ? DateFormat('dd/MM/yyyy').parse(_diaOcorrencia.text)
            : null,
        idAnimal: _selectedAnimalId,
        tipo: 1,
      );

      await database.create(historico, 'historico');

      Navigator.pop(context);
    }
  }

  List<DateTime> _markedDates = [
    DateTime(2022, 1, 1),
    DateTime(2022, 2, 14),
    DateTime(2022, 3, 15),
  ];

  int? _id;
  String? _descricao;
  String? _peso;
  late List<Gado> autocompleteData;
  bool isLoading = false;
  int? _selectedAnimalId;
  String? _selectedAnimalName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastro de Historico'),
      ),
      body: Container(
        key: _formKey,
        child: Form(
          child: SingleChildScrollView(
            child: Column(
              children: [
                isLoading
                    ? CircularProgressIndicator()
                    : Padding(
                        padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                        child: Column(
                          children: [
                            Autocomplete<Gado>(
                              initialValue: _selectedAnimalName != null
                                  ? TextEditingValue(
                                      text: _selectedAnimalName!,
                                    )
                                  : null,
                              fieldViewBuilder: (context, textEditingController,
                                  focusNode, onFieldSubmitted) {
                                return TextFormField(
                                  controller: textEditingController,
                                  focusNode: focusNode,
                                  onFieldSubmitted: (value) {
                                    onFieldSubmitted();
                                  },
                                  decoration: InputDecoration(
                                    labelText: 'Animal',
                                  ),
                                );
                              },
                              optionsBuilder:
                                  (TextEditingValue textEditingValue) {
                                print(autocompleteData);
                                return autocompleteData.where((option) =>
                                    option.nome!.toLowerCase().contains(
                                        textEditingValue.text.toLowerCase()));
                              },
                              onSelected: (option) {
                                this.setState(() {
                                  _selectedAnimalId = option.id;
                                });
                              },
                              displayStringForOption: (option) => option.nome!,
                            ),
                          ],
                        ),
                      ),
                fieldData(),
                SizedBox(height: 40),
                Container(
                  child: Text(
                    'Descrição',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 16, horizontal: 2),
                  child: TextFormField(
                    maxLines: 6,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                    textInputAction: TextInputAction.newline,
                    controller: _descricaoController, // Use the controller
                    onChanged: (value) {
                      setState(() {
                        _descricao =
                            value; // Update _descricao as the user types
                      });
                    },
                  ),
                ),
                ElevatedButton(
                  onPressed: _save,
                  child: Text('Cadastrar'),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future fetchAutoCompleteData() async {
    setState(() {
      isLoading = true;
    });

    var search = await database.searchDataWithParamiter('gado', '');

    search as List<Gado>;

    setState(() {
      isLoading = false;
      autocompleteData = search;
    });
  }

  _getGadoName([int? selectedIdAnimal]) async {
    var search = await database.searchNameById(selectedIdAnimal);
    if (search != null) {
      var breed = search as Gado;

      return breed.nome;
    }
  }

  TextEditingController _diaOcorrencia = TextEditingController();
  TextEditingController _descricaoController = TextEditingController();

  Widget fieldData() {
    return Padding(
      padding: const EdgeInsets.all(0),
      child: TextFormField(
        controller: _diaOcorrencia,
        decoration: const InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color.fromARGB(255, 61, 10, 201)),
            borderRadius: BorderRadius.all(Radius.circular(20.0)),
          ),
          icon: Icon(Icons.calendar_today_rounded,
              color: Color.fromARGB(255, 61, 10, 201)),
          hintText: 'Data da ocorrencia',
        ),
        onTap: () async {
          DateTime? pickDate = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2000),
            lastDate: DateTime.now(),
          );

          if (pickDate != null) {
            setState(() {
              _diaOcorrencia.text = DateFormat('dd/MM/yyyy').format(pickDate);
            });
          }
        },
      ),
    );
  }
}
