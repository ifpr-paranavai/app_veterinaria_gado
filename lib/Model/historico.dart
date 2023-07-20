final String tablehistorico = 'historico';

class HistoricoFields {
  static final List<String> values = [
    /// Add all fields
    id, idAnimal, descricao, diaOcorrencia,
  ];

  static final String id = '_id';
  static final String idAnimal = 'idAnimal';
  static final String descricao = 'descricao';
  static final String diaOcorrencia = 'diaOcorrencia';
}

class Historico {
  final int? id;
  final int? idAnimal;
  final String? descricao;
  final DateTime? diaOcorrencia;

  const Historico({
    this.id,
    this.idAnimal,
    this.descricao,
    this.diaOcorrencia,
  });

  Map<String, Object?> toJson() => {
        HistoricoFields.id: id,
        HistoricoFields.idAnimal: idAnimal,
        HistoricoFields.descricao: descricao,
        HistoricoFields.diaOcorrencia: diaOcorrencia != null ? diaOcorrencia!.toIso8601String() : '',
      };
  static Historico fromJson(Map<String, Object?> json) => Historico(
        id: json[HistoricoFields.id] as int?,
        idAnimal: json[HistoricoFields.idAnimal] as int?,
        descricao: json[HistoricoFields.descricao] as String?,
        diaOcorrencia: DateTime.parse(json[HistoricoFields.diaOcorrencia] as String),
      );

  Historico copy({
    int? id,
    int? idAnimal,
    String? descricao,
    DateTime? diaOcorrencia,
  }) =>
      Historico(
        id: id ?? this.id,
        idAnimal: idAnimal ?? this.idAnimal,
        descricao: descricao ?? this.descricao,
        diaOcorrencia: diaOcorrencia ?? this.diaOcorrencia,
      );
}
