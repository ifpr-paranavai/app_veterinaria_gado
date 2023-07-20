final String tablehistorico = 'historico';

class HistoricoFields {
  static final List<String> values = [
    /// Add all fields
    id, idAnimal, observaco, dataAplicacao, responsavel, localAplicacao,
    numeroLote, validade, dosagem
  ];

  static final String id = '_id';
  static final String idAnimal = 'idAnimal';
  static final String observaco = 'observaco';
  static final String dataAplicacao = 'dataAplicacao';
  static final String responsavel = 'responsavel';
  static final String localAplicacao = 'localAplicacao';
  static final String numeroLote = 'numeroLote';
  static final String validade = 'validade';
  static final String dosagem = 'dosagem';
}

class Historico {
  final int? id;
  final int? idAnimal;
  final String? observaco;
  final DateTime? dataAplicacao;
  final String? responsavel;
  final String? localAplicacao;
  final String? numeroLote;
  final DateTime? validade;
  final double? dosagem;

  const Historico(
      {this.id,
      this.idAnimal,
      this.dataAplicacao,
      this.dosagem,
      this.localAplicacao,
      this.numeroLote,
      this.observaco,
      this.responsavel,
      this.validade});

  Map<String, Object?> toJson() => {
        HistoricoFields.id: id,
        HistoricoFields.idAnimal: idAnimal,
        HistoricoFields.observaco: observaco,
        HistoricoFields.dataAplicacao:
            dataAplicacao != null ? dataAplicacao!.toIso8601String() : '',
        HistoricoFields.dosagem: dosagem,
        HistoricoFields.numeroLote: numeroLote,
        HistoricoFields.responsavel: responsavel,
        HistoricoFields.validade:
            validade != null ? validade!.toIso8601String() : '',
        HistoricoFields.localAplicacao: localAplicacao,
      };
  static Historico fromJson(Map<String, Object?> json) => Historico(
        id: json[HistoricoFields.id] as int?,
        idAnimal: json[HistoricoFields.idAnimal] as int?,
        observaco: json[HistoricoFields.observaco] as String?,
        dataAplicacao:
            DateTime.parse(json[HistoricoFields.dataAplicacao] as String),
        dosagem: json[HistoricoFields.dosagem] as double?,
        numeroLote: json[HistoricoFields.numeroLote] as String?,
        responsavel: json[HistoricoFields.responsavel] as String?,
        validade: DateTime.parse(json[HistoricoFields.validade] as String),
        localAplicacao: json[HistoricoFields.localAplicacao] as String?,
      );

  Historico copy({
    int? id,
    int? idAnimal,
    String? observaco,
    DateTime? dataAplicacao,
    double? dosagem,
    String? numeroLote,
    String? responsavel,
    DateTime? validade,
    String? localAplicacao,
  }) =>
      Historico(
        id: id ?? this.id,
        idAnimal: idAnimal ?? this.idAnimal,
        observaco: observaco ?? this.observaco,
        dataAplicacao: dataAplicacao ?? this.dataAplicacao,
        dosagem: dosagem ?? dosagem,
        numeroLote: numeroLote ?? numeroLote,
        responsavel: responsavel ?? responsavel,
        validade: validade ?? validade,
        localAplicacao: localAplicacao ?? localAplicacao,
      );
}
