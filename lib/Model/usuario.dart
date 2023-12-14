final String tableUsuario = "usuario";

class UsuarioFields {
  static final List<String> values = [
    id,
    name,
    email,
    password,
    firebaseId,
  ];

  static final String id = '_id';
  static final String name = 'name';
  static final String email = 'email';
  static final String password = 'password';
  static final String firebaseId = 'firebaseId';
}

class Usuario {
  final int? id;
  final String? name;
  final String? email;
  final String? password;
  String? firebaseId;

  Usuario({
    this.id,
    this.name,
    this.email,
    this.password,
    this.firebaseId,
  });

  Map<String, Object?> toJson() => {
        UsuarioFields.id: id,
        UsuarioFields.name: name,
        UsuarioFields.email: email,
        UsuarioFields.password: password,
        UsuarioFields.firebaseId: firebaseId,
      };

  static Usuario fromJson(Map<String, Object?> json) => Usuario(
        id: json[UsuarioFields.id] as int?,
        name: json[UsuarioFields.name] as String?,
        email: json[UsuarioFields.email] as String?,
        password: json[UsuarioFields.password] as String?,
        firebaseId: json[UsuarioFields.firebaseId] as String?,
      );

  Usuario copy({
    int? id,
    String? name,
    String? email,
    String? password,
    String? firebaseId,
  }) =>
      Usuario(
        id: id ?? this.id,
        name: name ?? this.name,
        email: email ?? this.email,
        password: password ?? this.password,
        firebaseId: firebaseId ?? this.firebaseId,
      );
}
