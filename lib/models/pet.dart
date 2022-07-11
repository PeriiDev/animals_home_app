// To parse this JSON data, do
//
//     final user = userFromMap(jsonString);

import 'dart:convert';

class Pet {
  int id;
  int userId;
  int typeId;
  String name;
  DateTime? birthdate;
  String color;
  double? weight;
  String state;
  String sex;
  String size;
  String description;
  bool inoculation;
  bool parasites;
  bool infertile;
  bool microchip;
  DateTime createdAt;
  DateTime updatedAt;
  String typeValue;
  String imageUrl;
  String? userName;
  String? userImageUrl;
  String? userDescription;

  Pet({
    required this.id,
    required this.userId,
    required this.typeId,
    required this.name,
    this.birthdate,
    required this.color,
    this.weight = 0,
    required this.state,
    required this.sex,
    required this.size,
    required this.description,
    required this.inoculation,
    required this.parasites,
    required this.infertile,
    required this.microchip,
    required this.createdAt,
    required this.updatedAt,
    this.typeValue = '',
    this.imageUrl = '',
    this.userName = '',
    this.userImageUrl = '',
    this.userDescription = '',
  });

  Pet copyWith({
    int? id,
    int? userId,
    int? typeId,
    String? name,
    DateTime? birthdate,
    String? color,
    double? weight,
    String? state,
    String? sex,
    String? size,
    String? description,
    bool? inoculation,
    bool? parasites,
    bool? infertile,
    bool? microchip,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? typeValue,
    String? imageUrl,
    String? userName,
    String? userImageUrl,
    String? userDescription,
  }) =>
      Pet(
        id: id ?? this.id,
        userId: userId ?? this.userId,
        typeId: typeId ?? this.typeId,
        name: name ?? this.name,
        birthdate: birthdate ?? this.birthdate,
        color: color ?? this.color,
        weight: weight ?? this.weight,
        state: state ?? this.state,
        sex: sex ?? this.sex,
        size: size ?? this.size,
        description: description ?? this.description,
        inoculation: inoculation ?? this.inoculation,
        parasites: parasites ?? this.parasites,
        infertile: infertile ?? this.infertile,
        microchip: microchip ?? this.microchip,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        typeValue: typeValue ?? this.typeValue,
        imageUrl: imageUrl ?? this.imageUrl,
        userName: userName ?? this.userName,
        userImageUrl: userImageUrl ?? this.userImageUrl,
        userDescription: userDescription ?? this.userDescription,
      );

  factory Pet.fromJson(String str) => Pet.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Pet.fromMap(Map<String, dynamic> json) => Pet(
        id: json["id"],
        userId: json["user_id"],
        typeId: json["type_id"],
        name: json["name"],
        birthdate: (json["birthdate"] == null) ? null : DateTime.parse(json["birthdate"]),
        color: json["color"] ?? 'Sin color',
        weight: (json["weight"] == null) ? 0.0 : json["weight"].toDouble(),
        state: json["state"],
        sex: json["sex"],
        size: json["size"],
        description: json["description"] ?? 'Sin descripción',
        inoculation: (json["inoculation"] == 0) ? false : true,
        parasites: (json["parasites"] == 0) ? false : true,
        infertile: (json["infertile"] == 0) ? false : true,
        microchip: (json["microchip"] == 0) ? false : true,
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        typeValue: json["type_value"],
        imageUrl: json["image"] ?? 'Sin imagen',
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "user_id": userId,
        "type_id": typeId,
        "name": name,
        //"birthdate":  "${birthdate.year.toString().padLeft(4, '0')}-${birthdate.month.toString().padLeft(2, '0')}-${birthdate.day.toString().padLeft(2, '0')}",
        "color": color,
        "weight": weight,
        "state": state,
        "sex": sex,
        "size": size,
        "description": description,
        "inoculation": inoculation,
        "parasites": parasites,
        "infertile": infertile,
        "microchip": microchip,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "name_appends": typeValue,
        "image_url": imageUrl,
      };

  @override
  String toString() {
    return 'Pet(id: $id, userId: $userId, typeId: $typeId, name: $name, birthdate: $birthdate, color: $color, weight: $weight, state: $state, sex: $sex, size: $size, description: $description, inoculation: $inoculation, parasites: $parasites, infertile: $infertile, microchip: $microchip, createdAt: $createdAt, updatedAt: $updatedAt, typeValue: $typeValue, imageUrl: $imageUrl)';
  }
}
