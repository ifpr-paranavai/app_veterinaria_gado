import 'dart:convert';

final String tableBreed = 'breed';

class BreedFields {
  static final List<String> values = [
    id,
    name,
    farmId,
  ];

  static final String id = '_id';
  static final String name = 'name';
  static final String farmId = 'farmId';
}

class Breed {
  final int? id;
  final String? name;
  final int? farmId;

  const Breed({
    this.id,
    this.name,
    this.farmId,
  });

  Map<String, Object?> toJson() => {
        BreedFields.id: id,
        BreedFields.name: name,
        BreedFields.farmId: farmId,
      };

  static Breed fromJson(Map<String, Object?> json) => Breed(
        id: json[BreedFields.id] as int?,
        name: json[BreedFields.name] as String?,
        farmId: json[BreedFields.farmId] as int?,
      );

  static Breed stringFromJson(Map<String, Object?> json) => Breed(
        name: json[BreedFields.name] as String?,
      );

  Breed copy({
    int? id,
    String? name,
    int? farmId,
  }) =>
      Breed(
        id: id ?? this.id,
        name: name ?? this.name,
        farmId: farmId ?? this.farmId,
      );
}
