class HeadQuartersDTO {
  int? id;
  int? idUsuario;
  String? observacao;
  String? number;
  String? name;
  String? cpfCnpj;

  HeadQuartersDTO({
    this.id,
    this.idUsuario,
    this.observacao,
    this.number,
    this.name,
    this.cpfCnpj,
  });

  static HeadQuartersDTO fromJson(Map<String, Object?> json) => HeadQuartersDTO(
        id: json["h_id"] as int?,
        idUsuario: json["h_idUsuario"] as int?,
        observacao: json["h_observacao"] as String?,
        number: json["h_number"] as String?,
        name: json["h_name"] as String?,
        cpfCnpj: json["h_cpfCnpj"] as String?,
      );
}
