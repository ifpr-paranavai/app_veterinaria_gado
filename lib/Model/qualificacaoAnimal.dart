final String tablequalificacaoanimal = 'qualificacaoAnimal';

class QualificacaoAnimalFields {
  static final List<String> values = [
    /// Add all fields
    id, identificadorAnimal, dataAmostra, valor, fazendaId
  ];

  static final String id = '_id';
  static final String identificadorAnimal = 'identificadorAnimal';
  static final String dataAmostra = 'dataAmostra';
  static final String valor = 'valor';
  static final String fazendaId = 'fazendaId';
}

class QualificacaoAnimal {
  final int? id;
  final int? fazendaId;
  final String? valor;
  final String? dataAmostra;
  final String? identificadorAnimal;

  const QualificacaoAnimal({
    this.id,
    this.identificadorAnimal,
    this.dataAmostra,
    this.valor,
    this.fazendaId,
  });

  Map<String, Object?> toJson() => {
        QualificacaoAnimalFields.id: id,
        QualificacaoAnimalFields.identificadorAnimal: identificadorAnimal,
        QualificacaoAnimalFields.dataAmostra: dataAmostra,
        QualificacaoAnimalFields.valor: valor,
        QualificacaoAnimalFields.fazendaId: fazendaId
      };
  static QualificacaoAnimal fromJson(Map<String, Object?> json) => QualificacaoAnimal(
        id: json[QualificacaoAnimalFields.id] as int?,
        identificadorAnimal: json[QualificacaoAnimalFields.identificadorAnimal] as String?,
        dataAmostra: json[QualificacaoAnimalFields.dataAmostra] as String?,
        valor: json[QualificacaoAnimalFields.valor] as String?,
        fazendaId: json[QualificacaoAnimalFields.fazendaId] as int?,
      );

  QualificacaoAnimal copy({
    int? id,
    String? identificadorAnimal,
    String? dataAmostra,
    String? valor,
    int? fazendaId,
  }) =>
      QualificacaoAnimal(
        id: id ?? this.id,
        identificadorAnimal: identificadorAnimal ?? this.identificadorAnimal,
        dataAmostra: dataAmostra ?? this.dataAmostra,
        valor: valor ?? this.valor,
        fazendaId: fazendaId ?? this.fazendaId,
      );
      
}
