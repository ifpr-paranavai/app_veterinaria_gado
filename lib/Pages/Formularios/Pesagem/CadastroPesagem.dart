import 'dart:convert';

import 'package:app_veterinaria/Model/breed.dart';
import 'package:app_veterinaria/Model/gado.dart';
import 'package:app_veterinaria/Model/pesagem.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import '../../../DataBase/notes_database.dart';

final pesagemDatabase = NotesDatabase.instance;

class CadastroPesagem extends StatefulWidget {
  final Pesagem? pesagem;
  // final int headquarters;

  CadastroPesagem({this.pesagem});
  // , required this.headquarters
  @override
  _CadastroPesagemState createState() => _CadastroPesagemState();
}

class _CadastroPesagemState extends State<CadastroPesagem> {
  var _headquarters;

  @override
  void initState() {
    super.initState();

    // _headquarters = widget.headquarters;
    fetchAutoCompleteData();
    if (widget.pesagem != null) {
      _getGadoName(widget.pesagem!.gadoId).then((value) {
        setState(() {
          _selectedAnimalName = value;
        });
      });
      setState(() {
        _id = widget.pesagem!.id;
      });
      setState(() {
        _anotacao = widget.pesagem!.anotacao;
      });
      _dataPesagem.text = widget.pesagem?.dataPesagem != null
          ? DateFormat('dd/MM/yyyy').format(widget.pesagem!.dataPesagem!)
          : '';
      _selectedAnimalId = widget.pesagem!.gadoId;
    }
  }

  final _formKey = GlobalKey<FormState>();

  Future<void> __savePesagem() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      Pesagem pesagem = Pesagem(
        id: _id,
        anotacao: _anotacao,
        dataPesagem: _dataPesagem.text != ""
            ? DateFormat('dd/MM/yyyy').parse(_dataPesagem.text)
            : null,
        peso: double.parse(_peso!),
        gadoId: _selectedAnimalId,
      );

      await pesagemDatabase.create(pesagem, 'pesagem');

      Navigator.pop(context);
      // Adicione aqui a chamada para a função de salvar
      // passando a nota como parâmetro
    }
  }

  TextEditingController _dataPesagem = TextEditingController();

  Widget fieldDataPesagem() {
    return Padding(
      padding: const EdgeInsets.all(0),
      child: TextFormField(
        controller: _dataPesagem,
        decoration: const InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color.fromARGB(255, 61, 10, 201)),
            borderRadius: BorderRadius.all(Radius.circular(20.0)),
          ),
          icon: Icon(Icons.calendar_today_rounded,
              color: Color.fromARGB(255, 61, 10, 201)),
          hintText: 'Data da pesagem',
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
              _dataPesagem.text = DateFormat('dd/MM/yyyy').format(pickDate);
            });
          }
        },
      ),
    );
  }

  List<DateTime> _markedDates = [
    DateTime(2022, 1, 1),
    DateTime(2022, 2, 14),
    DateTime(2022, 3, 15),
  ];

  int? _id;
  String? _anotacao;
  String? _peso;
  late List<Gado> autocompleteData;
  bool isLoading = false;
  int? _selectedAnimalId;
  String? _selectedAnimalName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastro de Pesagem'),
      ),
      body: Container(
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
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
                Container(
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                  child: TextFormField(
                    initialValue: _anotacao,
                    decoration: InputDecoration(labelText: 'Observação'),
                    onChanged: (value) => _anotacao = value,
                    onSaved: (value) => _anotacao = value,
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                  child: TextFormField(
                    initialValue: _peso,
                    decoration: InputDecoration(labelText: 'Peso'),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value!.isEmpty && _peso == null) {
                        return 'Insira o peso do animal';
                      }
                      return null;
                    },
                    onSaved: (value) => _peso = value,
                  ),
                ),

                fieldDataPesagem(),
                ElevatedButton(
                  onPressed: __savePesagem,
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

    var search = await pesagemDatabase.searchDataWithParamiter('gado', '');

    search as List<Gado>;

    print("Olha aqui ");

    setState(() {
      isLoading = false;
      autocompleteData = search;
    });
  }

  _getGadoName([int? selectedGadoId]) async {
    var search = await pesagemDatabase.searchNameById(selectedGadoId);
    if (search != null) {
      var breed = search as Gado;

      return breed.nome;
    }
  }
}
