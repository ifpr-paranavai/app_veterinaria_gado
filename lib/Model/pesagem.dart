import 'dart:convert';

final String tablePesagem = 'pesagem';

class PesagemFields {
  static final List<String> values = [
    id,
    gadoId,
    dataPesagem,
    peso,
    anotacao,
  ];

  static final String id = '_id';
  static final String gadoId = 'gadoId';
  static final String dataPesagem = 'dataPesagem';
  static final String peso = 'peso';
  static final String anotacao = 'anotacao';
}

class Pesagem {
  final int? id;
  final int? gadoId;
  final DateTime? dataPesagem;
  final double? peso;
  final String? anotacao;

  const Pesagem(
      {this.id, this.gadoId, this.dataPesagem, this.peso, this.anotacao});

  Map<String, Object?> toJson() => {
        PesagemFields.id: id,
        PesagemFields.dataPesagem: dataPesagem != null ? dataPesagem!.toIso8601String(): '',
        PesagemFields.gadoId: gadoId,
        PesagemFields.peso: peso,
        PesagemFields.anotacao: anotacao,
      };

  static Pesagem fromJson(Map<String, Object?> json) => Pesagem(
        id: json[PesagemFields.id] as int?,
        dataPesagem: DateTime.parse(json[PesagemFields.dataPesagem] as String),
        gadoId: json[PesagemFields.gadoId] as int?,
        peso: json[PesagemFields.peso] as double?,
        anotacao: json[PesagemFields.anotacao] as String?,
      );

  Pesagem copy({
    int? id,
    int? gadoId,
    DateTime? dataPesagem,
    double? peso,
    String? anotacao,
  }) =>
      Pesagem(
        id: id ?? this.id,
        gadoId: gadoId ?? this.gadoId,
        dataPesagem: dataPesagem ?? this.dataPesagem,
        peso: peso ?? this.peso,
        anotacao: anotacao ?? this.anotacao,
      );
}
