import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CadastroGado extends StatefulWidget {
  @override
  _CadastroGadoState createState() => _CadastroGadoState();
}

class _CadastroGadoState extends State<CadastroGado> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController _date = TextEditingController();

  Widget fieldDataNascimento() {
    return Padding(
      padding: const EdgeInsets.all(0),
      child: TextFormField(
        //onChanged: (newValue) => back.object.raca = newValue,
        controller: _date,
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
              _date.text = DateFormat('dd/MM/yyyy').format(pickDate);
            });
          }
        },
      ),
    );
  }

  DateTime? _selectedDate;
  List<DateTime> _markedDates = [
    DateTime(2022, 1, 1),
    DateTime(2022, 2, 14),
    DateTime(2022, 3, 15),
  ];

  String? _nome;
  String? _numero;
  DateTime? _dataNascimento;
  String? _dataBaixa;
  String? _motivoBaixa;
  String? _partosNaoLancados;
  String? _partosTotais;
  String? _lote;
  String? _nomePai;
  String? _numeroPai;
  String? _numeroMae;
  String? _nomeMae;

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
                  padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                  child: TextFormField(
                    decoration: InputDecoration(labelText: 'Nome'),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Por favor insira o nome';
                      }
                      return null;
                    },
                    onSaved: (value) => _nome = value,
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                  child: TextFormField(
                    decoration: InputDecoration(labelText: 'Numero'),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Por favor insira o numero';
                      }
                      return null;
                    },
                    onSaved: (value) => _numero = value,
                  ),
                ),
                // TextFormField(
                //   decoration: InputDecoration(labelText: 'Data de Nascimento'),
                //   validator: (value) {
                //     if (value!.isEmpty) {
                //       return 'Por favor insira a data de nascimento';
                //     }
                //     return null;
                //   },
                //   onSaved: (value) => _dataNascimento = value,
                // ),
                fieldDataNascimento(),

                Container(
                  padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                  child: TextFormField(
                    decoration: InputDecoration(labelText: 'Data da Baixa'),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Por favor insira a data da baixa';
                      }
                      return null;
                    },
                    onSaved: (value) => _dataBaixa = value,
                  ),
                ),

                TextFormField(
                  decoration: InputDecoration(labelText: 'Motivo da Baixa'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Por favor insira o motivo da baixa';
                    }
                    return null;
                  },
                  onSaved: (value) => _motivoBaixa = value,
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Partos Não Lançados'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Por favor insira o número de partos não lançados';
                    }
                    return null;
                  },
                  onSaved: (value) => _partosNaoLancados = value,
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Partos Totais'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Por favor insira o número total de partos';
                    }
                    return null;
                  },
                  onSaved: (value) => _partosTotais = value,
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Lote'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Por favor insira o lote';
                    }
                    return null;
                  },
                  onSaved: (value) => _lote = value,
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Nome do Pai'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Por favor insira o nome do pai';
                    }
                    return null;
                  },
                  onSaved: (value) => _nomePai = value,
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Numero do Pai'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Por favor insira o número do pai';
                    }
                    return null;
                  },
                  onSaved: (value) => _numeroPai = value,
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Numero da Mae'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Por favor insira o número da mãe';
                    }
                    return null;
                  },
                  onSaved: (value) => _numeroMae = value,
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Nome da Mae'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Por favor insira o nome da mãe';
                    }
                    return null;
                  },
                  onSaved: (value) => _nomeMae = value,
                ),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      // Enviar dados para o servidor ou salvar localmente
                    }
                  },
                  child: Text('Cadastrar'),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
