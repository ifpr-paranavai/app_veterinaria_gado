import 'package:app_veterinaria/Model/gado.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../DataBase/notes_database.dart';

final gadoDatabase = NotesDatabase.instance;

class CadastroGado extends StatefulWidget {
  final Gado? gado;

  CadastroGado({this.gado});

  @override
  _CadastroGadoState createState() => _CadastroGadoState();
}

class _CadastroGadoState extends State<CadastroGado> {
  @override
  void initState() {
    super.initState();
    if (widget.gado != null) {
      setState(() {
        _id = widget.gado!.id;
      });
      setState(() {
        _nome = widget.gado!.nome;
      });
      _nome = widget.gado!.nome;
      _numero = widget.gado!.numero;
      _dataNascimento.text =
          DateFormat('dd/MM/yyyy').format(widget.gado!.dataNascimento);
      _dataBaixa = widget.gado!.dataBaixa;
      _motivoBaixa = widget.gado!.motivoBaixa;
      _partosNaoLancados = widget.gado!.partosNaoLancados;
      _partosTotais = widget.gado!.partosTotais;
      _lote = widget.gado!.lote;
      _nomePai = widget.gado!.nomePai;
      _numeroPai = widget.gado!.numeroPai;
      _numeroMae = widget.gado!.numeroMae;
      _nomeMae = widget.gado!.nomeMae;
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
        dataNascimento: DateFormat('dd/MM/yyyy').parse(_dataNascimento.text),
        dataBaixa: _dataBaixa,
        motivoBaixa: _motivoBaixa,
        partosNaoLancados: _partosNaoLancados,
        partosTotais: _partosTotais,
        lote: _lote,
        nomePai: _nomePai,
        numeroPai: _numeroPai,
        numeroMae: _numeroMae,
        nomeMae: _nomeMae,
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
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                  child: TextFormField(
                    initialValue: _nome,
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
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                  child: TextFormField(
                    initialValue: _numero,
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
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                  child: TextFormField(
                    initialValue: _dataBaixa,
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

                Container(
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                  child: TextFormField(
                    initialValue: _motivoBaixa,
                    decoration: InputDecoration(labelText: 'Motivo da Baixa'),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Por favor insira o motivo da baixa';
                      }
                      return null;
                    },
                    onSaved: (value) => _motivoBaixa = value,
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                  child: TextFormField(
                    decoration:
                        InputDecoration(labelText: 'Partos Não Lançados'),
                    initialValue: _partosNaoLancados,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Por favor insira o número de partos não lançados';
                      }
                      return null;
                    },
                    onSaved: (value) => _partosNaoLancados = value,
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                  child: TextFormField(
                    initialValue: _partosTotais,
                    decoration: InputDecoration(labelText: 'Partos Totais'),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Por favor insira o número total de partos';
                      }
                      return null;
                    },
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
                Container(
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                  child: TextFormField(
                    initialValue: _nomeMae,
                    decoration: InputDecoration(labelText: 'Nome do Pai'),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Por favor insira o nome do pai';
                      }
                      return null;
                    },
                    onSaved: (value) => _nomePai = value,
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                  child: TextFormField(
                    initialValue: _numeroMae,
                    decoration: InputDecoration(labelText: 'Numero do Pai'),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Por favor insira o número do pai';
                      }
                      return null;
                    },
                    onSaved: (value) => _numeroPai = value,
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                  child: TextFormField(
                    initialValue: _numeroMae,
                    decoration: InputDecoration(labelText: 'Numero da Mae'),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Por favor insira o número da mãe';
                      }
                      return null;
                    },
                    onSaved: (value) => _numeroMae = value,
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                  child: TextFormField(
                    initialValue: _nomeMae,
                    decoration: InputDecoration(labelText: 'Nome da Mae'),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Por favor insira o nome da mãe';
                      }
                      return null;
                    },
                    onSaved: (value) => _nomeMae = value,
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
}
