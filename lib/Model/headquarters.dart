final String tableMatrix = 'headquarters';

class HeadquartersFields {
  static final List<String> values = [
    /// Add all fields
    id, idUsuario, observacao, number, name, cpfCnpj,
  ];

  static final String id = '_id';
  static final String idUsuario = 'idUsuario';
  static final String observacao = 'observacao';
  static final String number = 'number';
  static final String name = 'name';
  static final String cpfCnpj = 'cpfCnpj';
}

class Headquarters {
  final int? id;
  final int? idUsuario;
  final String? observacao;
  final String? number;
  final String? name;
  final String? cpfCnpj;

  const Headquarters({
    this.id,
    this.idUsuario,
    this.observacao,
    this.number,
    this.name,
    this.cpfCnpj,
  });

  Map<String, Object?> toJson() => {
        HeadquartersFields.id: id,
        HeadquartersFields.idUsuario: idUsuario,
        HeadquartersFields.observacao: observacao,
        HeadquartersFields.number: number,
        HeadquartersFields.name: name,
        HeadquartersFields.cpfCnpj: cpfCnpj,
      };
  static Headquarters fromJson(Map<String, Object?> json) => Headquarters(
        id: json[HeadquartersFields.id] as int?,
        idUsuario: json[HeadquartersFields.idUsuario] as int?,
        observacao: json[HeadquartersFields.observacao] as String?,
        number: json[HeadquartersFields.number] as String?,
        name: json[HeadquartersFields.name] as String?,
        cpfCnpj: json[HeadquartersFields.cpfCnpj] as String?,
      );

  Headquarters copy({
    int? id,
    int? idUsuario,
    String? observacao,
    String? number,
    String? name,
    String? cpfCnpj,
  }) =>
      Headquarters(
        id: id ?? this.id,
        idUsuario: idUsuario ?? this.idUsuario,
        observacao: observacao ?? this.observacao,
        number: number ?? this.number,
        name: name ?? this.name,
        cpfCnpj: cpfCnpj ?? this.cpfCnpj,
      );
}
