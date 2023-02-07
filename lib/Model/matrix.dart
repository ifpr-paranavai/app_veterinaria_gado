final String tableMatrix = 'matrix';

class MatrixFields {
  static final List<String> values = [
    /// Add all fields
    id, idUsuario, observacao, number, name,
  ];

  static final String id = '_id';
  static final String idUsuario = 'idUsuario';
  static final String observacao = 'observacao';
  static final String number = 'number';
  static final String name = 'name';
}

class Matrix {
  final int? id;
  final int? idUsuario;
  final String? observacao;
  final String? number;
  final String? name;

  const Matrix({
    this.id,
    this.idUsuario,
    this.observacao,
    this.number,
    this.name,
  });

  Map<String, Object?> toJson() => {
        MatrixFields.id: id,
        MatrixFields.idUsuario: idUsuario,
        MatrixFields.observacao: observacao,
        MatrixFields.number: number,
        MatrixFields.name: name,
      };
  static Matrix fromJson(Map<String, Object?> json) => Matrix(
        id: json[MatrixFields.id] as int?,
        idUsuario: json[MatrixFields.idUsuario] as int?,
        observacao: json[MatrixFields.observacao] as String?,
        number: json[MatrixFields.number] as String?,
        name: json[MatrixFields.name] as String?,
      );

  Matrix copy({
    int? id,
    int? idUsuario,
    String? observacao,
    String? number,
    String? name,
  }) =>
      Matrix(
        id: id ?? this.id,
        idUsuario: idUsuario ?? this.idUsuario,
        observacao: observacao ?? this.observacao,
        number: number ?? this.number,
        name: name ?? this.name,
      );
}
