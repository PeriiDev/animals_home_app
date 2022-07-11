import 'dart:convert';

class PetFavourite {
  int id;
  int userId;
  int petId;
  int ownerPetId;
  DateTime createdAt;
  DateTime updatedAt;
  String image;

  PetFavourite({
    required this.id,
    required this.userId,
    required this.petId,
    required this.ownerPetId,
    required this.createdAt,
    required this.updatedAt,
    required this.image,
  });

  PetFavourite copyWith({
    int? id,
    int? userId,
    int? petId,
    int? ownerPetId,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? image,
  }) {
    return PetFavourite(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      petId: petId ?? this.petId,
      ownerPetId: ownerPetId ?? this.ownerPetId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      image: image ?? this.image,
    );
  }

  @override
  String toString() {
    return 'PetFavourite(id: $id, userId: $userId, petId: $petId, createdAt: $createdAt, updatedAt: $updatedAt, image: $image, ownerPetId: $ownerPetId)';
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    result.addAll({'userId': userId});
    result.addAll({'petId': petId});
    result.addAll({'ownerPetId': ownerPetId});
    result.addAll({'createdAt': createdAt.millisecondsSinceEpoch});
    result.addAll({'updatedAt': updatedAt.millisecondsSinceEpoch});
    result.addAll({'image': image});

    return result;
  }

  factory PetFavourite.fromMap(Map<String, dynamic> map) {
    return PetFavourite(
      id: map['id'],
      userId: map['user_id'],
      petId: map['pet_id'],
      ownerPetId: map['ownerpet_id'],
      createdAt: DateTime.parse(map["created_at"]),
      updatedAt: DateTime.parse(map['updated_at']),
      image: map['image'],
    );
  }

  String toJson() => json.encode(toMap());

  factory PetFavourite.fromJson(String source) => PetFavourite.fromMap(json.decode(source));
}
