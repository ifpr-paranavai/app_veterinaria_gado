final String tablevacina = 'vacina';

class VacinaFields {
  static final List<String> values = [
    /// Add all fields
    id, idAnimal, observacao, dataAplicacao, responsavel, localAplicacao,
    numeroLote, validade, dosagem
  ];

  static final String id = '_id';
  static final String idAnimal = 'idAnimal';
  static final String nome = 'nome';
  static final String observacao = 'observacao';
  static final String dataAplicacao = 'dataAplicacao';
  static final String responsavel = 'responsavel';
  static final String localAplicacao = 'localAplicacao';
  static final String numeroLote = 'numeroLote';
  static final String validade = 'validade';
  static final String dosagem = 'dosagem';
}

class Vacina {
  final int? id;
  final int? idAnimal;
  final String? observacao;
  final DateTime? dataAplicacao;
  final String? responsavel;
  final String? localAplicacao;
  final String? numeroLote;
  final DateTime? validade;
  final double? dosagem;
  final String? nome;

  const Vacina(
      {this.id,
      this.idAnimal,
      this.nome,
      this.dataAplicacao,
      this.dosagem,
      this.localAplicacao,
      this.numeroLote,
      this.observacao,
      this.responsavel,
      this.validade});

  Map<String, Object?> toJson() => {
        VacinaFields.id: id,
        VacinaFields.idAnimal: idAnimal,
        VacinaFields.nome: nome,
        VacinaFields.observacao: observacao,
        VacinaFields.dataAplicacao:
            dataAplicacao != null ? dataAplicacao!.toIso8601String() : '',
        VacinaFields.dosagem: dosagem,
        VacinaFields.numeroLote: numeroLote,
        VacinaFields.responsavel: responsavel,
        VacinaFields.validade:
            validade != null ? validade!.toIso8601String() : '',
        VacinaFields.localAplicacao: localAplicacao,
      };
  static Vacina fromJson(Map<String, Object?> json) => Vacina(
        id: json[VacinaFields.id] as int?,
        idAnimal: json[VacinaFields.idAnimal] as int?,
        nome: json[VacinaFields.nome] as String?,
        observacao: json[VacinaFields.observacao] as String?,
        dataAplicacao:
            DateTime.parse(json[VacinaFields.dataAplicacao] as String),
        dosagem: json[VacinaFields.dosagem] as double?,
        numeroLote: json[VacinaFields.numeroLote] as String?,
        responsavel: json[VacinaFields.responsavel] as String?,
        validade: DateTime.parse(json[VacinaFields.validade] as String),
        localAplicacao: json[VacinaFields.localAplicacao] as String?,
      );

  Vacina copy({
    int? id,
    int? idAnimal,
    String? observacao,
    DateTime? dataAplicacao,
    double? dosagem,
    String? numeroLote,
    String? responsavel,
    DateTime? validade,
    String? localAplicacao,
    String? nome,
  }) =>
      Vacina(
        id: id ?? this.id,
        idAnimal: idAnimal ?? this.idAnimal,
        nome: nome ?? this.nome,
        observacao: observacao ?? this.observacao,
        dataAplicacao: dataAplicacao ?? this.dataAplicacao,
        dosagem: dosagem ?? dosagem,
        numeroLote: numeroLote ?? numeroLote,
        responsavel: responsavel ?? responsavel,
        validade: validade ?? validade,
        localAplicacao: localAplicacao ?? localAplicacao,
      );
}
