import 'dart:convert';

import 'package:app_veterinaria/Model/breed.dart';
import 'package:app_veterinaria/Model/gado.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import '../../../DataBase/notes_database.dart';

final gadoDatabase = NotesDatabase.instance;

class CadastroGado extends StatefulWidget {
  final Gado? gado;
  final int headquarters;

  CadastroGado({this.gado, required this.headquarters});

  @override
  _CadastroGadoState createState() => _CadastroGadoState();
}

class _CadastroGadoState extends State<CadastroGado> {
  var _headquarters;

  @override
  void initState() {
    super.initState();

    _headquarters = widget.headquarters;
    fetchAutoCompleteData();
    if (widget.gado != null) {
      _getBreedName(widget.gado!.breedId).then((value) {
        setState(() {
          _selectedBreedName = value;
        });
      });
      setState(() {
        _id = widget.gado!.id;
      });
      setState(() {
        _nome = widget.gado!.nome;
      });
      _nome = widget.gado!.nome;
      _numero = widget.gado!.numero;
      _dataNascimento.text = widget.gado?.dataNascimento != null
          ? DateFormat('dd/MM/yyyy').format(widget.gado!.dataNascimento!)
          : '';
      _selectedBreedId = widget.gado!.breedId;
    }
  }

  final _formKey = GlobalKey<FormState>();

  Future<void> __saveGado() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      Gado gado = Gado(
        id: _id,
        nome: _nome,
        numero: _numero,
        dataNascimento: _dataNascimento.text != ""
            ? DateFormat('dd/MM/yyyy').parse(_dataNascimento.text)
            : null,
        partosNaoLancados: _partosNaoLancados,
        partosTotais: _partosTotais,
        breedId: _selectedBreedId,
        farmId: _headquarters,
      );

      await gadoDatabase.create(gado, 'gado');

      Navigator.pop(context);
      // Adicione aqui a chamada para a função de salvar
      // passando a nota como parâmetro
    }
  }

  TextEditingController _dataNascimento = TextEditingController();

  Widget fieldDataNascimento() {
    return Padding(
      padding: const EdgeInsets.all(0),
      child: TextFormField(
        controller: _dataNascimento,
        decoration: const InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color.fromARGB(255, 61, 10, 201)),
            borderRadius: BorderRadius.all(Radius.circular(20.0)),
          ),
          icon: Icon(Icons.calendar_today_rounded,
              color: Color.fromARGB(255, 61, 10, 201)),
          hintText: 'Data de Nascimento',
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
              _dataNascimento.text = DateFormat('dd/MM/yyyy').format(pickDate);
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
  String? _nome;
  String? _numero;
  String? _motivoBaixa;
  String? _partosNaoLancados;
  String? _partosTotais;
  String? _lote;
  String? _nomePai;
  String? _numeroPai;
  String? _numeroMae;
  String? _nomeMae;
  late List<Breed> autocompleteData;
  bool isLoading = false;
  int? _selectedBreedId;
  String? _selectedBreedName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastro de Gado'),
      ),
      body: Container(
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                  child: TextFormField(
                    initialValue: _nome,
                    decoration: InputDecoration(labelText: 'Nome'),
                    validator: (value) {
                      if (value!.isEmpty && _numero == null) {
                        return 'Por favor insira o nome ou o número do animal';
                      }
                      return null;
                    },
                    onChanged: (value) => _nome = value,
                    onSaved: (value) => _nome = value,
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                  child: TextFormField(
                    initialValue: _numero,
                    decoration: InputDecoration(labelText: 'Numero'),
                    keyboardType: TextInputType.number,
                    validator: (e) {
                      if (e!.isEmpty && _nome == null) {
                        return 'Por favor insira o número ou nome do animal';
                      }
                      return null;
                    },
                    onSaved: (value) => _numero = value,
                  ),
                ),
                isLoading
                    ? CircularProgressIndicator()
                    : Padding(
                        padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                        child: Column(
                          children: [
                            Autocomplete<Breed>(
                              initialValue: _selectedBreedName != null
                                  ? TextEditingValue(
                                      text: _selectedBreedName!,
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
                                    labelText: 'Raça',
                                  ),
                                );
                              },
                              optionsBuilder:
                                  (TextEditingValue textEditingValue) {
                                print(autocompleteData);
                                return autocompleteData.where((option) =>
                                    option.name!.toLowerCase().contains(
                                        textEditingValue.text.toLowerCase()));
                              },
                              onSelected: (option) {
                                this.setState(() {
                                  _selectedBreedId = option.id;
                                });
                              },
                              displayStringForOption: (option) => option.name!,
                            ),
                          ],
                        ),
                      ),
                fieldDataNascimento(),
                Container(
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                  child: TextFormField(
                    initialValue: _motivoBaixa,
                    decoration: InputDecoration(labelText: 'Motivo da Baixa'),
                    // validator: (value) {
                    //   if (value!.isEmpty) {
                    //     return 'Por favor insira o motivo da baixa';
                    //   }
                    //   return null;
                    // },
                    onSaved: (value) => _motivoBaixa = value,
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                  child: TextFormField(
                    decoration:
                        InputDecoration(labelText: 'Partos Não Lançados'),
                    initialValue: _partosNaoLancados,
                    // validator: (value) {
                    //   if (value!.isEmpty) {
                    //     return 'Por favor insira o número de partos não lançados';
                    //   }
                    //   return null;
                    // },
                    onSaved: (value) => _partosNaoLancados = value,
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                  child: TextFormField(
                    initialValue: _partosTotais,
                    decoration: InputDecoration(labelText: 'Partos Totais'),
                    // validator: (value) {
                    //   if (value!.isEmpty) {
                    //     return 'Por favor insira o número total de partos';
                    //   }
                    //   return null;
                    // },
                    onSaved: (value) => _partosTotais = value,
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                  child: TextFormField(
                    initialValue: _lote,
                    decoration: InputDecoration(labelText: 'Lote'),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Por favor insira o lote';
                      }
                      return null;
                    },
                    onSaved: (value) => _lote = value,
                  ),
                ),
                ElevatedButton(
                  onPressed: __saveGado,
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

    var search = await gadoDatabase.searchDataWithParamiter('breed', '');

    search as List<Breed>;

    setState(() {
      isLoading = false;
      autocompleteData = search;
    });
  }

  _getBreedName([int? selectedBreedId]) async {
    var search = await gadoDatabase.searchNameById(selectedBreedId);
    if (search != null) {
      var breed = search as Breed;

      return breed.name;
    }
  }
}
