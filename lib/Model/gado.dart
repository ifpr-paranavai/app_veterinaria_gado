final String tableGado = 'gado';

class GadoFields {
  static final List<String> values = [
    id,
    nome,
    numero,
    dataNascimento,
    dataBaixa,
    motivoBaixa,
    partosNaoLancados,
    partosTotais,
    lote,
    nomePai,
    numeroPai,
    numeroMae,
    nomeMae,
    breedId,
    farmId,
  ];

  static final String id = '_id';
  static final String nome = 'nome';
  static final String numero = 'numero';
  static final String dataNascimento = 'dataNascimento';
  static final String dataBaixa = 'dataBaixa';
  static final String motivoBaixa = 'motivoBaixa';
  static final String partosNaoLancados = 'partosNaoLancados';
  static final String partosTotais = 'partosTotais';
  static final String lote = 'lote';
  static final String nomePai = 'nomePai';
  static final String numeroPai = 'numeroPai';
  static final String numeroMae = 'numeroMae';
  static final String nomeMae = 'nomeMae';
  static final String breedId = 'breedId';
  static final String farmId = 'farmId';
}

class Gado {
  final int? id;
  final String? nome;
  final String? numero;
  final DateTime? dataNascimento;
  final DateTime? dataBaixa;
  final String? motivoBaixa;
  final String? partosNaoLancados;
  final String? partosTotais;
  final String? lote;
  final String? nomePai;
  final String? numeroPai;
  final String? numeroMae;
  final String? nomeMae;
  final int? breedId;
  final int? farmId;

  const Gado({
    this.id,
    this.nome,
    this.numero,
    // required this.dataNascimento,
    this.dataNascimento,
    this.dataBaixa,
    this.motivoBaixa,
    this.partosNaoLancados,
    this.partosTotais,
    this.lote,
    this.nomePai,
    this.numeroPai,
    this.numeroMae,
    this.nomeMae,
    this.breedId,
    this.farmId,
  });

  Map<String, Object?> toJson() => {
        GadoFields.id: id,
        GadoFields.nome: nome,
        GadoFields.numero: numero,
        GadoFields.dataNascimento:
            dataNascimento != null ? dataNascimento!.toIso8601String() : '',
        GadoFields.dataBaixa:
            dataBaixa != null ? dataBaixa!.toIso8601String() : '',
        GadoFields.motivoBaixa: motivoBaixa,
        GadoFields.partosNaoLancados: partosNaoLancados,
        GadoFields.partosTotais: partosTotais,
        GadoFields.lote: lote,
        GadoFields.nomePai: nomePai,
        GadoFields.numeroPai: numeroPai,
        GadoFields.numeroMae: numeroMae,
        GadoFields.nomeMae: nomeMae,
        GadoFields.breedId: breedId,
        GadoFields.farmId: farmId,
      };

  static Gado fromJson(Map<String, Object?> json) => Gado(
        id: json[GadoFields.id] as int?,
        nome: json[GadoFields.nome] as String?,
        numero: json[GadoFields.numero] as String?,
        dataNascimento: json[GadoFields.dataNascimento] == null ||
                json[GadoFields.dataNascimento] == ''
            ? null
            : DateTime.parse(json[GadoFields.dataNascimento] as String),
        dataBaixa: json[GadoFields.dataBaixa] == null ||
                json[GadoFields.dataBaixa] == ''
            ? null
            : DateTime.parse(json[GadoFields.dataBaixa] as String),
        motivoBaixa: json[GadoFields.motivoBaixa] as String?,
        partosNaoLancados: json[GadoFields.partosNaoLancados] as String?,
        partosTotais: json[GadoFields.partosTotais] as String?,
        lote: json[GadoFields.lote] as String?,
        nomePai: json[GadoFields.nomePai] as String?,
        numeroPai: json[GadoFields.numeroPai] as String?,
        numeroMae: json[GadoFields.numeroMae] as String?,
        nomeMae: json[GadoFields.nomeMae] as String?,
        breedId: json[GadoFields.breedId] as int?,
        farmId: json[GadoFields.farmId] as int?,
      );

  Gado copy({
    int? id,
    String? nome,
    String? numero,
    DateTime? dataNascimento,
    DateTime? dataBaixa,
    String? motivoBaixa,
    String? partosNaoLancados,
    String? partosTotais,
    String? lote,
    String? nomePai,
    String? numeroPai,
    String? numeroMae,
    String? nomeMae,
    int? breedId,
    int? farmId,
  }) =>
      Gado(
        id: id ?? this.id,
        nome: nome ?? this.nome,
        numero: numero ?? this.numero,
        dataNascimento: dataNascimento ?? this.dataNascimento,
        dataBaixa: dataBaixa ?? this.dataBaixa,
        motivoBaixa: motivoBaixa ?? this.motivoBaixa,
        partosNaoLancados: partosNaoLancados ?? this.partosNaoLancados,
        partosTotais: partosTotais ?? this.partosTotais,
        lote: lote ?? this.lote,
        nomePai: nomePai ?? this.nomePai,
        numeroPai: numeroPai ?? this.numeroPai,
        numeroMae: numeroMae ?? this.numeroMae,
        nomeMae: nomeMae ?? this.nomeMae,
        breedId: breedId ?? this.breedId,
        farmId: farmId ?? this.farmId,
      );
}
